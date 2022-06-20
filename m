Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C0551DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350599AbiFTOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352465AbiFTN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:56:33 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A43632A;
        Mon, 20 Jun 2022 06:22:29 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 25KDKAgo049381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 20 Jun 2022 21:20:11 +0800 (CST)
        (envelope-from Di.Shen@unisoc.com)
Received: from bj10906pcu1.spreadtrum.com (10.0.74.51) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 20 Jun 2022 21:20:12 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>
CC:     <xuewen.yan@unisoc.com>, <cindygm567@gmail.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lukasz.luba@arm.com>
Subject: [PATCH 1/1] thermal/sysfs: Clear the slot left in cooling_device_attr_groups
Date:   Mon, 20 Jun 2022 21:19:53 +0800
Message-ID: <20220620131953.16575-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.51]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 25KDKAgo049381
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a space allocated for cooling_device_stats_attr_group within co-
oling_device_attr_groups. This space is shared by all cooling devices.

If not clear this space before cooling_device_stats_attr_group is initi-
alized, the next cooling device will still create stats sysfs file node.
At this time, read or write related nodes will cause kernel crash.

[exception_reboot_reason]: kernel_crash
[exception_panic_reason]: Fatal exception
[exception_time]: 2022-06-07_06-32-25
[exception_file_info]: not-bugon
[exception_task_id]: 3154
[exception_task_family]: [cat, 3154][sh, 2597][sh, 2362][adbd, 1804]
[exception_pc_symbol]: [<747516ae>] _raw_spin_lock+0x20/0x60
[exception_stack_info]: [<4cbe9ac1>] prepare_exception_info+0x19c/0x1a4
[<03041be7>] sysdump_panic_event+0x57c/0x6f4
[<b16f865e>] atomic_notifier_call_chain+0x48/0x7c
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

So clear the slot left in cooling_device_attr_groups before cooling_dev-
ice_stats_attr_group is initialized to avoid kernel crash.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/thermal_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..fbc3dbc85841 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -817,6 +817,11 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	unsigned long states;
 	int var;
 
+	/* Clear the slot left in cooling_device_attr_groups */
+	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
+	if (cooling_device_attr_groups[var])
+		cooling_device_attr_groups[var] = NULL;
+
 	if (cdev->ops->get_max_state(cdev, &states))
 		return;
 
-- 
2.17.1

