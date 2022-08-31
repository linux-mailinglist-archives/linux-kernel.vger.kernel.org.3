Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9B5A8100
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiHaPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:15:03 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D4E03C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661958898;
        bh=BlVCgitrI63+r41RaeryVWbY979iIr715rBBnGduC/g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lDymn/TlcAy5sN2pQ4khdXOyFqUXQ3A47J5V7gGatywkDi+HOdJvzRPZkJrMwUrLU
         4mQOxqEDFYmXbzKm7gkdz/xpIBROAiaNLuQVZ8RYjMFCui1zH2aRQDiw9Rhhhcg3+w
         VrXnSsxliQ4GQNItfD9vc5b7/AZEQjhqBV55mrnk=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4E6B966794;
        Wed, 31 Aug 2022 11:14:57 -0400 (EDT)
Message-ID: <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Date:   Wed, 31 Aug 2022 23:14:55 +0800
In-Reply-To: <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
References: <20220830104806.128365-1-xry111@xry111.site>
         <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
         <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
         <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
         <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
         <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn>
         <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
         <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
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

On Wed, 2022-08-31 at 22:40 +0800, Huacai Chen wrote:
> On Wed, Aug 31, 2022 at 4:09 PM Xi Ruoyao <xry111@xry111.site> wrote:
> >=20
> > On Wed, 2022-08-31 at 14:58 +0800, Jinyang He wrote:
> > > That's right. Also I am wondering why new toolchain produce .got* in
> > > kernel. It's unneeded. In the past, gcc create la.global and parsed
> > > to la.pcrel by gas, and kernel works well. Now it seems we lost this
> > > feature in gcc. I checked the x86 asm code just now. And some info
> > > follows,
> > >=20
> > > LoongArch64, ./net/ipv4/udp_diag.s, *have reloc hint*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcalau12i=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $r4,%got_pc_hi20(udplite_table)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ld.d=C2=A0=C2=
=A0=C2=A0 $r4,$r4,%got_pc_lo12(udplite_table)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 udp_dump
> > >=20
> > > x86_64, ./net/ipv4/udp_diag.s
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 movq=C2=A0=C2=
=A0=C2=A0 $udplite_table, %rdi
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jmp=C2=A0=C2=
=A0=C2=A0=C2=A0 udp_dump
> > >=20
> > > It seems related to -fno-PIE and -cmodel=3Dkernel on x86_64.
> > > Hope new gcc with this feature now.
> >=20
> > On x86_64 -mcmodel=3Dkernel means "all code and data are located in [-
> > 2GiB, 0) range.=C2=A0 We actually don't strictly require a "high" range=
 as
> > we're mostly a PIC-friendly architecture: note that we use a
> > pcalau12i/addi.d pair for PIC addressing in [PC-2GiB, PC+2GiB, and a
> > lu12i.w/addi.d pair for "non-PIC" addressing in [-2GiB, 2GiB), both are
> > 2-insn sequence.
> >=20
> > If we can put the main kernel image and the modules in one 2GiB VA
> > range, we can avoid GOT completely.=C2=A0 But it's not possible for now
> > because main kernel image is loaded in XKPRANGE but the modules are in
> > XKVRANGE.=C2=A0 So the best we can achieve before implementing
> > CONFIG_RELOCATION is using GOT in modules, and avoid GOT in the main
> > kernel image (with a new code model in GCC, which will benefit both the
> > kernel and statically linked executables).

> Emmm, can you implement this new code model in the near future?

I have a plan to make our toolchain addressing the symbols better:

(1) https://sourceware.org/pipermail/binutils/2022-August/122682.html.=20
This change will allow the linker to link a main executable image
(dynamically linked or statically linked, PIE or non-PIE, kernel or
userspace) with R_LARCH_COPY instead of GOT.  (Note that R_LARCH_COPY
will not show up in the kernel because we don't link to shared objects,
but GOT will be gone.)

(2) Change GCC to stop using GOT unless -fPIC.  (Technically it's a one-
line change.)

(3) In kernel, for main kernel image the default of toolchain will be
good enough (no GOT).  For modules we have two options:

  (a) get rid of XKPRANGE.
  (b) force -mcmodel=3Dextreme globally.
  (c) use -Wl,nocopyreloc to produce GOT.

(a) is the best, the performance of (b) and (c) will be worse than (a).
I'm not sure which one in (b) and (c) is better, but as (a) will be the
final solution we can just choose one in (b) and (c) "randomly" for now.

I don't want to add a new code model now, because if (1) works fine
we'll not need a new code model.  (1) is also the most tricky step in
the plan (I've sent the patch but not sure if it's completely correct),
(2) and (3) should be trivial.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
