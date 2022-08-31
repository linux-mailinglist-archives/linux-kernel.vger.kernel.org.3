Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D175A842B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiHaRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHaRUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:20:41 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB3A2A85
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:20:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h21so11506052qta.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SyLcqpHvP/Dxww6UQFwjysD5YzJ7EHxDql789Pl4OtM=;
        b=oMRptfbELFmdJSHW/QEuPetgUH+I22kllPmA1kXOWeqSStrFRFXFib2/W7muRsBeQO
         2W5/XdJfVvAlH1l2Nor64/fAgDI7iRqtEDE3hwJwiU3+o+1V4TV/9lyy/binjL6bpASS
         LiMwkprEba6CnMn8fkgzv64joEXUiepbkP+mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SyLcqpHvP/Dxww6UQFwjysD5YzJ7EHxDql789Pl4OtM=;
        b=3uI+cyXil/9tjIEMeVjWeJGb45s6vZdVN75S2a8yZZoEB1vRVPytOVb2R1v/6g+S76
         H30Jx5C0Pf9GzDtAJPuXtg4vo/HoLkOQCXQJD3ElIbnx5Q7Q8HnXelDqfkwfOuvmcqYu
         3CCUlR6U+7K/eCNCeRqgkb+Pi86lUDkOoK/RY8ALGvZLu0t5Lx2HfiTyWvHDUTTESuwn
         uOndqLw5G3QMEdIswBn8B27Tm2dR7gzAi6Vc60UiwYd4zpse9chOkB8dVjUDeJYQlUUZ
         cAsyc5AwHGayUj2vTFO/EEgglFPk3qlQDF188OWW9rtZoK29eb4ZkXor+5MyneMzs3AL
         qckQ==
X-Gm-Message-State: ACgBeo2p3zd9rhUgButJvXvUyN1UF6A5x8vqGwKp03GOO8fKJzdMhv+U
        Fh1pviyEzRREeamtHdD7XqmfI930z/lNRA==
X-Google-Smtp-Source: AA6agR4eoaT/16y28TB6ngRKEE+OZTwubs2MSerIMlxt3+iIByxOF9msh/3cim4Zwc7JH0D5ekw66g==
X-Received: by 2002:ac8:5983:0:b0:344:5dcb:3b6b with SMTP id e3-20020ac85983000000b003445dcb3b6bmr20544262qte.503.1661966432766;
        Wed, 31 Aug 2022 10:20:32 -0700 (PDT)
Received: from trappist.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id ge17-20020a05622a5c9100b003430589dd34sm8962611qtb.57.2022.08.31.10.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:20:32 -0700 (PDT)
From:   Sven van Ashbrook <svenva@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Levin <levinale@google.com>, Rajat Jain <rajatja@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v1 2/2] hwrng: core: fix potential suspend/resume race condition
Date:   Wed, 31 Aug 2022 17:20:24 +0000
Message-Id: <20220831172024.1613208-2-svenva@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220831172024.1613208-1-svenva@chromium.org>
References: <20220831172024.1613208-1-svenva@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwrng fill function runs as a normal kthread. This thread
doesn't get frozen by the PM, i.e. it will keep running during,
or in, system suspend. It may call the client driver's
data_present()/data_read() functions during, or in, suspend;
which may generate errors or warnings. For example, if the
client driver uses an i2c bus, the following warning may be
intermittently generated:

  i2c: Transfer while suspended

Fix by converting the delay polled kthread into an ordered work
queue running a single, self-rearming delayed_work. Make the
workqueue WQ_FREEZABLE, so the PM will drain any work items
before going into suspend. This prevents client drivers from
being accessed during, or in, suspend.

Tested on a Chromebook containing an cr50 tpm over i2c. The test
consists of 31000 suspend/resume cycles. Occasional
"i2c: Transfer while suspended" warnings are seen. After applying
this patch, these warnings disappear.

This patch also does not appear to cause any regressions on the
ChromeOS test queues.

Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
---

 drivers/char/hw_random/core.c | 95 +++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 3675122c6cce..ee85ca97d215 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -17,7 +17,7 @@
 #include <linux/hw_random.h>
 #include <linux/random.h>
 #include <linux/kernel.h>
-#include <linux/kthread.h>
+#include <linux/workqueue.h>
 #include <linux/sched/signal.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -28,14 +28,17 @@
 
 #define RNG_MODULE_NAME		"hw_random"
 
-static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
-static struct task_struct *hwrng_fill;
+static struct workqueue_struct *hwrng_wq;
+static struct delayed_work hwrng_fill_dwork;
+static size_t entropy_credit;
+/* Protects rng_list, current_rng, is_hwrng_wq_running */
+static DEFINE_MUTEX(rng_mutex);
 /* list of registered rngs */
 static LIST_HEAD(rng_list);
-/* Protects rng_list and current_rng */
-static DEFINE_MUTEX(rng_mutex);
+static struct hwrng *current_rng;
+static bool is_hwrng_wq_running;
 /* Protects rng read functions, data_avail, rng_buffer and rng_fillbuf */
 static DEFINE_MUTEX(reading_mutex);
 static int data_avail;
