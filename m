Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B35983FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245014AbiHRNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245008AbiHRNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:23:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D570C11157
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:23:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E490615DB;
        Thu, 18 Aug 2022 06:23:38 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A283F70D;
        Thu, 18 Aug 2022 06:23:36 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/1] include: trace: Harmonize SCMI tracing message format
Date:   Thu, 18 Aug 2022 14:23:09 +0100
Message-Id: <20220818132309.584042-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818132309.584042-1-cristian.marussi@arm.com>
References: <20220818132309.584042-1-cristian.marussi@arm.com>
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

Use the same format and across all SCMI traces.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/trace/events/scmi.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index 65016a767b7a..f160d68f961d 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -27,9 +27,9 @@ TRACE_EVENT(scmi_fc_call,
 		__entry->val2 = val2;
 	),
 
-	TP_printk("[0x%02X]:[0x%02X]:[%08X]:%u:%u",
-		  __entry->protocol_id, __entry->msg_id,
-		  __entry->res_id, __entry->val1, __entry->val2)
+	TP_printk("pt=%02X msg_id=%02X res_id:%u vals=%u:%u",
+		__entry->protocol_id, __entry->msg_id,
+		__entry->res_id, __entry->val1, __entry->val2)
 );
 
 TRACE_EVENT(scmi_xfer_begin,
@@ -53,9 +53,9 @@ TRACE_EVENT(scmi_xfer_begin,
 		__entry->poll = poll;
 	),
 
-	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u poll=%u",
-		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
-		__entry->seq, __entry->poll)
+	TP_printk("pt=%02X msg_id=%02X seq=%04X transfer_id=%X poll=%u",
+		__entry->protocol_id, __entry->msg_id, __entry->seq,
+		__entry->transfer_id, __entry->poll)
 );
 
 TRACE_EVENT(scmi_xfer_response_wait,
@@ -81,9 +81,9 @@ TRACE_EVENT(scmi_xfer_response_wait,
 		__entry->poll = poll;
 	),
 
-	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u tmo_ms=%u poll=%u",
-		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
-		__entry->seq, __entry->timeout, __entry->poll)
+	TP_printk("pt=%02X msg_id=%02X seq=%04X transfer_id=%X tmo_ms=%u poll=%u",
+		__entry->protocol_id, __entry->msg_id, __entry->seq,
+		__entry->transfer_id, __entry->timeout, __entry->poll)
 );
 
 TRACE_EVENT(scmi_xfer_end,
@@ -107,9 +107,9 @@ TRACE_EVENT(scmi_xfer_end,
 		__entry->status = status;
 	),
 
-	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u status=%d",
-		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
-		__entry->seq, __entry->status)
+	TP_printk("pt=%02X msg_id=%02X seq=%04X transfer_id=%X s=%d",
+		__entry->protocol_id, __entry->msg_id, __entry->seq,
+		__entry->transfer_id, __entry->status)
 );
 
 TRACE_EVENT(scmi_rx_done,
@@ -133,9 +133,9 @@ TRACE_EVENT(scmi_rx_done,
 		__entry->msg_type = msg_type;
 	),
 
-	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u msg_type=%u",
-		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
-		__entry->seq, __entry->msg_type)
+	TP_printk("pt=%02X msg_id=%02X seq=%04X transfer_id=%X msg_type=%u",
+		__entry->protocol_id, __entry->msg_id, __entry->seq,
+		__entry->transfer_id, __entry->msg_type)
 );
 
 TRACE_EVENT(scmi_msg_dump,
-- 
2.37.2

