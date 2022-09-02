Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C5AA635
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiIBDPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiIBDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:15:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB72A24D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:15:27 -0700 (PDT)
X-UUID: 3482856cadea4ddd9fb7aad610f43852-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=g2xnOcGvBy3Njjbz6b+gGaRXL1W5YwhL4H3CLYHZZnE=;
        b=oEkwR3Wi64K/9jiLcuqJ7nvDXg/FHOLCwD5JOqc8liQ/42rT9A5vcp5U9RVLpT46K4BZNOLgZMgkUKL6pyOFbps9h9VKvNPyuEBIrYY0I8desglfWXl98oUWXPxRldtH/kpfbwQi1DwQ24CGQZxbMsUQD3j7lTrq5PN+1S+kOho=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:3e20c926-97d5-4b7d-9de9-bb76eb4d32be,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Rele
        ase_Ham,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.10,REQID:3e20c926-97d5-4b7d-9de9-bb76eb4d32be,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_G
        S981B3D,ACTION:quarantine,TS:75
X-CID-META: VersionHash:84eae18,CLOUDID:577c5b56-e800-47dc-8adf-0c936acf4f1b,C
        OID:8e22b45f06f8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3482856cadea4ddd9fb7aad610f43852-20220902
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 429735254; Fri, 02 Sep 2022 11:15:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 2 Sep 2022 11:15:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 2 Sep 2022 11:15:22 +0800
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     <major.chen@samsung.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <wsd_upstream@mediatek.com>, <hongfei.tang@samsung.com>,
        kuyo chang <kuyo.chang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] sched/debug: fix dentry leak in update_sched_domain_debugfs
Date:   Fri, 2 Sep 2022 11:15:15 +0800
Message-ID: <20220902031518.1116-1-kuyo.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kuyo chang <kuyo.chang@mediatek.com>

[Syndrome]
Lowmemorykiller triggered while doing hotplug stress test as below cmd:
echo [0/1] > /sys/devices/system/cpu/cpu${index}/online

Rootcause:
Call trace of the slab owner & usage as below after hotplug stress
test(4hr).
There exists dentry leak at update_sched_domain_debugfs.

Total size : 322000KB
<prep_new_page+44>:
<get_page_from_freelist+672>:
<__alloc_pages+304>:
<allocate_slab+144>:
<___slab_alloc+404>:
<__slab_alloc+60>:
<kmem_cache_alloc+1204>:
<alloc_inode+100>:
<new_inode+40>:
<__debugfs_create_file+172>:
<update_sched_domain_debugfs+824>:
<partition_sched_domains_locked+1292>:
<rebuild_sched_domains_locked+576>:
<cpuset_hotplug_workfn+1052>:
<process_one_work+584>:
<worker_thread+1008>:

[Solution]
Provided by Major Chen <major.chen@samsung.com> as below link.
https://lore.kernel.org/lkml/20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a@epcms5p1/
update_sched_domain_debugfs() uses debugfs_lookup() to find wanted dentry(which has
been created by debugfs_create_dir() before), but not call dput() to return this dentry
back. This result in dentry leak even debugfs_remove() is called.

[Test result]
Using below commands to check inode_cache & dentry leak.
cat /proc/slabinfo | grep -w inode_cache
cat /proc/slabinfo | grep -w dentry

With the patch, the inode_cache & dentry stays consistent
so the lowmemorykiller will not triggered anymore.

Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")

Signed-off-by: Major Chen <major.chen@samsung.com>
Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
Tested-by: kuyo chang <kuyo.chang@mediatek.com>

---
 kernel/sched/debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bb3d63bdf4ae..4ffea2dc01da 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -412,11 +412,14 @@ void update_sched_domain_debugfs(void)
 
 	for_each_cpu(cpu, sd_sysctl_cpus) {
 		struct sched_domain *sd;
-		struct dentry *d_cpu;
+		struct dentry *d_cpu, *d_lookup;
 		char buf[32];
 
 		snprintf(buf, sizeof(buf), "cpu%d", cpu);
-		debugfs_remove(debugfs_lookup(buf, sd_dentry));
+		d_lookup = debugfs_lookup(buf, sd_dentry);
+		debugfs_remove(d_lookup);
+		if (!IS_ERR_OR_NULL(d_lookup))
+			dput(d_lookup);
 		d_cpu = debugfs_create_dir(buf, sd_dentry);
 
 		i = 0;
-- 
2.18.0

