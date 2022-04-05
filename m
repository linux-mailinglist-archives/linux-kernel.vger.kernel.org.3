Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EE4F46F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380434AbiDEUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573281AbiDESnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:43:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C53632E;
        Tue,  5 Apr 2022 11:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C791AB81F87;
        Tue,  5 Apr 2022 18:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3CDC385A0;
        Tue,  5 Apr 2022 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184074;
        bh=A6Cglr/SX17RIdHYKRyt+DQUM0hwlXEDX/OSPfNNycE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQGFEP789xWtWnwcwTXm40YoB6KiidAU6/C+PhRP9bYnU4SCmEb/eawdW2A3baTWh
         idC9yo3PgnuNan+HF+IwSf0Br9AWKgC4bakOnDHjQ1nBnODA351Sl2Ph+h+0k90njx
         zgGj+V1ptUowyS6UZxL+FKVDeXWpqZAPHfYFlIbvMUG4YdhmS8cQ7uv4OV13kz/8YV
         jrpJduVXr3TKJjoJ82KDInuxGQ8btJ+PBPlAF4C3JEFmiyGYmyyd4ay+y/H5J7LRfM
         EGoXLxEJ9QaY/NQICofIK8o85nGHWd+wNmbU9/g+miJRyX0zXWpJMmN0M3AboP9oj4
         tOi7tg6DLqqEQ==
Message-ID: <ddef013dc9ce496ff5840f42cf0651637060b4f2.camel@kernel.org>
Subject: Re: [PATCH V3 19/30] x86/sgx: Free up EPC pages directly to support
 large page ranges
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 21:42:24 +0300
In-Reply-To: <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
         <b3a17e1ce7bcd14db3c28903e8a97f094998ae74.1648847675.git.reinette.chatre@intel.com>
         <Ykvrk4hYvBEnNOOl@kernel.org>
         <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-05 at 10:13 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 4/5/2022 12:11 AM, Jarkko Sakkinen wrote:
> > On Mon, Apr 04, 2022 at 09:49:27AM -0700, Reinette Chatre wrote:
> > > The page reclaimer ensures availability of EPC pages across all
> > > enclaves. In support of this it runs independently from the
> > > individual enclaves in order to take locks from the different
> > > enclaves as it writes pages to swap.
> > >=20
> > > When needing to load a page from swap an EPC page needs to be
> > > available for its contents to be loaded into. Loading an existing
> > > enclave page from swap does not reclaim EPC pages directly if
> > > none are available, instead the reclaimer is woken when the
> > > available EPC pages are found to be below a watermark.
> > >=20
> > > When iterating over a large number of pages in an oversubscribed
> > > environment there is a race between the reclaimer woken up and
> > > EPC pages reclaimed fast enough for the page operations to proceed.
> > >=20
> > > Ensure there are EPC pages available before attempting to load
> > > a page that may potentially be pulled from swap into an available
> > > EPC page.
> > >=20
> > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > > ---
> > > No changes since V2
> > >=20
> > > Changes since v1:
> > > - Reword commit message.
> > >=20
> > > =C2=A0arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++++
> > > =C2=A0arch/x86/kernel/cpu/sgx/main.c=C2=A0 | 6 ++++++
> > > =C2=A0arch/x86/kernel/cpu/sgx/sgx.h=C2=A0=C2=A0 | 1 +
> > > =C2=A03 files changed, 13 insertions(+)
> > >=20
> > > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sg=
x/ioctl.c
> > > index 515e1961cc02..f88bc1236276 100644
> > > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > > @@ -777,6 +777,8 @@ sgx_enclave_restrict_permissions(struct sgx_encl =
*encl,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (c =3D 0 ; c < mo=
dp->length; c +=3D PAGE_SIZE) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0addr =3D encl->base + modp->offset + c;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_direct_reclaim();
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->lock);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0entry =3D sgx_encl_load_page(encl, addr);
> > > @@ -934,6 +936,8 @@ static long sgx_enclave_modify_type(struct sgx_en=
cl *encl,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (c =3D 0 ; c < mo=
dt->length; c +=3D PAGE_SIZE) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0addr =3D encl->base + modt->offset + c;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_direct_reclaim();
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->lock);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0entry =3D sgx_encl_load_page(encl, addr);
> > > @@ -1129,6 +1133,8 @@ static long sgx_encl_remove_pages(struct sgx_en=
cl *encl,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (c =3D 0 ; c < pa=
rams->length; c +=3D PAGE_SIZE) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0addr =3D encl->base + params->offset + c;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_direct_reclaim();
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->lock);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0entry =3D sgx_encl_load_page(encl, addr);
> > > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx=
/main.c
> > > index 6e2cb7564080..545da16bb3ea 100644
> > > --- a/arch/x86/kernel/cpu/sgx/main.c
> > > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > > @@ -370,6 +370,12 @@ static bool sgx_should_reclaim(unsigned long wat=
ermark)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 !list_empty(&sgx_active_page_list);
> > > =C2=A0}
> > > =C2=A0
> > > +void sgx_direct_reclaim(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sgx_should_reclaim(SGX=
_NR_LOW_PAGES))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_reclaim_pages();
> > > +}
> >=20
> > Please, instead open code this to both locations - not enough redundanc=
y
> > to be worth of new function. Causes only unnecessary cross-referencing
> > when maintaining. Otherwise, I agree with the idea.
> >=20
>=20
> hmmm, that means the heart of the reclaimer (sgx_reclaim_pages()) would b=
e
> made available for direct use from everywhere in the driver. I will look =
into this.
>=20
> Reinette
>=20

It's a valid enough point. Let's keep it as it is :-)

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
