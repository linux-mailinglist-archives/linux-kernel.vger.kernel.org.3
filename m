Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F444EC7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbiC3PIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347882AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7EA19BBB6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 913A723A;
        Wed, 30 Mar 2022 08:06:41 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4378A3F73B;
        Wed, 30 Mar 2022 08:06:40 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 08/22] firmware: arm_scmi: Remove unneeded NULL termination of clk name
Date:   Wed, 30 Mar 2022 16:05:37 +0100
Message-Id: <20220330150551.2573938-9-cristian.marussi@arm.com>
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

The string array 'name' inside struct scmi_clock_info holds the clock name
which was successfully retrieved by querying the SCMI platform, unless the
related underlying SCMI command failed.

Anyway, such scmi_clock_info structure is allocated using devm_kcalloc()
which in turn internally appends a __GFP_ZERO flag to its invocation:
as a consequence the string 'name' field does not need to be zeroed when
we fail to get the clock name via SCMI, it is already NULL terminated.

Remove unneeded explicit NULL termination.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 32ccac457d20..7adf99b92bf6 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -129,8 +129,6 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 		if (t->rx.len == sizeof(*attr))
 			clk->enable_latency =
 				le32_to_cpu(attr->clock_enable_latency);
-	} else {
-		clk->name[0] = '\0';
 	}
 
 	ph->xops->xfer_put(ph, t);
-- 
2.32.0

