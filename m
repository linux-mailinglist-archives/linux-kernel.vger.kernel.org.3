Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814265B2738
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIHT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIHT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED03A50D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BV5ynmETQj//VSEXh0fAfYZTasPgvMiaUOPYWaeZfe8=;
        b=IxIYD+a6OeNXzu5ZKuXRHPgSH238iRqTxUpp9fZtmNkGpyOmhm7bNoKAVkCw21P54Z/ayN
        jOT1SuCCC2Cnbp8kyGj/CYGiPZfzfYn/S0ZlepWrKguCF1aXvZG4rtJBp7czi4AX0E3+aR
        6835wstLEyn2LyPv59il7/hPv5UnrW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-vW0eyKDYPEa9FwmV1xQMqQ-1; Thu, 08 Sep 2022 15:57:16 -0400
X-MC-Unique: vW0eyKDYPEa9FwmV1xQMqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76DD785A596;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C7D2026D4C;
        Thu,  8 Sep 2022 19:57:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 24234415CD7D; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.760134219@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:02 -0300
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
Subject: [RFC PATCH 3/7] introduce _fail variants of stop_machine functions
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce stop_machine_fail and stop_machine_cpuslocked_fail,
which check if any online CPU in the system is tagged as 
a block interference CPU. 

If so, returns an error.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/stop_machine.h
===================================================================
--- linux-2.6.orig/include/linux/stop_machine.h
+++ linux-2.6/include/linux/stop_machine.h
@@ -113,6 +113,9 @@ static inline void print_stop_info(const
  */
 int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+
+int stop_machine_fail(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
+
 /**
  * stop_machine_cpuslocked: freeze the machine on all CPUs and run this function
  * @fn: the function to run
@@ -124,6 +127,9 @@ int stop_machine(cpu_stop_fn_t fn, void
  */
 int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+
+int stop_machine_cpuslocked_fail(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
+
 /**
  * stop_core_cpuslocked: - stop all threads on just one core
  * @cpu: any cpu in the targeted core
Index: linux-2.6/kernel/stop_machine.c
===================================================================
--- linux-2.6.orig/kernel/stop_machine.c
+++ linux-2.6/kernel/stop_machine.c
@@ -22,6 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sched/isolation.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -619,6 +620,17 @@ int stop_machine_cpuslocked(cpu_stop_fn_
 	return stop_cpus(cpu_online_mask, multi_cpu_stop, &msdata);
 }
 
+int stop_machine_cpuslocked_fail(cpu_stop_fn_t fn, void *data,
+				 const struct cpumask *cpus)
+{
+	block_interf_assert_held();
+
+	if (cpumask_intersects(block_interf_cpumask, cpu_online_mask))
+		return -EPERM;
+
+	return stop_machine_cpuslocked(fn, data, cpus);
+}
+
 int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 {
 	int ret;
@@ -631,6 +643,19 @@ int stop_machine(cpu_stop_fn_t fn, void
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
+int stop_machine_fail(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
+{
+	int ret;
+
+	/* No CPUs can come up or down during this. */
+	cpus_read_lock();
+	ret = stop_machine_cpuslocked_fail(fn, data, cpus);
+	cpus_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stop_machine_fail);
+
+
 #ifdef CONFIG_SCHED_SMT
 int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
 {


