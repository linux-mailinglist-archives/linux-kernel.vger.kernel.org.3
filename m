Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627D64712AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhLKIBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhLKIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:01:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401FC061714;
        Sat, 11 Dec 2021 00:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2FACDCE2F2E;
        Sat, 11 Dec 2021 08:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFB7C004DD;
        Sat, 11 Dec 2021 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639209664;
        bh=Q8xxOL4oJ4hCa17GjigzQDou0XVTSBm7yvT8kbqU+r0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z6fENzhoO5g851bpFlyOj/4MAm6hyDYFUq6bC//TyzO2sMFIxEAJqyinkNmxcMwBM
         borbwL1EDCmJ3FKirrTcvkXl2BjKrtlVxnWd/cL8w/egd8Gw0PBQbbzcRftGD3VW0A
         bE5giS5YR4MvL/3NVv43v6uW3PiKR+k85WOniuNSF8Uar9VROmukinaFLiQQOIDgLz
         70GUEm0rlrkG+fuwrn8MuUAirs1ysMrfCJNu9CScKJVyf4ZEkpVHhAGwuHdp5OBu3/
         rzDhgfgf3EwhQNbgH4h5O8nEdtxz0MFBQUhmZqgVnKG47IyyodmlhkSudHoT7ESRfU
         y48L3OKwRRu+Q==
Message-ID: <52aa2faf39e65032862fa18724443095a6de951f.camel@kernel.org>
Subject: Re: [PATCH 14/25] x86/sgx: Tighten accessible memory range after
 enclave initialization
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 10:01:00 +0200
In-Reply-To: <0522af41-59db-e621-69de-ad64dec3a5d6@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <66da195d44cbbed57b6840c5d20bb789c06fb99f.1638381245.git.reinette.chatre@intel.com>
         <Yav2ckVPrHSgCw/5@iki.fi> <0522af41-59db-e621-69de-ad64dec3a5d6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:45 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 3:14 PM, Jarkko Sakkinen wrote:
> > > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx=
/encl.c
> > > index 342b97dd4c33..37203da382f8 100644
> > > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > > @@ -403,6 +403,10 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsi=
gned long start,
> > >  =20
> > >   	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
> > >  =20
> >=20
> > Please write a comment here.
>=20
> Would the comment below suffice?
>=20
> /* Disallow mapping outside enclave's address range. */

Yeah, looks good to me.

/Jarkko
