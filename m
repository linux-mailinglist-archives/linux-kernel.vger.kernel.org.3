Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B31583FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiG1NbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiG1Nat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:30:49 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D720F53
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659015046;
        bh=5oTiHyOqGMawFY6tGFgbqtXOrPzO1JFb4QEGmlDiFJ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T54MoILf1qdvnrImPAyGaR/fk8q5mQMl1TZGl8Xf4ongKnRPe8RGkbU/TZrSpsTXZ
         cstEVYH+ytGW4V0KbquVJ3QoIq3jtRBsOErQfTpre/ZYEhMMtT2NlbCFgtkPS+ZWEg
         1LYw9k1bFEJqqn1xJoJrDOP0cxh2rAOR0nwJJQEc=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A808166970;
        Thu, 28 Jul 2022 09:30:44 -0400 (EDT)
Message-ID: <20d86df48af5e0f0f17a1b1bc6b365d1c158280f.camel@xry111.site>
Subject: Re: [PATCH v2 4/4] LoongArch: Support modules with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Thu, 28 Jul 2022 21:30:42 +0800
In-Reply-To: <1c1b5d2f-84f0-534c-ace2-2da48b5a7419@loongson.cn>
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
         <93087353ec0d23c56345d4c05e3d9719b284942c.camel@xry111.site>
         <1c1b5d2f-84f0-534c-ace2-2da48b5a7419@loongson.cn>
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

On Thu, 2022-07-28 at 20:41 +0800, Youling Tang wrote:
> Unaligned is handled more efficiently before overflow checking, while
> being consistent with apply_r_larch_sop_imm_field.

Will move unaligned before overflow in V3.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*location &=3D ~(u32)0x3ffff=
ff;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*location |=3D (offset >> 18=
) & 0x3ff;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*location |=3D ((offset >> 2=
) & 0xffff) << 10;
>=20
> It may be better to use the loongarch_instruction format to modify the
> immediate field of the instruction, similar to the following:
>=20
> union loongarch_instruction *insn =3D (union loongarch_instruction *)loca=
tion;
>=20
> offset >>=3D 2;
> insn->reg0i26_format.immediate_l =3D offset & 0xffff;
> insn->reg0i26_format.immediate_h =3D (offset >> 16) & 0x3ff;

Will use union loongarch_instruction in V3.  Why didn't I notice it
before? :(

Thanks for the review!

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
