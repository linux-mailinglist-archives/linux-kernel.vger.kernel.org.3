Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37025849C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiG2CaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiG2CaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:30:01 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD87AB35
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659061797;
        bh=fTlP0CuEA0WSeT1/OShyf0j1Ca8AYpjBY4e4Mf9jVJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nihWEJV59BFCRJaoTnpQ5dcKwLycOwOSZWDc1kK6fUsI3ryW7GYPxAH18ml9p3ZTs
         N/2FeTj+4dzRhqTfBJoj+jflXEKD5k5TqoBEmieDZyD1AwkggyLFwKSWOz12gLpUA1
         0aMsbZGtcuOISVMe8LSKRhFMcanI6Ne6yvuNJJRs=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 43A3366B51;
        Thu, 28 Jul 2022 22:29:55 -0400 (EDT)
Message-ID: <a30e39a1b41dc63fff32b8d350fecb92dfe27d09.camel@xry111.site>
Subject: Re: [PATCH v3 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 10:29:53 +0800
In-Reply-To: <879dc428-0407-3280-617d-840352aa6d08@loongson.cn>
References: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
         <879dc428-0407-3280-617d-840352aa6d08@loongson.cn>
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

On Fri, 2022-07-29 at 10:23 +0800, Youling Tang wrote:
> Hi, Ruoyao
>=20
> On 07/29/2022 10:07 AM, Xi Ruoyao wrote:
> > The version 2.00 of LoongArch ELF ABI specification introduced new
> > relocation types, and the development tree of Binutils and GCC has
> > started to use them.=C2=A0 If the kernel is built with the latest snaps=
hot of
> > Binutils or GCC, it will fail to load the modules because of unrecogniz=
ed
> > relocation types in modules.
> >=20
> > Add support for GOT and new relocation types for the module loader, so
> > the kernel (with modules) can be built with the "normal" code model and
> > function properly.
> >=20
> > This series does not break the compatibility with old toolchain using
> > stack-based relocation types, so with the patches applied the kernel ca=
n
> > be be built with both old and new toolchains.
> >=20
> > Tested by building the kernel with both Binutils & GCC master branch an=
d
> > my system Binutils & GCC (without new relocation type support), running
> > both the builds with 35 in-tree modules loaded, and loading one module
> > with 20 GOT loads (loaded addresses verified by comparing with
> > /proc/kallsyms).
> >=20
> > Changes from v2 to v3:
> >=20
> > - Use `union loongarch_instruction` instead of explicit bit shifts
> > =C2=A0 applying the relocation.=C2=A0 Suggested by Youling.
> > - For R_LARCH_B26, move the alignment check before the range check to b=
e
> > =C2=A0 consistent with stack pop relocations.=C2=A0 Suggested by Youlin=
g.
> > - Reword the commit message of the 3rd patch.=C2=A0 Suggested by Huacai=
.
>=20
> The log of changes from v1 to v2 should be preserved.
>=20
Retroactively, append the changes from v1 to v2:

- Fix a stupid programming error (confusion between the number of PLT
  entries and the number of GOT entries).  (Bug spotted by Youling).
- Synthesize the _GLOBAL_OFFSET_TABLE_ symbol with module.lds, instead
  of faking it at runtime.  The 3rd patch from V1 is now merged into
  the 1st patch because it would be a one-line change.  (Suggested by
  Jinyang).
- Keep reloc_rela_handlers[] ordered by the relocation type ID.
  (Suggested by Youling).
- Remove -fplt along with -Wa,-mla-* options because it's the default.
  (Suggested by Youling).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
