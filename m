Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5775838EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiG1Gli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiG1GlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:41:22 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839E50728
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1658990480;
        bh=fDQSFbUZY0M91qUtS+Iv4m66BChIz9OnKWn9rwXW7a8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EL+39Ph7bEITu8PzwGES+iF6ugZ9jlOeunCVSXGJ/r1RIVqM3360AImW/NUIrgarS
         tvBU4piCpYWB1LawjkV0fIrMdUepuC7gXpV16UmhLKp1tmcYOs72hjXAQ0GvBg5Nqo
         AQVwO0r1Sh+qFccIn8+RxdKMUj1TnYecvIwKA4Qg=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id D8A62669E8;
        Thu, 28 Jul 2022 02:41:18 -0400 (EDT)
Message-ID: <9a79a424a11339ae025539c38fe121104ff00804.camel@xry111.site>
Subject: Re: [PATCH 3/5] LoongArch: Support relocation against
 _GLOBAL_OFFSET_TABLE_
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 14:41:16 +0800
In-Reply-To: <10c1e0f9-8409-a0f4-9b18-a5f56dfb14e1@loongson.cn>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
         <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
         <10c1e0f9-8409-a0f4-9b18-a5f56dfb14e1@loongson.cn>
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

On Thu, 2022-07-28 at 09:02 +0800, Jinyang He wrote:

> Hi, Ruoyao,
>=20
> It is possible to create a symbol when linking, which means
> maybe we can add _GLOBAL_OFFSET_TABLE_ in 'module.lds.h'.
> What do you think about it?

Hi Jinyang,

I think you are right, this patch can be replaced with the following,
which is much simpler.

-- >8 --

With the stack-based relocations, the assembler emits three relocations
to push the PC-relative offset of a GOT entry:

    R_LARCH_SOP_PUSH_PCREL _GLOBAL_OFFSET_TABLE_
    R_LARCH_SOP_PUSH_GPREL foo
    R_LARCH_SOP_ADD

In normal relocatable ELF object files, "_GLOBAL_OFFSET_TABLE_" is
undefined in the symtab and the BFD linker generates it on final link.
Define it for kernel modules so we will be able to really use
R_LARCH_SOP_PUSH_GPREL relocation.

Note that we need to use "HIDDEN" to make it a local symbol because each
kernel module has its own GOT and the reference to it should not be
resolved to the GOT in the main kernel image.

Suggested-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/module.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/inclu=
de/asm/module.lds.h
index 57bbd0cedd26..42b7cca0b947 100644
--- a/arch/loongarch/include/asm/module.lds.h
+++ b/arch/loongarch/include/asm/module.lds.h
@@ -4,5 +4,5 @@ SECTIONS {
 	. =3D ALIGN(4);
 	.plt : { BYTE(0) }
 	.plt.idx : { BYTE(0) }
-	.got : { BYTE(0) }
+	.got : { HIDDEN(_GLOBAL_OFFSET_TABLE_ =3D .); BYTE(0) }
 }
--=20
2.37.0
