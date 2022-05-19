Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94452C9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiESChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiESChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:37:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2BB8FFB2;
        Wed, 18 May 2022 19:37:37 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3YrY5yZrz1JCDW;
        Thu, 19 May 2022 10:36:13 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 10:37:36 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 10:37:35 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gustavoars@kernel.org>, <johnny.chenyi@huawei.com>,
        <chenjiahao16@huawei.com>, <chenlifu@huawei.com>,
        <lizhengyu3@huawei.com>, <liaochang1@huawei.com>,
        <linyujun809@huawei.com>, <wangzhu9@huawei.com>,
        <xuyihang@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH -next v2] x86/events:Use struct_size() helper in kzalloc()
Date:   Thu, 19 May 2022 10:36:00 +0800
Message-ID: <20220519023600.241591-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/x86/events/rapl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5ad..8da003e02010 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -683,10 +683,8 @@ static const struct attribute_group *rapl_attr_update[] = {
 static int __init init_rapl_pmus(void)
 {
 	int maxdie = topology_max_packages() * topology_max_die_per_package();
-	size_t size;
 
-	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
-	rapl_pmus = kzalloc(size, GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-- 
2.17.1

