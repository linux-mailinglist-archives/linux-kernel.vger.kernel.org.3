Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D52C5A21C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiHZH0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbiHZH0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:26:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B64A82E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:25:59 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDWW52CMWzkWJX;
        Fri, 26 Aug 2022 15:22:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:25:58 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 15:25:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mhiramat@kernel.org>, <ast@kernel.org>, <jbacik@fb.com>,
        <akpm@linux-foundation.org>
Subject: [PATCH -next 1/3] fail_function: Switch to memdup_user_nul() helper
Date:   Fri, 26 Aug 2022 15:33:35 +0800
Message-ID: <20220826073337.2085798-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding to
simplify the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/fail_function.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 60dc825ecc2b..03643e33e4c3 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -247,15 +247,11 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 	/* cut off if it is too long */
 	if (count > KSYM_NAME_LEN)
 		count = KSYM_NAME_LEN;
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
 
-	if (copy_from_user(buf, buffer, count)) {
-		ret = -EFAULT;
-		goto out_free;
-	}
-	buf[count] = '\0';
+	buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
 	sym = strstrip(buf);
 
 	mutex_lock(&fei_lock);
@@ -308,7 +304,6 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 	}
 out:
 	mutex_unlock(&fei_lock);
-out_free:
 	kfree(buf);
 	return ret;
 }
-- 
2.25.1

