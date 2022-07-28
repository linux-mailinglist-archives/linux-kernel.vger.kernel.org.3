Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205DF583CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiG1K66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiG1K6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:58:51 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1716664C5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659005923;
        bh=y319GJZ42LdkVPQdcO0bdeXk+v6i2YLb2hHt78rlabo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TLQnLTWUCKPR0ZKBW4k7cxvSLPQwmV5oLCQnR+oz0gGlB8E56tqMvw5PZy7DFXYfC
         uvzEl4YR/7WH8J7yY2UpSK3iR63dYCzYu2x4tp9NE+6l4PbJVmNVbk7igVOPO7ytts
         3tSKwARcmFNTntEOUjmDqNRS513Agl+ApOYrbrpU=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3A502667D7;
        Thu, 28 Jul 2022 06:58:42 -0400 (EDT)
Message-ID: <4f8b9895d807b954b3af435b5ef4b70ddd95862b.camel@xry111.site>
Subject: Re: [PATCH 4/5] LoongArch: Stop using undocumented assembler options
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 18:58:40 +0800
In-Reply-To: <4f4ced23-2046-586c-2590-542923025149@loongson.cn>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
         <4f09c81c22d0a16883a6914a8f7209957386c07c.camel@xry111.site>
         <4f4ced23-2046-586c-2590-542923025149@loongson.cn>
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

On Thu, 2022-07-28 at 17:46 +0800, Youling Tang wrote:
>=20
> On 07/28/2022 12:29 AM, Xi Ruoyao wrote:
> > Now we can handle GOT and GOT-based relocations properly, remove the
> > undocumented `-Wa,-mla-{global,local}-with-{pcrel,abs}` assembler
> > hacks.
> >=20
> > Adjust assembly code to explicitly use "la.pcrel" where necessary.
> >=20
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0arch/loongarch/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +=
----
> > =C2=A0arch/loongarch/kernel/head.S | 10 +++++-----
> > =C2=A02 files changed, 6 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index 039dcc4fe1f3..9552c7880d34 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -40,10 +40,7 @@ endif
> >=20
> > =C2=A0cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0+=3D -G0 -pipe -msoft-float
> > =C2=A0LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0+=3D -G0 -static -n -nostdlib
> > -KBUILD_AFLAGS_KERNEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0+=3D -Wa,-mla-global-with-pcrel
> > -KBUILD_CFLAGS_KERNEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0+=3D -Wa,-mla-global-with-pcrel
> > -KBUILD_AFLAGS_MODULE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0+=3D -Wa,-mla-global-with-abs
> > -KBUILD_CFLAGS_MODULE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0+=3D -fplt -Wa,-mla-global-with-abs,-
> > mla-local-with-abs
> > +KBUILD_CFLAGS_MODULE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0+=3D -fplt
>=20
> The -fplt flag may be removed, the compiler defaults to -fplt if not
> specified (riscv is also not manually specified as -fplt).

Will remove explicit -fplt in V2.

By the way, how do you think about "-G0"?  It does not have any effect
now because the toolchain does not attempt to use sbss/sdata sections.
Do we have any plan to add sbss and sdata support in the toolchain?


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
