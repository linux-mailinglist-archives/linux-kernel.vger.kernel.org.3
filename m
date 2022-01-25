Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0C49B5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385906AbiAYOFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:05:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55862 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348539AbiAYOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:02:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58BDA6151D;
        Tue, 25 Jan 2022 14:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1AEC340E0;
        Tue, 25 Jan 2022 14:01:54 +0000 (UTC)
Date:   Tue, 25 Jan 2022 09:01:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125090152.0c457aae@gandalf.local.home>
In-Reply-To: <20220125222732.98ce2e445726e773f40e122e@kernel.org>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 22:27:32 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > But if this is true, I would imagine there would be plenty of other
> > warnings? I'm currently stumped.  
> 
> That is because __rel_loc is used only in the sample code in the kernel
> for testing. Other use-cases comes from user-space.
> Hmm, can we skip this boundary check for this example?

Is this only checked when __CHECKER__ is defined? If so, would this work?

-- Steve

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index cbbbb83beced..cdc68e0f9ef9 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -506,6 +506,8 @@ DEFINE_EVENT_PRINT(foo_template, foo_with_template_print,
 	TP_ARGS(foo, bar),
 	TP_printk("bar %s %d", __get_str(foo), __entry->bar));
 
+/* rel_loc is for user defined events, the checker will trigger bugs on it */
+#ifndef __CHECKER__
 /*
  * There are yet another __rel_loc dynamic data attribute. If you
  * use __rel_dynamic_array() and __rel_string() etc. macros, you
@@ -539,6 +541,10 @@ TRACE_EVENT(foo_rel_loc,
 	TP_printk("foo_rel_loc %s, %d, %s", __get_rel_str(foo), __entry->bar,
 		  __get_rel_bitmask(bitmask))
 );
+#else
+#define trace_foo_rel_loc(foo, bar, mask) do { } while (0)
+#endif /* __CHECKER __ */
+
 #endif
 
 /***** NOTICE! The #if protection ends here. *****/
