Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF053F36B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiFGBgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiFGBga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:36:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14CECEBB9;
        Mon,  6 Jun 2022 18:36:29 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LHCZm5xMyz1K9Rj;
        Tue,  7 Jun 2022 09:34:40 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 09:36:27 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 09:36:27 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
CC:     Kees Cook <keescook@chromium.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Wang Weiyang" <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: [RESEND PATCH] smack: Replace kzalloc + strncpy with kstrndup
Date:   Tue, 7 Jun 2022 17:36:49 +0800
Message-ID: <20220607093649.928131-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using kstrndup instead of kzalloc and strncpy in
smk_parse_smack(), which meanwhile remove strncpy as [1] suggests.

[1]: https://github.com/KSPP/linux/issues/90

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---

Resend: fix email issue to make it acceptable by the mailing list

 security/smack/smack_access.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index d2186e2757be..585e5e35710b 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -465,12 +465,9 @@ char *smk_parse_smack(const char *string, int len)
 	if (i == 0 || i >= SMK_LONGLABEL)
 		return ERR_PTR(-EINVAL);
 
-	smack = kzalloc(i + 1, GFP_NOFS);
-	if (smack == NULL)
+	smack = kstrndup(string, i, GFP_NOFS);
+	if (!smack)
 		return ERR_PTR(-ENOMEM);
-
-	strncpy(smack, string, i);
-
 	return smack;
 }
 
-- 
2.25.1

