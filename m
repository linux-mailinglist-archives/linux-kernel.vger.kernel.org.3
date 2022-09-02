Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607405AADB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiIBLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiIBLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:31:09 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9240101FB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662118051;
        bh=rFyj/oy6Tq5oo4+SvgvXbAA+R2fXY5QC8A9hGOZ0HHM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fOVkMWdp0pxK2RWZpFq34GF6+sKwscbm/IhvLZqKS6peqvOIjMQjQd0TZ+ft20b44
         GdYAomPWU0U2r/P51r6e6UmGk1FRbMge/rx/h2FteoS3MH3MxOEU60Z44ElUe1xQ3K
         TXILwbifVC389WOymN3/TjyARzpLtTIaAU4Jpa4M=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 72E2C6682D;
        Fri,  2 Sep 2022 07:27:30 -0400 (EDT)
Message-ID: <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Fri, 02 Sep 2022 19:27:28 +0800
In-Reply-To: <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
         <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
         <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-02 at 19:10 +0800, Xi Ruoyao wrote:
> Hi Youling,
>=20
> On Fri, 2022-09-02 at 18:08 +0800, Youling Tang wrote:
> > This tool is based on the arch/mips/boot/tools/relocs tool.
>=20
> I've dig some history of MIPS relocatable kernel
> (https://lwn.net/Articles/682020/):
>=20
> =C2=A0=C2=A0 * Kernel is compiled & statically linked as normal, with no =
position
> =C2=A0=C2=A0=C2=A0=C2=A0 independent code. MIPS before R6 only has limite=
d relative jump
> =C2=A0=C2=A0=C2=A0=C2=A0 instructions so the vast majority of jumps are a=
bsolute. To compile
> =C2=A0=C2=A0=C2=A0=C2=A0 the kernel position independent would introduce =
a highly undesireable
> =C2=A0=C2=A0=C2=A0=C2=A0 overhead. Relocating the static binary gives a s=
mall startup time
> =C2=A0=C2=A0=C2=A0=C2=A0 penalty but the kernel otherwise perforns normal=
ly.
>=20
> Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
> currently LoongArch toolchain always produces PIC (except, if -Wa,-mla-
> {local,global}-with-abs or la.abs macros are used explicitly).
>=20
> So would it be easier to review and correct the uses of "la.abs" in the
> code, and make the main kernel image a real PIE?=C2=A0 Then we can load i=
t
> everywhere w/o any need to do relocation at load time.

Arrgh, doing so will need to get rid of GOT (the GCC patch for this is
still under review) or we still need to relocate the GOT at least :(.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
