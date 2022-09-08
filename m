Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C405F5B273A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIHT52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIHT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3986EC746
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=N67gQ2stRWxvjqfXz9K3AlWY+C92r6fHBrkzUs9pLqs=;
        b=Co6dkypuTdSVukUFYt2C3Q28Onke/zFEl/M3GX9W2MDj3WmmRVS3L0kRnBfC0fmIC32W+A
        SgSB8HdPKK+KLBwy/yFvYJGXtYltMlUN6en+pFTzmUjp7k2Ln8AocHOr12WJgshEAODDpU
        adRYPGPZeFCpYaL87xbBi+pXdTMrpAo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-sRHX6peHPD2Jw5Q--Fz5Ug-1; Thu, 08 Sep 2022 15:57:16 -0400
X-MC-Unique: sRHX6peHPD2Jw5Q--Fz5Ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D3973C0CD54;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E0F2909FF;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 230D9415CD60; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.710559374@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:01 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Prasad Pandit <ppandit@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH 2/7] introduce smp_call_func_single_fail
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce smp_call_func_single_fail, which checks if
the target CPU is tagged as a "block interference" CPU,
and returns an error if so.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/smp.h
===================================================================
--- linux-2.6.orig/include/linux/smp.h
+++ linux-2.6/include/linux/smp.h
@@ -50,6 +50,9 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+int smp_call_func_single_fail(int cpuid, smp_call_func_t func, void *info,
+			     int wait);
+
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
Index: linux-2.6/kernel/smp.c
===================================================================
--- linux-2.6.orig/kernel/smp.c
+++ linux-2.6/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
+#include <linux/sched/isolation.h>
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -782,6 +783,30 @@ int smp_call_function_single(int cpu, sm
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
+/*
+ * smp_call_func_single_fail - Run a function on a specific CPU,
+ * failing if any target CPU is marked as "no ipi".
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait until function has completed on other CPUs.
+ *
+ * Returns 0 on success, else a negative status code.
+ */
+int smp_call_func_single_fail(int cpu, smp_call_func_t func, void *info,
+			     int wait)
+{
+	int err;
+
+	block_interf_assert_held();
+	if (block_interf_cpu(cpu))
+		return -EPERM;
+
+	err = smp_call_function_single(cpu, func, info, wait);
+
+	return err;
+}
+EXPORT_SYMBOL(smp_call_func_single_fail);
+
 /**
  * smp_call_function_single_async() - Run an asynchronous function on a
  * 			         specific CPU.


