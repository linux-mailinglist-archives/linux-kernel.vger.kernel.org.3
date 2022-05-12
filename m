Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9452556A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357910AbiELTK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiELTK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:10:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C0129C84;
        Thu, 12 May 2022 12:10:54 -0700 (PDT)
Received: from kbox (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 702BF20EC9E0;
        Thu, 12 May 2022 12:10:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 702BF20EC9E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652382654;
        bh=joY3xeylWrrPHHqgJ1TYAOvU9x8yBrB9yzFzNddBXoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVnSSn3sQ2FyTvTwPUx5ZeAQHr3DzImypL/1wbrNPRylGxZ+t69M5kH8098lTH3uC
         ocF0N82ZF8/MmnNecsJ5WH5EmSIPxZ3htxIK13N0wgHdPLlprbP9jTgSHAP9OGtPSV
         sXNHSjpoLRQp9puE9oo+EZMXqF+MTazDPAwclfwE=
Date:   Thu, 12 May 2022 12:10:47 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Primiano Tucci <primiano@google.com>
Subject: Re: Feedback on user-events UAPI
Message-ID: <20220512191047.GA2011@kbox>
References: <1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:47:19AM -0400, Mathieu Desnoyers wrote:
> Hi Beau,
> 
> I have queued a few questions I would like to discuss with respect to the proposed
> user events UAPI. I originally planned to expand further on them, but I now think it's
> best if I ask away right now and we clarify things through discussion:
> 

Sounds good, thanks for taking the time to write down your thoughts.

> First, I find it odd that the event enable bitmask and the event ID and payload
> type registration must be combined. I can think of various use-cases where other
> tracers would be interested to use the event-enable bitmask facility without
> polluting the event ID/payload registration data structures with useless data.
> Can those be split into two distinct independent ABIs ?
> 

If the ABI were to expand beyond kernel hosted trace_events, then I
think these could be split out. However, I believe the question of other
tracers was asked previously [1] and was out of scope for this work.

I don't have a plan to use other tracers, but that doesn't mean I would
close the door on the ability to have other tracers participate in the
ABI.

I believe Steven would ultimately own if something hosted in tracefs
would allow non-kernel tracers to be involved. If the events don't
follow the kernel format, I could see this being pretty hard to get
right while still allowing the kernel to filter them via ftrace, etc.

Masami should also have an opinion on this, regarding registering and
formats within the ABI.

Steven and Masami, do you mind giving your opinion/guidance here?

> I can't help but notice that this new user-space instrumentation infrastructure/ABI
> can only be used for tracing user-space through kernel tracers. Considering that
> ABIs dictated by the kernel usually end up being de facto standards, I am concerned
> that if it is unable to allow purely user-space tracers to use it, then all applications
> will end up being statically instrumented in ways that prevent user-space tracers from
> hooking efficiently on the static instrumentation. As I have replied in an earlier
> thread, purely user-space tracers are not just marginally faster than kernel tracers
> for tracing user-space. They are an order of magnitude faster as soon as all the proper
> configuration steps are taken to ensure there are no system calls on the tracer
> fast path. Therefore, it would be sad to effectively dismiss efficient tracer
> implementations for the sake of easiness of implementation of today's user-event
> ABI. This will cause a precedent we will be stuck with later.
> 
> Linux kernel developers involved in implementation of instrumentation within Linux
> have spent a lot of effort to make sure the instrumentation is orthogonal to the
> tracing technology (tracepoints, kprobe, kretprobe...). I understand that making
> sure the user-space instrumentation ABI keeps this orthogonal is a lot more work,
> but nobody said that exposing ABIs to user-space was easy. ;-)
> 

I agree on a lot of these points. This is why user_events uses
trace_events instead of rolling something custom. It just hooks the
probes already attached and acts as a bridge between a user buffer and
the various probes that are attached.

Since these are trace_events through the kernel we can re-use ways for
grabbing the stack, hardware counters, etc. via perf. We can also apply
filtering and debug things occurring very easily via ftrace (I do this
all the time to help figure out if events are really registered and
writing things out). Things just work without extra lines of code.

User events is using all the common framework that has been put into the
kernel to make this work, very little is specific to user mode (beside
what absolutely needs to be, like mmap).

Since the way to get data into user_events is via the write() syscall, I
don't see how the data can be used purely on the user side (beside just
the mmap part of it, which is likely why you want it split up, right?).

If the ABI were to split up between a pure status map and a data emit
mechanism, how do you envision the data emit mechanism to look? Would it
be the same we have now, or would there be some way to have the ABI
switch between kernel tracers and user tracers avoiding the write
syscall?

> The other point I would like to raise is container awareness. I can't help but
> notice that the user events ABI is exposed to trace all containers, with the intent
> to be used (consumed) from some privileged namespace (e.g. root pid namespace).
> This works in use-cases where the user of the tracing data controls the entire
> machine (all containers), but not so much if the user is a single tenant within
> a multi-tenants systems. I would expect that a proper namespace-aware facility
> would take care of making sure that a trace consumer could observe what is
> instrumented within its own container, and within nested containers as well.
> The fact that all container questions are entirely dismissed, thus keeping a
> event-enable bitmask registry and event ID/type registry global to the entire
> system, is not compatible with consuming traces from a non-privileged container,
> and I suspect this may also be used as a side-channel to learn information about
> what other containers are doing in a multi-tenant system.
> 

This is the same as uprobes/kprobes/tracefs today, right? This seems
much wider than just user_events.

We started a conversation [2] about getting tracefs more container/namespace
aware. I think this would be a good thing, but I'm not sure it's ABI related.

My understanding is that we would use the current users cgroup/namespace to
determine which pages to give back to them once tracefs had it's own
cgroup/namespace, ideally.

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

[1] https://lore.kernel.org/all/20220330153110.10c3f2236b1cd5759f0b5c79@kernel.org/
[2] https://lore.kernel.org/all/20220316232009.7952988633787ef1003f13b0@kernel.org/

Thanks,
-Beau
