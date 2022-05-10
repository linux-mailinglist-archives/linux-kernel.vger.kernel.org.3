Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE5520F75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiEJIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiEJILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:11:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1772207
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:07:01 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ky9bf1mymzhZ16;
        Tue, 10 May 2022 16:06:22 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 16:06:59 +0800
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 16:06:59 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <chris@zankel.net>, <jcmvbkbc@gmail.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-xtensa@linux-xtensa.org>, <linux-kernel@vger.kernel.org>,
        <axboe@kernel.dk>, <wangweiyang2@huawei.com>
Subject: [PATCH -next] xtensa/simdisk: fix error handling in proc_read_simdisk()
Date:   Tue, 10 May 2022 16:05:33 +0800
Message-ID: <20220510080533.51032-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frist simple_read_from_buffer() will change ppos. if ppos >= 1.
The second simple_read_from_buffer() will does not work and return 0.

Fixes: a69755b18774 ("xtensa simdisk: switch to proc_create_data()")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 arch/xtensa/platforms/iss/simdisk.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 0f0e0724397f..618c080c388d 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -210,13 +210,21 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 {
 	struct simdisk *dev = pde_data(file_inode(file));
 	const char *s = dev->filename;
+	char *temp;
+
 	if (s) {
+		ssize_t len = strlen(s);
+
+		temp = kmalloc(len + 2, GFP_KERNEL);
+		if (!temp)
+			return -ENOMEM;
+
+		scnprintf(temp, len + 2, "%s\n", s);
 		ssize_t n = simple_read_from_buffer(buf, size, ppos,
-							s, strlen(s));
-		if (n < 0)
-			return n;
-		buf += n;
-		size -= n;
+							temp, strlen(temp));
+
+		kfree(temp);
+		return n;
 	}
 	return simple_read_from_buffer(buf, size, ppos, "\n", 1);
 }
-- 
2.17.1

