Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA35AD68C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbiIEPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbiIEP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:29:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5626112C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C0C2B81200
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D405C433D6;
        Mon,  5 Sep 2022 15:28:23 +0000 (UTC)
Date:   Mon, 5 Sep 2022 11:29:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/4] tracing/hist: Call hist functions directly via a
 switch statement
Message-ID: <20220905112900.79c8a387@gandalf.local.home>
In-Reply-To: <20220905224849.80af1cb24d9eed1c1cdbcaee@kernel.org>
References: <20220823214606.344269352@goodmis.org>
        <20220823215139.658601723@goodmis.org>
        <20220905224849.80af1cb24d9eed1c1cdbcaee@kernel.org>
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

On Mon, 5 Sep 2022 22:48:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> I found this crashed the kernel if I ran 
> 
>  # ftracetest test.d/trigger/trigger-hist-expressions.tc
> 
> More specifically, here is the minimum reproduce command.
> 
>  # echo "hist:keys=common_pid:x=16-8-4" > events/sched/sched_process_fork/trigger 
> [   75.874402] BUG: kernel NULL pointer dereference, address: 0000000000000038
> [   75.875378] #PF: supervisor read access in kernel mode
> 
> I investigated it and found you missed to set correct fn_num for
> combined constant field;
> 
> > @@ -2725,7 +2748,8 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> >  		if (var2)
> >  			expr->operands[1] = var2;
> >  
> > -		expr->constant = op_fn(expr, NULL, NULL, NULL, NULL);
> > +		expr->fn_num = op_fn;
> > +		expr->constant = hist_fn_call(expr, NULL, NULL, NULL, NULL);
> >  
> >  		expr->operands[0] = NULL;
> >  		expr->operands[1] = NULL;  
> 
> Here, we need this;
> 
> 		expr->fn_num = HIST_FIELD_FN_CONST;
> 
> Without this fix, the binary op_fn is kept on this const field and it
> causes the problem because the const field doesn't have operands.
> 

Thanks Masami,

Today is a US holiday, and I'm only cleaning out some email (and working on
my LPC presentation for tomorrow's speaker's training), but not doing any
other work. I'll look at this tomorrow.

-- Steve
