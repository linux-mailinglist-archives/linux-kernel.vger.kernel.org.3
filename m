Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51135B2AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIIAI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIIAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:08:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D07969C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:08:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u22so240034plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=alQYuNcmbyILgkqdc4lZTWPETi3Q1DhJTtwP4LFLjP8=;
        b=n/AUGPMUYZZfb5bavzFGZwu9R3KpTG7GrAfnB27Qrha2QfIbox4GmeJbtN0IsACOlx
         DPl9zOSWFQj+vZ4V3T7LRV1jpSgliBYcaFlJcxT6eiIxUkZXja2uugEGypzsC6R+jrRn
         kCrHN/iFAaC3yneW/3zVbwwwvHRE3DUkRupf0z7VHjyWR8hkYE2KJPwXuo4v/f2BHm5V
         sGG0zDwGDL2DWUt9yThCZ/pWNPIGFVTVQuuKJHOwHLFlAh1NnV7cxYzT1R8e0+YSPIkz
         O0laorld6Fk8A/nUnNS0M912l7F/tl8spoCbovBjHZHMgZE1JH4q7hEeaKf+qA1qH/QC
         b2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=alQYuNcmbyILgkqdc4lZTWPETi3Q1DhJTtwP4LFLjP8=;
        b=aKwploM59P7IsXaP8sYzIAp3N3x/3jM95e46mCcnX9Ads//tC3flfJUmcOb5WoCC4R
         ThxSmekZiCHdoN0jH5wPU/Uz5mLJT0d2oIEYn5dcuwl6ScuM4UtTFyDJdPNxxZ4h93Ol
         mf7baBCfwX+EWx62DtxncMmZMBx7HdeuMhWUIeOvPmXV8Ebw9ip2GRnzvmX96Z51m1vs
         g569E9ZVwjwipKUPEnl5SmqRr+i+yPA9twUHC3kmLiU9jA6hNsNudwy3ZoY8MQLKNC/o
         zDBlWhw5Vig6eGS/Pzl4a/o5SgVKntYq0FJrwnrkgYMeO8qy3CWThH7SsMj3UchzZpDp
         6aow==
X-Gm-Message-State: ACgBeo1M9nUki+28k8kOlrpwcv2MoEe7gMjqCbJamFBw/BCepfVvzpqD
        PUx1V6CAuMDk1psfMESZu+g=
X-Google-Smtp-Source: AA6agR7G2LFHkXaQTstnJ6++CEhnuhxu11OQtQCRekr3JVbOuO2mxQwT/pvbiR+WtSvitVINDEOEOw==
X-Received: by 2002:a17:902:d2cd:b0:177:4940:cc03 with SMTP id n13-20020a170902d2cd00b001774940cc03mr9548755plc.98.1662682101783;
        Thu, 08 Sep 2022 17:08:21 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0016d1b70872asm101877plk.134.2022.09.08.17.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 17:08:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] locking: Add __sched to semaphore functions
Date:   Thu,  8 Sep 2022 17:08:03 -0700
Message-Id: <20220909000803.4181857-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal functions are marked with __sched already, let's do the same
for external functions too so that we can skip them in the stack trace.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/locking/semaphore.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index f2654d2fe43a..34bfae72f295 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -51,7 +51,7 @@ static noinline void __up(struct semaphore *sem);
  * Use of this function is deprecated, please use down_interruptible() or
  * down_killable() instead.
  */
-void down(struct semaphore *sem)
+void __sched down(struct semaphore *sem)
 {
 	unsigned long flags;
 
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(down);
  * If the sleep is interrupted by a signal, this function will return -EINTR.
  * If the semaphore is successfully acquired, this function returns 0.
  */
-int down_interruptible(struct semaphore *sem)
+int __sched down_interruptible(struct semaphore *sem)
 {
 	unsigned long flags;
 	int result = 0;
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(down_interruptible);
  * -EINTR.  If the semaphore is successfully acquired, this function returns
  * 0.
  */
-int down_killable(struct semaphore *sem)
+int __sched down_killable(struct semaphore *sem)
 {
 	unsigned long flags;
 	int result = 0;
@@ -131,7 +131,7 @@ EXPORT_SYMBOL(down_killable);
  * Unlike mutex_trylock, this function can be used from interrupt context,
  * and the semaphore can be released by any task or interrupt.
  */
-int down_trylock(struct semaphore *sem)
+int __sched down_trylock(struct semaphore *sem)
 {
 	unsigned long flags;
 	int count;
@@ -156,7 +156,7 @@ EXPORT_SYMBOL(down_trylock);
  * If the semaphore is not released within the specified number of jiffies,
  * this function returns -ETIME.  It returns 0 if the semaphore was acquired.
  */
-int down_timeout(struct semaphore *sem, long timeout)
+int __sched down_timeout(struct semaphore *sem, long timeout)
 {
 	unsigned long flags;
 	int result = 0;
@@ -180,7 +180,7 @@ EXPORT_SYMBOL(down_timeout);
  * Release the semaphore.  Unlike mutexes, up() may be called from any
  * context and even by tasks which have never called down().
  */
-void up(struct semaphore *sem)
+void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
 
-- 
2.37.2.789.g6183377224-goog

