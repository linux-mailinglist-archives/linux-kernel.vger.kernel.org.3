Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8E50767C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353259AbiDSRcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352885AbiDSRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:32:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFAF616C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:29:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y32so30631648lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQabVMdNZY/kAVQ/7p9MbSanGy4zyHtBTZqygFLt8XM=;
        b=U3as7frbJxtDTwATnnjDXC+5uvjqxgsYm3icnagtE05SIeou3sQoh4gFmkLbq9a5vb
         sHhD2vuo8i8PmxeK/ebuFgwtg15Zk2e2vqdUJ1jI0DvHuxBzXXowAsm+Tlw+a4rR5uxu
         rNNbmr1PgdtNNV7Sh1olMXcGWrM7pxu4yYS91ikG8c0rFOeXu/koLtHpMwPEip9kEEtG
         d7usws1oHeOadOTPaoqaSRoeEHHEgoBIjFfDdbuyBmLEmn9Gjy6rCB0rmvJ/ZmZ5krul
         QSr/gxzj+IO8LJgnwZtQkgz1B+FlPLJuNPhOpk/7aqZFeaQvKh7OGGro7RJaWINW2Y+R
         xgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQabVMdNZY/kAVQ/7p9MbSanGy4zyHtBTZqygFLt8XM=;
        b=E54+gDi+ib4HA9lomeMG/s6paI3gWyeCJgirWcdNyWYmaWCQ8e4KiE5yCwBYDhLeuX
         VS/qsplcdXq4KzyqgvBHZUG3L+BmA/GjZmYB3yJNDBI5vL9LlnPZHPh7Qd2D+W/Btjmn
         GbyH1n1Cx5Ddh6LgXZj4udiBtt2ytf1AlVMBTmVYDB2mVEks6+x/df+k4oQ7MAEXLqmN
         qWDrBGD89YsSbt5/8kKIfDdx8vBqBH9yT3fcCvn+ts/nm0euBRMTIkM9z/mr/l9BaFAH
         Z8BZzJiAcMhOZNwhCKlXsEz5qKNrA1LHHsFUGn2toIrpJuAn1dTCSzHeykHnJjGhmxzz
         DuYA==
X-Gm-Message-State: AOAM531mKKCI7XCb357hXVcRbHbIkXyNhbz3/40ZXsi1u559H/ONpxyN
        aCDic0TgiivFH5olSIzlQ8vHUQ==
X-Google-Smtp-Source: ABdhPJw8zdKzfEsDdZ5EUtT4jdyuj/HF/9Jk6hCtf74n7mnWGqeb0zeDBoaKP8MFSStObudkqPnhFA==
X-Received: by 2002:a05:6512:1045:b0:44a:5e41:b25f with SMTP id c5-20020a056512104500b0044a5e41b25fmr11274319lfb.245.1650389360670;
        Tue, 19 Apr 2022 10:29:20 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id o7-20020a05651c050700b0024b70ccbdd5sm1490573ljp.36.2022.04.19.10.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:29:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Move genpd's time-accounting to ktime_get_mono_fast_ns()
Date:   Tue, 19 Apr 2022 19:29:16 +0200
Message-Id: <20220419172916.440055-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

To move towards a more consistent behaviour between genpd and the runtime
PM core, let's start by converting genpd's time-accounting from ktime_get()
into ktime_get_mono_fast_ns().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 77 +++++++++++++++++++++----------------
 include/linux/pm_domain.h   |  6 +--
 2 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ee878d126fd..18cd7965e5d6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -225,24 +225,23 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
 
 static void genpd_update_accounting(struct generic_pm_domain *genpd)
 {
-	ktime_t delta, now;
+	u64 delta, now;
 
-	now = ktime_get();
-	delta = ktime_sub(now, genpd->accounting_time);
+	now = ktime_get_mono_fast_ns();
+	if (now <= genpd->accounting_time)
+		return;
+
+	delta = now - genpd->accounting_time;
 
 	/*
 	 * If genpd->status is active, it means we are just
 	 * out of off and so update the idle time and vice
 	 * versa.
 	 */
-	if (genpd->status == GENPD_STATE_ON) {
-		int state_idx = genpd->state_idx;
-
-		genpd->states[state_idx].idle_time =
-			ktime_add(genpd->states[state_idx].idle_time, delta);
-	} else {
-		genpd->on_time = ktime_add(genpd->on_time, delta);
-	}
+	if (genpd->status == GENPD_STATE_ON)
+		genpd->states[genpd->state_idx].idle_time += delta;
+	else
+		genpd->on_time += delta;
 
 	genpd->accounting_time = now;
 }
