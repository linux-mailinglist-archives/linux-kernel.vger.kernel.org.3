Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A954CC00B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiCCOfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiCCOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:35:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89D1587B2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E609261B60
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC8C004E1;
        Thu,  3 Mar 2022 14:34:15 +0000 (UTC)
Date:   Thu, 3 Mar 2022 09:34:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <20220303093413.387ee6f1@gandalf.local.home>
In-Reply-To: <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
References: <20220224211919.0612a3f6@rorschach.local.home>
        <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
        <20220225083647.12ceb54b@gandalf.local.home>
        <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
        <20220301142016.22e787fb@gandalf.local.home>
        <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
        <20220302110138.6d2abcec@gandalf.local.home>
        <20220302144716.1772020c@gandalf.local.home>
        <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
        <1646300416.yyrqygami4.naveen@linux.ibm.com>
        <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
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

On Thu, 3 Mar 2022 14:04:52 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > @@ -1596,7 +1596,7 @@ static int check_ftrace_location(struct kprobe *p)
> > {
> > 	unsigned long ftrace_addr;
> > 
> > -	ftrace_addr = ftrace_location((unsigned long)p->addr);
> > +	ftrace_addr = ftrace_location_range((unsigned long)p->addr, (unsigned long)p->addr);  
> 
> Yes, although perhaps a new helper. I'll go ponder during lunch.

Is there more places to add that to make it worth creating a helper?

If not, I would just keep using the ftrace_location_range().

If there is to be a helper function, then we should not have touched
ftrace_location() in the first place, and instead created a new function
that does the offset check.

Because thinking about this more, ftrace_location() is suppose to act just
like ftrace_location_range() and now it does not.

I rather keep ftrace_location() the same as ftrace_location_range() if
there's going to be another API. Maybe create a function ftrace_addr() that
does the new ftrace_location() that you have, and leave ftrace_location()
as is?

This is actually what I suggested in the beginning.

-- Steve
