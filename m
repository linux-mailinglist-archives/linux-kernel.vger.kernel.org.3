Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152A64E2628
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347237AbiCUMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiCUMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:15:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B61A6E25
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:14:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so19532263ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdqYxoutc6DsO1XYUa/CbHh15uqU3qu1/fReXRM+8bM=;
        b=Bws30VSjpwUf8+/rHfoUjxJuuojumekDO6vnEVaGexwkugcY6BvWDP7xIVX3t3M+Ua
         kOcQIlMpv9HA9gZmy92w31MiElYYs7t/LiQMv2X97gRIJv9BcL3bHPSmQHI6lmw9Bhi9
         WH4bzkHI1dyYlkdn5S8BBxNdPYKJlOFK0PyJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdqYxoutc6DsO1XYUa/CbHh15uqU3qu1/fReXRM+8bM=;
        b=jeytlb7bAD3inXdM4qOkgdQt85ni4O7keb2wUJ6NTlnEDG6jwDN/z1UJML40gQxBM+
         cu43twbjWJmyz0nY3DndBLhmGOE7b+hp7llcS1ux/K6JmYnl3bpzuZfz4oAlFs69AoZW
         JCOYeShe3VEqBO05FAGuTVnXx8mXeLnluvb42Gnv8/OxyOHibV5ycU2mj8i0L7Bu2RrB
         erqI68aNYMKA92J/cbxCXzPGKTcW4JHuOJOvsvrCfOBraHePGevqpqNfeZz0Ox8OyZfV
         ZB9XNxtYIX63RDIU+AfRUuUVWAgGh2xSoB3fG83rh+ueHP/0JyDCYQneKcTS51LmRXlz
         xppA==
X-Gm-Message-State: AOAM530wmyj9A/FfstRxOkELamMAsTsyDsOSoGdOWj+s+g/N5qead+IA
        zhCHGKc8TRs0gpsxZWeNYorbBw==
X-Google-Smtp-Source: ABdhPJxSECgSKE+FFm1j6vX16456ZsPRFygIBmhFFVdLV7Gnjqy4ySnLbRGANhmCzgDKIB0xQcbwFQ==
X-Received: by 2002:a05:651c:a05:b0:249:8586:3f42 with SMTP id k5-20020a05651c0a0500b0024985863f42mr3275360ljq.349.1647864862098;
        Mon, 21 Mar 2022 05:14:22 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h16-20020ac25d70000000b00445c231e814sm1796747lft.144.2022.03.21.05.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:14:21 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/Kconfig.debug: remove more CONFIG_..._VALUE indirections
Date:   Mon, 21 Mar 2022 13:13:00 +0100
Message-Id: <20220321121301.1389693-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
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

As in "kernel/panic.c: remove CONFIG_PANIC_ON_OOPS_VALUE indirection",
use the IS_ENABLED() helper rather than having a hidden config option.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/hung_task.c |  2 +-
 kernel/watchdog.c  |  4 ++--
 lib/Kconfig.debug  | 21 ---------------------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 52501e5f7655..cff3ae8c818f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -73,7 +73,7 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
  * hung task is detected:
  */
 unsigned int __read_mostly sysctl_hung_task_panic =
-				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
+				IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
 
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 99afb88d2e85..50a1b8a95127 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -57,7 +57,7 @@ int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
  * Should we panic when a soft-lockup or hard-lockup occurs:
  */
 unsigned int __read_mostly hardlockup_panic =
-			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
+			IS_ENABLED(CONFIG_BOOTPARAM_HARDLOCKUP_PANIC);
 /*
  * We may not want to enable hard lockup detection by default in all cases,
  * for example when running the kernel as a guest on a hypervisor. In these
@@ -168,7 +168,7 @@ static struct cpumask watchdog_allowed_mask __read_mostly;
 
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
-			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
+			IS_ENABLED(CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC);
 
 static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..522231f4a501 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1043,13 +1043,6 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
 
 	  Say N if unsure.
 
-config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
-	int
-	depends on SOFTLOCKUP_DETECTOR
-	range 0 1
-	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
-	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
-
 config HARDLOCKUP_DETECTOR_PERF
 	bool
 	select SOFTLOCKUP_DETECTOR
@@ -1091,13 +1084,6 @@ config BOOTPARAM_HARDLOCKUP_PANIC
 
 	  Say N if unsure.
 
-config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
-	int
-	depends on HARDLOCKUP_DETECTOR
-	range 0 1
-	default 0 if !BOOTPARAM_HARDLOCKUP_PANIC
-	default 1 if BOOTPARAM_HARDLOCKUP_PANIC
-
 config DETECT_HUNG_TASK
 	bool "Detect Hung Tasks"
 	depends on DEBUG_KERNEL
@@ -1145,13 +1131,6 @@ config BOOTPARAM_HUNG_TASK_PANIC
 
 	  Say N if unsure.
 
-config BOOTPARAM_HUNG_TASK_PANIC_VALUE
-	int
-	depends on DETECT_HUNG_TASK
-	range 0 1
-	default 0 if !BOOTPARAM_HUNG_TASK_PANIC
-	default 1 if BOOTPARAM_HUNG_TASK_PANIC
-
 config WQ_WATCHDOG
 	bool "Detect Workqueue Stalls"
 	depends on DEBUG_KERNEL
-- 
2.31.1

