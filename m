Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B94C0F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiBWJlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiBWJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:41:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF65B8BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:41:18 -0800 (PST)
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K3WC12n9Tzbbmn;
        Wed, 23 Feb 2022 17:36:45 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 23 Feb 2022 17:41:16 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>, <xiujianfeng@huawei.com>
Subject: [PATCH -next] audit: only print records that will be dropped via printk()
Date:   Wed, 23 Feb 2022 17:41:09 +0800
Message-ID: <20220223094109.192510-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an admin enables audit at early boot via the "audit=1" kernel
command line, netlink send errors seen will cause the audit subsystem
to drop some records or return records to the queue. And all records
will be printed via printk() in the kauditd_hold_skb(), but actually
only the records that will be dropped need to be printed via printk().

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/audit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 7690c29d4ee4..eb3e44c849be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -568,10 +568,6 @@ static void kauditd_rehold_skb(struct sk_buff *skb, __always_unused int error)
  */
 static void kauditd_hold_skb(struct sk_buff *skb, int error)
 {
-	/* at this point it is uncertain if we will ever send this to auditd so
-	 * try to send the message via printk before we go any further */
-	kauditd_printk_skb(skb);
-
 	/* can we just silently drop the message? */
 	if (!audit_default)
 		goto drop;
@@ -600,6 +596,11 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
 	/* we have no other options - drop the message */
 	audit_log_lost("kauditd hold queue overflow");
 drop:
+	/* at this point it is uncertain if we will ever send this to auditd so
+	 * try to send the message via printk before we go any further
+	 */
+	kauditd_printk_skb(skb);
+
 	kfree_skb(skb);
 }
 
-- 
2.30.0

