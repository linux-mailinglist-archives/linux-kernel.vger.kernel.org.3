Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284AD4CB4E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiCCCZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiCCCZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:25:22 -0500
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CF0222510
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FMC3B
        ThJay6ZyQySWuF7Ne1eBs8L9p34i4Q8u9HO1qM=; b=jo/2WOUeGtDJgPO95RWaY
        WR3aOnzsvYhdX6oLdLEJSATDcJBuaKzwxU28Ugxd0O42Fm4KGzJlbasH2mShXWXE
        DsYHf4iSFiZ+sk65jG5fbJHHvjaFHG5qFcOiiaZUGhSFdRCoz6tXrPKrb1ZihVZS
        gx+V3ywL7X3w02IuHu7YEc=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp4 (Coremail) with SMTP id HNxpCgDnb5qrJiBiPWY2Ew--.7370S4;
        Thu, 03 Mar 2022 10:23:51 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     gilad@benyossef.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] crypto: ccree: Fix use after free in cc_cipher_exit()
Date:   Thu,  3 Mar 2022 10:23:37 +0800
Message-Id: <20220303022337.460971-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDnb5qrJiBiPWY2Ew--.7370S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr17WFWkKr4DKrWUtF13urg_yoWfurX_u3
        4xGa4xJryUAryagw4UAw4rurWFkasavrZ5Wr4xtrWUWFyUZrn3uF1xArn7AryUZr45XFn7
        GF48Kw1rur1DWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE2YLPUUUUU==
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMh64jFWBxmyVCQABs7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_sensitive(ctx_p->user.key) will free the ctx_p->user.key. But
ctx_p->user.key is still used in the next line, which will lead to a
use after free.

We can call kfree_sensitive() after dev_dbg() to avoid the uaf.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/crypto/ccree/cc_cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 78833491f534..309da6334a0a 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -257,8 +257,8 @@ static void cc_cipher_exit(struct crypto_tfm *tfm)
 		&ctx_p->user.key_dma_addr);
 
 	/* Free key buffer in context */
-	kfree_sensitive(ctx_p->user.key);
 	dev_dbg(dev, "Free key buffer in context. key=@%p\n", ctx_p->user.key);
+	kfree_sensitive(ctx_p->user.key);
 }
 
 struct tdes_keys {
-- 
2.25.1

