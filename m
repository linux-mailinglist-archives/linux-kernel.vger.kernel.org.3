Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC465061AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiDSB0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiDSB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:26:45 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D41286ED;
        Mon, 18 Apr 2022 18:24:02 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 19 Apr
 2022 09:24:04 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 19 Apr
 2022 09:24:00 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <seakeel@gmail.com>
CC:     <alexs@kernel.org>, <baihaowen@meizu.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <siyanteng01@gmail.com>, <siyanteng@loongson.cn>
Subject: [PATCH V4] docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
Date:   Tue, 19 Apr 2022 09:23:58 +0800
Message-ID: <1650331438-4555-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <202ba5f5-f842-f4ce-dd67-c5166d94cc67@gmail.com>
References: <202ba5f5-f842-f4ce-dd67-c5166d94cc67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the tools/vm/page_owner_sort added some feature and original text
updated, sync the translation of zh_CN.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: fix whitespace warning.
V2->V3: fix some tab Alignment issue.
V3->V4: fix sphinx warning

 Documentation/translations/zh_CN/vm/page_owner.rst | 61 +++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/vm/page_owner.rst
index 9e951fabba9d..4d719547ce4f 100644
--- a/Documentation/translations/zh_CN/vm/page_owner.rst
+++ b/Documentation/translations/zh_CN/vm/page_owner.rst
@@ -103,14 +103,73 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
 		-m		按总内存排序
 		-p		按pid排序。
 		-P		按tgid排序。
+		-n		按任务名称排序。
 		-r		按内存释放时间排序。
 		-s		按堆栈跟踪排序。
 		-t		按时间排序（默认）。
+		--sort <order>	指定排序顺序。排序语法是 [+|-]key[,[+|-]key[,...]]. 从
+						**标准格式说明符** 部分选择一个键。"+" 是可选的，因为默认方向是增加数字或字典顺序。
+						允许混合使用缩写键和全称键。
+
+		Examples:
+				./page_owner_sort <input> <output> --sort=n,+pid,-tgid
+				./page_owner_sort <input> <output> --sort=at
 
    其它函数:
 
 	Cull:
-		-c		通过比较堆栈跟踪而不是总块来进行剔除。
+		--cull <rules>
+				指定筛选规则。筛选语法是 key[,key[,...]]。在**标准格式说明符**部分选择一个多字母键
+
+		<rules> 是逗号分隔列表形式的单个参数，它提供了一种指定单个筛选规则的方法。下面的**标准格式说明
+				符**部分描述了可识别的关键字。<rules> 可以由键 k1,k2, ... 顺序指定，如下面的
+				STANDARD SORT KEYS 部分所述。允许混合使用缩写形式和完整形式的键。
 
+		Examples:
+				./page_owner_sort <input> <output> --cull=stacktrace
+				./page_owner_sort <input> <output> --cull=st,pid,name
+				./page_owner_sort <input> <output> --cull=n,f
 	Filter:
 		-f		过滤掉内存已被释放的块的信息。
+
+	Select:
+		--pid <pidlist>		通过 pid 进行选择。这将选择进程 ID 号出现在 <pidlist> 中的块。
+		--tgid <tgidlist>	通过 tgid 进行选择。这将选择线程组 ID 号出现在 <tgidlist> 中的块。
+		--name <cmdlist>	按任务名称选择。这将选择任务名称出现在 <cmdlist> 中的块。
+
+		<pidlist>、<tgidlist>、<cmdlist>是逗号分隔列表形式的单参数，它提供了一种指定单个选择规则的方法。
+
+
+		Examples:
+				./page_owner_sort <input> <output> --pid=1
+				./page_owner_sort <input> <output> --tgid=1,2,3
+				./page_owner_sort <input> <output> --name name1,name2
+
+标准格式说明符
+==============
+
+--sort 选项:
+
+        ======          ==========      ===================
+        缩写键          全称键          描述
+        ======          ==========      ===================
+        p               pid             进程 ID
+        tg              tgid            线程组 ID
+        n               name            任务名称
+        st              stacktrace      页面分配的调用栈
+        T               txt             块的全文
+        ft              free_ts         页面被释放的时间戳
+        at              alloc_ts        页面分配的时间戳
+        ======          ==========      ===================
+
+--curl 选项:
+
+        ======          ==========      ==================
+        缩写键          全称键          描述
+        ======          ==========      ==================
+        p               pid             进程 ID
+        tg              tgid            线程组 ID
+        n               name            任务名称
+        f               free            该页面是否已被释放
+        st              stacktrace      页面分配的调用栈
+        ======          ==========      ==================
-- 
2.7.4

