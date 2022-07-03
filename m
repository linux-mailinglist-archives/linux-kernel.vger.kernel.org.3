Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADED56484B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiGCPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGCPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D465F67
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D6C060FD2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 15:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622A0C341C6;
        Sun,  3 Jul 2022 15:06:07 +0000 (UTC)
Date:   Sun, 3 Jul 2022 11:06:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: PATCH] tracing: ALSA: hda: Remove string manipulation out of the
 fast path
Message-ID: <20220703110605.07a86fb2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The TRACE_EVENT() macro is broken up into various parts to be efficient.
The TP_fast_assign() is just to record the event into the ring buffer, and
is to be done as fast as possible as this occurs during the actual running
of the code. The slower this is, the slower the code that is being traced
becomes.

The TP_printk() is processed when reading the tracing buffer. This is
considered the slow path. Any processing that can be moved from the
TP_fast_assign() to the TP_printk() should do so.

For some reason, the entire string processing of the trace events
hda_send_cmd, hda_get_response, and hda_unsol_event was moved from the
TP_printk() into the TP_fast_assign(). On top of that, the
__dynamic_array() was used with a fixed size of HDAC_MSG_MAX, which is
useless as a dynamic_array as it will always allocate HDAC_MSG_MAX bytes
on the ring buffer and even save that amount into the event (as it expects
the size to be dynamic, which using a fixed size defeats that purpose).

Instead, just save the necessary elements in the TP_fast_assign() and do
the string manipulation in the slow path.

The output should be the same.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 sound/hda/trace.h | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/sound/hda/trace.h b/sound/hda/trace.h
index 70af6c815089..2cc493434a8f 100644
--- a/sound/hda/trace.h
+++ b/sound/hda/trace.h
@@ -19,37 +19,48 @@ struct hdac_codec;
 TRACE_EVENT(hda_send_cmd,
 	TP_PROTO(struct hdac_bus *bus, unsigned int cmd),
 	TP_ARGS(bus, cmd),
-	TP_STRUCT__entry(__dynamic_array(char, msg, HDAC_MSG_MAX)),
+	TP_STRUCT__entry(
+		__string(name, dev_name((bus)->dev))
+		__field(u32, cmd)
+	),
 	TP_fast_assign(
-		snprintf(__get_str(msg), HDAC_MSG_MAX,
-			 "[%s:%d] val=0x%08x",
-			 dev_name((bus)->dev), (cmd) >> 28, cmd);
+		__assign_str(name, dev_name((bus)->dev));
+		__entry->cmd = cmd;
 	),
-	TP_printk("%s", __get_str(msg))
+	TP_printk("[%s:%d] val=0x%08x", __get_str(name), __entry->cmd >> 28, __entry->cmd)
 );
 
 TRACE_EVENT(hda_get_response,
 	TP_PROTO(struct hdac_bus *bus, unsigned int addr, unsigned int res),
 	TP_ARGS(bus, addr, res),
-	TP_STRUCT__entry(__dynamic_array(char, msg, HDAC_MSG_MAX)),
+	TP_STRUCT__entry(
+		__string(name, dev_name((bus)->dev))
+		__field(u32, addr)
+		__field(u32, res)
+	),
 	TP_fast_assign(
-		snprintf(__get_str(msg), HDAC_MSG_MAX,
-			 "[%s:%d] val=0x%08x",
-			 dev_name((bus)->dev), addr, res);
+		__assign_str(name, dev_name((bus)->dev));
+		__entry->addr = addr;
+		__entry->res = res;
 	),
-	TP_printk("%s", __get_str(msg))
+	TP_printk("[%s:%d] val=0x%08x", __get_str(name), __entry->addr, __entry->res)
 );
 
 TRACE_EVENT(hda_unsol_event,
 	TP_PROTO(struct hdac_bus *bus, u32 res, u32 res_ex),
 	TP_ARGS(bus, res, res_ex),
-	TP_STRUCT__entry(__dynamic_array(char, msg, HDAC_MSG_MAX)),
+	TP_STRUCT__entry(
+		__string(name, dev_name((bus)->dev))
+		__field(u32, res)
+		__field(u32, res_ex)
+	),
 	TP_fast_assign(
-		snprintf(__get_str(msg), HDAC_MSG_MAX,
-			 "[%s:%d] res=0x%08x, res_ex=0x%08x",
-			 dev_name((bus)->dev), res_ex & 0x0f, res, res_ex);
+		__assign_str(name, dev_name((bus)->dev));
+		__entry->res = res;
+		__entry->res_ex = res_ex;
 	),
-	TP_printk("%s", __get_str(msg))
+	TP_printk("[%s:%d] res=0x%08x, res_ex=0x%08x", __get_str(name),
+		  __entry->res_ex & 0x0f, __entry->res, __entry->res_ex)
 );
 
 DECLARE_EVENT_CLASS(hdac_stream,
-- 
2.35.1

