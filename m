Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4EC53EA04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiFFKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiFFKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:03:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39704BF60
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:03:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 062891684;
        Mon,  6 Jun 2022 03:03:03 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87643F66F;
        Mon,  6 Jun 2022 03:03:00 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 5/7] firmware: arm_scmi: Make use of FastChannels configurable
Date:   Mon,  6 Jun 2022 11:02:28 +0100
Message-Id: <20220606100230.3465828-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220606100230.3465828-1-cristian.marussi@arm.com>
References: <20220606100230.3465828-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Kernel configuration entry used to optionally disable the usage of
SCMI FastChannels even on platforms where they are available.

Make such option default-yes to preserve the original SCMI system behaviour
of using any available FC.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig    | 13 +++++++++++++
 drivers/firmware/arm_scmi/perf.c     |  3 ++-
 drivers/firmware/arm_scmi/powercap.c |  3 ++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 1e7b7fec97d9..624f32b61825 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -42,6 +42,19 @@ config ARM_SCMI_HAVE_MSG
 	  This declares whether a message passing based transport for SCMI is
 	  available.
 
+config ARM_SCMI_USE_FASTCHANNELS
+	bool "Use SCMI FastChannels when available"
+	default y
+	help
+	  Use SCMI FastChannels when advertised as available by the platform.
+
+	  On systems where the SCMI platform advertises the availability of
+	  FastChannels, supported SCMI commands can be issued triggering a
+	  one-way FastChannel request, much more quicker than using a
+	  regular SCMI message transfer.
+	  When set to N forces the OSPM to use instead regular SCMI message
+	  transfers even if FastChannels are available. If unsure say Y.
+
 config ARM_SCMI_TRANSPORT_MAILBOX
 	bool "SCMI transport based on Mailbox"
 	depends on MAILBOX
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 587b334589b0..3c491b3aa0bd 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -820,7 +820,8 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 		scmi_perf_domain_attributes_get(ph, domain, dom, version);
 		scmi_perf_describe_levels_get(ph, domain, dom);
 
-		if (dom->perf_fastchannels)
+		if (dom->perf_fastchannels &&
+		    IS_ENABLED(CONFIG_ARM_SCMI_USE_FASTCHANNELS))
 			scmi_perf_domain_init_fc(ph, domain, &dom->fc_info);
 	}
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index e9b4c34e1fb4..9e3a803d4f16 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -830,7 +830,8 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 		if (ret)
 			return ret;
 
-		if (pinfo->powercaps[domain].fastchannels)
+		if (pinfo->powercaps[domain].fastchannels &&
+		    IS_ENABLED(CONFIG_ARM_SCMI_USE_FASTCHANNELS))
 			scmi_powercap_domain_init_fc(ph, domain,
 						     &pinfo->powercaps[domain].fc_info);
 	}
-- 
2.32.0

