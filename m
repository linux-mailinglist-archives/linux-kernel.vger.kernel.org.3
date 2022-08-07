Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7B58BB8F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiHGPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHGPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:19:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F816330
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 08:19:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pm17so6725304pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=zyNvPVLyDDezqApjjesRSa+r/dJCUOj2kajhngA3cEY=;
        b=U1bLegysO3V+UCL2Q54RveB3Zmszqfc0p7d8TnVIoFVUi56Vpez2mRTa+v2j+P5y3u
         FDZpSlP3cwxlPCGK69D0zHt6FXMbXB1PQp15Df8Uy4GhQcv60ccRun3Bp37q7O88QV+O
         3MxWO2/INsFhAMJe4D8xLEKIOzhZAmAR0mw4ytUgrYosb8RVbtKvE0e/DF1J2ssMvIwf
         40V2n4VkFTNKNdrCZvykHqZYbQtNBGJQhT4cZTTp9lWLV2doNl0ICHk7qtrEClPnZBHu
         QiTFR9WdpGOuF48Heck1Wa+tbhR3oRHPMxZcsachgwtZrW6s+zprqb415HNH9Rs4tXgN
         RrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zyNvPVLyDDezqApjjesRSa+r/dJCUOj2kajhngA3cEY=;
        b=o4OkWl7K1edzKIcekukO45TOeyYVa1FPRG4CaLMD1YjctatcoBDyQ/VjjyAEuz3W5z
         OSktUljtHHhtt+HqzMf+kO3JBopgL/oTOdg0lXXbJcy5qLHNtXLBFkv/uVbkrF/hhYx4
         87EvW++W7FeRk0W3gBLbv2hDEmut2+I5fc4TZcXjlGS6jRi9r8FH3dT8UMB6xKEUaevW
         bNUZ6m783mMmiQbfjXPJLAQ54fXw20ebCcs14hn118+dB/86Bo85CEAf/3okhU5vE9Ol
         gKfHfs0RHeKEwr0I6eeLdfbzaFeElB7VVdrn98RNNb1igollPTJq0NRrOJyZuu1O0H4P
         lHOQ==
X-Gm-Message-State: ACgBeo0oNoeopWSJBbdUitk+txfzd9R4CNcu21B5viLmr+vV8bz0zAZj
        MAEvg2NJ0H+elzMafe/iHA0=
X-Google-Smtp-Source: AA6agR7NaNGx7oh8UfVl/gJPXMF8S/ck7dQr+6sm2ZO2jLPtgn/jhzjqKke4TQ/u+C49TpqkTp7n4A==
X-Received: by 2002:a17:903:2015:b0:16e:db59:f65d with SMTP id s21-20020a170903201500b0016edb59f65dmr15152394pla.106.1659885565459;
        Sun, 07 Aug 2022 08:19:25 -0700 (PDT)
Received: from localhost.localdomain ([113.88.93.147])
        by smtp.gmail.com with ESMTPSA id t188-20020a6281c5000000b0052acb753b8bsm6692577pfd.158.2022.08.07.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 08:19:24 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
Cc:     Puyou Lu <puyou.lu@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog: don't enable watchdog if user disabled it
Date:   Sun,  7 Aug 2022 23:18:44 +0800
Message-Id: <20220807151845.18597-1-puyou.lu@gmail.com>
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

Take a check of watchdog_enabled before reconfigure/enable watchdog.

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 kernel/watchdog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index bed1fe7ecaea..791765c9bece 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -454,6 +454,9 @@ static void watchdog_enable(unsigned int cpu)
 
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
+	if (!watchdog_enabled)
+		return;
+
 	init_completion(done);
 	complete(done);
 
@@ -546,6 +549,10 @@ static void __lockup_detector_reconfigure(void)
 
 	set_sample_period();
 	lockup_detector_update_enable();
+
+	if (!watchdog_enabled)
+		return;
+
 	if (watchdog_enabled & SOFT_WATCHDOG_ENABLED)
 		softlockup_start_all();
 
@@ -591,6 +598,10 @@ static void __lockup_detector_reconfigure(void)
 	cpus_read_lock();
 	watchdog_nmi_stop();
 	lockup_detector_update_enable();
+
+	if (!watchdog_enabled)
+		return;
+
 	watchdog_nmi_start();
 	cpus_read_unlock();
 }
-- 
2.17.1

