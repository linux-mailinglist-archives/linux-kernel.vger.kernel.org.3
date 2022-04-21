Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA104509581
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383981AbiDUDnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiDUDnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:43:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CA9FE6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:40:22 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KkNbK5nXkzhY1t;
        Thu, 21 Apr 2022 11:40:13 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 11:40:20 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 11:40:20 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <peterz@infradead.org>, <gor@linux.ibm.com>, <tglx@linutronix.de>,
        <axboe@kernel.dk>, <rdunlap@infradead.org>, <arnd@arndb.de>
Subject: [PATCH 5.10] fix csdlock_debug cause arm64 boot panic
Date:   Thu, 21 Apr 2022 11:39:14 +0800
Message-ID: <20220421033914.217622-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 65a630f62363..1ce64de460d0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -176,7 +176,7 @@ static int __init csdlock_debug(char *str)
 
 	return 0;
 }
-early_param("csdlock_debug", csdlock_debug);
+__setup("csdlock_debug=", csdlock_debug);
 
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
-- 
2.17.1

