Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC44EC7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbiC3PJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347874AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DE189BAFA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07C0215BF;
        Wed, 30 Mar 2022 08:06:40 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD3C23F73B;
        Wed, 30 Mar 2022 08:06:38 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 07/22] firmware: arm_scmi: Check CLOCK_RATE_SET_COMPLETE async reply
Date:   Wed, 30 Mar 2022 16:05:36 +0100
Message-Id: <20220330150551.2573938-8-cristian.marussi@arm.com>
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

When CLOCK_RATE_SET command is issued in asynchronous mode the delayed
response CLOCK_RATE_SET_COMPLETE comes back once the SCMI platform has
effectively operated the requested change: such delayed response carries
also the clock ID and the final clock rate that has been set.

As an aid to debug issues, check that the clock ID in the delayed
response matches the expected one and debug print the rate value.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 0ae39ee920e9..32ccac457d20 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -68,6 +68,12 @@ struct scmi_clock_set_rate {
 	__le32 value_high;
 };
 
+struct scmi_msg_resp_set_rate_complete {
+	__le32 id;
+	__le32 rate_low;
+	__le32 rate_high;
+};
+
 struct clock_info {
 	u32 version;
 	int num_clocks;
@@ -266,10 +272,23 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	cfg->value_low = cpu_to_le32(rate & 0xffffffff);
 	cfg->value_high = cpu_to_le32(rate >> 32);
 
-	if (flags & CLOCK_SET_ASYNC)
+	if (flags & CLOCK_SET_ASYNC) {
 		ret = ph->xops->do_xfer_with_response(ph, t);
-	else
+		if (!ret) {
+			struct scmi_msg_resp_set_rate_complete *resp;
+
+			resp = t->rx.buf;
+			if (le32_to_cpu(resp->id) == clk_id)
+				dev_dbg(ph->dev,
+					"Clock ID %d set async to %llu\n",
+					clk_id,
+					get_unaligned_le64(&resp->rate_low));
+			else
+				ret = -EPROTO;
+		}
+	} else {
 		ret = ph->xops->do_xfer(ph, t);
+	}
 
 	if (ci->max_async_req)
 		atomic_dec(&ci->cur_async_req);
-- 
2.32.0

