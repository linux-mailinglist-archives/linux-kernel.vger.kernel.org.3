Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10215A21C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiHZH0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiHZH0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:26:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB44BD04
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:26:01 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDWW63cczz19S70;
        Fri, 26 Aug 2022 15:22:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:25:58 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 15:25:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mhiramat@kernel.org>, <ast@kernel.org>, <jbacik@fb.com>,
        <akpm@linux-foundation.org>
Subject: [PATCH -next 3/3] fail_function: fix wrong use of fei_attr_remove()
Date:   Fri, 26 Aug 2022 15:33:37 +0800
Message-ID: <20220826073337.2085798-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826073337.2085798-1-yangyingliang@huawei.com>
References: <20220826073337.2085798-1-yangyingliang@huawei.com>
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

If register_kprobe() fails, the new attr is not added to the list yet,
so it should call fei_attr_free() intstead.

Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/fail_function.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 893e8f9a9118..a7ccd2930c5f 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -295,7 +295,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 
 	ret = register_kprobe(&attr->kp);
 	if (ret) {
-		fei_attr_remove(attr);
+		fei_attr_free(attr);
 		goto out;
 	}
 	fei_debugfs_add_attr(attr);
-- 
2.25.1

