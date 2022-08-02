Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44A5882BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiHBToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6497E45F5E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAAF6146B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8634BC433C1;
        Tue,  2 Aug 2022 19:44:14 +0000 (UTC)
Date:   Tue, 2 Aug 2022 15:44:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] tracing: Use alignof__(struct {type b;}) instead of
 offsetof()
Message-ID: <20220802154412.513c50e3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Simplify:

  #define ALIGN_STRUCTFIELD(type) ((int)(offsetof(struct {char a; type b;}, b)))

with

  #define  ALIGN_STRUCTFIELD(type) __alignof__(struct {type b;})

Which works just the same.

Link: https://lore.kernel.org/all/a7d202457150472588df0bd3b7334b3f@AcuMS.aculab.com/

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage4_event_fields.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index 80d34f396555..a8fb25f39a99 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -2,7 +2,7 @@
 
 /* Stage 4 definitions for creating trace events */
 
-#define ALIGN_STRUCTFIELD(type) ((int)(offsetof(struct {char a; type b;}, b)))
+#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))
 
 #undef __field_ext
 #define __field_ext(_type, _item, _filter_type) {			\
-- 
2.35.1

