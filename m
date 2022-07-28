Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5971583746
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiG1DF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1DF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:05:26 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Jul 2022 20:05:24 PDT
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6652ED7A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2329; q=dns/txt; s=iport;
  t=1658977524; x=1660187124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unObAmyFM0AeFcB0n9K8pVq0cKXLUsPlrJ4yDA9c1Uc=;
  b=XL9qvfCMMMHBtX0akYoBQxDRRCd2lgbJJuLEtrEePoxv2F2hNFZo6SN4
   F8oMOH8unkNOWVvx6lbfeQWF4odLH3PwjxqFb5XiwFu6BEBdsUs/4d4ob
   WxOuh2VLX147hKBIZ0oLotSWxjDn5yRiKL99427lP0o9k7jg2LQrDK7X6
   U=;
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1055582059"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 28 Jul 2022 03:04:21 +0000
Received: from zorba.lan (sjc-vpn6-1010.cisco.com [10.21.123.242])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id 26S34K5n030786;
        Thu, 28 Jul 2022 03:04:20 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     George Cherian <george.cherian@marvell.com>, sgoutham@marvell.com,
        "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: allow selection of number of sparse irqs
Date:   Wed, 27 Jul 2022 20:04:20 -0700
Message-Id: <20220728030420.2279713-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.21.123.242, sjc-vpn6-1010.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the maximum number of interrupters is capped at 8260 (64 +
8196) in most of the architectures were CONFIG_SPARSE_IRQ is selected.
This upper limit is not sufficient for couple of existing SoC's from
Marvell.
For eg: Octeon TX2 series of processors support a maximum of 32K
interrupters.

Allow configuration of the upper limit of the number of interrupts.

Cc: George Cherian <george.cherian@marvell.com>
Cc: sgoutham@marvell.com
Cc: "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 kernel/irq/Kconfig     | 23 +++++++++++++++++++++++
 kernel/irq/internals.h | 10 +++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..b356217abcfe 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -125,6 +125,29 @@ config SPARSE_IRQ
 
 	  If you don't know what to do here, say N.
 
+choice
+	prompt "Select number of sparse irqs"
+	depends on SPARSE_IRQ
+	default SPARSE_IRQ_EXTEND_8K
+	help
+          Allows choosing the number of sparse irq's available on the
+          system. For each 8k of additional irqs added there is approximatly
+          1kb of kernel size increase.
+
+config SPARSE_IRQ_EXTEND_8K
+	bool "8k"
+
+config SPARSE_IRQ_EXTEND_16K
+	bool "16K"
+
+config SPARSE_IRQ_EXTEND_32K
+	bool "32K"
+
+config SPARSE_IRQ_EXTEND_64K
+	bool "64K"
+
+endchoice
+
 config GENERIC_IRQ_DEBUGFS
 	bool "Expose irq internals in debugfs"
 	depends on DEBUG_FS
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f09c60393e55..25fe5abf6c16 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,7 +12,15 @@
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
+# if defined(CONFIG_SPARSE_IRQ_EXTEND_8K)
+# define IRQ_BITMAP_BITS	(NR_IRQS + 8192 + 4)
+# elif defined(CONFIG_SPARSE_IRQ_EXTEND_16K)
+# define IRQ_BITMAP_BITS	(NR_IRQS + 16384 + 4)
+# elif defined(CONFIG_SPARSE_IRQ_EXTEND_32K)
+# define IRQ_BITMAP_BITS	(NR_IRQS + 32768 + 4)
+# elif defined(CONFIG_SPARSE_IRQ_EXTEND_64K)
+# define IRQ_BITMAP_BITS	(NR_IRQS + 65536 + 4)
+# endif
 #else
 # define IRQ_BITMAP_BITS	NR_IRQS
 #endif
-- 
2.25.1

