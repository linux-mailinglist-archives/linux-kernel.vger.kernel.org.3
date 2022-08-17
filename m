Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957EC597510
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiHQR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbiHQR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:27:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0F6AA1D3D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:27:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44FFF1595;
        Wed, 17 Aug 2022 10:27:58 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA02D3F66F;
        Wed, 17 Aug 2022 10:27:56 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 5/6] firmware: arm_scmi: Fix asynchronous reset requests
Date:   Wed, 17 Aug 2022 18:27:30 +0100
Message-Id: <20220817172731.1185305-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817172731.1185305-1-cristian.marussi@arm.com>
References: <20220817172731.1185305-1-cristian.marussi@arm.com>
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

SCMI Reset protocol specification allows for asynchronous reset request
only when an Autonomous Reset action is specified: reset requests based on
explicit assert/deassert of signals should not be served asynchronously.

Current implementation will instead issue an asynchronous request in any
case, as long as the reset domain had advertised to support asynchronous
resets.

Avoid requesting asynchronous resets when the reset action is not of the
Autonomous type, even if the target reset-domain does, in general, support
asynchronous requests.

Fixes: 95a15d80aa0d ("firmware: arm_scmi: Add RESET protocol in SCMI v2.0")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index b0494165b1cb..e9afa8cab730 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -172,7 +172,7 @@ static int scmi_domain_reset(const struct scmi_protocol_handle *ph, u32 domain,
 		return -EINVAL;
 
 	rdom = pi->dom_info + domain;
-	if (rdom->async_reset)
+	if (rdom->async_reset && flags & AUTONOMOUS_RESET)
 		flags |= ASYNCHRONOUS_RESET;
 
 	ret = ph->xops->xfer_get_init(ph, RESET, sizeof(*dom), 0, &t);
@@ -184,7 +184,7 @@ static int scmi_domain_reset(const struct scmi_protocol_handle *ph, u32 domain,
 	dom->flags = cpu_to_le32(flags);
 	dom->reset_state = cpu_to_le32(state);
 
-	if (rdom->async_reset)
+	if (flags & ASYNCHRONOUS_RESET)
 		ret = ph->xops->do_xfer_with_response(ph, t);
 	else
 		ret = ph->xops->do_xfer(ph, t);
-- 
2.32.0

