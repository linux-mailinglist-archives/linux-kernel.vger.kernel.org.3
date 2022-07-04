Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A95655A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiGDMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiGDMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:41:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1C11177;
        Mon,  4 Jul 2022 05:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B902BB80EF7;
        Mon,  4 Jul 2022 12:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E86BC3411E;
        Mon,  4 Jul 2022 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656938510;
        bh=woMFBKGhZbbP6U8C9VLpfXm9CACfBtvBeAVHM0vUyw0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t7MRw9ut8MceLs1bkRj2Y8T3OoJ/2PZ13T1oHMBYxpL7V8+ko2hNKInR8wT/2todk
         OIMiBqlCnjJLFs2ZCT0eyussRy96qUoJ8QIMxv41VQuv2w04ACKDaU0E7t++KiushN
         0p2cZU21o3ddsDVJUKy8XJGyqVqIMlp3mXbQG3XMroyAd3DYK0MCmEW0/cicTS/Snf
         ftWa6nmUVqWYiZK5FZxFLs2aXYj9HQpKgPtvN2H7JevHqYeYZkKemWYTAo/YEmLBzz
         lFY77WhZeC2pinH3sJ8XNsDgBzumIfC14xppbnqbMhXIzV4L7nCzdt4qgWtFANLhLU
         ZoVWbrdyKazgA==
Message-ID: <fe1c0bd0-303b-6758-a6fd-2eb5eeb5c0b8@kernel.org>
Date:   Mon, 4 Jul 2022 14:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Gabriele Paoloni <gpaoloni@redhat.com>,
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
References: <cover.1655368610.git.bristot@kernel.org>
 <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
 <168af019-70d1-3237-dc9c-56a82beb5990@roeck-us.net>
 <04ca385b-47dc-5535-419e-1b814a383d1a@kernel.org>
 <CA+wEVJbvcMZbCroO2_rdVxLvYkUo-ePxCwsp5vbDpoqys4HGWQ@mail.gmail.com>
 <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
 <20220628153256.65dc84dd@gandalf.local.home>
 <56166be5-e30f-8f2a-e85a-09b993c7a8f0@roeck-us.net>
 <20220701113851.3167403e@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220701113851.3167403e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 17:38, Steven Rostedt wrote:
> On Fri, 1 Jul 2022 07:45:50 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> Do not confuse this with static analyzers or other general purpose tooling
>>> to find bugs. This is not the purpose of the run time verify. It is just to
>>> prove that certain use cases will perform as expected, given a limited
>>> input.
>>>   
>>
>> ... this is, unfortunately, not explained in the patch. I would have much less
>> of a problem with the series if those details were included.
> 
> It's one of those cases where developers get so involved in their code that
> they leave out the things that are so obvious to them, but not obvious to
> others ;-)

I agree that the main point here is that the documentation [patch 20/20] needs
to be extended and correctly linked to the code.

The goal of the model is to specify the minimum but obligatory steps to set a
watchdog (start, set a safe timeout, ping...) so it can be used by
"safety/heath" monitors in safety-critical systems.

Another goal is to reduce the amount of code/dependencies that will require
deeper inspections to qualify the subsystem for usage in a given context via
monitoring (as steven mentioned - more about it here [1]), without having to
reduce the generic subsystem.

Although the method allows one to create a complete model of the watchdog device
layer, covering all use cases, that is not the idea of this monitor. Moreover, a
full model would not be the adequate model for this specific (but relevant) case
raised and discussed in the Elisa workgroup [2].

The goal of the monitor (that uses the model) is to verify that the interaction
between the watchdog device layer and the "safety/heath" monitors follows this
established model, at runtime.

> My new saying is: "We work in a field where the obvious seldom is".
> 
> Hmm, I think I'll go tweet that :-)

/me liked the tweet... and yep, you clarified well the context in which this is
being applied.

>>
>> Not that I would mind such a verifier, if it was possible to define one,
>> but it would have to be tested with a large number of watchdog drivers
>> to ensure that it addresses all use cases, or at least with a substantial
>> percentage of use cases. It would also require that the state machine is
>> readable to give people a chance to fix it if turns out to be broken.

The patch 20/20 has the automaton in the ASCII art format. Both C and ASCII
models were extracted from the same .dot file. I am not including the .dot file
because there was a previous discussion with the doc people that prefer the
ASCII format in the documentation. But I can add as well, not linked with the
rst file. By reading the model in the ASCII format, it is possible to see that
it is broad enough to cover many watchdogs as it uses simple/generic operations.

The model (the .h) and the instrumentation (the .c) can be updated at any time.
I am adding the tooling to facilitate that, like [patch 06/20].

Patch 19/20 adds a safety application that enables the RV monitor, uses the
watchdog, and collects feedback from the monitor to see if the requested actions
are occurring in the model - and it can be used to test the RV monitor with
any watchdog.

The goal is the one I described above, so an exception generated by this monitor
needs to be read accordingly: it does not imply that a watchdog driver is
broken. It means the interaction between the safety/health monitor and the
watchdog is not following specifications and must be checked at the development
phase, or that something went really wrong at runtime phase.

I will add that to the documentation and emphasize the context of this monitor.

>> It would also have to be robust, meaning it would have to reject invalid
>> (unsupported) settings from the start and not only during runtime.
> 
> I would agree than any module would need to state up front exactly what it
> is modeling. In safety critical systems, all the components that are used
> are defined up front. Not sure if we can have the model not load if the
> required drivers to test are not loaded or ones not part of the model are
> (Daniel?).

I can add a check in the time in which the model is being enabled. But for this
specific case, removing that part might be better and adding it later if it
becomes fundamental.

In practice, selecting a watchdog device can assume that the get_timeleft
implementation is a requirement - so that option was just an additional check.

[1] This is one use case for the broader goal of the strategy discussed here:
https://www.youtube.com/watch?v=DkiwkAKOXNs

[2] https://www.youtube.com/watch?v=qFSYlCbHCYk
> Anyway, thanks for the feedback.
> 
> -- Steve

