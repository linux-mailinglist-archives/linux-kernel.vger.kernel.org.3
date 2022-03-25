Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F64E6C95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357797AbiCYCeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357773AbiCYCen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:34:43 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09ACD5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:33:07 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 25 Mar
 2022 10:33:06 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 25 Mar
 2022 10:33:05 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <haren@us.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] lib: 842: Fix pointer dereferenced before checking
Date:   Fri, 25 Mar 2022 10:33:03 +0800
Message-ID: <1648175583-2045-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer t is dereferencing comp_ops[c] before c is being
 bound checked. Fix this by assigning comp_ops[c] to t only if
c is safy, otherwise just NULL.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 lib/842/842_compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4..6ff6973 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -222,7 +222,7 @@ static int add_bits(struct sw842_param *p, u64 d, u8 n)
 static int add_template(struct sw842_param *p, u8 c)
 {
 	int ret, i, b = 0;
-	u8 *t = comp_ops[c];
+	u8 *t = c < OPS_MAX ? comp_ops[c] : NULL;
 	bool inv = false;
 
 	if (c >= OPS_MAX)
-- 
2.7.4

