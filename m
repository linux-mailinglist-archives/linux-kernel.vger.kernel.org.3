Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C4519C00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbiEDJkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347472AbiEDJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:40:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75941ADBD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:36:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC9C152B;
        Wed,  4 May 2022 02:36:49 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30C543FA50;
        Wed,  4 May 2022 02:36:48 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 5/7] firmware: arm_scmi: Make use of FastChannels configurable
Date:   Wed,  4 May 2022 10:36:07 +0100
Message-Id: <20220504093609.3077646-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504093609.3077646-1-cristian.marussi@arm.com>
References: <20220504093609.3077646-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index da7fe3561217..0852087c06e1 100644
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
index 314c89bbd3d6..874a851a1f6c 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -781,7 +781,8 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
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

