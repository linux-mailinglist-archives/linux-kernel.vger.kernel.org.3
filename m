Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6B522A61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiEKDWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbiEKDWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:22:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E25F2CCA9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:21:16 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kyg8x6TzszGpm6;
        Wed, 11 May 2022 11:18:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 11:21:13 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <haren@linux.ibm.com>,
        <gregkh@linuxfoundation.org>, <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] powerpc/pseries/vas: Call misc_deregister if sysfs init fails
Date:   Wed, 11 May 2022 11:35:07 +0800
Message-ID: <20220511033507.2745992-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Undo effects of misc_register if sysfs init fails after
misc_register.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 arch/powerpc/platforms/pseries/vas-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/vas-sysfs.c b/arch/powerpc/platforms/pseries/vas-sysfs.c
index ec65586cbeb3..89ed64d61da7 100644
--- a/arch/powerpc/platforms/pseries/vas-sysfs.c
+++ b/arch/powerpc/platforms/pseries/vas-sysfs.c
@@ -248,6 +248,7 @@ int __init sysfs_pseries_vas_init(struct vas_all_caps *vas_caps)
 	pseries_vas_kobj = kobject_create_and_add("vas0",
 					&vas_miscdev.this_device->kobj);
 	if (!pseries_vas_kobj) {
+		misc_deregister(&vas_miscdev);
 		pr_err("Failed to create VAS sysfs entry\n");
 		return -ENOMEM;
 	}
@@ -259,6 +260,7 @@ int __init sysfs_pseries_vas_init(struct vas_all_caps *vas_caps)
 		if (!gzip_caps_kobj) {
 			pr_err("Failed to create VAS GZIP capability entry\n");
 			kobject_put(pseries_vas_kobj);
+			misc_deregister(&vas_miscdev);
 			return -ENOMEM;
 		}
 	}
--
2.31.1

