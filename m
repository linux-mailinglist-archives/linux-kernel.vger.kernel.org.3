Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4970556435B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 02:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiGCABm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 20:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGCABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 20:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D44B4AE;
        Sat,  2 Jul 2022 17:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D48A6112B;
        Sun,  3 Jul 2022 00:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD108C34114;
        Sun,  3 Jul 2022 00:01:28 +0000 (UTC)
Date:   Sat, 2 Jul 2022 20:01:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] USB: gadget: udc: tracing: Do not open code __string() with
 __dynamic_array()
Message-ID: <20220702200127.399d2358@gandalf.local.home>
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

The event classes udc_log_ep and udc_log_req both declare:

    __dynamic_array(char, name, UDC_TRACE_STR_MAX)

Which will reserve UDC_TRACE_STR_MAX bytes on the ring buffer for the
event to write in name. It then uses snprintf() to write into that space.

Assuming that the string being copied is nul terminated, it is better to
just use the __string() helper. That way only the size of the string is
saved into the ring buffer and not the max size (yes, the entire
UDC_TRACE_STR_MAX is used in the trace event, and anything not used is
just junk in the ring buffer). Worse, there's also meta data saved into
the event that denotes where the string is stored in the event and also
saves its size, which is always going to be UDC_TRACE_STR_MAX.

Convert both to use the __string() and __assign_str() helpers that are for
this kind of use case.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/gadget/udc/trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 98584f6b6c66..db6510454b28 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -140,7 +140,7 @@ DECLARE_EVENT_CLASS(udc_log_ep,
 	TP_PROTO(struct usb_ep *ep, int ret),
 	TP_ARGS(ep, ret),
 	TP_STRUCT__entry(
-		__dynamic_array(char, name, UDC_TRACE_STR_MAX)
+		__string(name, ep->name)
 		__field(unsigned, maxpacket)
 		__field(unsigned, maxpacket_limit)
 		__field(unsigned, max_streams)
@@ -152,7 +152,7 @@ DECLARE_EVENT_CLASS(udc_log_ep,
 		__field(int, ret)
 	),
 	TP_fast_assign(
-		snprintf(__get_str(name), UDC_TRACE_STR_MAX, "%s", ep->name);
+		__assign_str(name, ep->name);
 		__entry->maxpacket = ep->maxpacket;
 		__entry->maxpacket_limit = ep->maxpacket_limit;
 		__entry->max_streams = ep->max_streams;
@@ -214,7 +214,7 @@ DECLARE_EVENT_CLASS(udc_log_req,
 	TP_PROTO(struct usb_ep *ep, struct usb_request *req, int ret),
 	TP_ARGS(ep, req, ret),
 	TP_STRUCT__entry(
-		__dynamic_array(char, name, UDC_TRACE_STR_MAX)
+		__string(name, ep->name);
 		__field(unsigned, length)
 		__field(unsigned, actual)
 		__field(unsigned, num_sgs)
@@ -228,7 +228,7 @@ DECLARE_EVENT_CLASS(udc_log_req,
 		__field(struct usb_request *, req)
 	),
 	TP_fast_assign(
-		snprintf(__get_str(name), UDC_TRACE_STR_MAX, "%s", ep->name);
+		__assign_str(name, ep->name);
 		__entry->length = req->length;
 		__entry->actual = req->actual;
 		__entry->num_sgs = req->num_sgs;
-- 
2.35.1

