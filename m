Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E5D4AE21A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385962AbiBHTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385929AbiBHTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:17:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A7C0612C0;
        Tue,  8 Feb 2022 11:17:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8228DB81CBE;
        Tue,  8 Feb 2022 19:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30DDC004E1;
        Tue,  8 Feb 2022 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644347872;
        bh=tM3+yTNfndQKhKxV0q8n28hJCRchdQiyxSD4fHX/LUs=;
        h=From:To:Cc:Subject:Date:From;
        b=bxWFxuFCPOdRvgaYNBs/mKRcWsM4tX71d978uaf5gB+B2EP+NuYva09aLB2QafYS6
         heBjMhyM254fh69jsPIxS4xUX8sFXMNA1X7OdziR18Qn4FR5Iw2KLd/JWYcvEHg1LL
         S5zLxThkyfJuvI/Cs0MPeufE6F4f1q53XaqcDBu1zZRgQPf8a5MQgWzS2mwNkItGnW
         pQ8lidZqtYxa0Lekfun8QLLkVfwB5wlfUKh7UvIOK/VvHcE43sH72h3HwojK7XkuwH
         6pTLLtlLkOMvAsI+Aq4zi/CpdAYttZ4GOWHpQ3rh8gcXlQvkxygr5n3Ay9rPScmZuB
         uFOW1mO7mqo5Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] MIPS: Malta: Enable BLK_DEV_INITRD
Date:   Tue,  8 Feb 2022 12:17:26 -0700
Message-Id: <20220208191726.1304731-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration is useful for boot testing malta_defconfig in QEMU
with just a simple cpio initrd, instead of a full ext4 rootfs.

This results in an increase of ~164KB of vmlinux (with GCC 11.2.0):

$ diskus vmlinux.before
11.19 MB (11,194,368 bytes)

$ diskus vmlinux.after
11.36 MB (11,358,208 bytes)

This size increase comes from the fact that usr/Kconfig is sourced when
CONFIG_BLK_DEV_INITRD is enabled, which defaults to supporting several
decompression algorithms for compressed initrds. This seems like a
reasonable tradeoff but these configurations could be disabled in the
future if there are complaints about the size increase.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/mips/configs/malta_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 3321bb576944..3456ac8ded6c 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -4,6 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_NAMESPACES=y
 CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y

base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.35.1

