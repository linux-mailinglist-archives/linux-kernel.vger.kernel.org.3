Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57645550281
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiFRDdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiFRDdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:33:02 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03F1519FAB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YG6dR
        e/hH640v9iwqegEl+qUfUjOQngoEiIIerWSUzc=; b=FIZb4tzAYeyqgHmXnBp45
        ryDHiBl2oQ+0QIOePtw3m5xcmKG1Ga3zLzRw2jGmNNL00rQeVOFAdjaV2oHdatEF
        D591kucTfAeUXr5TaQW4YjRuJl/jmgK0qflJiVhhFyBRyr4qAtARRaMU5NRivh2W
        S8W0j4uECveZcRXTFqhil4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgDnStM4R61iQDkAFA--.33191S2;
        Sat, 18 Jun 2022 11:32:09 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, paulus@samba.org, christophe.leroy@csgroup.eu,
        nick.child@ibm.com, pali@kernel.org, npiggin@gmail.com
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sysdev: Fix refcount leak bug in fsl_pci.c
Date:   Sat, 18 Jun 2022 11:32:07 +0800
Message-Id: <20220618033207.4057410-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgDnStM4R61iQDkAFA--.33191S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1kCryrtFyxJw43trW7CFg_yoWDJrg_Xw
        1xu3WDZ395Ja1furs3Ca93t3sakw48WayqgFn2gay7Ja4Yg3y7Ja17Zr98XrW7ur4SyrWY
        kr95XrWYka4IvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMxhLDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBkkF2JVj6vE7wAAsq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In is_kdump(), we need a of_node_put() to dec the refcount which is
incremented by of_find_node_by_type().

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 1011cfea2e32..4c986c955951 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -180,6 +180,7 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 static bool is_kdump(void)
 {
 	struct device_node *node;
+	bool ret;
 
 	node = of_find_node_by_type(NULL, "memory");
 	if (!node) {
@@ -187,7 +188,10 @@ static bool is_kdump(void)
 		return false;
 	}
 
-	return of_property_read_bool(node, "linux,usable-memory");
+	ret = of_property_read_bool(node, "linux,usable-memory");
+	of_node_put(node);
+
+	return ret;
 }
 
 /* atmu setup for fsl pci/pcie controller */
-- 
2.25.1