@@ -1999,7 +1998,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->max_off_time_changed = true;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
-	genpd->accounting_time = ktime_get();
+	genpd->accounting_time = ktime_get_mono_fast_ns();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
 	genpd->domain.ops.prepare = genpd_prepare;
@@ -3163,6 +3162,7 @@ static int sub_domains_show(struct seq_file *s, void *data)
 static int idle_states_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
+	u64 now, delta, idle_time = 0;
 	unsigned int i;
 	int ret = 0;
 
@@ -3173,17 +3173,19 @@ static int idle_states_show(struct seq_file *s, void *data)
 	seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
-		ktime_t delta = 0;
-		s64 msecs;
+		idle_time += genpd->states[i].idle_time;
 
-		if ((genpd->status == GENPD_STATE_OFF) &&
-				(genpd->state_idx == i))
-			delta = ktime_sub(ktime_get(), genpd->accounting_time);
+		if (genpd->status == GENPD_STATE_OFF && genpd->state_idx == i) {
+			now = ktime_get_mono_fast_ns();
+			if (now > genpd->accounting_time) {
+				delta = now - genpd->accounting_time;
+				idle_time += delta;
+			}
+		}
 
-		msecs = ktime_to_ms(
-			ktime_add(genpd->states[i].idle_time, delta));
-		seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
-			      genpd->states[i].usage, genpd->states[i].rejected);
+		do_div(idle_time, NSEC_PER_MSEC);
+		seq_printf(s, "S%-13i %-14llu %-14llu %llu\n", i, idle_time,
+			   genpd->states[i].usage, genpd->states[i].rejected);
 	}
 
 	genpd_unlock(genpd);
@@ -3193,18 +3195,22 @@ static int idle_states_show(struct seq_file *s, void *data)
 static int active_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
-	ktime_t delta = 0;
+	u64 now, on_time, delta = 0;
 	int ret = 0;
 
 	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
-	if (genpd->status == GENPD_STATE_ON)
-		delta = ktime_sub(ktime_get(), genpd->accounting_time);
+	if (genpd->status == GENPD_STATE_ON) {
+		now = ktime_get_mono_fast_ns();
+		if (now > genpd->accounting_time)
+			delta = now - genpd->accounting_time;
+	}
 
-	seq_printf(s, "%lld ms\n", ktime_to_ms(
-				ktime_add(genpd->on_time, delta)));
+	on_time = genpd->on_time + delta;
+	do_div(on_time, NSEC_PER_MSEC);
+	seq_printf(s, "%llu ms\n", on_time);
 
 	genpd_unlock(genpd);
 	return ret;
@@ -3213,7 +3219,7 @@ static int active_time_show(struct seq_file *s, void *data)
 static int total_idle_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
-	ktime_t delta = 0, total = 0;
+	u64 now, delta, total = 0;
 	unsigned int i;
 	int ret = 0;
 
@@ -3222,16 +3228,19 @@ static int total_idle_time_show(struct seq_file *s, void *data)
 		return -ERESTARTSYS;
 
 	for (i = 0; i < genpd->state_count; i++) {
+		total += genpd->states[i].idle_time;
 
-		if ((genpd->status == GENPD_STATE_OFF) &&
-				(genpd->state_idx == i))
-			delta = ktime_sub(ktime_get(), genpd->accounting_time);
-
-		total = ktime_add(total, genpd->states[i].idle_time);
+		if (genpd->status == GENPD_STATE_OFF && genpd->state_idx == i) {
+			now = ktime_get_mono_fast_ns();
+			if (now > genpd->accounting_time) {
+				delta = now - genpd->accounting_time;
+				total += delta;
+			}
+		}
 	}
-	total = ktime_add(total, delta);
 
-	seq_printf(s, "%lld ms\n", ktime_to_ms(total));
+	do_div(total, NSEC_PER_MSEC);
+	seq_printf(s, "%llu ms\n", total);
 
 	genpd_unlock(genpd);
 	return ret;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 67017c9390c8..043d48e4420a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -98,7 +98,7 @@ struct genpd_power_state {
 	u64 usage;
 	u64 rejected;
 	struct fwnode_handle *fwnode;
-	ktime_t idle_time;
+	u64 idle_time;
 	void *data;
 };
 
@@ -149,8 +149,8 @@ struct generic_pm_domain {
 			    unsigned int state_count);
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-	ktime_t on_time;
-	ktime_t accounting_time;
+	u64 on_time;
+	u64 accounting_time;
 	const struct genpd_lock_ops *lock_ops;
 	union {
 		struct mutex mlock;
-- 
2.25.1

