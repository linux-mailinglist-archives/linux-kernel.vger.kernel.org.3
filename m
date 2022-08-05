Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92B58A845
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiHEIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiHEIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:45:12 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29715FDE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=yZtg6j0wq4XYVGRBzZzToejMHBPt0GKD09ZyjIA/dLA=;
        b=fHqELKZHqPU9lZdaMTaSdI7o3S21Iw9K7JuKozlxw56mhuSyzPkhCw+8LdLOdiyAbGFGAKD2UxF8G
         IREt+I3WmjgYD5Tzs7KeSpdJKLM9cWzo5mXZnmbT0dhyp+9yDncTkDMBg6csSIskxyhSy1Qov/skyp
         F+yJKZfowIdWcZaBhA10ngRDLWeILSztWhObTUro4jYGkZhA29UjK30bt8wmo4Nvy2/yO7U2CIU0zU
         bkDenpxyK6iYJrh1RgIDk6jmkeZTVHOX5bhP4DHtujKUrCZ/v8xyfph+VwcfkdLaCE2Gc+KTIgc902
         yo5X+BRtamWhZrnPOV16tYa3jVbHtOQ==
X-MSG-ID: e77b8611-149a-11ed-ba03-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Jander <david@protonic.nl>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: spi.c: Add missing __percpu annotations in users of spi_statistics
Date:   Fri,  5 Aug 2022 10:44:58 +0200
Message-Id: <20220805084458.1602277-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparse warnings of this kind:
drivers/spi/spi.c:117:16: sparse:     expected struct spi_statistics *
drivers/spi/spi.c:117:16: sparse:     got struct spi_statistics [noderef]
 __percpu *[assigned] pcpu_stats

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8f97a3eacdea..83da8862b8f2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -95,7 +95,7 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
-static struct spi_statistics *spi_alloc_pcpu_stats(struct device *dev)
+static struct spi_statistics __percpu *spi_alloc_pcpu_stats(struct device *dev)
 {
 	struct spi_statistics __percpu *pcpu_stats;
 
@@ -162,7 +162,7 @@ static struct device_attribute dev_attr_spi_device_##field = {		\
 }
 
 #define SPI_STATISTICS_SHOW_NAME(name, file, field)			\
-static ssize_t spi_statistics_##name##_show(struct spi_statistics *stat, \
+static ssize_t spi_statistics_##name##_show(struct spi_statistics __percpu *stat, \
 					    char *buf)			\
 {									\
 	ssize_t len;							\
@@ -309,7 +309,7 @@ static const struct attribute_group *spi_master_groups[] = {
 	NULL,
 };
 
-static void spi_statistics_add_transfer_stats(struct spi_statistics *pcpu_stats,
+static void spi_statistics_add_transfer_stats(struct spi_statistics __percpu *pcpu_stats,
 					      struct spi_transfer *xfer,
 					      struct spi_controller *ctlr)
 {
@@ -1275,8 +1275,8 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 			     struct spi_message *msg,
 			     struct spi_transfer *xfer)
 {
-	struct spi_statistics *statm = ctlr->pcpu_statistics;
-	struct spi_statistics *stats = msg->spi->pcpu_statistics;
+	struct spi_statistics __percpu *statm = ctlr->pcpu_statistics;
+	struct spi_statistics __percpu *stats = msg->spi->pcpu_statistics;
 	u32 speed_hz = xfer->speed_hz;
 	unsigned long long ms;
 
@@ -1432,8 +1432,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	struct spi_statistics *statm = ctlr->pcpu_statistics;
-	struct spi_statistics *stats = msg->spi->pcpu_statistics;
+	struct spi_statistics __percpu *statm = ctlr->pcpu_statistics;
+	struct spi_statistics __percpu *stats = msg->spi->pcpu_statistics;
 
 	spi_set_cs(msg->spi, true, false);
 
-- 
2.32.0

