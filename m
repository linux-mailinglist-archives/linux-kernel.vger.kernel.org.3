Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2A51ACBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbiEDS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376740AbiEDS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49012BF1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89D4EB82753
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004B7C385A4;
        Wed,  4 May 2022 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651687082;
        bh=wzXnasZ78VhWcyWzDggxLS2kE3GV40WE6obISeL6wYw=;
        h=From:To:Cc:Subject:Date:From;
        b=hG+nzQoXWc8YFm5HbNPZHG2c540IC6LcNVKSfVTopvlcryvURcgSido6nfjjgJFYg
         rz5cOJ/h0cwMlrJXXf2pM1j4PqUD7goQnnu59fBHwwTPF+cv3OQBvbtGg4x12cDgKJ
         qgaiiOdQHBXBYltqiekwvzctrNcGf2x/lOzD72smxbKJYH9F8hsPcE6QNbfaQNfYQA
         AdbuCfPQn1rN/8IB+70Qqag+/mIYM2ZX1bs4oyAhgwav8ZdJ2GW58e+YFdPxm5wP8r
         sZnzqIsiUWWTpJm2W6NV8AznHaV3oK4dhlmpADAHol+sd/OlR5xYb+2PZlmN8Z1pzs
         iAU6MkBMt4WsQ==
Received: by pali.im (Postfix)
        id 10AEA96D; Wed,  4 May 2022 19:57:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pci: Add config option for using OF 'reg' for PCI domain
Date:   Wed,  4 May 2022 19:57:18 +0200
Message-Id: <20220504175718.29011-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on
device-tree properties"), powerpc kernel always fallback to PCI domain
assignment from OF / Device Tree 'reg' property of the PCI controller.

PCI code for other Linux architectures use increasing assignment of the PCI
domain for individual controllers (assign the first free number), like it
was also for powerpc prior mentioned commit.

Upgrading powerpc kernels from LTS 4.4 version (which does not contain
mentioned commit) to new LTS versions brings a regression in domain
assignment.

Fix this issue by introducing a new option CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG
When this options is disabled then powerpc kernel would assign PCI domains
in the similar way like it is doing kernel for other architectures and also
how it was done prior that commit.

Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/Kconfig             | 10 ++++++++++
 arch/powerpc/kernel/pci-common.c |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..4dd3e3acddda 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -375,6 +375,16 @@ config PPC_OF_PLATFORM_PCI
 	depends on PCI
 	depends on PPC64 # not supported on 32 bits yet
 
+config PPC_PCI_DOMAIN_FROM_OF_REG
+	bool "Use OF reg property for PCI domain"
+	depends on PCI
+	help
+	  By default PCI domain for host bridge during its registration is
+	  chosen as the lowest unused PCI domain number.
+
+	  When this option is enabled then PCI domain is determined from
+	  the OF / Device Tree 'reg' property.
+
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8bc9cf62cd93..8cb6fc5302ae 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -74,7 +74,6 @@ void __init set_pci_dma_ops(const struct dma_map_ops *dma_ops)
 static int get_phb_number(struct device_node *dn)
 {
 	int ret, phb_id = -1;
-	u32 prop_32;
 	u64 prop;
 
 	/*
@@ -83,7 +82,8 @@ static int get_phb_number(struct device_node *dn)
 	 * reading "ibm,opal-phbid", only present in OPAL environment.
 	 */
 	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
-	if (ret) {
+	if (ret && IS_ENABLED(CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG)) {
+		u32 prop_32;
 		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
 		prop = prop_32;
 	}
-- 
2.20.1

