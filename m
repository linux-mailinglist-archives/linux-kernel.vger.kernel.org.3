Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9B55F63F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiF2GFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiF2GFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:05:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3718E1A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:05:21 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXrWM4nFYzkX5D;
        Wed, 29 Jun 2022 14:03:59 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 14:05:18 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 14:05:18 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        <kernel-hardening@lists.openwall.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: [PATCH v2] stack: Declare {randomize_,}kstack_offset to fix Sparse warnings
Date:   Wed, 29 Jun 2022 14:04:23 +0800
Message-ID: <20220629060423.2515693-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following Sparse warnings that got noticed when the PPC-dev
patchwork was checking another patch (see the link below):

init/main.c:862:1: warning: symbol 'randomize_kstack_offset' was not declared. Should it be static?
init/main.c:864:1: warning: symbol 'kstack_offset' was not declared. Should it be static?

Which in fact are triggered on all architectures that have
HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET support (for instances x86, arm64
etc).

Link: https://lore.kernel.org/lkml/e7b0d68b-914d-7283-827c-101988923929@huawei.com/T/#m49b2d4490121445ce4bf7653500aba59eefcb67f
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---

v2: remove unnecessary #ifdef around the header

 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index e2490387db2b..eb9bf7c5b28b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
+#include <linux/randomize_kstack.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
-- 
2.25.1

