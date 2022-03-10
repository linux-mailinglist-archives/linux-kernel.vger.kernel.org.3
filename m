Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15D4D4682
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiCJMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbiCJMK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:10:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F51470C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:09:57 -0800 (PST)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDnsD2KZBzdb6l;
        Thu, 10 Mar 2022 20:08:32 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 20:09:55 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 20:09:54 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <peterz@infradead.org>, <tglx@linutronix.de>
CC:     <alexandre.chartre@oracle.com>, <mhiramat@kernel.org>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <laijs@linux.alibaba.com>,
        <chang.seok.bae@intel.com>, <fenghua.yu@intel.com>,
        <thomas.tai@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/traps: Mark do_int3() NOKPROBE_SYMBOL
Date:   Thu, 10 Mar 2022 20:09:15 +0800
Message-ID: <20220310120915.63349-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kprobe_int3_handler() is called in do_int3(), probing do_int3()
can cause a breakpoint recursion and crash the kernel. Therefore,
do_int3() should be marked as NOKPROBE_SYMBOL.

Fixes: 21e28290b317 ("x86/traps: Split int3 handler up")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c9d566dcf89a..8143693a7ea6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -659,6 +659,7 @@ static bool do_int3(struct pt_regs *regs)
 
 	return res == NOTIFY_STOP;
 }
+NOKPROBE_SYMBOL(do_int3);
 
 static void do_int3_user(struct pt_regs *regs)
 {
-- 
2.17.1

