Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D608A4F8294
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbiDGPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDGPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF570198954;
        Thu,  7 Apr 2022 08:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F39B61DFB;
        Thu,  7 Apr 2022 15:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFBEC385A4;
        Thu,  7 Apr 2022 15:13:20 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:13:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Message-ID: <20220407111318.649f908d@gandalf.local.home>
In-Reply-To: <20220407105446.186114c3@gandalf.local.home>
References: <20220407144524.2a592ed6@canb.auug.org.au>
        <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
        <20220407105446.186114c3@gandalf.local.home>
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

On Thu, 7 Apr 2022 10:54:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, I know we added code to handle "__get_sockaddr()" but I guess this
> should also be fine for "__get_dynamic_array()" as well.

Does the below patch fix it?

(not even compiled tested)

-- Steve

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..043b80f3e19a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -392,8 +392,9 @@ static void test_event_printk(struct trace_event_call *call)
 			if (!(dereference_flags & (1ULL << arg)))
 				goto next_arg;
 
-			/* Check for __get_sockaddr */;
-			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
+			/* Check for __get_sockaddr or __get_dynamic_array */;
+			if (str_has_prefix(fmt + i, "__get_sockaddr(") ||
+			    str_has_prefix(fmt + i, "__get_dynamic_array(")) {
 				dereference_flags &= ~(1ULL << arg);
 				goto next_arg;
 			}
