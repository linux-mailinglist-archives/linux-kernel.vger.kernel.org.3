Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE8F49AE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452354AbiAYIs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:48:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35863 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452002AbiAYIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:44:43 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JjgPL1sKLzcchp;
        Tue, 25 Jan 2022 16:43:50 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 16:44:39 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <roberto.sassu@huawei.com>, <wangweiyang2@huawei.com>,
        <xiujianfeng@huawei.com>
Subject: [PATCH -next] Documentation: added order requirement for ima_hash=
Date:   Tue, 25 Jan 2022 16:44:50 +0800
Message-ID: <20220125084450.116549-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Zihua <guozihua@huawei.com>

Commandline parameter ima_hash= and ima_template= has order requirement
for them to work correctly together. Namely ima_hash= must be
specified after ima_template=, otherwise ima_template= will be ignored.

The reason is that when handling ima_hash=, ima template would be set to
the default value if it has not been initialized already, and that value
cannot be changed afterwards by ima_template=.

This patch adds this limitation to the documentation.

Signed-off-by: Guo Zihua <guozihua@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..1b5aa6ca65f8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1843,6 +1843,10 @@
 			The list of supported hash algorithms is defined
 			in crypto/hash_info.h.
 
+			This parameter must be specified after ima_template=,
+			as it would set the default template and that cannot be
+			changed by ima_template= afterwards.
+
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
@@ -1879,6 +1883,9 @@
 			Formats: { "ima" | "ima-ng" | "ima-sig" }
 			Default: "ima-ng"
 
+			This parameter must be specified before ima_hash=.
+			Please refer to ima_hash= for further explanation.
+
 	ima_template_fmt=
 			[IMA] Define a custom template format.
 			Format: { "field1|...|fieldN" }
-- 
2.17.1

