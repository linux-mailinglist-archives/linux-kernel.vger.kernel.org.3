Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DE4C8EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiCAPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiCAPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:16:06 -0500
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139D42A25
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:15:17 -0800 (PST)
X-QQ-mid: bizesmtp88t1646147709tbqoizn3
Received: from leo.localdomain (unknown [103.144.149.54])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Mar 2022 23:15:06 +0800 (CST)
X-QQ-SSF: 0140000000800040B000000A0000000
X-QQ-FEAT: aUmmB7BHjL+JU/Ms1wMGQcQsh0/ClGgbR7zaMh8GOGhAxk7sLQyxPIOhnv1vC
        u75Ip0M/gfZDIL/ccOiVsu7JNaZsw6cMPe8uiiUWdrqsKnmt01twH4FwH64VwQZt45KvXRP
        aUaXhbXgqlYX6dngYl1tBLirZud3UwzB5u7AIPV+RkXbVAPsJ01kZ78Vi9l5WWL37hC5R46
        lG9jUwKVTtuafXvYcOLuTlKEE/Yg2lmaO1enUQbY4X0U1aVIaYTEJISJ6n8u3Q7VDinypHw
        8OtRjbqmKZ3Ddb1Qxh0/GjXB0Lknrn4aSJBZfiiW7kfppaH8m9saWxLIUgmn3Mk+pjCeb/s
        DNmuTR4L9bXWE4w/rZ53q8uCcNoqemw1j5QvdCI
X-QQ-GoodBg: 2
From:   Jiajian Ye <yejiajian2018@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, caoyixuan2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn,
        zhaochongxi2019@email.szu.edu.cn, weizhenliang@huawei.com,
        zhangyinan2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 2/3] tools/vm/page_owner_sort.c: add a security check
Date:   Tue,  1 Mar 2022 23:14:37 +0800
Message-Id: <20220301151438.166118-2-yejiajian2018@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301151438.166118-1-yejiajian2018@email.szu.edu.cn>
References: <20220301151438.166118-1-yejiajian2018@email.szu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a security check after using malloc() to allocate memory.

Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 79d69c3b84ed..69fb6ca7c0b7 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -217,7 +217,13 @@ static void add_list(char *buf, int len)
 		printf("max_size too small??\n");
 		exit(1);
 	}
+
 	list[list_size].txt = malloc(len+1);
+	if (!list[list_size].txt) {
+		printf("Out of memory\n");
+		exit(1);
+	}
+
 	list[list_size].len = len;
 	list[list_size].num = 1;
 	list[list_size].page_num = get_page_num(buf);
-- 
2.25.1



