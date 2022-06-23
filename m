Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9A557E53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiFWOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiFWOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:55:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34EE25B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:55:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC5CD13D5;
        Thu, 23 Jun 2022 07:55:46 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2F6F3F66F;
        Thu, 23 Jun 2022 07:55:45 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        james.quinlan@broadcom.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] include: trace: Add SCMI full message tracing
Date:   Thu, 23 Jun 2022 15:55:32 +0100
Message-Id: <20220623145533.2882688-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220623145533.2882688-1-cristian.marussi@arm.com>
References: <20220623145533.2882688-1-cristian.marussi@arm.com>
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

Add a distinct trace event to dump full SCMI message headers and payloads.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/trace/events/scmi.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index cee4b2b64ae4..40995c8416ba 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -112,6 +112,37 @@ TRACE_EVENT(scmi_rx_done,
 		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
 		__entry->seq, __entry->msg_type)
 );
+
+TRACE_EVENT(scmi_msg_dump,
+	TP_PROTO(u8 protocol_id, u8 msg_id, unsigned char *tag, u16 seq,
+		 int status, void *buf, size_t len),
+	TP_ARGS(protocol_id, msg_id, tag, seq, status, buf, len),
+
+	TP_STRUCT__entry(
+		__field(u8, protocol_id)
+		__field(u8, msg_id)
+		__array(char, tag, 5)
+		__field(u16, seq)
+		__field(int, status)
+		__field(size_t, len)
+		__dynamic_array(unsigned char, cmd, len)
+	),
+
+	TP_fast_assign(
+		__entry->protocol_id = protocol_id;
+		__entry->msg_id = msg_id;
+		strscpy(__entry->tag, tag, 5);
+		__entry->seq = seq;
+		__entry->status = status;
+		__entry->len = len;
+		memcpy(__get_dynamic_array(cmd), buf, __entry->len);
+	),
+
+	TP_printk("[0x%02X]:%s:[0x%02X]:[%04X]:[%d]: %s",
+		  __entry->protocol_id, __entry->tag, __entry->msg_id,
+		  __entry->seq, __entry->status,
+		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
+);
 #endif /* _TRACE_SCMI_H */
 
 /* This part must be outside protection */
-- 
2.32.0

