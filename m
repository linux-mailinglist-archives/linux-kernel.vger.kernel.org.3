Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69842532501
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiEXIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiEXIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B2E454F9B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653379949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vrj/sayM80RGEEGyY0KC0sGkY2iaaQz1Te5aknMB76E=;
        b=BLmkxG+4kCXPphSmPVKCJnFgVx0LA7BNKowm8DZ2NbMBhpaTGv/Wr2amqZu+7cFFLeh/Et
        v8qUbb3rfbPoZ/lf8+nm93MkFDW1oIjZF9rqZwEjNqpBxYisJFhLvs5tPwWsUfRjtIttNf
        hHP1FORxxMPW2xi2TvQd+3T5vrtIeMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-Pt8V-noAO0i1TWZslY78wQ-1; Tue, 24 May 2022 04:12:24 -0400
X-MC-Unique: Pt8V-noAO0i1TWZslY78wQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE752858F00;
        Tue, 24 May 2022 08:12:23 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 191D2492C14;
        Tue, 24 May 2022 08:12:18 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
        rafael@kernel.org, Jonathan.Cameron@huawei.com, drjones@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: [PATCH] arch_topology: Limit threads to one specific cluster
Date:   Tue, 24 May 2022 16:12:12 +0800
Message-Id: <20220524081212.1363105-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sibling information for one particular CPU is updated after ACPI
PPTT table is parsed. struct cpu_topology::thread_sibling tracks the
the CPUs in same core. However, cluster isn't considered when it's
populated. In this case, multiple threads belonging to different
clusters can be put together through the sibling information. It
eventually leads to unexpected warning from sched subsystem.

For example, the following warning is observed in a VM where we have
2 sockets, 4 clusters, 8 cores and 16 threads and the CPU topology
is populated as below.

   CPU  Socket-ID  Cluster-ID  Core-ID  Thread-ID
   ----------------------------------------------
    0      0          0          0        0
    1      0          0          0        1
    2      0          0          1        0
    3      0          0          1        1
    4      0          1          0        0
    5      0          1          0        1
    6      0          1          1        0
    7      0          1          1        1
    8      1          0          0        0
    9      1          0          0        1
   10      1          0          1        0
   11      1          0          1        1
   12      1          1          0        0
   13      1          1          0        1
   14      1          1          1        0
   15      1          1          1        1

  [    0.592181] CPU: All CPU(s) started at EL1
  [    0.593766] alternatives: patching kernel code
  [    0.595890] BUG: arch topology borken
  [    0.597210]      the SMT domain not a subset of the CLS domain
  [    0.599286]      child=0-1,4-5    sd=0-3

  # cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
  0-3
  # cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
  0-1,4-5

This fixes the issue by limiting threads to one specific cluster.
With this applied, the unexpected warning disappears in the VM.

  # cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
  0-3
  # cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
  0-1

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/base/arch_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index f73b836047cf..25a63a89ae7d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -710,7 +710,8 @@ void update_siblings_masks(unsigned int cpuid)
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
 
-		if (cpuid_topo->core_id != cpu_topo->core_id)
+		if (cpuid_topo->cluster_id != cpu_topo->cluster_id ||
+		    cpuid_topo->core_id != cpu_topo->core_id)
 			continue;
 
 		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
-- 
2.23.0

