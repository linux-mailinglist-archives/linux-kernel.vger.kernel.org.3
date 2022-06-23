Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5605574B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiFWIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFWIAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:00:15 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9536746CB2;
        Thu, 23 Jun 2022 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655971214;
  x=1687507214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y6qmbNorIhVgztbdVRKjKcyLbrdYuGj36PW0vcE3Cwc=;
  b=YHU19ZN/4MSnVcyn1UV3Rshv1q3ntIf6kcvL0ZpBsj1g0LIeEWpdk2Cb
   qBdDZi04w+a5AhkZR4ghtAkNiJpDGjYMj8v+uycysxsiSWW/cROo/ABg7
   q0e93oOtc7ZbIvvhlsYjxGztvJgxTBpMe9ILMAFnukVzeVuQZ7EnEikMY
   ZjLXaCqWFlMCGwNz6Zwprv0wEXEOqEYFEgPfdm8yh2a3N7XPn1BquJg1G
   bRGHfgE6FMuAHXFyMYmx9Gz82olgVR2hcTtWV1FRy/N/K2hMDBG23BWPe
   0vL/AYV7bd1rgiiuMEQaJaoXKOlHb+3CFsw8Fa+HxcmeUlHBd4CIY7idC
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: core: Allow speed modes to be adjusted via module param
Date:   Thu, 23 Jun 2022 10:00:09 +0200
Message-ID: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During board verification, there is a need to test the various supported
eMMC/SD speed modes.  However, since the framework chooses the best mode
supported by the card and the host controller's caps, this currently
necessitates changing the devicetree for every iteration.

To make changing the modes easier, allow the various host controller
capabilities to be cleared via a module parameter.  (A per-controller
debugfs wouldn't work since the controller needs to be re-probed to
trigger re-init of cards.  A module parameter is used instead of a
global debugfs to allow this to be also set via the kernel command
line.)

The values to be written are the raw MMC_CAP* values from
include/linux/mmc/host.h.  This is rather low-level, and these defines
are not guaranteed to be stable, but it is perhaps good enough for the
indented use case.  A warning is emitted when the caps clearing is in
effect.

Example of use:

 # grep timing /sys/kernel/debug/mmc0/ios
 timing spec:	9 (mmc HS200)

 // MMC_CAP2_HS200_1_8V_SDR
 # echo $((1 << 5)) > /sys/module/mmc_core/parameters/caps2_clear

 # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
 # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
 # grep timing /sys/kernel/debug/mmc0/ios
 timing spec:	8 (mmc DDR52)

 // MMC_CAP_1_8V_DDR
 # echo $((1 << 12)) > /sys/module/mmc_core/parameters/caps_clear

 # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
 # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
 # grep timing /sys/kernel/debug/mmc0/ios
 timing spec:	1 (mmc high-speed)

 # echo 0 > /sys/module/mmc_core/parameters/caps2_clear

 # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/unbind
 # echo 16d40000.mmc > /sys/bus/platform/drivers/dwmmc_exynos/bind
 # grep timing /sys/kernel/debug/mmc0/ios
 timing spec:	9 (mmc HS200)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/core/host.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2ed2b4d5e5a5..37971b7c7f62 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -34,6 +34,10 @@
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
 static DEFINE_IDA(mmc_host_ida);
+static unsigned int caps_clear, caps2_clear;
+
+module_param(caps_clear, uint, 0644);
+module_param(caps2_clear, uint, 0644);
 
 #ifdef CONFIG_PM_SLEEP
 static int mmc_host_class_prepare(struct device *dev)
@@ -411,6 +415,14 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
 				 MMC_CAP2_HS400_ES);
 
+	if (caps_clear || caps2_clear)
+		dev_warn(host->parent,
+			 "clearing host controller caps %#x caps2 %#x\n",
+			 caps_clear, caps2_clear);
+
+	host->caps &= ~caps_clear;
+	host->caps2 &= ~caps2_clear;
+
 	/* Must be after "non-removable" check */
 	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
 		if (host->caps & MMC_CAP_NONREMOVABLE)
-- 
2.34.1

