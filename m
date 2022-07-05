Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20D56673D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiGEKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiGEKBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:01:00 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DC12AD7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1657015256;
        bh=E6o1RFAIrfJESU+NgsvD4EBv6BUvExPltXkj7Me7Lig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W2uSUEQVyJ1nU4GF9JWZsE5ljwM+NxAicX93mST+EjexPE67/aXOHPrAAWpdFyHIF
         BfrUFpxX6tdWnhTi5FfMdn+QCv77veSoEod+dG0yrb/bJGe5ClXvNqSAcRK3b7ETbx
         ApWMhajAkNXSB211DyPNWwiknW38dlLSp6R8Aa0U=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A1EEE667AC;
        Tue,  5 Jul 2022 06:00:54 -0400 (EDT)
Message-ID: <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>, Qi Hu <huqi@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 05 Jul 2022 18:00:52 +0800
In-Reply-To: <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
References: <20220704153612.314112-1-huqi@loongson.cn>
         <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
         <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 17:49 +0800, Xi Ruoyao wrote:
> On Tue, 2022-07-05 at 16:46 +0800, WANG Xuerui wrote:
>=20
> > Actually I'm still not very satisfied with the explanation; the code
> > must be written with *something* in mind, since GS464V/LA464 is the onl=
y=20
> > LoongArch implementation so far, it must have a VCSR to begin with. And=
=20
> > you can't magically melt the VCSR on the tens of thousands of=20
> > 3A5000/3C5000's already shipped, because the old-world kernel obviously=
=20
> > comes with LSX/LASX and it most likely utilizes the VCSR. In addition,
> > you didn't mention what will happen if LSX/LASX *is* enabled on this
> > new-world kernel, *and* fcsr16 is being accessed.
> >=20
> > I think maybe you just want to remove the mentions of VCSR since they=
=20
> > are dead code right now, as I don't believe it's gone in shipped=20
> > hardware, as explained above. Except if there's magically a way to=20
> > implement LSX/LASX without touching the said-to-have-disappeared VCSR,
> > which I don't know of, and can't know because the LSX/LASX ISA manual i=
s=20
> > still not publicly accessible; so I don't feel comfortable approving
> > this patch.
>=20
> Let me make some bold guess here.=C2=A0 In the MIPS-compatible 3A4000 we =
had
> "MSACSR" register.=C2=A0 According to the MSA manual, only the 24-th bit =
of
> this register is used:
>=20
> "Some MSA floating point instructions might not handle subnormal input
> operands or compute tiny non-zero results. Such instructions may signal
> the Unimplemented Operation Exception and let the software emulation
> finalize the operation. If software emulation is not needed or desired,
> MSACSR FS bit could be set to replace every tiny non-zero result and
> subnormal input operand with zero of the same sign."
>=20
> And, it says:
>=20
> "Should the alternate exception handling attributes of the IEEE Standard
> for Floating-Point Arithmetic 754-2008, Section 8 be desired, the MSACSR
> FS bit should be zero, the Underflow Exception be enabled and a trap
> handler be provided to carry out the execution of the alternate
> exception handling attributes."
>=20
> We can see Loongson has been trying to make 3A processors more IEEE-754
> compatible.=C2=A0 For example, 3A4000 is the only non-R6 MIPS-compatible
> processor using IEEE-754-2008 NaN encoding.=C2=A0 And LoongArch manual
> directly refers to IEEE-754-2008 manual in many places.=C2=A0 So I guess =
this
> change means Loongson won't set this bit to 1 for 3A5000 at all, and any
> attempt by the user to set this bit could be considered undefined
> behavior (causing inconsistent behavior on 3A5000 as the kernel doesn't
> save/restore VCSR at context switch, and SIGILL on 3A6000 as the
> register is removed).

P. S. I'm just playing an "intelligence game" writing the reply so maybe
I'm completely wrong.  And, it does not indicate any position of me or
my affiliation about some "controversial topics".  And, even if my guess
is correct, it's still better to add something like "the use of VCSR is
optional in LA464 and we've decided to remove it in future
architectures, so it's not supported to use it even on LA464" into the
commit message.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
