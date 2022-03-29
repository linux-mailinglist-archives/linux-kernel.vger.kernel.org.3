Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6652F4EAE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiC2NMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiC2NL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:11:57 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9ADF10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:10:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d553:ff0a:6830:6bde])
        by albert.telenet-ops.be with bizsmtp
        id CDAC2700C49QC4406DACYu; Tue, 29 Mar 2022 15:10:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZBbv-007Grs-N8; Tue, 29 Mar 2022 15:10:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZBbv-00CEiP-4U; Tue, 29 Mar 2022 15:10:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bhaskara Budiredla <bbudiredla@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] perf: MARVELL_CN10K_DDR_PMU should depend on ARCH_THUNDER
Date:   Tue, 29 Mar 2022 15:10:10 +0200
Message-Id: <18bfd6e1bcf67db7ea656d684a8bbb68261eeb54.1648559364.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell CN10K DRAM Subsystem (DSS) performance monitor is only
present on Marvell CN10K SoCs.  Hence add a dependency on ARCH_THUNDER,
to prevent asking the user about this driver when configuring a kernel
without Cavium Thunder (incl. Marvell CN10K) SoC support,

Fixes: 68fa55f0e05ce371 ("perf/marvell: cn10k DDR perf event core ownership")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/perf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index afdcb91601d2bbf9..1e2d69453771d4ac 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -187,7 +187,7 @@ source "drivers/perf/hisilicon/Kconfig"
 
 config MARVELL_CN10K_DDR_PMU
 	tristate "Enable MARVELL CN10K DRAM Subsystem(DSS) PMU Support"
-	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
 	help
 	  Enable perf support for Marvell DDR Performance monitoring
 	  event on CN10K platform.
-- 
2.25.1

