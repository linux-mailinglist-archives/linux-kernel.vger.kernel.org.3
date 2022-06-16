Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A1854E527
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377774AbiFPOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376985AbiFPOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:41:35 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A910D4738B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=phAgN
        klwvZ7SdoZ2WJPlzBwUJAkY95Zd5DNyI8fp88c=; b=gBN4cU/Myd2tGIza1Q6lT
        mqFRxwpu5vmSthPUPG6AOxgZNKYaKWQ0mRLVwC+WVFfgl6jm+4etuqxnC3yjAv/r
        0OXRxcMIUa+UYWyWc9TvFhRRH9/RdRAZbX2NujXRYcQ5hzqM3nMnuKL1pzv3wE/3
        d31MQtZ47sW2VMFNWQxQAs=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowABXlfTHQKti04bZDQ--.15246S2;
        Thu, 16 Jun 2022 22:40:08 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, agust@denx.de, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu, maz@kernel.org,
        wangqing@vivo.com
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: platforms: 52xx: Fix refcount leak in media5200.c
Date:   Thu, 16 Jun 2022 22:40:07 +0800
Message-Id: <20220616144007.3987743-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowABXlfTHQKti04bZDQ--.15246S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr17tFykJFykZw48KF45ZFb_yoWkArg_W3
        WkZF47Wr48Jr4DJrZIvr13AF1jyw48WF18KFn0qa17Jwn8XrsxWrn2vFsFkw4UXr4IvrW5
        Gan5KF4qya4YvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjn2-3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gkiF1uwMN203AAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In media5200_init_irq(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Don't worry about 'fpga_np==NULL' as of_node_put() can correctly
handle it.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/52xx/media5200.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index ee367ff3ec8a..33a35fff11b5 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -174,6 +174,8 @@ static void __init media5200_init_irq(void)
 		goto out;
 	pr_debug("%s: allocated irqhost\n", __func__);
 
+	of_node_put(fpga_np);
+
 	irq_set_handler_data(cascade_virq, &media5200_irq);
 	irq_set_chained_handler(cascade_virq, media5200_irq_cascade);
 
@@ -181,6 +183,7 @@ static void __init media5200_init_irq(void)
 
  out:
 	pr_err("Could not find Media5200 FPGA; PCI interrupts will not work\n");
+	of_node_put(fpga_np);
 }
 
 /*
-- 
2.25.1

