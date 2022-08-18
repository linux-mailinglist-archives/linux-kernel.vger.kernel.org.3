Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B17598522
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbiHROAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245478AbiHRN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFA65573
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C27ADB82175
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E13AC433D6;
        Thu, 18 Aug 2022 13:59:34 +0000 (UTC)
Date:   Thu, 18 Aug 2022 09:59:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH] x86/unwind/orc: unwind ftrace trampolines with correct
 orc
Message-ID: <20220818095944.5fbe3e8e@gandalf.local.home>
In-Reply-To: <24556707-99b3-ec3c-c176-cb73e1d030d8@huawei.com>
References: <20220818015525.222053-1-chenzhongjin@huawei.com>
        <20220817222836.72aa77bd@gandalf.local.home>
        <24556707-99b3-ec3c-c176-cb73e1d030d8@huawei.com>
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

On Thu, 18 Aug 2022 11:42:17 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> Thanks for review!
> 
> 
> On 2022/8/18 10:28, Steven Rostedt wrote:
> > On Thu, 18 Aug 2022 09:55:25 +0800
> > Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> >
> >  
> >>   arch/x86/kernel/unwind_orc.c | 13 ++++++++-----
> >>   1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> >> index 38185aedf7d1..a938c5d0ed6f 100644
> >> --- a/arch/x86/kernel/unwind_orc.c
> >> +++ b/arch/x86/kernel/unwind_orc.c
> >> @@ -93,22 +93,25 @@ static struct orc_entry *orc_find(unsigned long ip);
> >>   static struct orc_entry *orc_ftrace_find(unsigned long ip)
> >>   {
> >>   	struct ftrace_ops *ops;
> >> -	unsigned long caller;
> >> +	unsigned long tramp_addr, offset;
> >>   
> >>   	ops = ftrace_ops_trampoline(ip);
> >>   	if (!ops)
> >>   		return NULL;
> >>     
> > Now if this is that unlikely recursion mentioned below then ops->trampoline
> > will be NULL, and if we do that offset addition, it will be incorrect.
> >
> > Perhaps we should add here:
> >
> > 	if (!ops->trampoline)
> > 		return NULL;  
> 
> I think when this will return NULL and then stop at orc_find:`if (ip == 
> 0)` and return null_orc_entry.
> 

Duh, you're correct. I wasn't paying attention to how we acquired ops. Yes,
if ops->trampoline is NULL, then it will never be returned by
ftrace_ops_trampoline().
 
> >
> > Let's add some comments.  
> 
> Makes sense.
> 
> If the above explanation logic is fine, I'll add this comment and send v2.
> 

Yes, just add the comments for v2.

Thanks,

-- Steve
