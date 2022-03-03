Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98C24CB56C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiCCD07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCCD06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:26:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AF45799
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:26:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8ADD61738
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D07C004E1;
        Thu,  3 Mar 2022 03:26:12 +0000 (UTC)
Date:   Wed, 2 Mar 2022 22:23:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/2] tracing: Add sample code for custom trace events
Message-ID: <20220302222325.7ad12606@rorschach.local.home>
In-Reply-To: <20220303104006.56820d801a9ba6c4d5da8c93@kernel.org>
References: <20220302032414.503960863@goodmis.org>
        <20220302032820.877781830@goodmis.org>
        <20220303104006.56820d801a9ba6c4d5da8c93@kernel.org>
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

On Thu, 3 Mar 2022 10:40:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +static struct trace_event_call sched_switch_call = {
> > +	.class			= &sched_switch_class,
> > +	.event			= {
> > +		.funcs			= &sched_switch_funcs,
> > +	},
> > +	.print_fmt		= SCHED_PRINT_FMT,
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
> > +	.module			= THIS_MODULE,
> > +#else
> > +	.mod			= THIS_MODULE,
> > +#endif  
> 
> I think this example code doesn't need to care about older kernels. 

Oops, I thought I got rid of all the mod versions :-p  I had this
working on a 5.4 kernel that we were going use, and there was a bunch
more of these in my original code. I'll nuke this on v2.

> 
> Others looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Hopefully, it is more helpful if there are more comments for other developers. :-)
> (and usage comments too)

Actually, I was thinking of coming up with a bunch of helper
functions/macros to make this less complex. But yeah, it needs a bunch
of comments before it can be accepted.

Thanks a lot for the review!

-- Steve
