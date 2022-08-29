Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6F5A4FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiH2PCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH2PCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:02:48 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0485A9C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661785363;
        bh=P0So/d1QHvZh/G4+ijTFNIkaXwtW+51RX8yFY1F9e6Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SNXxaCpVH8BLpiKMYNfVMPX5HvyElAUAwMtcmZu+HwbE9GvPxhY4zfKNj8bUsS1mp
         wcaJ9lbFKot2YOykwAPcPcp9EsvTkJnNAXPmsp5bmPbjNNfFohHlF4ZpHESvi2IH8e
         B6ZK9xOP0qQ5U4biZl12cXlO6f9kHChQInPCLmww=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 34143667AA;
        Mon, 29 Aug 2022 11:02:42 -0400 (EDT)
Message-ID: <5f9d3aa5fad957dae2f14e483b3b79dbcf9e794d.camel@xry111.site>
Subject: Re: [PATCH v6 3/6] LoongArch: Use model("extreme") attribute for
 per-CPU variables in module if CONFIG_AS_HAS_EXPLICIT_RELOCS
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Mon, 29 Aug 2022 23:02:40 +0800
In-Reply-To: <20220829133146.15236-4-xry111@xry111.site>
References: <20220829133146.15236-1-xry111@xry111.site>
         <20220829133146.15236-4-xry111@xry111.site>
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

On Mon, 2022-08-29 at 21:31 +0800, Xi Ruoyao wrote:
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 1563747c4fa8..593818a61741 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -53,6 +53,9 @@ LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0+=3D -G0 -static -n -nostdlib
> =C2=A0# combination of a "new" assembler and "old" compiler is not suppor=
ted.=C2=A0 Either
> =C2=A0# upgrade the compiler or downgrade the assembler.
> =C2=A0ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
> +ifeq ($(shell echo '__has_attribute(model)' | $(CC) -E -P - 2> /dev/null=
), 0)
> +$(error "C compiler must support model attribute if using explicit reloc=
s")
> +endif

Self review:

I'm wondering if we really need this thing...  There won't be a GCC
version released with explicit relocation but without model attribute
(GCC 13 starts to support them both).

But without a check, if someone uses an early GCC 13 snapshot and
ignores the -Wattributes warning, the system will suddenly blow up
loading a module with per-CPU variable defined.

Maybe "-Werror=3Dattributes" is better, but is it OK to add a -Werror=3D
option for entire Linux tree?

> =C2=A0cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0+=3D -mexplicit-relocs
> =C2=A0else
> =C2=A0cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0+=3D $(call cc-option,-mno-explicit-relocs)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
