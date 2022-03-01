Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B184C8EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiCAPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiCAPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B7D8A6E9;
        Tue,  1 Mar 2022 07:24:34 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVJhdb2BS4mYDpLqZdxym+SAAYZWFezHhoTiZiDZMO8=;
        b=zgC4GlhMFUt7XMJ0ft04Yo1Ehv+fENoDdxTJOSPOXwBUCVd9q6jb72yc5+QjA0KYKs7uk9
        zPFUXo3IT+zvh+F/B1w8Mh59nlK3+GybzIIYm/A2/GMJL/TTS4m4yEB0i8Q6GT/E+/9IXs
        IUXVXxqLPUjCGLEV1r2izpXORAyViVYKfBMwXb8ylvxqn773/OACHmGYO4aU1Clq+n6YAq
        hWZ1jYl3yN0ET1RZHgRJQoL1V1GRdYVhYmG2XaOKs8aj/Knqbs/o88aNERlZbYa4/aN6Rp
        XH/jAmDXisIvdZ96CfPyP1W2/UPZmv61GKaLHTkj1ti5cKFonN2QnKiWKmqrLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVJhdb2BS4mYDpLqZdxym+SAAYZWFezHhoTiZiDZMO8=;
        b=UfQpL3L9XLcUjEl8FVpMYE7watjlZvtdDjIs7usO9C+s67PzCE4zglSr95u8OCiYbmkzee
        920CHaQHxXFflgBg==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Make uncore_discovery clean
 for 64 bit addresses
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220218175418.421268-1-steve.wahl@hpe.com>
References: <20220218175418.421268-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <164614827209.16921.9067840905142821813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     71a412ed4c104bcc239b1a8e06f90b58a4aee0bb
Gitweb:        https://git.kernel.org/tip/71a412ed4c104bcc239b1a8e06f90b58a4aee0bb
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 18 Feb 2022 11:54:18 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:19:01 +01:00

perf/x86/intel/uncore: Make uncore_discovery clean for 64 bit addresses

Support 64-bit BAR size for discovery, and do not truncate return from
generic_uncore_mmio_box_ctl() to 32 bits.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20220218175418.421268-1-steve.wahl@hpe.com
---
 arch/x86/events/intel/uncore_discovery.c | 16 +++++++++++-----
 arch/x86/events/intel/uncore_discovery.h |  2 --
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 6ddadb4..61185d1 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -210,15 +210,21 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	void __iomem *io_addr;
 	resource_size_t addr;
 	unsigned long size;
-	u32 val;
+	u32 val, val2;
 	int i;
 
 	pci_read_config_dword(dev, bar_offset, &val);
 
-	if (val & UNCORE_DISCOVERY_MASK)
+	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
 		return -EINVAL;
 
-	addr = (resource_size_t)(val & ~UNCORE_DISCOVERY_MASK);
+	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		pci_read_config_dword(dev, bar_offset + 4, &val2);
+		addr |= ((resource_size_t)val2) << 32;
+	}
+#endif
 	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
 	io_addr = ioremap(addr, size);
 	if (!io_addr)
@@ -444,7 +450,7 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 
 #define UNCORE_GENERIC_MMIO_SIZE		0x4000
 
-static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
+static u64 generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 {
 	struct intel_uncore_type *type = box->pmu->type;
 
@@ -456,7 +462,7 @@ static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 
 void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
-	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
+	u64 box_ctl = generic_uncore_mmio_box_ctl(box);
 	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index cfaf558..f443935 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -18,8 +18,6 @@
 #define UNCORE_DISCOVERY_BIR_BASE		0x10
 /* Discovery table BAR step */
 #define UNCORE_DISCOVERY_BIR_STEP		0x4
-/* Mask of the discovery table offset */
-#define UNCORE_DISCOVERY_MASK			0xf
 /* Global discovery table size */
 #define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
 
