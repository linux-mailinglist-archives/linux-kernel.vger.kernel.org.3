Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35855C600
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiF0MbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiF0MbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:31:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CADCE766F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:31:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF29F176A;
        Mon, 27 Jun 2022 05:31:03 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40053F792;
        Mon, 27 Jun 2022 05:31:01 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 5/9] firmware: arm_scmi: Make use of FastChannels configurable
Date:   Mon, 27 Jun 2022 13:30:34 +0100
Message-Id: <20220627123038.1427067-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220627123038.1427067-1-cristian.marussi@arm.com>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
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

Add a Kernel configuration entry used to optionally disable, globally, the
usage of SCMI FastChannels even on platforms where they are available.

Make such option default-no to preserve the original SCMI system behaviour
of using any available FC.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- fixed wording in Kconfig
- reverted Kconfig logic _USE_ -> _AVOID_
---
 drivers/firmware/arm_scmi/Kconfig  | 13 +++++++++++++
 drivers/firmware/arm_scmi/driver.c |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 1e7b7fec97d9..3fb34db01014 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -42,6 +42,19 @@ config ARM_SCMI_HAVE_MSG
 	  This declares whether a message passing based transport for SCMI is
 	  available.
 
+config ARM_SCMI_AVOID_FASTCHANNELS
+	bool "Avoid using SCMI FastChannels even when available"
+	help
+	  Avoid using SCMI FastChannels even if advertised as available by
+	  the platform.
+
+	  On systems where the SCMI platform advertises the availability of
+	  FastChannels, supported SCMI commands can be issued triggering a
+	  one-way FastChannel request, much more quickly than using a
+	  regular SCMI message transfer.
+	  When set to Y forces the OSPM to use instead regular SCMI message
+	  transfers even if FastChannels are available. If unsure say N.
+
 config ARM_SCMI_TRANSPORT_MAILBOX
 	bool "SCMI transport based on Mailbox"
 	depends on MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 00b7f2aff4ec..76dc82ba04b3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1298,6 +1298,12 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	struct scmi_msg_resp_desc_fc *resp;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_AVOID_FASTCHANNELS)) {
+		dev_warn_once(ph->dev,
+			      "FastChannels usage disabled in Kconfig.\n");
+		return;
+	}
+
 	if (!p_addr) {
 		ret = -EINVAL;
 		goto err_out;
-- 
2.32.0

