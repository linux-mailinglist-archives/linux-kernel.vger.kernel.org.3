Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79F583C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiG1Kxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiG1Kxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:53:35 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E095A2EA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659005607;
        bh=yRmMveNaOUKifT4ewJ5e1rXURoy9i48LHR1X4r7j7CQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JYpaftwlnDdye6MzckAT39py18n6vZ1gI3QYA3T+dVXlNR7twUrO9OUHPMGwrHmRP
         blxNw0wwU0uxGCO7k/wBaKs0Ww9/8fVb5k0HzWkfeTOgonME53uANDEbvB9OmzkBKz
         fn42Ifm8Xd+Sa1LrBlH4AmJxbSkOG0MQMoGMBLWc=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 8381B667D6;
        Thu, 28 Jul 2022 06:53:26 -0400 (EDT)
Message-ID: <39d3b56e3265e70d26e1d08698b461d81c3e1c1d.camel@xry111.site>
Subject: Re: [PATCH 1/5] LoongArch: Add section of GOT for kernel module
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 18:53:24 +0800
In-Reply-To: <fac4319d-26ee-1702-518c-2d6fbb1a0d57@loongson.cn>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
         <3f43d51d530344f73a0a7087407799ff9dff3ba8.camel@xry111.site>
         <849f514e-f78a-72a2-b94e-6974074b75eb@loongson.cn>
         <00914cf65b64e06f370213fdc079111aa2a27145.camel@xry111.site>
         <fac4319d-26ee-1702-518c-2d6fbb1a0d57@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-28 at 17:21 +0800, Youling Tang wrote:
>=20
>=20
> On 07/28/2022 05:02 PM, Xi Ruoyao wrote:
> > On Thu, 2022-07-28 at 16:29 +0800, Youling Tang wrote:
> > > On 07/28/2022 12:26 AM, Xi Ruoyao wrote:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod->arch.got.shdr->sh_t=
ype =3D SHT_NOBITS;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod->arch.got.shdr->sh_f=
lags =3D SHF_ALLOC;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod->arch.got.shdr->sh_a=
ddralign =3D L1_CACHE_BYTES;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod->arch.got.shdr->sh_s=
ize =3D (num_plts + 1) *
> > > > sizeof(struct plt_entry);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod->arch.got.num_entrie=
s =3D 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod->arch.got.max_entrie=
s =3D num_plts;
> > > =C2=A0Hi, Ruoyao
> > >=20
> > > =C2=A0 We should use num_gots instead of num_plts when creating .got
> > > section.
> >=20
> > Yes, it's a stupid error and I'll fix it in V2.
> >=20
> > But why didn't this cause a malfunction on my system? :(.
>=20
> Maybe num_plts is greater than num_gots, and the size of plt_entry is=20
> equivalent to the size of four got_entry, so that when the module is=20
> loaded, it just allocates a larger space without causing the module to
> fail to load.

I'll write a module to load address of 10 kernel symbols with only one
printk call to test before sending V2 :).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
