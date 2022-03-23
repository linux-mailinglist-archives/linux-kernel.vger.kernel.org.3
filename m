Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798BA4E5944
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbiCWTlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiCWTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:40:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1A45790
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94030B82027
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84352C340E8;
        Wed, 23 Mar 2022 19:39:25 +0000 (UTC)
Date:   Wed, 23 Mar 2022 15:39:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] tracing: Updates for 5.18
Message-ID: <20220323153923.425be157@gandalf.local.home>
In-Reply-To: <CAHk-=wiY2iVfuwuOLbaQ1PG2sK2ZGVtCfRH+bjDyei3j5YytLA@mail.gmail.com>
References: <20220321105621.3d4a9bc6@gandalf.local.home>
        <CAHk-=wiY2iVfuwuOLbaQ1PG2sK2ZGVtCfRH+bjDyei3j5YytLA@mail.gmail.com>
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

On Wed, 23 Mar 2022 11:47:07 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Mar 21, 2022 at 7:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > A restructure of include/trace caused a conflict [..]  
> 
> Ugh. Disgusting. And in the very same pull request it shows why that
> TRACE_CUSTOM_EVENT() thing that caused this all was actually a
> horribly bad idea, since it also then DIDN'T WORK due to the kernel
> interfaces changing.

I thought I explained the reasoning behind that in my pull request.

CUSTOM events have to match the function prototype to the tracepoint that
they are on top of (which is created by the TRACE_EVENT), and if they do
not, bad things can happen at run time. Thus, the added check to make sure
it will fail at build time.

> 
> So this restructuring seems to have been triggered by something that
> was a bad idea to begin with.
> 
> But the real problem is here:
> 
> > Tracing updates for 5.18:
> >
> > - New user_events interface. User space can register an event with the kernel
> >   describing the format of the event. Then it will receive a byte in a page
> >   mapping that it can check against. A privileged task can then enable that
> >   event like any other event, which will change the mapped byte to true,
> >   telling the user space application to start writing the event to the
> >   tracing buffer.  
> 
> That explanation makes no sense, because it doesn't actually explain *why*.

Sorry, sometimes when you are deep into the work, things that are obvious
to yourself may not be obvious to others. Being able to know those things
is an art onto itself.

> 
> It explains *what*, but the big issue for new interfaces shoudl always
> be why the heck a new interface was needed in the first place.

The why is that we have applications that run in containers that want
events to be traced. But we do not want to always trace those events. These
applications will not have an interface to talk to, to say "start tracing
X", as they are inside a container and various other reasons.

Thus, the applications can add their own trace events, and then the admin
that is outside the container can enable the events inside the container,
by enabling them from the tracefs file system, which will set a byte in the
mapping that happened when the application registered the event, where it
can now know to start tracing the event.

It does require that the application has a conditional jmp on that byte,
and not be optimized like the kernel is with static_branches.

I hope that explains things a bit better.

> 
> I've pulled this, but under protest.

Thank you.

-- Steve
