Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA257DCB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiGVIpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiGVIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:44:56 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A99F077;
        Fri, 22 Jul 2022 01:44:53 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 26M8hgAv073488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 22 Jul 2022 16:43:42 +0800 (CST)
        (envelope-from Di.Shen@unisoc.com)
Received: from bj10906pcu1.spreadtrum.com (10.0.74.51) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 22 Jul 2022 16:43:43 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC:     <viresh.kumar@linaro.org>, <amitk@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeson.gao@unisoc.com>, <xuewen.yan@unisoc.com>,
        <cindygm567@gmail.com>
Subject: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group before initialized
Date:   Fri, 22 Jul 2022 16:43:14 +0800
Message-ID: <20220722084314.17816-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.51]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 26M8hgAv073488
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a space allocated for cooling_device_stats_attr_group
within cooling_device_attr_groups. This space is shared by all
cooling devices.

If the stats structure of one cooling device successfully
creates stats sysfs. After that, another cooling device fails
to get max_states in cooling_device_stats_setup(). It can
return directly without initializing the stats structure, but
the cooling_device_stats_attr_group is still the attribute
group of the last cooling device.

At this time, read or write stats sysfs nodes can cause kernel
crash. Like the following, kernel crashed when
'cat time_in_state_ms'.

[<5baac8d4>] panic+0x1b4/0x3c8
[<9d287b0f>] arm_notify_die+0x0/0x78
[<094fc22c>] __do_kernel_fault+0x94/0xa4
[<3b4b69a4>] do_page_fault+0xd4/0x364
[<23793e7a>] do_translation_fault+0x38/0xc0
[<6e5cc52a>] do_DataAbort+0x4c/0xd0
[<a28c16b8>] __dabt_svc+0x5c/0xa0
[<747516ae>] _raw_spin_lock+0x20/0x60
[<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
[<cb78325e>] dev_attr_show+0x38/0x64
[<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
[<c0a843ab>] seq_read+0x244/0x620
[<b316b374>] vfs_read+0xd8/0x218
[<3aebf5fa>] sys_read+0x80/0xe4
[<7cf100f5>] ret_fast_syscall+0x0/0x28
[<08cbe22f>] 0xbe8c1198

stats sysfs:
phone:/sys/class/thermal/cooling_device2/stats # ls
reset  time_in_state_ms  total_trans  trans_table

The same as cat total_trans, trans_table, and echo reset.

To avoid kernel crash, this patch set clears the
cooling_device_attr_groups before stats structure is initialized.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..e3fae63fa0f7 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -817,6 +817,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	unsigned long states;
 	int var;
 
+	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
+	cooling_device_attr_groups[var] = NULL;
+
 	if (cdev->ops->get_max_state(cdev, &states))
 		return;
 
-- 
2.17.1

