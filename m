Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369DC52AFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiERBSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiERBSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:18:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32536424B7;
        Tue, 17 May 2022 18:18:34 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2w8j1MqrzhZ4J;
        Wed, 18 May 2022 09:17:57 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 09:18:32 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 09:18:32 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Kees Cook" <keescook@chromium.org>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        "Xiu Jianfeng" <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH] security: keys: add __randomize_layout to keyring_search_context
Date:   Wed, 18 May 2022 09:18:41 +0000
Message-ID: <20220518091841.141441-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Struct keyring_search_context contains a pointer to `struct cred`, which
is a security-critical structure and whose layout is randomized already.
Apply __randomize_layout to struct keyring_search_context as well, as
suggested in [1].

[1]: https://github.com/KSPP/linux/issues/188

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 security/keys/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..3e3def5fbaa4 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -136,7 +136,7 @@ struct keyring_search_context {
 	bool			possessed;
 	key_ref_t		result;
 	time64_t		now;
-};
+} __randomize_layout;
 
 extern bool key_default_cmp(const struct key *key,
 			    const struct key_match_data *match_data);
-- 
2.17.1

