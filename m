Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72F5582F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiG0R1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiG0R1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:10 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A16A6051A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1658940417;
        bh=7ILEiHkZaaxtluhCY7IN0k/C4z/OAzKEwdfgQuLQnP8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mpLqyFpBqF9FNRtrKpzraGF8g9SzmkzzzmdF5BuoUAYv/6S1va6AMpCFQ8b1wYMuM
         6ubR9vwpgdSJ7dq1/KqEfm42+kkJW+rKsauiI24h5O+0X0SeogAIYz+9RygPM1uX4C
         qO/9Y6dmrvBl/5jdqIL0InWp0I8S2nUmPCpDeG5Y=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7E4596685A;
        Wed, 27 Jul 2022 12:46:55 -0400 (EDT)
Message-ID: <aced7303ca2a4130b73cfa46d7a25c1f4812a651.camel@xry111.site>
Subject: Re: [PATCH 0/5] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 00:46:53 +0800
In-Reply-To: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
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

Self notes:

With "-mla-global-with-pcrel" in KBUILD_CFLAGS_KERNEL gone (even if I
don't remove it, it will be ineffective with binutils-2.40/gcc-13), the
kernel will use GOT to access the objects in other translation units.=20
It may cause a performance regression.

*If* such a performance regression is really observed, we need to change
GCC to use PC relative addressing (instead of GOT) for loading external
objects when -fno-PIC.  Such a change will benefit userspace apps as
well, *if* PC relative addressing is really faster than GOT access.

(Emphasize "if" here: I've not run any benchmarks yet.)

I'll be mostly AFK in the following one or two weeks, apologize for
possible slow respond.

On Thu, 2022-07-28 at 00:24 +0800, Xi Ruoyao wrote:
> The version 2.00 of LoongArch ELF ABI specification introduced new
> relocation types, and the development tree of Binutils and GCC has
> started to use them.=C2=A0 If the kernel is built with the latest snapsho=
t of
> Binutils or GCC, it will fail to load the modules because of unrecognized
> relocation types in modules.
>=20
> Add support for GOT and new relocation types for the module loader, so
> the kernel (with modules) can be built with the "normal" code model and
> function properly.
>=20
> Tested by building the kernel with Binutils & GCC master branch, and
> running the kernel with 35 in-tree modules loaded.
>=20
> Link: https://github.com/loongson/LoongArch-Documentation/pull/57
> Link: https://gcc.gnu.org/r13-1834
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Df09=
482a
>=20
> Xi Ruoyao (5):
> =C2=A0 LoongArch: Add section of GOT for kernel module
> =C2=A0 LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kerne=
l
> =C2=A0=C2=A0=C2=A0 module
> =C2=A0 LoongArch: Support relocation against _GLOBAL_OFFSET_TABLE_
> =C2=A0 LoongArch: Stop using undocumented assembler options
> =C2=A0 LoongArch: Support modules with new relocation types
>=20
> =C2=A0arch/loongarch/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +-
> =C2=A0arch/loongarch/include/asm/elf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 37 ++++++++++
> =C2=A0arch/loongarch/include/asm/module.h=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++=
++++
> =C2=A0arch/loongarch/include/asm/module.lds.h |=C2=A0 1 +
> =C2=A0arch/loongarch/kernel/head.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +--
> =C2=A0arch/loongarch/kernel/module-sections.c | 72 +++++++++++++++++--
> =C2=A0arch/loongarch/kernel/module.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 94 +++++++++++++++++++++++++
> =C2=A07 files changed, 229 insertions(+), 13 deletions(-)
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
