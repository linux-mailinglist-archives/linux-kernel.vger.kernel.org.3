Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5CD573D09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiGMTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiGMTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:13:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8613F45;
        Wed, 13 Jul 2022 12:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E7BEB8212F;
        Wed, 13 Jul 2022 19:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E60C34114;
        Wed, 13 Jul 2022 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739621;
        bh=4gRkzlpRhfwDwt3txru4R7vN1hWK8tgG6Ph6530NTVo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UuH0pAnTY9nEcydrnNYcOa5n1c/Q3n+hmxm5Sk2ITyB+Uwc3RwAp7z9Ps05oK1Qwj
         G/Jpu9PDW2tFbCKugdTVfT5/g0Unp976NCEOtJmzWgSFT29IKehx68gmSEweUprYdw
         FIi9BBJoE6jlWrP85eNFO9ABl4iS0mPrLEjDDeI+uK4anIlJyirV68Wd4BPC5Ti8wd
         eEgPgyXI7puyJVJsoA3It7LeDtk06PUUqXUzpMslOZSJ1KhtMxC3gX2kGfLFmJjJQX
         JovsQTsc5N+8MbMt+tX89dUZYllae7XmiVdlRvJMuRhUEVeRhGl1POtkFjOeeAOZFB
         o8/4C/5iUAXxA==
Message-ID: <e53ddfa5-1e6b-a771-bb96-b43640b1d3b2@kernel.org>
Date:   Wed, 13 Jul 2022 21:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 10:45, Daniel Bristot de Oliveira wrote:
> The watchdog is an essential building block for the usage of Linux in
> safety-critical systems because it allows the system to be monitored from
> an external element - the watchdog hardware, acting as a safety-monitor.

Guenter and Steven,

I will move the watchdog monitor to a separated thread, as it will require
further discussions specific to it, mainly to get feedback from watchdog
maintainers.

Anyways, I am adding additional information for the sample monitors based on our
discussions here.

They are:

I added documentation about the automata format and the translation between
the formal <-> dot -> C.

I am adding the .dot file to the tools/verification/models/ so that one can get
the .dot file and convert it to other formats, like, a png file. This
will make it easy to read the automata model.

I am adding a .rst documentation for each model, including details about it.

I will send the v5 of RV without the safe_wtd monitor and then start a new
one about the watchdog later, after getting the RV interface series ready.

-- Daniel