@@ -488,37 +491,29 @@ static int __init register_miscdev(void)
 	return misc_register(&rng_miscdev);
 }
 
-static int hwrng_fillfn(void *unused)
+static void hwrng_fillfn(struct work_struct *unused)
 {
-	size_t entropy, entropy_credit = 0; /* in 1/1024 of a bit */
+	unsigned short quality;
 	unsigned long delay;
+	struct hwrng *rng;
+	size_t entropy; /* in 1/1024 of a bit */
 	long rc;
 
-	while (!kthread_should_stop()) {
-		unsigned short quality;
-		struct hwrng *rng;
-
-		rng = get_current_rng();
-		if (IS_ERR(rng) || !rng)
-			break;
-		mutex_lock(&reading_mutex);
-		rc = rng_get_data(rng, rng_fillbuf,
-				  rng_buffer_size(), 1);
-		if (current_quality != rng->quality)
-			rng->quality = current_quality; /* obsolete */
-		quality = rng->quality;
-		mutex_unlock(&reading_mutex);
-		put_rng(rng);
-
-		if (!quality)
-			break;
+	rng = get_current_rng();
+	if (IS_ERR(rng) || !rng)
+		return;
+	mutex_lock(&reading_mutex);
+	rc = rng_get_data(rng, rng_fillbuf, rng_buffer_size(), 1);
+	if (current_quality != rng->quality)
+		rng->quality = current_quality; /* obsolete */
+	quality = rng->quality;
+	mutex_unlock(&reading_mutex);
+	put_rng(rng);
 
-		if (rc <= 0) {
-			pr_warn("hwrng: no data available\n");
-			msleep_interruptible(10000);
-			continue;
-		}
+	if (!quality)
+		return;
 
+	if (rc > 0) {
 		/* If we cannot credit at least one bit of entropy,
 		 * keep track of the remainder for the next iteration
 		 */
@@ -529,11 +524,11 @@ static int hwrng_fillfn(void *unused)
 		/* Outside lock, sure, but y'know: randomness. */
 		delay = add_hwgenerator_randomness((void *)rng_fillbuf, rc,
 						   entropy >> 10);
-		if (delay > 0)
-			schedule_timeout_interruptible(delay);
+	} else {
+		pr_warn("hwrng: no data available\n");
+		delay = 10 * HZ;
 	}
-	hwrng_fill = NULL;
-	return 0;
+	mod_delayed_work(hwrng_wq, &hwrng_fill_dwork, delay);
 }
 
 static void hwrng_manage_rngd(struct hwrng *rng)
@@ -541,14 +536,12 @@ static void hwrng_manage_rngd(struct hwrng *rng)
 	if (WARN_ON(!mutex_is_locked(&rng_mutex)))
 		return;
 
-	if (rng->quality == 0 && hwrng_fill)
-		kthread_stop(hwrng_fill);
-	if (rng->quality > 0 && !hwrng_fill) {
-		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
-		if (IS_ERR(hwrng_fill)) {
-			pr_err("hwrng_fill thread creation failed\n");
-			hwrng_fill = NULL;
-		}
+	if (rng->quality == 0 && is_hwrng_wq_running) {
+		cancel_delayed_work(&hwrng_fill_dwork);
+		is_hwrng_wq_running = false;
+	} else if (rng->quality > 0 && !is_hwrng_wq_running) {
+		mod_delayed_work(hwrng_wq, &hwrng_fill_dwork, 0);
+		is_hwrng_wq_running = true;
 	}
 }
 
@@ -631,8 +624,7 @@ void hwrng_unregister(struct hwrng *rng)
 	new_rng = get_current_rng_nolock();
 	if (list_empty(&rng_list)) {
 		mutex_unlock(&rng_mutex);
-		if (hwrng_fill)
-			kthread_stop(hwrng_fill);
+		cancel_delayed_work_sync(&hwrng_fill_dwork);
 	} else
 		mutex_unlock(&rng_mutex);
 
@@ -703,17 +695,32 @@ static int __init hwrng_modinit(void)
 		return -ENOMEM;
 	}
 
+	/* ordered wq to mimic delay-polled kthread behaviour */
+	hwrng_wq = alloc_ordered_workqueue("hwrng",
+		WQ_FREEZABLE |	/* prevent work from running during suspend/resume */
+		WQ_MEM_RECLAIM	/* client drivers may need memory reclaim */
+	);
+	if (!hwrng_wq) {
+		kfree(rng_fillbuf);
+		kfree(rng_buffer);
+		return -ENOMEM;
+	}
+
 	ret = register_miscdev();
 	if (ret) {
+		destroy_workqueue(hwrng_wq);
 		kfree(rng_fillbuf);
 		kfree(rng_buffer);
 	}
 
+	INIT_DELAYED_WORK(&hwrng_fill_dwork, hwrng_fillfn);
+
 	return ret;
 }
 
 static void __exit hwrng_modexit(void)
 {
+	destroy_workqueue(hwrng_wq);
 	mutex_lock(&rng_mutex);
 	BUG_ON(current_rng);
 	kfree(rng_buffer);
-- 
2.37.2.672.g94769d06f0-goog

