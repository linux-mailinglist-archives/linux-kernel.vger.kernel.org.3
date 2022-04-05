Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EA4F4826
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbiDEV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573279AbiDESmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:42:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5088020BE2;
        Tue,  5 Apr 2022 11:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 037F5B81C87;
        Tue,  5 Apr 2022 18:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD9C385A0;
        Tue,  5 Apr 2022 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184024;
        bh=ghRwdOCZeE0FLxCkHuewv1vVzfiJAyexUmL+mjAuZKI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PuGrDTfN9mtaJLKhCc8cygB5HY+S9ISDbBOaEvUtNqr/5L0Ba2s9ylit7TYx2lzLq
         vqFsbywVAXKgmawyMVR4X9FOjydhYiVzJmPlaMf82vcqp44S49pvQfCnCDSjYQ6j0m
         f5oAkChWbnvd2x2inPli7WjMwxxrTeu7CZEEdMQSsp9wuLe90Y3fevpIgPCPfvLK4E
         Y77yULlDTEUO49GFkRB4/LWpB3UP7yfJbU1sWbWx+/VBCUhlnS0WN27doMdeZUHbV9
         wQxqO9nGnAU3CO4ZWmSTlRj9PRZbIFxfT9XjRGPJSn8e28wWm5EEoPl+V2Y5Fyps41
         rxSsUdk8bpzIw==
Message-ID: <94f62e19a630792f78e3c48895dfb792ecb02c6c.camel@kernel.org>
Subject: Re: [PATCH V3 17/30] x86/sgx: Support modifying SGX page type
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 21:41:34 +0300
In-Reply-To: <d8cc2142-c50d-fbd9-425f-01e279c9a0f1@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
         <bac6e77fe04100d6bfebd4e13aa9b916f82bfea6.1648847675.git.reinette.chatre@intel.com>
         <Ykvqf3Ws6jlN5g+p@kernel.org>
         <b41d81ebcb6934765d7f37d4ce95baa16ec9b5d2.camel@kernel.org>
         <d8cc2142-c50d-fbd9-425f-01e279c9a0f1@intel.com>
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

On Tue, 2022-04-05 at 10:05 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 4/5/2022 8:34 AM, Jarkko Sakkinen wrote:
> > On Tue, 2022-04-05 at 10:06 +0300, Jarkko Sakkinen wrote:
>=20
> > > >=20
> > >=20
> > > To be coherent with other names, this should be
> > > SGX_IOC_ENCLAVE_MODIFY_TYPES.
>=20
> This is not such a clear change request to me:
>=20
> SGX_IOC_ENCLAVE_ADD_PAGES - add multiple pages
> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS - restrict multiple permissions
> SGX_IOC_ENCLAVE_REMOVE_PAGES - remove multiple pages
> SGX_IOC_ENCLAVE_MODIFY_TYPE - set a single type
>=20
> Perhaps it should rather be SGX_IOC_ENCLAVE_SET_TYPE to indicate that
> there is a single target type as opposed to the possibility
> of multiple source types (TCS and regular pages can be trimmed).
>=20
> >=20
> > This should take only page type given that flags are zeroed:
> >=20
> > EPCM(DS:RCX).R :=3D 0;
> > EPCM(DS:RCX).W :=3D 0;
> > EPCM(DS:RCX).X :=3D 0;=20
> >=20
>=20
> ok, this was how it was done in V1 [1] and I can go back to that.

I would name the fields as "flags" and "page_type" just to align
names with SGX instead of trying to mimim "posix names". Otherwise,=C2=A0
I support that.

BR, Jarkko
