Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFF5ADED6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiIFFR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiIFFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:17:52 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3386BCD7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662441468;
        bh=NsoOFwFx0AaCpoovCG8Ki6hZzXU3jxwvWcd2PK9PRqU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hp7IQRiDpU6Bbdl1RyNiTcuOZCsE3I/D4feOVWr+fTnOOcwVUaG6ugNw9L0PSYpDA
         xGCIEEBIMc4/efYr4wG+whO2rrSX3FZEAaDSuXJV1gfoTjjQyFdhm4UgnA4y99Tx0y
         1PViNCnZGTL9hCxrmuonolCKIVEM67AbU4Cetfbo=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1889965C56;
        Tue,  6 Sep 2022 01:17:46 -0400 (EDT)
Message-ID: <a218373f773ef193903daa528291ec8bb384ddd2.camel@xry111.site>
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Tue, 06 Sep 2022 13:17:45 +0800
In-Reply-To: <29cd929b-185b-1c4b-f200-08f2a724b59d@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
         <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
         <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
         <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
         <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
         <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
         <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
         <0b2d115c42ff6cb9b8c65d852ec2f0746ca6e8d9.camel@xry111.site>
         <d852f590-95b4-3fd1-924a-68c0a6bb1b1b@loongson.cn>
         <29cd929b-185b-1c4b-f200-08f2a724b59d@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.3 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-06 at 10:16 +0800, Youling Tang wrote:

> Switch to relative exception tables:
>=20
> https://github.com/tangyouling/linux/commit/6525b8da
> https://github.com/tangyouling/linux/commit/b6ac0827
>=20
> Will switch to the relative exception tables after applying the above
> two patches. So there is no need to relocate the exception table
> (remove relocate_exception_table).
>=20
> Now we can remove the relocation of la.abs , got and ex_table, but
> still need to relocate LARCH_64. Is there anything else that needs to
> be modified to eliminate this relocation?

You may see the RISC-V patch as a reference:

https://lore.kernel.org/all/20211009171259.2515351-2-alexandre.ghiti@canoni=
cal.com/

Basically, make the linker to generate R_*_RELATIVE instead of R_*_64
for pointers.  And, perform R_*_RELATIVE relocation loading the kernel.

Something problematic IMO: RISC-V uses "-shared" to trick the linker to
generate R_*_RELATIVE but I consider it ugly (if the kernel is a shared
library, my grandma will be a wagon!)  I prefer "-pie -static", but our
Glibc does not have static-pie support for now.  It won't really affect
the kernel (we are -nostdlib), but we cannot learn how to handle
R_*_RELATIVE in static pie from Glibc then.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
