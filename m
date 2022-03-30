Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8AE4EC7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbiC3PKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348028AbiC3PJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:09:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E6EBA7756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:07:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0811576;
        Wed, 30 Mar 2022 08:07:03 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F5303F73B;
        Wed, 30 Mar 2022 08:07:02 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 22/22] firmware: arm_scmi: Add SCMIv3.1 PERFORMANCE_LIMITS_SET checks
Date:   Wed, 30 Mar 2022 16:05:51 +0100
Message-Id: <20220330150551.2573938-23-cristian.marussi@arm.com>
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

Starting with SCMIv3.1, the PERFORMANCE_LIMITS_SET command allows a user
to request only one between max and min ranges to be changed, while leaving
the other untouched if set to zero in the request; anyway SCMIv3.1 states
also explicitly that you cannot leave both of those unchanged (zeroed) when
issuing such command: add a proper check for this condition.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 65ffda5495d6..8f4051aca220 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -423,6 +423,9 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
+	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
+		return -EINVAL;
+
 	if (dom->fc_info && dom->fc_info->limit_set_addr) {
 		iowrite32(max_perf, dom->fc_info->limit_set_addr);
 		iowrite32(min_perf, dom->fc_info->limit_set_addr + 4);
-- 
2.32.0

