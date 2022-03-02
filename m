Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC14CA9C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiCBQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCBQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:02:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD705DA45
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC3D9B81F2D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9D1C004E1;
        Wed,  2 Mar 2022 16:01:39 +0000 (UTC)
Date:   Wed, 2 Mar 2022 11:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <20220302110138.6d2abcec@gandalf.local.home>
In-Reply-To: <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
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
        <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
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

On Wed, 2 Mar 2022 14:20:23 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Like so, or is something else needed?
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 68ecd3e35342..d1b30b5c5c23 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4980,7 +4980,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
>  {
>  	struct ftrace_func_entry *entry;
>  
> -	if (!ftrace_location(ip))
> +	ip = ftrace_location(ip);
> +	if (!ip)
>  		return -EINVAL;

This could possibly work. I'd have to test all this though.

I probably could just take this patch and try it out. You can remove the
"x86/ibt" from the subject, as this patch may be a requirement for that
(include that in the commit log), but it is has no changes to x86/ibt
specifically.

-- Steve


>  
>  	if (remove) {
