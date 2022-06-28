Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6425B55EDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiF1TmA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Jun 2022 15:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiF1Tle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:41:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD521EC73;
        Tue, 28 Jun 2022 12:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E7A7B81F8E;
        Tue, 28 Jun 2022 19:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3799EC341C6;
        Tue, 28 Jun 2022 19:32:58 +0000 (UTC)
Date:   Tue, 28 Jun 2022 15:32:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Gabriele Paoloni <gpaoloni@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
Message-ID: <20220628153256.65dc84dd@gandalf.local.home>
In-Reply-To: <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
References: <cover.1655368610.git.bristot@kernel.org>
        <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
        <168af019-70d1-3237-dc9c-56a82beb5990@roeck-us.net>
        <04ca385b-47dc-5535-419e-1b814a383d1a@kernel.org>
        <CA+wEVJbvcMZbCroO2_rdVxLvYkUo-ePxCwsp5vbDpoqys4HGWQ@mail.gmail.com>
        <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 16:53:54 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> >      >> +
> >      >> +struct automaton_safe_wtd automaton_safe_wtd = {
> >      >> +    .state_names = {
> >      >> +        "init",
> >      >> +        "closed_running",
> >      >> +        "closed_running_nwo",
> >      >> +        "nwo",
> >      >> +        "opened",
> >      >> +        "opened_nwo",
> >      >> +        "reopened",
> >      >> +        "safe",
> >      >> +        "safe_nwo",
> >      >> +        "set",
> >      >> +        "set_nwo",
> >      >> +        "started",
> >      >> +        "started_nwo",
> >      >> +        "stoped"
> >      >> +    },
> >      >> +    .event_names = {
> >      >> +        "close",
> >      >> +        "nowayout",
> >      >> +        "open",
> >      >> +        "other_threads",
> >      >> +        "ping",
> >      >> +        "set_safe_timeout",
> >      >> +        "start",
> >      >> +        "stop"
> >      >> +    },
> >      >> +    .function = {

I think it could become much more readable if you added comments here that
show what each column is. That way, we do not need to try to remember it.

And maybe even a diagram in the comments. If we can automate the generating
of an ASCII DFA diagram then that would be awesome too :-)

> >      >> +        {                          -1,                nwo_safe_wtd,             opened_safe_wtd,               init_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
> >      >> +        {                          -1, closed_running_nwo_safe_wtd,           reopened_safe_wtd,     closed_running_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
> >      >> +        {                          -1, closed_running_nwo_safe_wtd,        started_nwo_safe_wtd, closed_running_nwo_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
> >      >> +        {                          -1,                nwo_safe_wtd,         opened_nwo_safe_wtd,                nwo_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
> >      >> +        {               init_safe_wtd,                          -1,                          -1,                          -1,                          -1,                          -1,           started_safe_wtd,                          -1 },
> >      >> +        {                nwo_safe_wtd,                          -1,                          -1,                          -1,                          -1,                          -1,       started_nwo_safe_wtd,                          -1 },
> >      >> +        {     closed_running_safe_wtd,                          -1,                          -1,                          -1,                          -1,                set_safe_wtd,                          1,             opened_safe_wtd },
> >      >> +        {     closed_running_safe_wtd,                          -1,                          -1,                          -1,               safe_safe_wtd,                          -1,                          1,             stoped_safe_wtd },
> >      >> +        { closed_running_nwo_safe_wtd,                          -1,                          -1,                          -1,           safe_nwo_safe_wtd,                          -1,                         -1,                          -1 },
> >      >> +        {                          -1,                          -1,                          -1,                          -1,               safe_safe_wtd,                          -1,                         -1,                          -1 },
> >      >> +        {                          -1,                          -1,                          -1,                          -1,           safe_nwo_safe_wtd,                          -1,                         -1,                          -1 },
> >      >> +        {     closed_running_safe_wtd,                          -1,                          -1,                          -1,                          -1,                set_safe_wtd,                         -1,             stoped_safe_wtd },
> >      >> +        { closed_running_nwo_safe_wtd,                          -1,                          -1,                          -1,                          -1,            set_nwo_safe_wtd,                         -1,                          -1 },
> >      >> +        {               init_safe_wtd,                          -1,                          -1,                          -1,                          -1,                          -1,                         -1,                          -1 },
> >      >> +    },
> >      >> +    .initial_state = init_safe_wtd,
> >      >> +    .final_states = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },  
> >      >
> >      > I find this event table all but impossible to verify.  
> > 
> >     It is a matrix. Lines are states, and columns are events.
> > 
> >     On a given state/line, receiving a given event/column, the data is the next
> >     state/row.
> >   
> 
> I am aware of that, and I did program state machines before.
> 
> >     For instance, let's say "init" (row 0), event "nwo" (column 1), and the next
> >     state is the "nwo" (row 3).
> > 
> >     -1 means invalid/blocked state (yeah, maybe it is better to have an #define
> >     INVALID_STATE -1).
> > 
> >     This is the C representation of an automaton, following the formal definition of
> >     a deterministic automaton. I've added an explanation of this representation in
> >     the documentation (patch 15, file da_monitor_synthesis.rst).
> > 
> >     A deeper look into this subject is here (peer-reviewed conference paper at
> >     Software Engineer and Formal Methods 2019):
> >     https://bristot.me/wp-content/uploads/2019/09/paper.pdf <https://bristot.me/wp-content/uploads/2019/09/paper.pdf>
> > 
> >     One could translate it back to the automaton's graphical format... to a format
> >     of by a tool used to analyze automaton properties... that is the good point of
> >     using a well-established formalism. (The bad part is that they are often
> >     boring... c'est la vie :-)).
> >   
> 
> If the above state machine fails, no one but the authors will be able to even
> remotely figure out what happened, and if the watchdog driver is at fault or
> its monitor. It is a state machine making assumptions about state transitions,
> sure, but who knows if those asssumptions are even remotely correct or match
> reality. For example, I have no idea if the lack of a 'ping' function is handled
> correctly,  if the lack of a 'stop' function is handled correctly, or what
> happens if any of the driver functions returns an error.
> 
> I already found three assumptions which do not or not necessarily match
> reality:
> 
> - The function to read the remaining timeout is optional and must not be
>    used unconditionally, and its lack is not an error.
> - The requested timeout (and pretimeout) do not have to match the actually
>    configured timeout, and userspace must not rely on the assumption that
>    the values match.
> - The code assumes that the process opening the watchdog and the process
>    accessing it are the same. While that is in general the case, it might
>    well be that some application opens the watchdog and then handles it
>    from a child process.
> 
> And that is just after briefly browsing through the code.
> 
> I am open to suggestions from others, but at this point I have serious doubts
> that this code is maintainable in the kernel.
> 

Let me give some background on this. Various safety critical users
(automotive, power plants, etc) are looking at using Linux in the field.
Obviously, Linux itself is too big to verify properly. In fact, even small
OSs that say they are verifiable seldom are. Part of the solution is to add
a way to check that Linux is running as expected, and be able to detect
when it is not. When that happens, you fall into a "fail-safe" mode (for
example, if you have an autonomous driving vehicle, it could sound an alarm
and inform the driver to go into manual mode, or it is going to simply
"pull over". Note, this is just a hypothetical example, not something I've
seen in reality).

But to implement this, you need to verify the verifier. In this case, the
watchdog timer is what verifies that Linux is running properly. It is
possible to verify parts of the kernel when you limit the inputs of the
kernel. This means we are not trying to verify all use cases of the
watchdog timer. That would be pretty much impossible, or take decades to
complete. We only need to verify the use cases used in safety critical
systems.

Do not confuse this with static analyzers or other general purpose tooling
to find bugs. This is not the purpose of the run time verify. It is just to
prove that certain use cases will perform as expected, given a limited
input.

Years ago there was an interview with Linus where he was asked if he would
trust Linux in real-time safety critical projects. And Linus's response was
something to the effect that he would, as those projects have a very
limited use case, and the code that actually gets run is not as big as you
would think. And that code can be verified.

That's exactly what we are doing here. There are very strict standards on
what is considered safe for safety critical projects and by limiting the
use cases of the code we are verifying, we can achieve those objectives.

But your complaint about not being able to read or understand the table is
legitimate, and that needs to be addressed. And what the limiting input is
must also be commented as well, that way people will not get confused when
they see a legitimate use case not covered by the DFA.

Action Items:
 1. Add column title to the matrix. 
 2. Ideally, also add an ASCII DFA diagram.
 3. And finally, comment what the range of inputs are (what use cases are
    being covered).

-- Steve
