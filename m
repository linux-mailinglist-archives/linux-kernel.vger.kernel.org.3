Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB9478CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbhLQOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLQOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:00:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5EC061574;
        Fri, 17 Dec 2021 06:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D82EB82809;
        Fri, 17 Dec 2021 14:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D893C36AE7;
        Fri, 17 Dec 2021 14:00:27 +0000 (UTC)
Date:   Fri, 17 Dec 2021 14:00:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [next] arm64: efi-rt-wrapper.S:8: Error: unknown mnemonic `bti'
 -- `bti c'
Message-ID: <YbyX+I2PBwio0MYk@arm.com>
References: <CA+G9fYt-k1daHarGoXKz7uYvsAcDMNM2bk7jRcYBNf0sRE=+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt-k1daHarGoXKz7uYvsAcDMNM2bk7jRcYBNf0sRE=+LQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Naresh for the report.

On Thu, Dec 16, 2021 at 09:30:44AM +0530, Naresh Kamboju wrote:
> [ Please ignore this email if it is already reported ]
> 
> While building Linux next 20211215 arm64 defconfig with gcc-8
> following warnings / errors noticed.
> and gcc-9, gcc-10 and gcc-11 builds pass.
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/current \
>   ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
>   CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- \
>   'CC=sccache aarch64-linux-gnu-gcc' \
>   'HOSTCC=sccache gcc'
> 
> /builds/linux/arch/arm64/kernel/efi-rt-wrapper.S: Assembler messages:
> /builds/linux/arch/arm64/kernel/efi-rt-wrapper.S:8: Error: unknown
> mnemonic `bti' -- `bti c'
> make[3]: *** [/builds/linux/scripts/Makefile.build:411:
> arch/arm64/kernel/efi-rt-wrapper.o] Error 1

We defined the bti macro in assembler.h but that's not included by
linkage.h and not all asm files seem to include the former. At a quick
grep we need the diff below, not sure it's the best solution:

diff --git a/arch/arm64/crypto/nh-neon-core.S b/arch/arm64/crypto/nh-neon-core.S
index 51c0a534ef87..bf6f7ee46d63 100644
--- a/arch/arm64/crypto/nh-neon-core.S
+++ b/arch/arm64/crypto/nh-neon-core.S
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 	KEY		.req	x0
 	MESSAGE		.req	x1
diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 75691a2641c1..9fde85521146 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 SYM_FUNC_START(__efi_rt_asm_wrapper)
 	stp	x29, x30, [sp, #-32]!
diff --git a/arch/arm64/kernel/reloc_test_syms.S b/arch/arm64/kernel/reloc_test_syms.S
index c50f45fa29fa..57bf78446a29 100644
--- a/arch/arm64/kernel/reloc_test_syms.S
+++ b/arch/arm64/kernel/reloc_test_syms.S
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 SYM_FUNC_START(absolute_data64)
 	ldr	x0, 0f

-- 
Catalin
