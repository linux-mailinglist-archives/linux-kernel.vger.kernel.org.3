Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF8854C968
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbiFONEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbiFONEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:04:36 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E324BC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GlgJr
        jeg/CBr0HUGVAWv37hbOz7nXbo7LjovdWwvOH8=; b=AhDUc/UaRBRkd5DD0Z+1K
        MuM2Y3k8gTD+pwycRwoKgn+15YeDruNuFExAI+9T2PPunoGXKy8LPHOOw/DUfRMV
        LTGTw0gl1byPHb37ZGDzw2MYf1giPy1QKaY/Udo7qMOc8f+K1tGhhqJMylNTtmZU
        YSxOf5mW63SCp0cVu4+XUw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgDX2a6f2KliVkMvEw--.52482S2;
        Wed, 15 Jun 2022 21:03:28 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     monstr@monstr.eu, wangxiang@cdjrlc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: microblaze: pci: Add missing of_node_put() in xilinx_pci.c
Date:   Wed, 15 Jun 2022 21:03:26 +0800
Message-Id: <20220615130326.3966842-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgDX2a6f2KliVkMvEw--.52482S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryDJF17trb_yoWkWrgEgw
        1fWFWfCrW8Zry7CrsFvr43A3s8AayxGwn0gF1xtF17ta47GFnIkrykA39xGry8ur4YqrW7
        CrWqqF47ZF129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_5l1JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gAhF1uwMNV9LQAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xilinx_pci_init(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put() in
fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/microblaze/pci/xilinx_pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index f4cb86fffcee..018d91bdcbb9 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -132,13 +132,13 @@ void __init xilinx_pci_init(void)
 
 	if (of_address_to_resource(pci_node, 0, &r)) {
 		pr_err("xilinx-pci: cannot resolve base address\n");
-		return;
+		goto out_put;
 	}
 
 	hose = pcibios_alloc_controller(pci_node);
 	if (!hose) {
 		pr_err("xilinx-pci: pcibios_alloc_controller() failed\n");
-		return;
+		goto out_put;
 	}
 
 	/* Setup config space */
@@ -167,4 +167,7 @@ void __init xilinx_pci_init(void)
 
 	pr_info("xilinx-pci: Registered PCI host bridge\n");
 	xilinx_early_pci_scan(hose);
+	
+out_put:
+	of_node_put(pci_node);
 }
-- 
2.25.1

