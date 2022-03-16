Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC864DB807
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357750AbiCPSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbiCPSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B843F55204
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556D0618CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808AFC340E9;
        Wed, 16 Mar 2022 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647455918;
        bh=4I2dqIsVLhZjm8CnyFJ7pDn7LPMROJTBLGpZPLGAP1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=t8k6kmURw5+vEqAankWi7xR5393jq2B2dTT6kRbbvlzSuA3N9Wzxe5sR5t4IiJ7hS
         MF8jtysqZtFol5FQSA2ItMQbSuOeOSno8XJJVq69g8QwwroQo3meoToEM5Y2A4XbKp
         lZGjVUX7Yxom72fOEIHmsin0Q8O0GCvdcVfkQxSwJ+0BNIe7xlP2JIuxYfcqyVEnyJ
         BJCugmhH6pIBKU72w0XIjzRzQccQYx5cJQsQyZ2i9H4/trUXekogPPq4abFL3CE8wO
         F0PzVZGGXhXL8hjV6FGBiOi13fAmbcrmy1Dm/TmIZJC02opyIs/PF4RCO6hrJVp2SK
         AFs9eozuUQDjQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] arm64: fix clang warning about TRAMP_VALIAS
Date:   Wed, 16 Mar 2022 19:38:18 +0100
Message-Id: <20220316183833.1563139-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced TRAMP_VALIAS definition causes a build warning
with clang-14:

arch/arm64/include/asm/vectors.h:66:31: error: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Werror,-Wnull-pointer-arithmetic]
                return (char *)TRAMP_VALIAS + SZ_2K * slot;

Change the addition to something clang does not complain about.

Fixes: bd09128d16fa ("arm64: Add percpu vectors for EL1")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/vectors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

I see this warning on 5.17-rc8, but did not test it on linux-next,
which may already have a fix.

diff --git a/arch/arm64/include/asm/vectors.h b/arch/arm64/include/asm/vectors.h
index f64613a96d53..bc9a2145f419 100644
--- a/arch/arm64/include/asm/vectors.h
+++ b/arch/arm64/include/asm/vectors.h
@@ -56,14 +56,14 @@ enum arm64_bp_harden_el1_vectors {
 DECLARE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector);
 
 #ifndef CONFIG_UNMAP_KERNEL_AT_EL0
-#define TRAMP_VALIAS	0
+#define TRAMP_VALIAS	0ul
 #endif
 
 static inline const char *
 arm64_get_bp_hardening_vector(enum arm64_bp_harden_el1_vectors slot)
 {
 	if (arm64_kernel_unmapped_at_el0())
-		return (char *)TRAMP_VALIAS + SZ_2K * slot;
+		return (char *)(TRAMP_VALIAS + SZ_2K * slot);
 
 	WARN_ON_ONCE(slot == EL1_VECTOR_KPTI);
 
-- 
2.29.2

