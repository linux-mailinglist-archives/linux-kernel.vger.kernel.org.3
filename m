Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06850D705
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiDYCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiDYCq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:46:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5C68F84
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:43:26 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kmq4w54xpzGpHX;
        Mon, 25 Apr 2022 10:40:48 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 10:43:23 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 10:43:23 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] base: topology: fix unused variable compile error
Date:   Mon, 25 Apr 2022 10:41:49 +0800
Message-ID: <20220425024149.259189-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compile error:
drivers/base/topology.c: In function ‘topology_is_visible’:
drivers/base/topology.c:158:17: error: unused variable ‘dev’ [-Werror=unused-variable]
  struct device *dev = kobj_to_dev(kobj);
                 ^~~
cc1: all warnings being treated as errors

If CONFIG_SMP is N, the macro 'topology_ppin()'expands as follows.
"topology_ppin(dev->id) -> boot_cpu_data.ppin"
This cause an unused variable warning for 'dev' which used in the
topology_is_visible().

To fix build warning unused attribute added to the 'dev' variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes:aa63a74d4535("topology/sysfs: Hide PPIN on systems that do not support it.")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/base/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 706dbf8bf249..70962a4bcb1f 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -155,7 +155,8 @@ static struct attribute *default_attrs[] = {
 static umode_t topology_is_visible(struct kobject *kobj,
 				   struct attribute *attr, int unused)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	struct device *dev __maybe_unused;

+	dev = kobj_to_dev(kobj);
 
 	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
 		return 0;
-- 
2.17.1

