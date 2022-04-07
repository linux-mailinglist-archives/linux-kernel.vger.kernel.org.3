Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39034F8485
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbiDGQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiDGQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78613114DE4;
        Thu,  7 Apr 2022 09:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C27C61ADA;
        Thu,  7 Apr 2022 16:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA00C385A5;
        Thu,  7 Apr 2022 16:05:15 +0000 (UTC)
Date:   Thu, 7 Apr 2022 12:05:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Message-ID: <20220407120513.6f64b67e@gandalf.local.home>
In-Reply-To: <20220407115030.3454b29e@gandalf.local.home>
References: <20220407144524.2a592ed6@canb.auug.org.au>
        <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
        <20220407105446.186114c3@gandalf.local.home>
        <20220407111318.649f908d@gandalf.local.home>
        <F1B98786-A0C4-4907-9B44-7D13050237F2@oracle.com>
        <20220407114241.0c52b8f0@gandalf.local.home>
        <20220407115030.3454b29e@gandalf.local.home>
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

On Thu, 7 Apr 2022 11:50:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Actually, I found an issue with the above that will not fix it, but the fix
> > to that is not that difficult (currently testing it this time).  
> 
> Take two:

I found a way that can even make it more robust and easier to backport:

Take three:

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..c060ae35f785 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -392,12 +392,6 @@ static void test_event_printk(struct trace_event_call *call)
 			if (!(dereference_flags & (1ULL << arg)))
 				goto next_arg;
 
-			/* Check for __get_sockaddr */;
-			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
-				dereference_flags &= ~(1ULL << arg);
-				goto next_arg;
-			}
-
 			/* Find the REC-> in the argument */
 			c = strchr(fmt + i, ',');
 			r = strstr(fmt + i, "REC->");
@@ -413,7 +407,14 @@ static void test_event_printk(struct trace_event_call *call)
 				a = strchr(fmt + i, '&');
 				if ((a && (a < r)) || test_field(r, call))
 					dereference_flags &= ~(1ULL << arg);
+			} else if ((r = strstr(fmt + i, "__get_dynamic_array(")) &&
+				   (!c || r < c)) {
+				dereference_flags &= ~(1ULL << arg);
+			} else if ((r = strstr(fmt + i, "__get_sockaddr(")) &&
+				   (!c || r < c)) {
+				dereference_flags &= ~(1ULL << arg);
 			}
+
 		next_arg:
 			i--;
 			arg++;
