Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4771F59CE73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiHWCXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbiHWCXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:23:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0A5AC7F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:23:10 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBXx82SqSzkWg7;
        Tue, 23 Aug 2022 10:19:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 10:23:08 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 10:23:08 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH -next] x86: i8259: Make default_legacy_pic static
Date:   Tue, 23 Aug 2022 10:19:58 +0800
Message-ID: <20220823021958.3052493-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol is not used outside of the file, so mark it static.

Fixes the following warning:

arch/x86/kernel/i8259.c:410:19: warning:
	symbol 'default_legacy_pic' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/x86/kernel/i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 15aefa3f3e18..3aa5304200c5 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -405,11 +405,11 @@ struct legacy_pic null_legacy_pic = {
 	.probe = legacy_pic_probe,
 	.irq_pending = legacy_pic_irq_pending_noop,
 	.make_irq = legacy_pic_uint_noop,
 };
 
-struct legacy_pic default_legacy_pic = {
+static struct legacy_pic default_legacy_pic = {
 	.nr_legacy_irqs = NR_IRQS_LEGACY,
 	.chip  = &i8259A_chip,
 	.mask = mask_8259A_irq,
 	.unmask = unmask_8259A_irq,
 	.mask_all = mask_8259A,
-- 
2.37.1

