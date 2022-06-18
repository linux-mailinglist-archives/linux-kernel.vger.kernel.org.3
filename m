Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314C655029D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 06:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiFRELi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 00:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFRELg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 00:11:36 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0C81606F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DhswK
        TrmeUbKndG6IYc5Pec0+hrQzVcfBYcwy6754iY=; b=Kf5feUfvu5rP35R6M3Rn9
        TimAtl8GS8lKAeozkpaEfRPFu+5pSlOFd6Bj030dvNZKE4ej9BuDJOvGvD/DQzMq
        92prbAkEBxYAdvw8L3C+fRQOrFY6xc5FJfZBaVuGNqYI4zrkWkVayNXGl/iXCJ5j
        XTXukdljFC2fZ2UM0BojnQ=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgD3RGlDUK1iKBiWEw--.28580S2;
        Sat, 18 Jun 2022 12:10:44 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com, maz@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] powerpc: embedded6xx: Fix refcount leak bugs
Date:   Sat, 18 Jun 2022 12:10:42 +0800
Message-Id: <20220618041042.4058066-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgD3RGlDUK1iKBiWEw--.28580S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1DAFy7WFyDGF1fGF4rKrg_yoW8KFykpr
        yvkFs2yF48WFZ7ta4vyFZrZryxGFnYgrW3tw4jk3s7ZF1DurWIvFWUX3sxtrWkGrWUW3Wr
        Zr4Ikw4Sqwn3W3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR5UUUUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AQkF1pEDvpQjAAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xx_init_xx(), of_find_node_by_type() will return a node pointer
with refcount incremented. We should use of_node_put() when it is
not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 v2: we merge all embedded6xx related bugs into one commit
 v1: we only report the bug in holly_init_pci() of holly.c

 arch/powerpc/platforms/embedded6xx/holly.c        | 6 ++++++
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 78f2378d9223..bebc5a972694 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -123,6 +123,8 @@ static void __init holly_init_pci(void)
 	if (np)
 		tsi108_setup_pci(np, HOLLY_PCI_CFG_PHYS, 1);
 
+	of_node_put(np);
+
 	ppc_md.pci_exclude_device = holly_exclude_device;
 	if (ppc_md.progress)
 		ppc_md.progress("tsi108: resources set", 0x100);
@@ -184,6 +186,9 @@ static void __init holly_init_IRQ(void)
 	tsi108_pci_int_init(cascade_node);
 	irq_set_handler_data(cascade_pci_irq, mpic);
 	irq_set_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
+
+	of_node_put(tsi_pci);
+	of_node_put(cascade_node);
 #endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
@@ -210,6 +215,7 @@ static void __noreturn holly_restart(char *cmd)
 	if (bridge) {
 		prop = of_get_property(bridge, "reg", &size);
 		addr = of_translate_address(bridge, prop);
+		of_node_put(bridge);
 	}
 	addr += (TSI108_PB_OFFSET + 0x414);
 
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 8b2b42210356..ddf0c652af80 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -135,6 +135,9 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 	tsi108_pci_int_init(cascade_node);
 	irq_set_handler_data(cascade_pci_irq, mpic);
 	irq_set_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
+
+	of_node_put(tsi_pci);
+	of_node_put(cascade_node);
 #endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
-- 
2.25.1

