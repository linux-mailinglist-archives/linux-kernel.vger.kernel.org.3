Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB70D4EC7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347918AbiC3PIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347835AbiC3PIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2A09A99B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAFE81596;
        Wed, 30 Mar 2022 08:06:36 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8E83F73B;
        Wed, 30 Mar 2022 08:06:35 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 05/22] firmware: arm_scmi: Dynamically allocate protocols array
Date:   Wed, 30 Mar 2022 16:05:34 +0100
Message-Id: <20220330150551.2573938-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
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

Move away from a statically allocated array for holding the current set of
protocols implemented by the platform in favour of allocating it
dynamically based on the number of protocols effectively advertised by the
platform via BASE protocol exchanges.

While at that, rectify the BASE_DISCOVER_LIST_PROTOCOLS loop iterations to
terminate only when a number of protocols equal to the advertised ones has
been received, instead of looping till the platform returns no more
protocols descriptors: this new behaviour is better compliant with the
specification and it has been tested to work equally well against an SCMI
stack running on top of an official SCP firmware on a JUNO board.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c   | 17 ++++++++++-------
 drivers/firmware/arm_scmi/common.h |  1 -
 drivers/firmware/arm_scmi/driver.c |  6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index c1165d1282ef..d6322624da9f 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -178,6 +178,7 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 	__le32 *num_skip, *num_ret;
 	u32 tot_num_ret = 0, loop_num_ret;
 	struct device *dev = ph->dev;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
 
 	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_LIST_PROTOCOLS,
 				      sizeof(*num_skip), 0, &t);
@@ -200,8 +201,9 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 			break;
 
 		loop_num_ret = le32_to_cpu(*num_ret);
-		if (loop_num_ret > MAX_PROTOCOLS_IMP - tot_num_ret) {
-			dev_err(dev, "No. of Protocol > MAX_PROTOCOLS_IMP");
+		if (loop_num_ret > rev->num_protocols - tot_num_ret) {
+			dev_err(dev,
+				"No. Returned protocols > Total protocols.\n");
 			break;
 		}
 
@@ -229,7 +231,7 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 		tot_num_ret += loop_num_ret;
 
 		ph->xops->reset_rx_to_maxsz(ph, t);
-	} while (loop_num_ret);
+	} while (tot_num_ret < rev->num_protocols);
 
 	ph->xops->xfer_put(ph, t);
 
@@ -372,10 +374,6 @@ static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
-	prot_imp = devm_kcalloc(dev, MAX_PROTOCOLS_IMP, sizeof(u8), GFP_KERNEL);
-	if (!prot_imp)
-		return -ENOMEM;
-
 	rev->major_ver = PROTOCOL_REV_MAJOR(version),
 	rev->minor_ver = PROTOCOL_REV_MINOR(version);
 	ph->set_priv(ph, rev);
@@ -384,6 +382,11 @@ static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	prot_imp = devm_kcalloc(dev, rev->num_protocols, sizeof(u8),
+				GFP_KERNEL);
+	if (!prot_imp)
+		return -ENOMEM;
+
 	scmi_base_vendor_id_get(ph, false);
 	scmi_base_vendor_id_get(ph, true);
 	scmi_base_implementation_version_get(ph);
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4fda84bfab42..6885348a505d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -30,7 +30,6 @@
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
 #define PROTOCOL_REV_MINOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x)))
-#define MAX_PROTOCOLS_IMP	16
 #define MAX_OPPS		16
 
 enum scmi_common_cmd {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7436c475e708..8e07bee16c8e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -128,7 +128,8 @@ struct scmi_protocol_instance {
  *	       usage.
  * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
- *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
+ *		   scmi_revision_info.num_protocols elements allocated by the
+ *		   base protocol
  * @active_protocols: IDR storing device_nodes for protocols actually defined
  *		      in the DT and confirmed as implemented by fw.
  * @atomic_threshold: Optional system wide DT-configured threshold, expressed
@@ -1309,11 +1310,12 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 {
 	int i;
 	struct scmi_info *info = handle_to_scmi_info(handle);
+	struct scmi_revision_info *rev = handle->version;
 
 	if (!info->protocols_imp)
 		return false;
 
-	for (i = 0; i < MAX_PROTOCOLS_IMP; i++)
+	for (i = 0; i < rev->num_protocols; i++)
 		if (info->protocols_imp[i] == prot_id)
 			return true;
 	return false;
-- 
2.32.0

