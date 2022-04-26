Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49D50F1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiDZHLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343784AbiDZHJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:09:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F5637033
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:06:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EC7E23A;
        Tue, 26 Apr 2022 00:06:22 -0700 (PDT)
Received: from e129167.arm.com (unknown [10.57.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05D3E3F73B;
        Tue, 26 Apr 2022 00:06:20 -0700 (PDT)
From:   Michal Orzel <michal.orzel@arm.com>
To:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.orzel@arm.com, bertrand.marquis@arm.com
Subject: [PATCH] arm64: cputype: Avoid overflow using MIDR_IMPLEMENTOR_MASK
Date:   Tue, 26 Apr 2022 09:06:03 +0200
Message-Id: <20220426070603.56031-1-michal.orzel@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value of macro MIDR_IMPLEMENTOR_MASK exceeds the range of integer
and can lead to overflow. Currently there is no issue as it is used
in expressions implicitly casting it to u32. To avoid possible
problems, fix the macro.

Signed-off-by: Michal Orzel <michal.orzel@arm.com>
---
Should we also add a U suffix to ARM_CPU_IMP_* macros that are also shifted
by MIDR_IMPLEMENTOR_SHIFT? None of them has bit 7 set but we could take some
precaution steps.
---
 arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index ff8f4511df71..92331c07c2d1 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -36,7 +36,7 @@
 #define MIDR_VARIANT(midr)	\
 	(((midr) & MIDR_VARIANT_MASK) >> MIDR_VARIANT_SHIFT)
 #define MIDR_IMPLEMENTOR_SHIFT	24
-#define MIDR_IMPLEMENTOR_MASK	(0xff << MIDR_IMPLEMENTOR_SHIFT)
+#define MIDR_IMPLEMENTOR_MASK	(0xffU << MIDR_IMPLEMENTOR_SHIFT)
 #define MIDR_IMPLEMENTOR(midr)	\
 	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
 
-- 
2.25.1

