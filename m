Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07368544B7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245216AbiFIMOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiFIMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:14:20 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3F31504
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=B/M5r4B90mbTkpJzac0CttJDuKdqEl0o8kb84irHerE=;
        b=o6HzE3W8Ij5m1xQnFcTjjKq6lS2+eQtAgGGHD6sihovrqSSJJnxOzaQglQ4byIMoZwkIAbd7RGY5g
         37hFqf6tCbEURL8luaZQG2i89IQVM0owNP2JV/hT5o5ZVOU0ncfJZRnSCLLRsZYkJrJzAsx4dDOe7m
         /UNeWQcZr4imCE6RaYw+Bs15bDAepftCPzslHmzXnxdYe9XFTPvA8zHbX87ZuwcsCdhpS+xz6PkWVd
         mVOMga98vqwcYxw52YXTNk53FxncTVGYm1109IKlHIxG+h0sdTip7HFeX+nhMa13hxiic1x5mwwv98
         rW9c19Zlw6CJRuAclIa6PFb6y0RVITA==
X-MSG-ID: ae2393fb-e7ed-11ec-a2aa-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH] spi: Fix per-cpu stats access on 32 bit systems
Date:   Thu,  9 Jun 2022 14:13:34 +0200
Message-Id: <20220609121334.2984808-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32 bit systems, the following kernel BUG is hit:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is debug_smp_processor_id+0x18/0x24
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g6ae0aec8a366 #181
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:81024ffd r6:00000000 r5:81024ffd r4:60000013
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x14/0x1c
 r7:81024ffd r6:80f652de r5:80bec180 r4:819a2500
 dump_stack from check_preemption_disabled+0xc8/0xf0
 check_preemption_disabled from debug_smp_processor_id+0x18/0x24
 r8:8119b7e0 r7:81205534 r6:819f5c00 r5:819f4c00 r4:c083d724
 debug_smp_processor_id from __spi_sync+0x78/0x220
 __spi_sync from spi_sync+0x34/0x4c
 r10:bb7bf4e0 r9:c083d724 r8:00000007 r7:81a068c0 r6:822a83c0 r5:c083d724
 r4:819f4c00
 spi_sync from spi_mem_exec_op+0x338/0x370
 r5:000000b4 r4:c083d910
 spi_mem_exec_op from spi_nor_read_id+0x98/0xdc
 r10:bb7bf4e0 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:82358040
 r4:819f7c40
 spi_nor_read_id from spi_nor_detect+0x38/0x114
 r7:82358040 r6:00000000 r5:819f7c40 r4:819f7c40
 spi_nor_detect from spi_nor_scan+0x11c/0xbec
 r10:bb7bf4e0 r9:00000000 r8:00000000 r7:c083da4c r6:00000000 r5:00010101
 r4:819f7c40
 spi_nor_scan from spi_nor_probe+0x10c/0x2d0
 r10:bb7bf4e0 r9:bb7bf4d0 r8:00000000 r7:819f4c00 r6:00000000 r5:00000000
 r4:819f7c40

per-cpu access needs to be guarded against preemption.

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       |  5 ++++-
 include/linux/spi/spi.h | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d94822bf3cec..ac61824b87b5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -314,11 +314,13 @@ static void spi_statistics_add_transfer_stats(struct spi_statistics *pcpu_stats,
 					      struct spi_controller *ctlr)
 {
 	int l2len = min(fls(xfer->len), SPI_STATISTICS_HISTO_SIZE) - 1;
-	struct spi_statistics *stats = this_cpu_ptr(pcpu_stats);
+	struct spi_statistics *stats;
 
 	if (l2len < 0)
 		l2len = 0;
 
+	get_cpu();
+	stats = this_cpu_ptr(pcpu_stats);
 	u64_stats_update_begin(&stats->syncp);
 
 	u64_stats_inc(&stats->transfers);
@@ -333,6 +335,7 @@ static void spi_statistics_add_transfer_stats(struct spi_statistics *pcpu_stats,
 		u64_stats_add(&stats->bytes_rx, xfer->len);
 
 	u64_stats_update_end(&stats->syncp);
+	put_cpu();
 }
 
 /*
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 2e63b4935deb..c96f526d9a20 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -84,18 +84,24 @@ struct spi_statistics {
 
 #define SPI_STATISTICS_ADD_TO_FIELD(pcpu_stats, field, count)		\
 	do {								\
-		struct spi_statistics *__lstats = this_cpu_ptr(pcpu_stats); \
+		struct spi_statistics *__lstats;			\
+		get_cpu();						\
+		__lstats = this_cpu_ptr(pcpu_stats);			\
 		u64_stats_update_begin(&__lstats->syncp);		\
 		u64_stats_add(&__lstats->field, count);			\
 		u64_stats_update_end(&__lstats->syncp);			\
+		put_cpu();						\
 	} while (0)
 
 #define SPI_STATISTICS_INCREMENT_FIELD(pcpu_stats, field)		\
 	do {								\
-		struct spi_statistics *__lstats = this_cpu_ptr(pcpu_stats); \
+		struct spi_statistics *__lstats;			\
+		get_cpu();						\
+		__lstats = this_cpu_ptr(pcpu_stats);			\
 		u64_stats_update_begin(&__lstats->syncp);		\
 		u64_stats_inc(&__lstats->field);			\
 		u64_stats_update_end(&__lstats->syncp);			\
+		put_cpu();						\
 	} while (0)
 
 /**
-- 
2.32.0

