Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5A5474B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiFKNGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiFKNGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:06:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530A221
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:06:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w21so1831946pfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf143K8u8sQ9l6dxICIgh9+sJda0jdS+IW0uFjAZt+s=;
        b=Y/EJGgK+pU1cPIYPWwDsYXum3z74xAqGW7IFNOnf1W06DmyjJBTW/hB+qfapWm/gF6
         M5Qhb9AjcV9C7x8fwtRFlVpOZUfM0WpvGyFrsOoGGgZvcYzIGEg5lw14kOJ8K0F1hygj
         uTukT0OT1f+U7v3dt1z/n2BOu0qPk1eLbJwNxat1VwjSeDNIBtcCHdX+L9uJ00O9Ff77
         kmr66R7pdHJB+1ldVB/zHsVZMmrPGJ8ZYGYYxEke2IxEef5wGpc6qhRZHf3qOXdTfAic
         TVCXNoCYcBg1DQE2HmunR0rWhz6DCXOCb4zb2mOa/xTt9nCH230f7+Dp/idZNhARzyCL
         kQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf143K8u8sQ9l6dxICIgh9+sJda0jdS+IW0uFjAZt+s=;
        b=QBEXZ6jr1SAZQtUFHxTdNH5d+PAKrVsm7dnb1kT78/Bako29ElJHpHVpCID4eO/qLk
         K9bPNJTSOija968Qy3jf/wIA90HBHPbZtiFPFvokFfFrjeVxRgrYYECNsopcnX7zwJA8
         19+++W3oDOD2cU5tQ8qGKNPbnON9tH4X7utWIR3PAmOjtJFJn2klE1U4gRVgz8RVd8xA
         MGS9werRjzoSuRh5AhnqiLbKXGuZFxONdG1XdEB+gR/rPOsLkk95RHv/2UG+WK37cPo3
         jKY7wUHWJffHiRFO2+6nba/c9RbhbPQDGQ62viW9DVP4dBG7qZTmvaDiTQPlynMlH/wD
         hKRQ==
X-Gm-Message-State: AOAM532HfDgYuqy2A9eYzeMXdNISaRSk9tOblttslcpPM80WZHOTcF/O
        roOB3r4MbW1vpbfHfvgrlRs=
X-Google-Smtp-Source: ABdhPJxz3L2GMh3xSXdtyX2hZ6jQeoE26PcAcw6nPeF+/b0+Z041wWGvyfWMNMairJdu3sUXEEo7QA==
X-Received: by 2002:a63:1f1b:0:b0:3fd:e8b8:328f with SMTP id f27-20020a631f1b000000b003fde8b8328fmr23934688pgf.43.1654952800138;
        Sat, 11 Jun 2022 06:06:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709027c1300b0015f4b7a012bsm1451246pll.251.2022.06.11.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 06:06:39 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     tglx@linutronix.de, hch@lst.de, keescook@chromium.org,
        longman@redhat.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/debugobjects: Fix stat count and optimize debug_objects_mem_init.
Date:   Sat, 11 Jun 2022 21:06:34 +0800
Message-Id: <20220611130634.99741-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Var debug_objects_allocated tracks valid kmem_cache_alloc calls, so
track it in debug_objects_replace_static_objects. Do similar things in
object_cpu_offline.

2. In debug_objects_mem_init, there is no need to call function
cpuhp_setup_state_nocalls when debug_objects_enabled = 0 (out of memory).

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/debugobjects.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 337d797a7141..6f8e5dd1dcd0 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -437,6 +437,7 @@ static int object_cpu_offline(unsigned int cpu)
 	struct debug_percpu_free *percpu_pool;
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
+	unsigned long flags;
 
 	/* Remote access is safe as the CPU is dead already */
 	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
@@ -444,6 +445,12 @@ static int object_cpu_offline(unsigned int cpu)
 		hlist_del(&obj->node);
 		kmem_cache_free(obj_cache, obj);
 	}
+
+	raw_spin_lock_irqsave(&pool_lock, flags);
+	obj_pool_used -= percpu_pool->obj_free;
+	debug_objects_freed += percpu_pool->obj_free;
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
+
 	percpu_pool->obj_free = 0;
 
 	return 0;
@@ -1318,6 +1325,8 @@ static int __init debug_objects_replace_static_objects(void)
 		hlist_add_head(&obj->node, &objects);
 	}
 
+	debug_objects_allocated += i;
+
 	/*
 	 * debug_objects_mem_init() is now called early that only one CPU is up
 	 * and interrupts have been disabled, so it is safe to replace the
@@ -1386,6 +1395,7 @@ void __init debug_objects_mem_init(void)
 		debug_objects_enabled = 0;
 		kmem_cache_destroy(obj_cache);
 		pr_warn("out of memory.\n");
+		return;
 	} else
 		debug_objects_selftest();
 
-- 
2.20.1

