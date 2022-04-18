Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E59505EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiDRT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347788AbiDRT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 700C82C65C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650311658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VsrC4kJjjqui1pmrz4mc8VqF0RzWeNKXqSF9848FyHY=;
        b=eRLwMgm5t5iclwIMmqiZDXWBYTFpB5GiFbuB7Z0mjyX7llPCzSyO96G04NOzu7VovsSyqy
        qIXXk5Np1Xwc8GXuT/nLkWgBV9sBx5w2lSZHPCmviZXFTCAhXoJRNtQeQ971Ucc0wLsn3r
        CSE6+SK7bR0Rs9WgHwY10TRyoOcW/VI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-SvLPzhdZOIid6hQgyaefVA-1; Mon, 18 Apr 2022 15:54:14 -0400
X-MC-Unique: SvLPzhdZOIid6hQgyaefVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C49C4802819;
        Mon, 18 Apr 2022 19:54:12 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.34.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15799407E1C1;
        Mon, 18 Apr 2022 19:54:12 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Baokun Li <libaokun1@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Hildenbrand <dhildenb@redhat.com>
Subject: [RFC PATCH] kernel/cpu: restart cpu_up when hotplug is disabled
Date:   Mon, 18 Apr 2022 15:54:02 -0400
Message-Id: <20220418195402.2986573-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu hotplug path may be utilized while hotplug is disabled for a
brief moment leading to failures. As an example, attempts to perform
cpu hotplug by userspace soon after boot may race with pci_device_probe
leading to inconsistent results.

Proposed idea:
Call restart_syscall instead of returning -EBUSY since
cpu_hotplug_disabled seems to only have a positive value
for short, temporary amounts of time.

Does anyone see any serious problems with this?

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5797c2a7a93f..2992c7d1d24e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -35,6 +35,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
 #include <linux/random.h>
+#include <linux/delay.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1401,7 +1402,9 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 	cpu_maps_update_begin();
 
 	if (cpu_hotplug_disabled) {
-		err = -EBUSY;
+		/* avoid busy looping (5ms of sleep should be enough) */
+		msleep(5);
+		err = restart_syscall();
 		goto out;
 	}
 	if (!cpu_smt_allowed(cpu)) {
-- 
2.27.0

