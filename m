Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505425133B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346280AbiD1Mck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346236AbiD1Mch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:32:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C1BAF1EA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:29:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A691474;
        Thu, 28 Apr 2022 05:29:20 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F341C3F73B;
        Thu, 28 Apr 2022 05:29:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Set clock latency to U32_MAX if it is not supported
Date:   Thu, 28 Apr 2022 13:29:13 +0100
Message-Id: <20220428122913.1654821-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the spec, the clock_enable_delay is the worst case latency
incurred by the platform to enable the clock. The value of 0 indicates
that the platform doesn't support the same and must be considered as
maximum latency for practical purposes.

Currently the value of 0 is assigned as is and is propogated to the clock
framework which can assume that the clock can support atomic enable operation.

Fixes: 18f295b758b2 ("firmware: arm_scmi: Add support for clock_enable_latency")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 7a031afff389..2460979eabd2 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/limits.h>
 #include <linux/sort.h>
 
 #include "protocols.h"
@@ -128,12 +129,13 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
+		u32 latency;
 		attributes = le32_to_cpu(attr->attributes);
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
 		/* Is optional field clock_enable_latency provided ? */
 		if (t->rx.len == sizeof(*attr))
-			clk->enable_latency =
-				le32_to_cpu(attr->clock_enable_latency);
+			latency = le32_to_cpu(attr->clock_enable_latency);
+		clk->enable_latency = latency ? : U32_MAX;
 	}
 
 	ph->xops->xfer_put(ph, t);
-- 
2.36.0

