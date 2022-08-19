Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABE59A660
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbiHSTRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiHSTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367C112332
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD3BEB828EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4046AC433D6;
        Fri, 19 Aug 2022 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936622;
        bh=xh2RwUx+IOfvx0O23D32LtyCfn37Im7W6U99oWOdZfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTNiSBZeRFYczCUQtpOW5j7eoDA7pIH7AyCg4Swt2iy6DLCJFIeXWaV1unG1jbFGp
         IebK8FdZiOUFI7TXq9ILPQi7/PFEFV1tZdX547zVVGhjfdD4GhXYS6aMDfj0qqxWBa
         R5lXX8GtM9mZ6O24J5COyMK0JDKcVQDQDrMQnldd0aIw+X/6cz3mZslnzhMW5Qy738
         BD1sEOHk5BoTdjdGPPoGmNTFHcuUZm3Pm2VpZANL/Z9YFplwDgrmtvDwG+EcYx7n7V
         V9AMSQvgyaH7bzlS0brjpdspNNlCXmwFeHl4RT1j/S9XeOuyKxBqEzSN5DnBQGKzu/
         p/0M3DvZAm/iA==
Received: by pali.im (Postfix)
        id E723D761; Fri, 19 Aug 2022 21:17:01 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] powerpc/85xx: p2020: Define just one machine description
Date:   Fri, 19 Aug 2022 21:15:55 +0200
Message-Id: <20220819191557.28116-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819191557.28116-1-pali@kernel.org>
References: <20220819191557.28116-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine machine descriptions and code of all P2020 boards into just one
generic unified P2020 machine description. This allows kernel to boot on
any P2020-based board with P2020 DTS file without need to patch kernel and
define a new machine description in 85xx powerpc platform directory.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/p2020.c | 83 +++++++----------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index d327e6c9b838..1a3ffeb47dfc 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -154,83 +154,38 @@ static void __init p2020_setup_arch(void)
 #endif
 }
 
-#ifdef CONFIG_MPC85xx_DS
-machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
-machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
-#endif /* CONFIG_MPC85xx_RDB */
+machine_arch_initcall(p2020, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
  */
-#ifdef CONFIG_MPC85xx_DS
-static int __init p2020_ds_probe(void)
-{
-	return !!of_machine_is_compatible("fsl,P2020DS");
-}
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-static int __init p2020_rdb_probe(void)
-{
-	if (of_machine_is_compatible("fsl,P2020RDB"))
-		return 1;
-	return 0;
-}
-
-static int __init p2020_rdb_pc_probe(void)
+static int __init p2020_probe(void)
 {
-	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
-		return 1;
-	return 0;
+	struct device_node *p2020_cpu;
+
+	/*
+	 * There is no common compatible string for all P2020 boards.
+	 * The only common thing is "PowerPC,P2020@0" cpu node.
+	 * So check for P2020 board via this cpu node.
+	 */
+	p2020_cpu = of_find_node_by_path("/cpus/PowerPC,P2020@0");
+	if (!p2020_cpu)
+		return 0;
+
+	of_node_put(p2020_cpu);
+	return 1;
 }
-#endif /* CONFIG_MPC85xx_RDB */
-
-#ifdef CONFIG_MPC85xx_DS
-define_machine(p2020_ds) {
-	.name			= "P2020 DS",
-	.probe			= p2020_ds_probe,
-	.setup_arch		= p2020_setup_arch,
-	.init_IRQ		= p2020_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-define_machine(p2020_rdb) {
-	.name			= "P2020 RDB",
-	.probe			= p2020_rdb_probe,
-	.setup_arch		= p2020_setup_arch,
-	.init_IRQ		= p2020_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
 
-define_machine(p2020_rdb_pc) {
-	.name			= "P2020RDB-PC",
-	.probe			= p2020_rdb_pc_probe,
+define_machine(p2020) {
+	.name			= "Freescale P2020",
+	.probe			= p2020_probe,
 	.setup_arch		= p2020_setup_arch,
 	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
+	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
-#endif /* CONFIG_MPC85xx_RDB */
-- 
2.20.1

