Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E319E4CA5D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbiCBNWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiCBNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:21:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1680C4283
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3zZYdFutFHK9yk4/nsgXX6UhECyksVopaUY1Z8IbprQ=; b=D8RqM/QvB5FTt5qgQmrxouTdVQ
        xCLI0tQuNHlYl2umc0hl8PBMMZSFykUXv0nOF1N2TJ9j86KeO1w8XrfT5MfCns0+dy7bebVKd3e5N
        2F3moqjr0bdB014OZk5KROREkdhg68b74yQEdrPV9bLXxZXc6u+yEMStYPpdD3mvsAgEBwpKrPdwm
        uTxNeOOYw1p8QjOoDtj4BckfhBvP+M9oBF3mhJ6xEPPq4cbCohPnPwLHPUe7Mwu5Dr98rBD3AMcTa
        WKftN1heP738pc4DSrezPVWC5OvckYZzrIGVAR5PjayV6WZk9stWVeSm7lyCK2hbq6uO+HSCojvGp
        bAr2N34A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPOu1-00AcY0-Jv; Wed, 02 Mar 2022 13:20:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 584DD3001C3;
        Wed,  2 Mar 2022 14:20:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15B0B32304D40; Wed,  2 Mar 2022 14:20:23 +0100 (CET)
Date:   Wed, 2 Mar 2022 14:20:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.714815604@infradead.org>
 <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
 <20220224105847.5c899324@gandalf.local.home>
 <20220225103449.6084e5314273556f35107cd9@kernel.org>
 <20220224211919.0612a3f6@rorschach.local.home>
 <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
 <20220225083647.12ceb54b@gandalf.local.home>
 <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
 <20220301142016.22e787fb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301142016.22e787fb@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 02:20:16PM -0500, Steven Rostedt wrote:
> On Wed, 02 Mar 2022 00:27:51 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Won't this cause issues with ftrace_set_filter_ip() and others? If the 
> > passed-in ip points to func+0 when the actual ftrace location is at some 
> > offset, the ftrace location check in ftrace_match_addr() will now pass, 
> > resulting in adding func+0 to the hash. Should we also update 
> > ftrace_match_addr() to use the ip returned by ftrace_location()?
> > 
> 
> Yes, ftrace_match_addr() would need to be updated, or at least
> ftrace_set_filter_ip() which is the only user ftrace_match_addr(), and is
> currently only used by kprobes, live kernel patching and the direct
> trampoline example code.

Like so, or is something else needed?

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 68ecd3e35342..d1b30b5c5c23 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4980,7 +4980,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
 	struct ftrace_func_entry *entry;
 
-	if (!ftrace_location(ip))
+	ip = ftrace_location(ip);
+	if (!ip)
 		return -EINVAL;
 
 	if (remove) {
