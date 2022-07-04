Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F2565238
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiGDKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGDKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:23:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C8ADF08
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70209153B;
        Mon,  4 Jul 2022 03:23:16 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EFF03F792;
        Mon,  4 Jul 2022 03:23:14 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 6/7] firmware: arm_scmi: Use FastChannel tracing
Date:   Mon,  4 Jul 2022 11:22:40 +0100
Message-Id: <20220704102241.2988447-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704102241.2988447-1-cristian.marussi@arm.com>
References: <20220704102241.2988447-1-cristian.marussi@arm.com>
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

Make use of SCMI FastChannel event tracing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c     | 10 ++++++++++
 drivers/firmware/arm_scmi/powercap.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 521458fda355..64ea2d2f2875 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -16,6 +16,8 @@
 #include <linux/scmi_protocol.h>
 #include <linux/sort.h>
 
+#include <trace/events/scmi.h>
+
 #include "protocols.h"
 #include "notify.h"
 
@@ -363,6 +365,8 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].set_addr) {
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
 
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_SET,
+				   domain, min_perf, max_perf);
 		iowrite32(max_perf, fci->set_addr);
 		iowrite32(min_perf, fci->set_addr + 4);
 		ph->hops->fastchannel_db_ring(fci->set_db);
@@ -409,6 +413,8 @@ static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 
 		*max_perf = ioread32(fci->get_addr);
 		*min_perf = ioread32(fci->get_addr + 4);
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_GET,
+				   domain, *min_perf, *max_perf);
 		return 0;
 	}
 
@@ -446,6 +452,8 @@ static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
 
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_SET,
+				   domain, level, 0);
 		iowrite32(level, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
@@ -484,6 +492,8 @@ static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
 		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_GET,
+				   domain, *level, 0);
 		return 0;
 	}
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 10b77c3401b5..83b90bde755c 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
+#include <trace/events/scmi.h>
+
 #include "protocols.h"
 #include "notify.h"
 
@@ -323,6 +325,8 @@ static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 	dom = pi->powercaps + domain_id;
 	if (dom->fc_info && dom->fc_info[POWERCAP_FC_CAP].get_addr) {
 		*power_cap = ioread32(dom->fc_info[POWERCAP_FC_CAP].get_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_GET,
+				   domain_id, *power_cap, 0);
 		return 0;
 	}
 
@@ -388,6 +392,8 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 
 		iowrite32(power_cap, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_SET,
+				   domain_id, power_cap, 0);
 		return 0;
 	}
 
@@ -427,6 +433,8 @@ static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
 	dom = pi->powercaps + domain_id;
 	if (dom->fc_info && dom->fc_info[POWERCAP_FC_PAI].get_addr) {
 		*pai = ioread32(dom->fc_info[POWERCAP_FC_PAI].get_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_GET,
+				   domain_id, *pai, 0);
 		return 0;
 	}
 
@@ -469,6 +477,8 @@ static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
 	if (pc->fc_info && pc->fc_info[POWERCAP_FC_PAI].set_addr) {
 		struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_PAI];
 
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_SET,
+				   domain_id, pai, 0);
 		iowrite32(pai, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
-- 
2.32.0

