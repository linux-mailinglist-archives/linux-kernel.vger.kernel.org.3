Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0905098D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385643AbiDUHPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357106AbiDUHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:15:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896917A8A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:12:38 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkTHW1nK8z1J9nW;
        Thu, 21 Apr 2022 15:11:51 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 15:12:37 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 15:12:36 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rdunlap@infradead.org>
CC:     <peterz@infradead.org>, <gor@linux.ibm.com>, <tglx@linutronix.de>,
        <axboe@kernel.dk>, <arnd@arndb.de>, <chenzhongjin@huawei.com>
Subject: [PATCH 5.10 v2] fix csdlock_debug cause arm64 boot panic
Date:   Thu, 21 Apr 2022 15:11:29 +0800
Message-ID: <20220421071129.151794-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csdlock_debug is a early_param to enable csd_lock_wait
feature.

It uses static_branch_enable in early_param which triggers
a panic on arm64 with config:
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_VMEMMAP=n

The log shows:
Unable to handle kernel NULL pointer dereference at
virtual address ", '0' <repeats 16 times>, "
...
Call trace:
__aarch64_insn_write+0x9c/0x18c
...
static_key_enable+0x1c/0x30
csdlock_debug+0x4c/0x78
do_early_param+0x9c/0xcc
parse_args+0x26c/0x3a8
parse_early_options+0x34/0x40
parse_early_param+0x80/0xa4
setup_arch+0x150/0x6c8
start_kernel+0x8c/0x720
...
Kernel panic - not syncing: Oops: Fatal exception

Call trace inside __aarch64_insn_write:
__nr_to_section
__pfn_to_page
phys_to_page
patch_map
__aarch64_insn_write

Here, with CONFIG_SPARSEMEM_VMEMMAP=n, __nr_to_section returns
NULL and makes the NULL dereference because mem_section is
initialized in sparse_init after parse_early_param stage.

So, static_branch_enable shouldn't be used inside early_param.
To avoid this, I changed it to __setup and fixed this.

Reported-by: Chen jingwen <chenjingwen6@huawei.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
Change v1 -> v2:
Fix return 1 for __setup
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 65a630f62363..381eb15cd28f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -174,9 +174,9 @@ static int __init csdlock_debug(char *str)
 	if (val)
 		static_branch_enable(&csdlock_debug_enabled);
 
-	return 0;
+	return 1;
 }
-early_param("csdlock_debug", csdlock_debug);
+__setup("csdlock_debug=", csdlock_debug);
 
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
-- 
2.17.1

