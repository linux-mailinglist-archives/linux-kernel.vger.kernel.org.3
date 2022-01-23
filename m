Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA3497492
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiAWSlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiAWSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:58 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD8C06173D;
        Sun, 23 Jan 2022 10:40:57 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so7873287pgc.1;
        Sun, 23 Jan 2022 10:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UUKJUI5LEQZKArKXE5kTNrLEuODfkVdvxUFHk4GiAXc=;
        b=B8p8tHIZv+dHEfVHl/No8uGC1d6rBNR6KHiGIhB03BC1EQYyDbAFs0hZR8USDjt7YJ
         3BoLtDJ5s3uk+CrF8kCmGokKb4I5AxPFFEYJNS2upRFlOrifOivmrVCyvvbSblPt+8QR
         STKpfwVdgogy51f2LObUIq3MF8dfBcNvricle3FbVfD/Lvk9zeg90qAhFoz9FJ7BxJn/
         GM/zJCtI9FWyBo11QplwdknQKRo4mmbbO9dcmA2AMQ2r6h4D/R+C/6Z5Upz2H+6FwawR
         McHv69WPqBt6COW7wuNPvTYLatkej8o2lExGiIEITYQDhZ07nISE4qjY1T0p/V3fyJXa
         +iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUKJUI5LEQZKArKXE5kTNrLEuODfkVdvxUFHk4GiAXc=;
        b=jY6QJ0zklMjv6hqzQGgfMJMWOCj1OigQws7E2DIA7QIF+ywjUYshnSxbkppqTHE3qz
         ScCBrRuokyUfDZMjMN5T7I0g+KONAI80+lxu8dAaJhGRzqCo5NhXwXc1VLAbWwmhgG/P
         r4Dtkj41jH/eVcDFBllI9CQwipw8lSGLyowygGsCzeoIe1jT3LNJRfBmHfNORmvxwh9c
         a1BFTwexAsZB3PV19KuKua5yMLMI8I8UggvxwdE4/YVNnko5FtjlBKoa4DKik8nRd16c
         VvsvL1ftk162yIXQJs5cLIT6pultr5ev6P2cI+7pm/78TKZLKybboKJdbfRI+rA827kE
         amgA==
X-Gm-Message-State: AOAM532F9vb8toge0AiG3g2TZ0YM8o98ji3alqL8g5kVrTlUWNEshQDb
        VNuIJ1rPp1Wnk1bBwKfzWuQOPpfls9U=
X-Google-Smtp-Source: ABdhPJx6P1H1G7heLbutA+icIyViqrkaWle0teU4GGguSdO0pA8FIAznKJQS2GmROqlo2H6iYL8uJg==
X-Received: by 2002:a62:dd56:0:b0:4c7:8603:3ffe with SMTP id w83-20020a62dd56000000b004c786033ffemr8567637pff.15.1642963257316;
        Sun, 23 Jan 2022 10:40:57 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v8sm3258809pfu.186.2022.01.23.10.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:57 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 22/54] rcu: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:53 -0800
Message-Id: <20220123183925.1052919-23-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, RCU code calls cpumask_weight() to check if any bit of a
given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/rcu/tree_nocb.h   | 4 ++--
 kernel/rcu/tree_plugin.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a0..f83c7b1d6110 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1169,7 +1169,7 @@ void __init rcu_init_nohz(void)
 	struct rcu_data *rdp;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
 		need_rcu_nocb_mask = true;
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
@@ -1348,7 +1348,7 @@ static void __init rcu_organize_nocb_kthreads(void)
  */
 void rcu_bind_current_to_nocb(void)
 {
-	if (cpumask_available(rcu_nocb_mask) && cpumask_weight(rcu_nocb_mask))
+	if (cpumask_available(rcu_nocb_mask) && !cpumask_empty(rcu_nocb_mask))
 		WARN_ON(sched_setaffinity(current->pid, rcu_nocb_mask));
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c5b45c2f68a1..0dc0c8d6717c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1215,7 +1215,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
 	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
-	if (cpumask_weight(cm) == 0)
+	if (cpumask_empty(cm))
 		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
 	set_cpus_allowed_ptr(t, cm);
 	free_cpumask_var(cm);
-- 
2.30.2

