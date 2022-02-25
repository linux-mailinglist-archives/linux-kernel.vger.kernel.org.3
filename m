Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CF4C42BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiBYKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiBYKuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:50:01 -0500
X-Greylist: delayed 524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 02:49:30 PST
Received: from mail.sysgo.com (mail.sysgo.com [IPv6:2a01:4f8:150:204a::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05088235315
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:49:29 -0800 (PST)
From:   David Engraf <david.engraf@sysgo.com>
To:     suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        broonie@kernel.org, mark.rutland@arm.com, elver@google.com,
        ebiederm@xmission.com, seanjc@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] arm64: signal: nofpsimd: Do not allocate fp/simd context when not available
Date:   Fri, 25 Feb 2022 11:40:08 +0100
Message-Id: <20220225104008.820289-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for
signal frames") introduced saving the fp/simd context for signal handling
only when support is available. But setup_sigframe_layout() always
reserves memory for fp/simd context. The additional memory is not touched
because preserve_fpsimd_context() is not called and thus the magic is
invalid.

This may lead to an error when parse_user_sigframe() checks the fp/simd
area and does not find a valid magic number.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 arch/arm64/kernel/signal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index d8aaf4b6f432..3d66fba69016 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -577,10 +577,12 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 {
 	int err;
 
-	err = sigframe_alloc(user, &user->fpsimd_offset,
-			     sizeof(struct fpsimd_context));
-	if (err)
-		return err;
+	if (system_supports_fpsimd()) {
+		err = sigframe_alloc(user, &user->fpsimd_offset,
+				     sizeof(struct fpsimd_context));
+		if (err)
+			return err;
+	}
 
 	/* fault information, if valid */
 	if (add_all || current->thread.fault_code) {
-- 
2.25.1

