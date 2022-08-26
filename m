Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3415A214D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbiHZHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiHZHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:00:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D92910AB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:00:13 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDVxM2yzPz19VdM;
        Fri, 26 Aug 2022 14:56:39 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:59:59 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 14:59:58 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 3/3] mm/zswap: skip confusing print info
Date:   Fri, 26 Aug 2022 15:34:32 +0800
Message-ID: <20220826073432.4168976-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826073432.4168976-1-liushixin2@huawei.com>
References: <20220826073432.4168976-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's confusing when we disable zswap while zswap is init failed or has no
pool. If no change required, just return directly.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 4c476c463035..ef7463550e49 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -886,6 +886,15 @@ static int zswap_zpool_param_set(const char *val,
 static int zswap_enabled_param_set(const char *val,
 				   const struct kernel_param *kp)
 {
+	bool res;
+
+	if (kstrtobool(val, &res))
+		return -EINVAL;
+
+	/* no change required */
+	if (res == *(bool *)kp->arg)
+		return 0;
+
 	if (system_state == SYSTEM_RUNNING) {
 		mutex_lock(&zswap_init_lock);
 		if (zswap_setup()) {
-- 
2.25.1

