Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A6585FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiGaQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGaQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:02:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF44F5BC;
        Sun, 31 Jul 2022 09:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DEEDB80D86;
        Sun, 31 Jul 2022 16:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0BEC433D6;
        Sun, 31 Jul 2022 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659283375;
        bh=JnzgGcVBp807cZAqx6W/5ioAlDkM6Mambx7xHyw/NGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gf80AnxnSXZmm4AIyKASiuPlDUxT/SDON7V0hl3ALuFUujbzgo2YFxTbuYxL+39Bd
         8jGaY18welZMgukxZExsknB+zoFnuiujyTmRQXI5bH2OxkQ53U9S+TusP8Tpvia98z
         9GDt4KdopGWTxHh7YcdNqKzM1dr6LR6Plqr5owuqROgfVzcVlwJIun3xqVsmSWzTlc
         wmGWlQBQvFQT3XrVCEBZAOqRQ4LBBpIx1qvOLDX1XyosrODH0xsAOqkpeRwwvgUG64
         VIGVEL8DDnLG+M9JDi+o51wijEb4E3+CIxM2qTER1qz/qa3xGvrL8kYuEkz3iVM/3j
         l3eaIo3ZLOtmA==
Message-ID: <7b3f7ec1-a479-f3ed-42b3-ddead0f9b427@kernel.org>
Date:   Sun, 31 Jul 2022 18:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 03/16] rv/include: Add helper functions for
 deterministic automata
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1659052063.git.bristot@kernel.org>
 <563234f2bfa84b540f60cf9e39c2d9f0eea95a55.1659052063.git.bristot@kernel.org>
 <YuacJsPya8PSE8qt@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YuacJsPya8PSE8qt@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/22 17:13, Tao Zhou wrote:
> On Fri, Jul 29, 2022 at 11:38:42AM +0200, Daniel Bristot de Oliveira wrote:
> 
> [...]
> 
>> +static inline type model_get_next_state_##name(enum states_##name curr_state,	\
>> +					       enum events_##name event)	\
>> +{										\
>> +	if ((curr_state < 0) || (curr_state >= state_max_##name))		\
>> +		return INVALID_STATE;						\
>> +										\
>> +	if ((event < 0) || (event >= event_max_##name))				\
>> +		return INVALID_STATE;						\
> 
> Should define the INVALID_EVENT corresponding to event invalid case.

no.

-- Daniel
