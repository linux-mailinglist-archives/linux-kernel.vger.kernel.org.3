Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49E8574650
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiGNIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGNIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:06:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698629833
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:06:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so736127wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3WbPlZqSS4Vb8MfGJkxkUiSAiggi3mYIZReCx2ozlM=;
        b=hTuoRN0viSxD9CKIZjpzF3Uw1AnKS2Gw1dxFSjthP3Mhy7fKKYMPnp/RAXJgP9P3bT
         mQp74gqDFYsPCSeB1pCt2lTnn+upKmqXE/bf2/cHFxpNcLr9AwC4IYZ+I9nmLSRAn0Tf
         j8j3iUL/WVmGAPdfBQUm8uXtK96h8Rh2FqrzoTGfdGbETcAFrTT/WzvyQ1B/cNUZK6U/
         LupA20UTUZsdhpzmSQHYKv5njpN1QZHGS3srZIKXVit5oJ/xvzt8xaX8gU2wIfvX/tWt
         p9KuLnJxxDVlZ+M6RzIVFnrpP8J8cYnGE5J5DkCJIrey2X4pEbOFIA2bRB/Yy0HDL0/W
         XQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3WbPlZqSS4Vb8MfGJkxkUiSAiggi3mYIZReCx2ozlM=;
        b=kkDnaHZDUMg3PSjC0W7/KDYdg5TKnxpWl4fqdWKpRUseuZmmTl1GY87rkCvccGO/9U
         ZoxAZ/IwZQH33t/CVwS4FDRJ8zfeDA8fXMhVGpcNdrzPGRDPNiyL5+iUDgHksNy6gGYR
         FuuLOZ+bp7oxlIeRvA1CbuYd0+k8wAF35DZu1DoOxvyNxreteo7FnWUEmWz/UQ9w/TvU
         vIeni3vljmBOT6r0C1L/gd52ureT/2HldGrB6KgwGSnC4/bSyefB2xx4RYZl+V4S6nsT
         yBzGDvL/z9+euOomYhh/RRYHjUK9GOEbG61BF7we2W3wDb+ItI/Xu0X9IZ7n849Uw0+V
         nYhQ==
X-Gm-Message-State: AJIora/x+O4YL0pvh8qLlHB34oTyu7/jQfFjobCttq2+Ojga9F+QWSZc
        rlQMc7KPAm5oXYeciQrtXC0y5jPsz3Fa3e0R
X-Google-Smtp-Source: AGRyM1sjJjpa+MOPf3wN/CrRewZJcnIepcXauTDi/Dlq3rG1Buq0AQ/cnysAWbpMInQrInjeS/9Tmg==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr13760340wmz.27.1657785979509;
        Thu, 14 Jul 2022 01:06:19 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b003a2e5296befsm4613086wmq.32.2022.07.14.01.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 01:06:19 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] kernel/hung_task: make unexported variables static
Date:   Thu, 14 Jul 2022 09:06:17 +0100
Message-Id: <20220714080617.198810-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings for un-declared variables
by making them static:

kernel/hung_task.c:31:19: warning: symbol 'sysctl_hung_task_check_count' was not declared. Should it be static?
kernel/hung_task.c:50:29: warning: symbol 'sysctl_hung_task_check_interval_secs' was not declared. Should it be static?
kernel/hung_task.c:52:19: warning: symbol 'sysctl_hung_task_warnings' was not declared. Should it be static?
kernel/hung_task.c:75:28: warning: symbol 'sysctl_hung_task_panic' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 kernel/hung_task.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2354f73ded..48106a950554 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -28,7 +28,7 @@
 /*
  * The number of tasks checked:
  */
-int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
+static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
 
 /*
  * Limit number of tasks checked in a batch.
@@ -47,9 +47,9 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
 /*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:
  */
-unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
+static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 
-int __read_mostly sysctl_hung_task_warnings = 10;
+static int __read_mostly sysctl_hung_task_warnings = 10;
 
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
@@ -72,7 +72,7 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
  * Should we panic (and reboot, if panic_timeout= is set) when a
  * hung task is detected:
  */
-unsigned int __read_mostly sysctl_hung_task_panic =
+static unsigned int __read_mostly sysctl_hung_task_panic =
 				IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
 
 static int
-- 
2.35.1

