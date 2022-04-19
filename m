Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D215060EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiDSA2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiDSA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:28:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8DD422B33;
        Mon, 18 Apr 2022 17:26:00 -0700 (PDT)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5665F20C360F;
        Mon, 18 Apr 2022 17:26:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5665F20C360F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650327960;
        bh=+d8zINXu1e0i7/hJ59NpTOShuy/1+3GCZlvbU1Rdgvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpBCjAQcruArdzyS36Depw/dKiQQIDqM8A4m10c2k9kvkXkVqWLlOBGF7L0zyd7m+
         Ck0OEQaaW36v+cxfIm0jzDdkqUaQhoF+N7M1Wi5qmvQoGn6oG/hfHhySGqow7PtKk5
         UG9XbMqFahkdEFdEhWQ2Babm/FSGQT8ijTgIE3X4=
Date:   Mon, 18 Apr 2022 17:25:49 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v8 00/12] user_events: Enable user processes to create
 and write to trace events
Message-ID: <20220419002549.GA2055@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <Yl3NcRRIJMrd0WZu@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl3NcRRIJMrd0WZu@laniakea>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:43:29PM +0200, Hagen Paul Pfeifer wrote:
> * Beau Belgrave | 2021-12-16 09:34:59 [-0800]:
> 
> >The typical scenario is on process start to mmap user_events_status. Processes
> >then register the events they plan to use via the REG ioctl. The ioctl reads
> >and updates the passed in user_reg struct. The status_index of the struct is
> >used to know the byte in the status page to check for that event. The
> >write_index of the struct is used to describe that event when writing out to
> >the fd that was used for the ioctl call. The data must always include this
> >index first when writing out data for an event. Data can be written either by
> >write() or by writev().
> 
> Hey Beau, a little bit late to the party. A few questions from my side: What
> are the exact weak points of USDT compared to User Events that stand in the
> way of further extend USDT (in a non-compatible way, sure, just as an
> different approach!)? The nice thing about USDT is that I can search for all
> possible probes of the system via "find / | readelf | ". Since they are listed
> in a dedicated ELF section (.note.stapsdt) - they are visible & transparent. I
> can also map a hierarchy/structure in Executable/DSO via clever choice of
> names. The big disadvantage of USDT is the lack of type information, but from
> a registration, explicit point of view, they are nice.
> 
> Or in other words: why not extends the USDT approach? Why not
> 
> u32 val = 23;
> const char *garbage = "tracestring";
> 
> DYNAMIC_TRACE_PROBE2("foo:bar", val, u32, garbage, cstring);
> 

We actually tried some USDT extension methods early on, by extending the
.note.stapsdt sections and seeing how far we could get our definitions
into that form.

There are a few problems when running in a highly container/CGROUP
environment even if you can get our formats into stapsdt.

It costs a lot to transverse every ELF file on the machine to find all
the notes. When profiling or tracing many containers, each cgroup's
mount space must be entered and then tracked. Since these files are in
different locations, they each need a separate probe definition, since
the definitions/patches are tied to the location of the binary to patch.

As new cgroups come online, we would have to keep track of each new
binary location and find probes that match their location. This becomes
really hard to manage if for example we just want to always enable a
specific event regardless of where it is on the filesystem. Events are
limited to a max of 2^16 having many duplicate events in the system
might start to approach that limit for high-core machines with many
small cgroup isolations.

We run programs that are built on interpreted or JIT'd code (C#,
javascript, etc.). These don't have great places to put a stap
definition, since they aren't ELF files. I've seen approaches where
temporary ELF files are generated, however, this costs a lot. Now we
have even more temporarily files to go patch, meaning more events and
more probe definitions (many of them in our case would be duplicates of
the others).

In production environments we have them locked down heavily with both
SELINUX and IPE enabled. This prevents us from patching user mode code
on the fly, the typical perf probe calls fail here.

We typically want to know what events are available to us with very
little overhead. Having programs register to a well known location
already (trace_events, tracefs) I can easily see all the user events on
the system by just doing ls on /sys/kernel/tracing/events/user_events. I
can also see all their data formats and easily enable hist and filtering
since these formats are known to the kernel.

In our testing uprobes are much more costly to the running program than
the write syscall.

For managed code, as in java, code is moving around and are not always
in static locations. The probe locations can change, etc. Calling from
a managed location into a native one has performance implications as
well when using a dynamic/temp elf stub approach.

We are actively using user_events to solve these problems in our
environments that have previously seen high overheads to achieve the
same results. Many times we cannot afford to miss any events, so live
scanning for new ELF files doesn't work for us as the programs and
cgroups are short lived.

> 
> Sure, the argument names, here "val" and "garbage" should also be saved. I
> also like the "just one additional header to the project to get things
> running" (#include "sdt.h"). Sure, a DYNAMIC_TRACE_IS_ACTIVE("foo:bar") would
> be great. But in fact we have never needed that in the past.
> 
> 
> hgn

Thanks,
-Beau
