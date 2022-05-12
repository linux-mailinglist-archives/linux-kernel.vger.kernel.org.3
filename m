Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92BE52564E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358330AbiELUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357297AbiELUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:20:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADBDC26FA2D;
        Thu, 12 May 2022 13:20:36 -0700 (PDT)
Received: from kbox (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3627F20ECB86;
        Thu, 12 May 2022 13:20:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3627F20ECB86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652386836;
        bh=lKLoduqjtrzaOJhx7C3HeM2d/gUSVsRaSXsqF86yC04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX9PHeISh5Wvk4EY9fv9A9Am1oAhtZtskv5bAPQqORdX9g9Bd1xk5qowcG36D6RGf
         XDlCBi/65TRiAz1YZcBI+ymX0/f+5gTFxuDGC+u3Dt1xtqySt2QkKwuLnwfuNk56gx
         3WRGZtEW/EWGgj7kacVjYnCz62F4DxBAE++tBddU=
Date:   Thu, 12 May 2022 13:20:28 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Primiano Tucci <primiano@google.com>
Subject: Re: Feedback on user-events UAPI
Message-ID: <20220512202028.GA2559@kbox>
References: <1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com>
 <680139213.54888.1652384731022.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680139213.54888.1652384731022.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:45:31PM -0400, Mathieu Desnoyers wrote:
> ----- On May 12, 2022, at 11:47 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > Hi Beau,
> > 
> > I have queued a few questions I would like to discuss with respect to the
> > proposed
> > user events UAPI. I originally planned to expand further on them, but I now
> > think it's
> > best if I ask away right now and we clarify things through discussion:
> > 
> > First, I find it odd that the event enable bitmask and the event ID and payload
> > type registration must be combined. I can think of various use-cases where other
> > tracers would be interested to use the event-enable bitmask facility without
> > polluting the event ID/payload registration data structures with useless data.
> > Can those be split into two distinct independent ABIs ?
> > 
> > I can't help but notice that this new user-space instrumentation
> > infrastructure/ABI
> > can only be used for tracing user-space through kernel tracers. Considering that
> > ABIs dictated by the kernel usually end up being de facto standards, I am
> > concerned
> > that if it is unable to allow purely user-space tracers to use it, then all
> > applications
> > will end up being statically instrumented in ways that prevent user-space
> > tracers from
> > hooking efficiently on the static instrumentation. As I have replied in an
> > earlier
> > thread, purely user-space tracers are not just marginally faster than kernel
> > tracers
> > for tracing user-space. They are an order of magnitude faster as soon as all the
> > proper
> > configuration steps are taken to ensure there are no system calls on the tracer
> > fast path. Therefore, it would be sad to effectively dismiss efficient tracer
> > implementations for the sake of easiness of implementation of today's user-event
> > ABI. This will cause a precedent we will be stuck with later.
> > 
> > Linux kernel developers involved in implementation of instrumentation within
> > Linux
> > have spent a lot of effort to make sure the instrumentation is orthogonal to the
> > tracing technology (tracepoints, kprobe, kretprobe...). I understand that making
> > sure the user-space instrumentation ABI keeps this orthogonal is a lot more
> > work,
> > but nobody said that exposing ABIs to user-space was easy. ;-)
> > 
> > The other point I would like to raise is container awareness. I can't help but
> > notice that the user events ABI is exposed to trace all containers, with the
> > intent
> > to be used (consumed) from some privileged namespace (e.g. root pid namespace).
> > This works in use-cases where the user of the tracing data controls the entire
> > machine (all containers), but not so much if the user is a single tenant within
> > a multi-tenants systems. I would expect that a proper namespace-aware facility
> > would take care of making sure that a trace consumer could observe what is
> > instrumented within its own container, and within nested containers as well.
> > The fact that all container questions are entirely dismissed, thus keeping a
> > event-enable bitmask registry and event ID/type registry global to the entire
> > system, is not compatible with consuming traces from a non-privileged container,
> > and I suspect this may also be used as a side-channel to learn information about
> > what other containers are doing in a multi-tenant system.
> 
> One more thought: I may have simply missed it, but is there any user events code 
> which dynamically validates that the input from user-space writev() indeed match the
> event description layout ? I'm thinking about wrong size, too short strings, too long
> strings, missing null terminator and so on. Any user input that could make the trace
> unreadable should never reach the tracing buffers.
> 

Yes, there are validators attached to events to ensure that the minimum
size is written and ensure types that require certain safety gaurantees
are met. Currently I believe the only such requirement is for variable
length strings to have proper null termination (beside the min size
requirement).

See user_event_validate() in kernel/trace/trace_events_user.c.
This is called for both perf and ftrace buffers, buffers discard if the
validation fails.

Related patch:
https://lore.kernel.org/all/20220118204326.2169-7-beaub@linux.microsoft.com/

> Thanks,
> 
> Mathieu
> 
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

Thanks,
-Beau
