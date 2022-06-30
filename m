Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4156214E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiF3RcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiF3Rby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:31:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B41F2871E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:31:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B4F106F;
        Thu, 30 Jun 2022 10:31:53 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BA9F3F792;
        Thu, 30 Jun 2022 10:31:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        james.quinlan@broadcom.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/2] include: trace: Add SCMI full message tracing
Date:   Thu, 30 Jun 2022 18:31:34 +0100
Message-Id: <20220630173135.2086631-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220630173135.2086631-1-cristian.marussi@arm.com>
References: <20220630173135.2086631-1-cristian.marussi@arm.com>
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
v1 --> v2
- changed dump formatting
---
 include/trace/events/scmi.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index fa8879568a37..65016a767b7a 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -137,6 +137,37 @@ TRACE_EVENT(scmi_rx_done,
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
+	TP_printk("pt=%02X t=%s msg_id=%02X seq=%04X s=%d pyld=%s",
+		  __entry->protocol_id, __entry->tag, __entry->msg_id,
+		  __entry->seq, __entry->status,
+		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
+);
 #endif /* _TRACE_SCMI_H */
 
 /* This part must be outside protection */
-- 
2.32.0

