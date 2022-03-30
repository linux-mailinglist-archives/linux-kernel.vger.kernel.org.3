Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E394EC8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348454AbiC3P6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348593AbiC3P6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ECD115FED
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648655776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=OAKeevVq2uim2I3bStMAlMgog9psP1nOaTVNXMX0TeQ=;
        b=jE2vI6pVDHFbzCWEH1F+A9np4Exx4jbJGcE4Z18SrWN9kg527PbYdwH+dr++M9jNERmjZK
        zHSCZTN6J3WaNM3Bj9b1hSbKwmdO6aNSP1P66GYvTA1yTtUmqONUP4lpdffaUlfzVV7R6c
        hCoEoXALnfS2K8WHzdDaMEosTDI/9PM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-atDwIMjgMQ68Rmta3jub-g-1; Wed, 30 Mar 2022 11:56:12 -0400
X-MC-Unique: atDwIMjgMQ68Rmta3jub-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 677E7811E75;
        Wed, 30 Mar 2022 15:56:12 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E8F7141DECD;
        Wed, 30 Mar 2022 15:56:12 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v2] arch/arm64: Fix topology initialization for core scheduling
Date:   Wed, 30 Mar 2022 11:56:11 -0400
Message-Id: <20220330155611.30216-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 systems rely on store_cpu_topology() to call update_siblings_masks()
to transfer the toplogy to the various cpu masks. This needs to be done 
before the call to notify_cpu_starting() which tells the scheduler about 
each cpu found, otherwise the core scheduling data structures are setup 
in a way that does not match the actual topology.

Without this change stress-ng (which enables core scheduling in its prctl 
tests) causes a warning and then a crash (trimmed for legibility):

[ 1853.805168] ------------[ cut here ]------------
[ 1853.809784] task_rq(b)->core != rq->core
[ 1853.809792] WARNING: CPU: 117 PID: 0 at kernel/sched/fair.c:11102 cfs_prio_less+0x1b4/0x1c4
...
[ 1854.015210] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
...
[ 1854.231256] Call trace:
[ 1854.233689]  pick_next_task+0x3dc/0x81c
[ 1854.237512]  __schedule+0x10c/0x4cc
[ 1854.240988]  schedule_idle+0x34/0x54

Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
Signed-off-by: Phil Auld <pauld@redhat.com>
---
This is a similar issue to 
  f2703def339c ("MIPS: smp: fill in sibling and core maps earlier") 
which fixed it for MIPS. 

v2: Fixed the commit message. No code change.

 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 27df5c1e6baa..3b46041f2b97 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -234,6 +234,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 * Log the CPU info before it is marked online and might get read.
 	 */
 	cpuinfo_store_cpu();
+	store_cpu_topology(cpu);
 
 	/*
 	 * Enable GIC and timers.
@@ -242,7 +243,6 @@ asmlinkage notrace void secondary_start_kernel(void)
 
 	ipi_setup(cpu);
 
-	store_cpu_topology(cpu);
 	numa_add_cpu(cpu);
 
 	/*
-- 
2.18.0

