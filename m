Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F04DB01D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355939AbiCPMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355980AbiCPMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:53:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A04F46C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:51:48 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KJVRx5qYCz9sjx;
        Wed, 16 Mar 2022 20:47:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 20:51:46 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 20:51:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] locking/refcount: Use REFCOUNT_WARN() to simplify code
Date:   Wed, 16 Mar 2022 20:51:14 +0800
Message-ID: <20220316125114.1177-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the check "new > val" appears twice, and make the style
consistent with that in refcount_warn_saturate().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3ca35..d36aa3fa728f53b 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -84,7 +84,7 @@ bool refcount_dec_not_one(refcount_t *r)
 
 		new = val - 1;
 		if (new > val) {
-			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
+			REFCOUNT_WARN("underflow; use-after-free");
 			return true;
 		}
 
-- 
2.25.1

