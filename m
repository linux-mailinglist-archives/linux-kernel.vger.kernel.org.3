Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7761659745A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbiHQQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiHQQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE17696E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7A860C99
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5AFC433D6;
        Wed, 17 Aug 2022 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660754399;
        bh=iESuab/GKX0fswCPTX5dFkCWT/Mxgq1ucT4DlEoSJkE=;
        h=From:To:Cc:Subject:Date:From;
        b=RWuXyU6pA4gCnpeYpA4Q/0/G0LEnURX3g/ZObpiqyaiSJa/yy4nJEDe9c47R1qmCo
         4CvQd5lW5W4+hrsLKEX/aBSmUy3fCRfTJoCoWQ7pMXv1VD6tbmUWxa3msNKy07a0ug
         JRVX8bkZJhaGsVJJXygfVmXS9DV+Xqqrw0xeWeDy0H9TQSKZOIeQPzriq2Yd/Z8HHx
         UEcKEW7npeEg2LrUOsgX9wLH+itaA5rJvOWZCdcLw+ETvNPMe9v5P/32+sK6tEMA+0
         HHDHQZqrQiZIj27LiqPB/ShAK6wBHz+eWqMPJVIFsTToCfaO9yjWhlolh/6PAhqqRr
         B28QDKDbion3g==
Received: by pali.im (Postfix)
        id C46E6739; Wed, 17 Aug 2022 18:39:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/pci: Allow to disable filling deprecated pci-OF-bus-map
Date:   Wed, 17 Aug 2022 18:39:26 +0200
Message-Id: <20220817163927.24453-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Creating or filling pci-OF-bus-map property in the device-tree is
deprecated since May 2006 [1]. Allow to disable filling this property by
unsetting config option CONFIG_PPC_PCI_OF_BUS_MAP_FILL for remaining chrp
and powermac code.

Disabling of pci-OF-bus-map property allows to enable new option
CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT also for chrp and powermac.

[1] - https://lore.kernel.org/linuxppc-dev/1148016268.13249.14.camel@localhost.localdomain/

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/Kconfig         | 12 +++++++++++-
 arch/powerpc/kernel/pci_32.c |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5881441f7672..df2696c406ad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -373,9 +373,19 @@ config PPC_DCR
 	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
 	default y
 
+config PPC_PCI_OF_BUS_MAP_FILL
+	bool "Fill pci-OF-bus-map property in the device-tree"
+	depends on PPC32
+	depends on PPC_PMAC || PPC_CHRP
+	default y
+	help
+	  This option creates and fills pci-OF-bus-map property in the
+	  device-tree which is deprecated and is needed only for old
+	  platforms.
+
 config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 	depends on PPC32
-	depends on !PPC_PMAC && !PPC_CHRP
+	depends on !PPC_PCI_OF_BUS_MAP_FILL
 	bool "Assign PCI bus numbers from zero individually for each PCI domain"
 	help
 	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 433965bf37b4..ffc4e1928c80 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -64,6 +64,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixu
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
 
+#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
+
 static u8* pci_to_OF_bus_map;
 static int pci_bus_count;
 
@@ -223,6 +225,8 @@ pci_create_OF_bus_map(void)
 }
 #endif
 
+#endif /* CONFIG_PPC_PCI_OF_BUS_MAP_FILL */
+
 #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP) */
 
 void pcibios_setup_phb_io_space(struct pci_controller *hose)
@@ -264,6 +268,7 @@ static int __init pcibios_init(void)
 	}
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
+#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
 	pci_bus_count = next_busno;
 
 	/* OpenFirmware based machines need a map of OF bus
@@ -272,6 +277,7 @@ static int __init pcibios_init(void)
 	 */
 	if (pci_assign_all_buses)
 		pcibios_make_OF_bus_map();
+#endif
 #endif
 
 	/* Call common code to handle resource allocation */
-- 
2.20.1

