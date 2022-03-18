Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58824DD715
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiCRJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCRJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:29:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1F0C2E35B8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:28:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F29516F2;
        Fri, 18 Mar 2022 02:28:28 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF26E3F7B4;
        Fri, 18 Mar 2022 02:28:27 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Fix sorting of retrieved clock rates
Date:   Fri, 18 Mar 2022 09:28:13 +0000
Message-Id: <20220318092813.49283-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
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

During SCMI Clock protocol initialization, after having retrieved from the
SCMI platform all the available discrete rates for a specific clock, the
clock rates array is sorted, unfortunately using a pointer to its end as
a base instead of its start, so that sorting does not work.

Fix invocation of sort() passing as base a pointer to the start of the
retrieved clock rates array.

Fixes: dccec73de91 ("firmware: arm_scmi: Keep the discrete clock rates sorted")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index cf6fed6dec77..ef6431c6eb1c 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -210,7 +210,8 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 
 	if (rate_discrete && rate) {
 		clk->list.num_rates = tot_rate_cnt;
-		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
+		sort(clk->list.rates, tot_rate_cnt, sizeof(*rate),
+		     rate_cmp_func, NULL);
 	}
 
 	clk->rate_discrete = rate_discrete;
-- 
2.32.0

