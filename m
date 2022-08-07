Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2292D58BB8C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiHGPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHGPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:18:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148762E9
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 08:18:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so5534636pjm.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=f4puBzIh+2fwMzCLxOTv6T0TgB7OLw32VLd1/PfG9h4=;
        b=Xo2bBbXbHiiU45ogFCXtsMLy4vyVdoXrSALkxLIL+3dE/LtOUa6Ifp5Ctwh3TQHJCX
         jL5nJg6qehl6itnqY1KuVzmnSlb7HJDZRpxIRRHI7nTklnpOFiV9Sa2R/hNi9vfJsEL/
         1J7zK+6WrLXpoHAjP3/G0yEAhn+WOm2KkLc87ZVr59KZUnxfJxqCS52Np87/LYMWPWzL
         KFqU7VnykHsbf/9Or0FhVNNIYKo0Qsu+JiWwb8+9mC4DsQrAEWfo3Z33RWtg2a0h+8lW
         pUzpNQ7VefZsF8awcIpIsUZxvUAQjHSec9wPUKDXVh4LDJUOdsUuB1GSYtloQfaJxd8k
         fsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f4puBzIh+2fwMzCLxOTv6T0TgB7OLw32VLd1/PfG9h4=;
        b=xe8O6BlyAZQuXTsmTpltTAqZNhPD0gQapFCrowPxmSB2M31mbkcu74B5112e+eJdMz
         MX28WlROsPYtDoN0xLyBn9vgpLTJ7bT3pvtUpaX2dkPscnkNMvjNQzn3BnFehNaCu85O
         U6GIgfCNRKm3JpSHIhOy2vMuNcuuuw7gLAF9Y3JPtGmaCrtUVwzpq5P6o99rrNhzUnfb
         em6DdgC8hrNkvN2uMRwKyy+jWaoFUJe66UZBQZ00lnfnwvBIuigpGyF7anC541O2ZXMA
         ekT5daAglYSOKNDyHhKObwbB4sPqZ32tqEFPrGr6BWCTBL1gQvZvs7JzAbfFevt9otLx
         1GTw==
X-Gm-Message-State: ACgBeo0lpm8BB7hXXClSRjrwD88SYqjjdwEhLh+IaUzbET/CUnjM2A3o
        GiDnYfrJ81JT6Y2F1wY6ya78NO+EKl1bHM4SQmE=
X-Google-Smtp-Source: AA6agR4PFCXFKZrCtmfoK84ZXQbSdSPehRwO/1j1O+1rs8YRj/5TQLKlQPdqQjGJOlFULLPiVfyceQ==
X-Received: by 2002:a17:90a:ead3:b0:1f3:366d:5005 with SMTP id ev19-20020a17090aead300b001f3366d5005mr25537234pjb.1.1659885519228;
        Sun, 07 Aug 2022 08:18:39 -0700 (PDT)
Received: from localhost.localdomain ([113.88.93.147])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b0016b90620910sm6867626plg.71.2022.08.07.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 08:18:38 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
Cc:     Puyou Lu <puyou.lu@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watchdog: enable watchdog only when watchdog_thresh != 0
Date:   Sun,  7 Aug 2022 23:17:55 +0800
Message-Id: <20220807151757.18466-1-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify the check of watchdog_thresh, as watchdog_thresh
shouldn't be zero for both nmi and soft watchdog.

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 kernel/watchdog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..bed1fe7ecaea 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -144,7 +144,7 @@ void __weak watchdog_nmi_start(void) { }
 static void lockup_detector_update_enable(void)
 {
 	watchdog_enabled = 0;
-	if (!watchdog_user_enabled)
+	if (!(watchdog_user_enabled && watchdog_thresh))
 		return;
 	if (nmi_watchdog_available && nmi_watchdog_user_enabled)
 		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
@@ -306,7 +306,7 @@ static int is_softlockup(unsigned long touch_ts,
 			 unsigned long period_ts,
 			 unsigned long now)
 {
-	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
+	if (watchdog_enabled & SOFT_WATCHDOG_ENABLED) {
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
@@ -543,9 +543,10 @@ static void __lockup_detector_reconfigure(void)
 	watchdog_nmi_stop();
 
 	softlockup_stop_all();
+
 	set_sample_period();
 	lockup_detector_update_enable();
-	if (watchdog_enabled && watchdog_thresh)
+	if (watchdog_enabled & SOFT_WATCHDOG_ENABLED)
 		softlockup_start_all();
 
 	watchdog_nmi_start();
@@ -575,8 +576,7 @@ static __init void lockup_detector_setup(void)
 	 */
 	lockup_detector_update_enable();
 
-	if (!IS_ENABLED(CONFIG_SYSCTL) &&
-	    !(watchdog_enabled && watchdog_thresh))
+	if (!IS_ENABLED(CONFIG_SYSCTL) && !watchdog_enabled)
 		return;
 
 	mutex_lock(&watchdog_mutex);
-- 
2.17.1

