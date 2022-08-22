Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F359B780
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiHVCQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiHVCQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FC222510;
        Sun, 21 Aug 2022 19:16:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so9022140pfb.7;
        Sun, 21 Aug 2022 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xSWHQT0Gh+ASwqDbuftZ9hOwt+7ZpIdbcTfHZLJUjew=;
        b=drdEGnn6bSG1bQXrr6SCO9vL8sEJJnSyNh0s4SAbgA50zj3osmvGAr+RilNPSGW7tp
         KAfFuc5fnb/IN3BmLw8Lx1KUVaemwzWMqg+7fGeE+qpb2RuR+Kib91bE6zeP6pdAU+Iv
         rHPp+ANtA230uW3x89/bKkqo7TORCuWAHvqz4rYuwfwa0RHsGIPHziXZEfrA5sbdna54
         tQSSr4N/VaS9RF7zANbJqRDu+IaNTN4xu3gRYTJ/+K+ZA/pY1IFky9Y0+JvCObZ18NYD
         vzacLfpll9SGbrBMx+pDubr0qCbwovinLpHj7a49H5uO4QvUDuMrSrN+nvwfBoxvGTK5
         Cm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xSWHQT0Gh+ASwqDbuftZ9hOwt+7ZpIdbcTfHZLJUjew=;
        b=lXmwxlw58DzQIZPoXb/N0fB2vn79WR8mkpVy4vIIQxK3gz/Op8huAfKDW42IHVZ+ZN
         n2Z10hSlQkwHdb/qNZoGOGnc0l3EV+336k/+f8N5ihTcWcahltvpYIl9rMgBlBKZSBt1
         XWBK8cKIa4duqU+QnAVOIaIcJ8pyD6D4bxDUwbexMEwrI7pudc1+cwPFW8iVYUdXhT2g
         e68tuyiONI5GAw8NE+XBr9zdblp+qzhV8Dhi+Mz3Rk3Pk9JcCo82xkAcWhotDXocDAHB
         tqzCsq7dIVrC3x7sP5mU3ztixcMXmwB05yxKl273Aili9xJ+CK8isMNDU1Uv/mNgVilt
         Uvfw==
X-Gm-Message-State: ACgBeo1sDVDiNV/3IhdKztANZxWIGk3VU4A+Qwt8Qx5xIhBe3SbeGltr
        V0LXA3u8olitfczvP+tDAA==
X-Google-Smtp-Source: AA6agR7KljxZ9kbPwullzRTYyS9R74MZRULUzSQZWPtq0VQwcgMNVf0XgsbzpqwnU5ffstdl5YcXvw==
X-Received: by 2002:a63:c1f:0:b0:41a:9b73:a89e with SMTP id b31-20020a630c1f000000b0041a9b73a89emr14967609pgl.342.1661134566121;
        Sun, 21 Aug 2022 19:16:06 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:05 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RFC 04/10] cpu/hotplug: Check the capability of kexec quick reboot
Date:   Mon, 22 Aug 2022 10:15:14 +0800
Message-Id: <20220822021520.6996-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
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

The kexec quick reboot needs each involved cpuhp_step to run in
parallel.

There are lots of teardown cpuhp_step, but not all of them belong to
arm/arm64/riscv kexec reboot path. So introducing a member
'support_kexec_parallel' in the struct cpuhp_step to signal whether the
teardown supports parallel or not. If a cpuhp_step is used in kexec
reboot, then it needs to support parallel to enable the quick reboot.

The function check_quick_reboot() checks all teardown cpuhp_steps and
report those unsupported if any.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arm-kernel@lists.infradead.org
To: linux-ia64@vger.kernel.org
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 include/linux/cpuhotplug.h |  2 ++
 kernel/cpu.c               | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f61447913db9..73093fc15aec 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -374,6 +374,8 @@ static inline int cpuhp_setup_state_multi(enum cpuhp_state state,
 				   (void *) teardown, true);
 }
 
+void cpuhp_set_step_parallel(enum cpuhp_state state);
+
 int __cpuhp_state_add_instance(enum cpuhp_state state, struct hlist_node *node,
 			       bool invoke);
 int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 94ab2727d6bb..1261c3f3be51 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -137,6 +137,9 @@ struct cpuhp_step {
 	/* public: */
 	bool			cant_stop;
 	bool			multi_instance;
+#ifdef CONFIG_SHUTDOWN_NONBOOT_CPUS
+	bool			support_kexec_parallel;
+#endif
 };
 
 static DEFINE_MUTEX(cpuhp_state_mutex);
@@ -147,6 +150,14 @@ static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 	return cpuhp_hp_states + state;
 }
 
+#ifdef CONFIG_SHUTDOWN_NONBOOT_CPUS
+void cpuhp_set_step_parallel(enum cpuhp_state state)
+{
+	cpuhp_hp_states[state].support_kexec_parallel = true;
+}
+EXPORT_SYMBOL(cpuhp_set_step_parallel);
+#endif
+
 static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
 {
 	return bringup ? !step->startup.single : !step->teardown.single;
@@ -1347,7 +1358,22 @@ static void takedown_cpus_no_rollback(struct cpumask *cpus)
 
 static bool check_quick_reboot(void)
 {
-	return false;
+	struct cpuhp_step *step;
+	enum cpuhp_state state;
+	bool ret = true;
+
+	for (state = CPUHP_ONLINE; state >= CPUHP_AP_OFFLINE; state--) {
+		step = cpuhp_get_step(state);
+		if (step->teardown.single == NULL)
+			continue;
+		if (step->support_kexec_parallel == false) {
+			pr_info("cpuhp state:%d, %s, does not support cpudown in parallel\n",
+					state, step->name);
+			ret = false;
+		}
+	}
+
+	return ret;
 }
 
 static struct cpumask kexec_ap_map;
-- 
2.31.1

