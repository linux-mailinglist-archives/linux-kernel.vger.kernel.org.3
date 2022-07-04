Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071D565232
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiGDKY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiGDKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:23:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF202BF56
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542E1152B;
        Mon,  4 Jul 2022 03:23:14 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2330D3F792;
        Mon,  4 Jul 2022 03:23:12 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 5/7] include: trace: Add SCMI FastChannel tracing
Date:   Mon,  4 Jul 2022 11:22:39 +0100
Message-Id: <20220704102241.2988447-6-cristian.marussi@arm.com>
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

All the currently defined SCMI events are meant to trace only regular SCMI
transfers based on SCMI messages exchanges; SCMI transactions based on
FastChannels, where used, are completely invisible from the tracing point
of view.

Add support to trace FastChannel transactions; while doing that avoid
exposing full shared memory location addresses.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/trace/events/scmi.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index cee4b2b64ae4..fa8879568a37 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -7,6 +7,31 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(scmi_fc_call,
+	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 val1, u32 val2),
+	TP_ARGS(protocol_id, msg_id, res_id, val1, val2),
+
+	TP_STRUCT__entry(
+		__field(u8, protocol_id)
+		__field(u8, msg_id)
+		__field(u32, res_id)
+		__field(u32, val1)
+		__field(u32, val2)
+	),
+
+	TP_fast_assign(
+		__entry->protocol_id = protocol_id;
+		__entry->msg_id = msg_id;
+		__entry->res_id = res_id;
+		__entry->val1 = val1;
+		__entry->val2 = val2;
+	),
+
+	TP_printk("[0x%02X]:[0x%02X]:[%08X]:%u:%u",
+		  __entry->protocol_id, __entry->msg_id,
+		  __entry->res_id, __entry->val1, __entry->val2)
+);
+
 TRACE_EVENT(scmi_xfer_begin,
 	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
 		 bool poll),
-- 
2.32.0

