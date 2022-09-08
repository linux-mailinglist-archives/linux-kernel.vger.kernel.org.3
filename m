Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180445B273B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIHT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIHT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E4FDBA4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=K3kPDvRnZ5sJSBggdbe1FgXRWBmDeuCU2G3Z/g5bs1o=;
        b=Ls0xReApBHVSoTHb4yJhCxtj7UitCuWbho/V5XksyuOXKwBW83Zq6DTTzT4BNoWp7WtXt3
        iylqggFYfLo3vmN04hBBVilBsBXTRFFLA3vGRq13JEU2EcHFuAPbgCYLfN0kaClkvO72GW
        8wKX8AlrqMhfXNhei1I6Zzr2aPIdj8M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-L21TuuGmPeWsliL34oBB_g-1; Thu, 08 Sep 2022 15:57:19 -0400
X-MC-Unique: L21TuuGmPeWsliL34oBB_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9A218A6522;
        Thu,  8 Sep 2022 19:57:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E4201121315;
        Thu,  8 Sep 2022 19:57:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 292F84148B8E; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908195111.966739489@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:29:06 -0300
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
Subject: [RFC PATCH 7/7] mtrr_add_page/mtrr_del_page: check for block interference CPUs
References: <20220908192859.546633738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if any online CPU in the system is tagged as
a block interference CPU, and if so return an error
to mtrr_add_page/mtrr_del_page. 

This can avoid interference to such CPUs (while allowing
userspace to handle the failures).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


Index: linux-2.6/arch/x86/kernel/cpu/mtrr/mtrr.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ linux-2.6/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -45,6 +45,7 @@
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpufeature.h>
 #include <asm/e820/api.h>
@@ -335,6 +336,13 @@ int mtrr_add_page(unsigned long base, un
 	error = -EINVAL;
 	replace = -1;
 
+	block_interf_read_lock();
+
+	if (cpumask_intersects(block_interf_cpumask, cpu_online_mask)) {
+		block_interf_read_unlock();
+		return -EPERM;
+	}
+
 	/* No CPU hotplug when we change MTRR entries */
 	cpus_read_lock();
 
@@ -399,6 +407,7 @@ int mtrr_add_page(unsigned long base, un
  out:
 	mutex_unlock(&mtrr_mutex);
 	cpus_read_unlock();
+	block_interf_read_unlock();
 	return error;
 }
 
@@ -484,6 +493,11 @@ int mtrr_del_page(int reg, unsigned long
 		return -ENODEV;
 
 	max = num_var_ranges;
+	block_interf_read_lock();
+	if (cpumask_intersects(block_interf_cpumask, cpu_online_mask)) {
+		block_interf_read_unlock();
+		return -EPERM;
+	}
 	/* No CPU hotplug when we change MTRR entries */
 	cpus_read_lock();
 	mutex_lock(&mtrr_mutex);
@@ -521,6 +535,7 @@ int mtrr_del_page(int reg, unsigned long
  out:
 	mutex_unlock(&mtrr_mutex);
 	cpus_read_unlock();
+	block_interf_read_unlock();
 	return error;
 }
 


