Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E34584E53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiG2Jnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiG2Jnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:43:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13C1F5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:43:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so3623505pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dryKzknTwjOf+VunOu1ss5DcnVHNtdSKVmRMmz8L7/M=;
        b=RmegUcAao+BR1SjifamXxiAd7dUw4XR+bu86vHq/s/P/1pGQSqeuT4SW8+0IaFNX8D
         Vwrc7D59ZwOG3ianRT7wF6cptOrXrpoVd74iQm5DJ6prrvQKzXtbjMAjEpiPeeUtMeYn
         kcF0s4Fa+TRsmjMFUw049o9THXkDAisBqya7GdDgF8Ev+zMg60a4LkQPg4kow676F9/K
         5UnH1t3Gj6N8qLcy1Xhx87uPBCdzif5UVqwYFqMYoowRPuKI2J3HsNuusRL6KJcVhHKz
         Q20b1DBQI40tsS1eQCXxRpTK1TG6BuPlaAr2Gy07GkGhhRBaDxPKl2MxaPHQcbyiq1dn
         60qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dryKzknTwjOf+VunOu1ss5DcnVHNtdSKVmRMmz8L7/M=;
        b=MM8EljvAOF/rrbcLc/XU+qH47vekRV/EoxxZ/YQfTR+qXESCZXStwtMmNUMj1JEYj5
         M2N86M18jlFoN++kFf0DT98PMOTBPiWqkMsYYUZhB/DIqKiJ7P6loU+mW/b3Znpj+PN3
         KoXCXWHQjvmYG+bHgIgLKP7s1GzWDP5L9I/1XDFm5jmx4rXn2avmCQpTp7xs3qpejpV/
         zWGTc//WCofc/Ywiz8zMRV0rUuEimObRxdSbZv+SWM5zXAdNcNF68xUfTt3kTLKaDolz
         TjASgxW0odmVDcbEO+nMdw2xfdpP6K2aiN0YmTG6vrLGA/2qVnkjJ2TFLbbfeA+tejeF
         IiFg==
X-Gm-Message-State: AJIora9viCV+d6z+RARWYc0BGWKS39V9D1VaSD6udfZSqU/ypQuvxsIN
        wLEOBmA3idc0U68SkJycWtF9cnGK5S4=
X-Google-Smtp-Source: AGRyM1vEoz3kXJjr0a1E2TYq1Ga+O49AjHwlkCiVuRthWguGtQcS/b9nUEdQuALL19nzzsb/cWzDeA==
X-Received: by 2002:a63:d456:0:b0:41a:aa82:cd9e with SMTP id i22-20020a63d456000000b0041aaa82cd9emr2321179pgj.271.1659087823198;
        Fri, 29 Jul 2022 02:43:43 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id h2-20020a656382000000b003fadfd7be5asm2256495pgv.18.2022.07.29.02.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 02:43:42 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH] workqueue: Avoid a false warning in unbind_workers()
Date:   Fri, 29 Jul 2022 17:44:38 +0800
Message-Id: <20220729094438.3941-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Doing set_cpus_allowed_ptr() with wq_unbound_cpumask can be possible
fails and trigger the false warning.

Use cpu_possible_mask instead when wq_unbound_cpumask has no active CPUs.

It is very easy to trigger the warning:
  Set wq_unbound_cpumask to a small set of CPUs.
  Offline all the CPUs of wq_unbound_cpumask.
  Offline an extra CPU and trigger the warning.

Fixes: 10a5a651e3af("workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 355897b790a5..a429b50b06e6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4975,7 +4975,10 @@ static void unbind_workers(int cpu)
 
 		for_each_pool_worker(worker, pool) {
 			kthread_set_per_cpu(worker->task, -1);
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+			if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
+				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+			else
+				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
-- 
2.19.1.6.gb485710b

