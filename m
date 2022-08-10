Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073B158E58D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiHJDfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiHJDfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:35:11 -0400
X-Greylist: delayed 1461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 20:35:07 PDT
Received: from mx5.cs.washington.edu (mx5.cs.washington.edu [IPv6:2607:4000:200:11::6a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDA647F9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:35:07 -0700 (PDT)
Received: from mx5.cs.washington.edu (localhost [IPv6:0:0:0:0:0:0:0:1])
        by mx5.cs.washington.edu (8.17.1/8.17.1/1.26) with ESMTP id 27A3Aj4X207166;
        Tue, 9 Aug 2022 20:10:45 -0700
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [IPv6:2607:4000:200:10:0:0:0:8c])
        (authenticated bits=128)
        by mx5.cs.washington.edu (8.17.1/8.17.1/1.26) with ESMTPSA id 27A3AjBd207162
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:10:45 -0700
Received: from attu4.cs.washington.edu (localhost [127.0.0.1])
        by attu4.cs.washington.edu (8.15.2/8.15.2/1.23) with ESMTP id 27A3AiYQ2620315;
        Tue, 9 Aug 2022 20:10:44 -0700
Received: (from klee33@localhost)
        by attu4.cs.washington.edu (8.15.2/8.15.2/Submit/1.2) id 27A3AiAT2620314;
        Tue, 9 Aug 2022 20:10:44 -0700
From:   Kenneth Lee <klee33@uw.edu>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Kenneth Lee <klee33@uw.edu>
Subject: [PATCH] nvmem: brcm_nvram: Use kzalloc for allocating only one element
Date:   Tue,  9 Aug 2022 20:10:37 -0700
Message-Id: <20220810031037.2620221-1-klee33@uw.edu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc(...) rather than kcalloc(1, ...) because the number of
elements we are specifying in this case is 1, so kzalloc would
accomplish the same thing and we can simplify.

Signed-off-by: Kenneth Lee <klee33@uw.edu>
---
 drivers/nvmem/brcm_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 450b927691c3..4441daa20965 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -96,7 +96,7 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 
 	len = le32_to_cpu(header.len);
 
-	data = kcalloc(1, len, GFP_KERNEL);
+	data = kzalloc(len, GFP_KERNEL);
 	memcpy_fromio(data, priv->base, len);
 	data[len - 1] = '\0';
 
-- 
2.31.1

