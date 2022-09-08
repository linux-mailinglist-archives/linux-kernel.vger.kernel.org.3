Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856D5B28CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIHV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIHVzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FAAD98F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so154247537b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=koezPCxm32fHAwZgdGqKK7XqmRXL9JxASzrYTVD4m+E=;
        b=JSacEPUoej5v/XIN7Hsi8+T5GHAejPEIXTMi6W7AKQLC5hVqZnvtkNAu5BK6krzUQx
         fctP5X9cs9aaG7Slukq3widQl5Sz3Cg4B2+9Ms/40HHHiPhW+ORwgrMpQFg4g2DD6vyP
         nsbocmqQcPUoKOu9GBsszyWW5Y/9pcHmD1tong6jGdtvxt1q98M9IMk9vq27vD9xYIlm
         X5YII9Nz1tn+CVFWxqczzbj3f8cmmHd52JOITZuOclM3trrztiE9Anovjz5avPkqa+tl
         mNVIYYwqwAqyxAbBXm25Fyh9l2MDmpgRTRoUJ5NAd2cCa7cVJSAWyrMN3tEzDgFbbiIe
         6TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=koezPCxm32fHAwZgdGqKK7XqmRXL9JxASzrYTVD4m+E=;
        b=Fp8vL8+XGHEAH8UnSLu/dccUbNaSdiV0Is/mAJz4JJOpyffJ7W0VjspnMGHK/SUF6P
         zzPrBnltmuegdi51hQm7tWKJFcidSnn+qtJl1g96QMjmlv1ytXuo1nI51Q5wkZPCoDdp
         dGU69vJbrTjZazOJPBASNxp+yuVaYJRL9l9o9fU4eeYPjkvrrPdd8zrqXL0zvE1FmrRx
         K5YaRqYdsjCh13dM64DKH2O+y1IDxlejRDAlEtP2U4+utQQmAZGsZwlcBVFg15KSxIJq
         V2JnSNWlQ+GZZWw+AltTEE4Y6Cr7CHoPPaZvpV/tbXtYdvq6O1ZW0RVCVePLxixVsYUU
         ctJA==
X-Gm-Message-State: ACgBeo3OiGqYoUfCZWFPcoSqUixolG2DAFaU1xY17G2ziyij9wiuIBPr
        uYI0EfKO/ffog6ps8cYAmsY10k92mx45zNaVnEBNK2aUZkXpITaPZ43OOFyJzhP9yoaTi5meiyX
        mEXUGK4TQUUGzYtNT0uGKS8ICEOVzKsRafqFgJOg5+/NHDqzOpp2KhE2UMPNKO3TfyhUYAhcByZ
        58R1jkfkjPpA==
X-Google-Smtp-Source: AA6agR4f3SYEc+Bp0TdIuCv586ybfdJDVN30qGCNPGKAFJMjsSrHsBG3kNu8QkrrVyppevzh+B3tK1Z4CU58zsMdLI0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:3486:0:b0:6a1:881a:5d86 with SMTP
 id b128-20020a253486000000b006a1881a5d86mr8937712yba.323.1662674128390; Thu,
 08 Sep 2022 14:55:28 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:50 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=samitolvanen@google.com;
 h=from:subject; bh=jyM+rGxWUU219XYY5/O2nBNl+QplLQ4hASchurrzdpo=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS0202vID3CXZ0XLmebB+d9NIzgSUGtOWGy99hv
 ue7C0ruJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktAAKCRBMtfaEi7xW7lPxC/
 9lKOPhgsglfXR1fj5L/0qgYqxVBFIG9R2MnXno1UwVmdTTRPq0bkQzscG3ZpD7ATu2TIr53T1Edqxa
 yuQxpw1bh5TSssxhwO6IU7t5pOMBdP86oaYB2aEUoAFRLV16cwaX3ei3GpZl9y/mD9QGlDzconUw2f
 JaNKLMZshc/LblHCMDbxS8I8wIe8AEjCb5QEIxM7P9I2wAPAxx4/4mDDj8ivfGS3tzIMF1EXYYFkv0
 wHyzUefM39JrhnAXhKtJ+5JSsakAbxyGBuFX31X5YeQhoOvbR/eqylaRbt7Tej1510BlgG+zIxM4go
 U3JlUJiPPvWfW/rych3iQYkqRHFcpJLtgshmb3HaA64wvo2hwTTFK82MJeP2qDRxZJPY8gDK0dR0v2
 UxktEOG6eZ4oLvqy4bI1mp5dfETqiJ16qfIZ7BPnnCOG71n04ZjUltD6AAhj6pPHqMNHNYVnnUdFS7
 OThfxGxDoCPjO+/PYXGv9Mn7QoeBz+hDGxY9/SQR8lC+c=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 08/22] psci: Fix the function type for psci_initcall_t
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions called through a psci_initcall_t pointer all have
non-const arguments. Fix the type definition to avoid tripping
indirect call checks with CFI_CLANG.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/psci/psci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..75ef784a3789 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -274,7 +274,7 @@ static void set_conduit(enum arm_smccc_conduit conduit)
 	psci_conduit = conduit;
 }
 
-static int get_set_conduit_method(struct device_node *np)
+static int get_set_conduit_method(const struct device_node *np)
 {
 	const char *method;
 
@@ -528,7 +528,7 @@ typedef int (*psci_initcall_t)(const struct device_node *);
  *
  * Probe based on PSCI PSCI_VERSION function
  */
-static int __init psci_0_2_init(struct device_node *np)
+static int __init psci_0_2_init(const struct device_node *np)
 {
 	int err;
 
@@ -549,7 +549,7 @@ static int __init psci_0_2_init(struct device_node *np)
 /*
  * PSCI < v0.2 get PSCI Function IDs via DT.
  */
-static int __init psci_0_1_init(struct device_node *np)
+static int __init psci_0_1_init(const struct device_node *np)
 {
 	u32 id;
 	int err;
@@ -585,7 +585,7 @@ static int __init psci_0_1_init(struct device_node *np)
 	return 0;
 }
 
-static int __init psci_1_0_init(struct device_node *np)
+static int __init psci_1_0_init(const struct device_node *np)
 {
 	int err;
 
-- 
2.37.2.789.g6183377224-goog

