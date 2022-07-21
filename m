Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DD57C3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiGUF6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiGUF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:57:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0076F78592
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k64-20020a253d43000000b0067080eb57fdso587766yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iLoEKCBMnlFKYYYcN0OANFAEglV5FtD84V5LcwTvHwg=;
        b=iOS+USjx9NgCbUY4yL44SP1DEiSpvV4mn2X29qjPNJNxKeAXL+qsxjnw4XKuHrWeBy
         QD0Wm6fBKb8nu9zx4zo5TptOXWfccSlTjHBGDDSGFcaD8PPGK+TGhkHKPtLrzs/KbRJb
         H1SNm2km8Suv1iEJCtBPfDgjv+umAyAcBIe7aADByBmfws/QIkHBnZGLBs2FyCKyknys
         Gtc+j9+p2a6y9rCrUFts1wK/l0PmmdJjS5v5wA2EQwS66QfFDOyrTjSXddAEmXiHYdcB
         AeG3gM/Zw1g5oLlyQyCa7GCwb20o7b95xy2/Spd817zI5klqXWnSZI3hO3OG78CFY969
         RoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iLoEKCBMnlFKYYYcN0OANFAEglV5FtD84V5LcwTvHwg=;
        b=FSh/46kgX7qUoJxBHrafFmaAdZ+oy7LF2Hgu3DlMVpNt/R/byALwcMCOVM60JZc2xe
         5WrkcGo2IU/pamLQrth0OxV6k0q3sCQ2xpbuoMvr3ICIG3JLTBQMTPKwBwFGNe8Ks5od
         Ctih9ls386KY464ZGIP4uAVXyDxJUyiGdbeXidcMWU2DUYspZtmGlJVKbnP/biLCsF4t
         YiyLH0Fzj818byZlRc41YKW2RYtdwtjqNbmcC+lrjNtvaGmWo8XG2r1BOCZZD3thc6O3
         V/nNa2nmN8SH+6QL7PMZchgUvCgJ3yUv9zoZDVPbAqGZC33OJN36b4dyRJilHwic4JTv
         5kqA==
X-Gm-Message-State: AJIora++QN9vmKUsHI1BBrRwFQB4jWd+UeBNuxZSidpnwsGl+UQb5IJt
        kd2xl7G/Q0QNITDaNF7KxBGgEr5lQ40oH2sB/g==
X-Google-Smtp-Source: AGRyM1vQM1i7bebcbDD5BeZRxIvCI5qJDGD+svsXThCao0+6CLL/xgSSD/QNovAdrA91Ct+RzSbDrGrdlDrjB3F5wA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a81:57c3:0:b0:31d:e2dd:116 with SMTP
 id l186-20020a8157c3000000b0031de2dd0116mr34878043ywb.5.1658383068317; Wed,
 20 Jul 2022 22:57:48 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:17 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 06/17] arm64: stacktrace: Add description of stacktrace/common.h
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brief description on how to use stacktrace/common.h to implement
a stack unwinder.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Add short description of each required function, per Fuad and Marc
  - Add Reviewed-by tag from Fuad

 arch/arm64/include/asm/stacktrace/common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index 7807752aaab1..be7920ba70b0 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -2,6 +2,21 @@
 /*
  * Common arm64 stack unwinder code.
  *
+ * To implement a new arm64 stack unwinder:
+ *     1) Include this header
+ *
+ *     2) Provide implementations for the following functions:
+ *          on_overflow_stack():   Returns true if SP is on the overflow
+ *                                 stack.
+ *          on_accessible_stack(): Returns true is SP is on any accessible
+ *                                 stack.
+ *          unwind_next():         Performs validation checks on the frame
+ *                                 pointer, and transitions unwind_state
+ *                                 to the next frame.
+ *
+ *         See: arch/arm64/include/asm/stacktrace.h for reference
+ *              implementations.
+ *
  * Copyright (C) 2012 ARM Ltd.
  */
 #ifndef __ASM_STACKTRACE_COMMON_H
-- 
2.37.0.170.g444d1eabd0-goog

