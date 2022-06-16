Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F554E64A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377417AbiFPPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiFPPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:43:57 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2074419C01
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3SyGV
        GPAl6RCeoR6/3GY66rPKd6XLustmDizqKaNl8Y=; b=RwOw51MgK71kHeJ0Qekqq
        RN7adtZBwVvPmvKYxLmvLvrDIiYYpSjwiEboWze5XbCspqeQeiCIyHCGfGxkEDRt
        Pdd20rs0iemeL6zUKqT3XjCjGfRrXLcVeOVuQUPY/TQ/nDNKzGhwkbR0u/J0NuN9
        7P/adUvdXX+wiz2qSaKfBo=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgA37ZEwT6titcAYFw--.50981S2;
        Thu, 16 Jun 2022 23:41:37 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        clg@kaod.org, nick.child@ibm.com
Cc:     windhl@126.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sysdev: xive: Fix refcount leak in native.c
Date:   Thu, 16 Jun 2022 23:41:35 +0800
Message-Id: <20220616154135.3989769-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgA37ZEwT6titcAYFw--.50981S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyfZFy5ur4xZw47GFW7urg_yoW8CFW5pF
        Z7GFyjya1S9w18KrWSyF10vF4DCr1ktayrXa97GwnrAw4q9w4ktr45KryFqrW5GrWku3Wr
        tF1fCr1UJFsrWaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziZa9DUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hEiF1uwMN39YwAAsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xive_native_init(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
in each fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/sysdev/xive/native.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index d25d8c692909..3925825954bc 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -579,12 +579,12 @@ bool __init xive_native_init(void)
 	/* Resource 1 is HV window */
 	if (of_address_to_resource(np, 1, &r)) {
 		pr_err("Failed to get thread mgmnt area resource\n");
-		return false;
+		goto err_put;
 	}
 	tima = ioremap(r.start, resource_size(&r));
 	if (!tima) {
 		pr_err("Failed to map thread mgmnt area\n");
-		return false;
+		goto err_put;
 	}
 
 	/* Read number of priorities */
@@ -612,7 +612,7 @@ bool __init xive_native_init(void)
 	/* Resource 2 is OS window */
 	if (of_address_to_resource(np, 2, &r)) {
 		pr_err("Failed to get thread mgmnt area resource\n");
-		return false;
+		goto err_put;
 	}
 
 	xive_tima_os = r.start;
@@ -624,7 +624,7 @@ bool __init xive_native_init(void)
 	rc = opal_xive_reset(OPAL_XIVE_MODE_EXPL);
 	if (rc) {
 		pr_err("Switch to exploitation mode failed with error %lld\n", rc);
-		return false;
+		goto err_put;
 	}
 
 	/* Setup some dummy HV pool VPs */
@@ -634,10 +634,15 @@ bool __init xive_native_init(void)
 	if (!xive_core_init(np, &xive_native_ops, tima, TM_QW3_HV_PHYS,
 			    max_prio)) {
 		opal_xive_reset(OPAL_XIVE_MODE_EMU);
-		return false;
+		goto err_put;
 	}
+	of_node_put(np);
 	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
 	return true;
+
+err_put:
+	of_node_put(np);
+	return false;
 }
 
 static bool xive_native_provision_pages(void)
-- 
2.25.1

