Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1054EC7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347890AbiC3PIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347830AbiC3PIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F1A1996B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4907B1595;
        Wed, 30 Mar 2022 08:06:35 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04EA3F73B;
        Wed, 30 Mar 2022 08:06:33 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 04/22] firmware: arm_scmi: Validate BASE_DISCOVER_LIST_PROTOCOLS reply
Date:   Wed, 30 Mar 2022 16:05:33 +0100
Message-Id: <20220330150551.2573938-5-cristian.marussi@arm.com>
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

Do not blindly trust SCMI backend server reply about list of implemented
protocols, instead validate the reported length of the list of protocols
against the real payload size of the message reply.

Fixes: b6f20ff8bd9 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index f279146f8110..c1165d1282ef 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -189,6 +189,9 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 	list = t->rx.buf + sizeof(*num_ret);
 
 	do {
+		size_t real_list_sz;
+		u32 calc_list_sz;
+
 		/* Set the number of protocols to be skipped/already read */
 		*num_skip = cpu_to_le32(tot_num_ret);
 
@@ -202,6 +205,24 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 			break;
 		}
 
+		if (t->rx.len < (sizeof(u32) * 2)) {
+			dev_err(dev, "Truncated reply - rx.len:%zd\n",
+				t->rx.len);
+			ret = -EPROTO;
+			break;
+		}
+
+		real_list_sz = t->rx.len - sizeof(u32);
+		calc_list_sz = ((loop_num_ret / sizeof(u32)) +
+				!!(loop_num_ret % sizeof(u32))) * sizeof(u32);
+		if (calc_list_sz != real_list_sz) {
+			dev_err(dev,
+				"Malformed reply - real_sz:%zd  calc_sz:%u\n",
+				real_list_sz, calc_list_sz);
+			ret = -EPROTO;
+			break;
+		}
+
 		for (loop = 0; loop < loop_num_ret; loop++)
 			protocols_imp[tot_num_ret + loop] = *(list + loop);
 
-- 
2.32.0

