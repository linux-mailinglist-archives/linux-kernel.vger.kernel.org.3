Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1E4DA14E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350619AbiCORdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350676AbiCORdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02556775;
        Tue, 15 Mar 2022 10:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B97615AC;
        Tue, 15 Mar 2022 17:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E2C340E8;
        Tue, 15 Mar 2022 17:31:53 +0000 (UTC)
Date:   Tue, 15 Mar 2022 13:31:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the ftrace tree with the nfsd tree
Message-ID: <20220315133151.7e415bb3@gandalf.local.home>
In-Reply-To: <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
References: <20220315145828.413e9301@canb.auug.org.au>
        <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
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

On Tue, 15 Mar 2022 13:33:30 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > On Mar 14, 2022, at 11:58 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Hi all,
> > 
> > Today's linux-next merge of the ftrace tree got a conflict in:
> > 
> >  include/trace/trace_events.h
> > 
> > between commit:
> > 
> >  d07c9ad62247 ("tracing: Introduce helpers to safely handle dynamic-sized sockaddrs")
> > 
> > from the nfsd tree and commit:
> > 
> >  af6b9668e85f ("tracing: Move the defines to create TRACE_EVENTS into their own files")
> > 
> > from the ftrace tree.
> > 
> > Well, this is a pain :-(  
> 
> Apologies. Steven, can you take the sockaddr patches in your tree
> and resolve the x86_64 build issue?

Actually, the issue is not with your tree. It's a conflict with:

  fa2c3254d7cff ("sched/tracing: Don't re-read p->state when emitting sched_switch event")

Which changed the sched_switch event that my example was attaching to.

At least this proves that it will not compile if your custom event does not
match the prototype of the event that the custom event is modifying :-)


> > 
> > However, my x86_64 allmodconfig build then failed like this:
> > 
> > In file included from include/trace/define_custom_trace.h:55,
> >                 from samples/trace_events/trace_custom_sched.h:95,
> >                 from samples/trace_events/trace_custom_sched.c:24:
> > samples/trace_events/./trace_custom_sched.h: In function 'ftrace_test_custom_probe_sched_switch':
> > include/trace/trace_custom_events.h:178:42: error: passing argument 1 of 'check_trace_callback_type_sched_switch' from incompatible pointer type [-Werror=incompatible-pointer-types]
> >  178 |         check_trace_callback_type_##call(trace_custom_event_raw_event_##template); \
> >      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      |                                          |
> >      |                                          void (*)(void *, bool,  struct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  struct task_struct *, struct task_struct *)}
> > include/trace/trace_custom_events.h:34:9: note: in expansion of macro 'DEFINE_CUSTOM_EVENT'
> >   34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(args));
> >      |         ^~~~~~~~~~~~~~~~~~~
> > samples/trace_events/./trace_custom_sched.h:21:1: note: in expansion of macro 'TRACE_CUSTOM_EVENT'
> >   21 | TRACE_CUSTOM_EVENT(sched_switch,
> >      | ^~~~~~~~~~~~~~~~~~
> > In file included from include/linux/trace_events.h:11,
> >                 from samples/trace_events/trace_custom_sched.c:10:
> > include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *, struct task_struct *)' {aka 'void (*)(void *, _Bool,  struct task_struct *, struct task_struct *)'}
> >  279 |         check_trace_callback_type_##name(void (*cb)(data_proto))        \


It's the type check code that failed. The above is complaining that it
expects:

 'void (*)(void *, bool,  unsigned int,  struct task_struct *, struct
 task_struct *)' {aka 'void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)'}

But it found:

 'void (*)(void *, bool,  struct task_struct *, struct task_struct *)' {aka
 'void (*)(void *, _Bool,  struct task_struct *, struct task_struct *)'}


That's because the sched_switch event had the int prev_state added to it,
but my custom event was unaware of that.

Stephen, I pushed out a branch on my tree that merges my for-next branch
with next-20220315 and pushed it to:

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

branch: trace-merge-next-20220315

-- Steve




> >      |                                          ~~~~~~~^~~~~~~~~~~~~~~
> > include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
> >  419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
> >      |         ^~~~~~~~~~~~~~~
> > include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TRACE'
> >  553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> >      |         ^~~~~~~~~~~~~
> > include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EVENT'
> >  222 | TRACE_EVENT(sched_switch,
> >      | ^~~~~~~~~~~
> > 
> > So I gave up and uses the ftrace tree from next-20220310 for today.
> > 
> > I am going to need some help with this mess, please.
> > -- 
> > Cheers,
> > Stephen Rothwell  
> 
> --
> Chuck Lever
> 
> 

