Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4327542CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiFHKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiFHKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:10:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A798D62FC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:55:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294221424;
        Wed,  8 Jun 2022 02:55:46 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 631B43F73B;
        Wed,  8 Jun 2022 02:55:45 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 1/3] firmware: arm_scmi: Review BASE protocol string-buffers sizes
Date:   Wed,  8 Jun 2022 10:55:28 +0100
Message-Id: <20220608095530.497879-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
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

SCMI Base protocol agent_name/vendor_id/sub_vendor_id are defined by the
specification as NULL-terminated ASCII strings up to 16-bytes in length.

The underlying buffers and message descriptors are currently bigger than
needed; resize them to fit only the strictly needed 16 bytes.

While at that, convert Base protocol strings handling routines to use the
preferred strscpy.

Fixes: b260fccaebdc2 ("firmware: arm_scmi: Add SCMI v3.1 protocol extended names support")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c      | 8 ++++----
 drivers/firmware/arm_scmi/protocols.h | 2 --
 include/linux/scmi_protocol.h         | 9 +++++----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index d0ac96da1ddf..a52f084a6a87 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -36,7 +36,7 @@ struct scmi_msg_resp_base_attributes {
 
 struct scmi_msg_resp_base_discover_agent {
 	__le32 agent_id;
-	u8 name[SCMI_MAX_STR_SIZE];
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 
@@ -119,7 +119,7 @@ scmi_base_vendor_id_get(const struct scmi_protocol_handle *ph, bool sub_vendor)
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
-		memcpy(vendor_id, t->rx.buf, size);
+		strscpy(vendor_id, t->rx.buf, size);
 
 	ph->xops->xfer_put(ph, t);
 
@@ -276,7 +276,7 @@ static int scmi_base_discover_agent_get(const struct scmi_protocol_handle *ph,
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		agent_info = t->rx.buf;
-		strlcpy(name, agent_info->name, SCMI_MAX_STR_SIZE);
+		strscpy(name, agent_info->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -375,7 +375,7 @@ static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 	int id, ret;
 	u8 *prot_imp;
 	u32 version;
-	char name[SCMI_MAX_STR_SIZE];
+	char name[SCMI_SHORT_NAME_MAX_SIZE];
 	struct device *dev = ph->dev;
 	struct scmi_revision_info *rev = scmi_revision_area_get(ph);
 
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 73304af5ec4a..c679f3fb8718 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -24,8 +24,6 @@
 
 #include <asm/unaligned.h>
 
-#define SCMI_SHORT_NAME_MAX_SIZE	16
-
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 1c58646ba381..704111f63993 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -13,8 +13,9 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
-#define SCMI_MAX_STR_SIZE	64
-#define SCMI_MAX_NUM_RATES	16
+#define SCMI_MAX_STR_SIZE		64
+#define SCMI_SHORT_NAME_MAX_SIZE	16
+#define SCMI_MAX_NUM_RATES		16
 
 /**
  * struct scmi_revision_info - version information structure
@@ -36,8 +37,8 @@ struct scmi_revision_info {
 	u8 num_protocols;
 	u8 num_agents;
 	u32 impl_ver;
-	char vendor_id[SCMI_MAX_STR_SIZE];
-	char sub_vendor_id[SCMI_MAX_STR_SIZE];
+	char vendor_id[SCMI_SHORT_NAME_MAX_SIZE];
+	char sub_vendor_id[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 struct scmi_clock_info {
-- 
2.32.0

