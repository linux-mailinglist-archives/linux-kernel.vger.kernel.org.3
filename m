Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF267507BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357900AbiDSVOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiDSVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:14:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18721257;
        Tue, 19 Apr 2022 14:11:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650402678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/aQIgWXxwBmFGO013/E4FwX4lEBkuaiUJLDZEQdNAE=;
        b=cr7DjwyrwAC1xj1sLtRiFpR+sBqbFVqNojlImLNsKBdnAmjfYqaOuoyb9phyuVLp5ppfSZ
        dtd707TV/x8I5HqP5QwypxYvQrB5bsc1xtoRYRRi6X2QBApCbIeDQWRYRCuRDi1d63KMp/
        9CPBxYNvr9X5pIERJXjRlaVFEjvunetwb8HJnLkHQAYQ6NhZPXkor/ZP6gH2DJEn7OojgC
        Juhad1bgturpCdcAWMOtN7jCOAz7u0btW9CHX2J9A7M2hta+p4F4hrgttf4QUPyofTkqo7
        R/y16yc54zp7n2lCSwLKMEC5OmpD9vEyV8Q09kZ3qtlLdPE7oHtP9CF0dvnoGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650402678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/aQIgWXxwBmFGO013/E4FwX4lEBkuaiUJLDZEQdNAE=;
        b=j72MpmW6lV/Z3DmwOd+aLbRYakj1ZRkHArWZR6R0Wo3oy/I0Ex81jvVCg7qxWbJZhpMRbN
        dlCbsXjQ7RVaHeDg==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
In-Reply-To: <CAJZ5v0jf-NGa4-xaNaxehkLGPVqwhZrUhLXw2cJ1avtjgT5yPA@mail.gmail.com>
References: <20220415133356.179706384@linutronix.de>
 <005001d85413$75e5dce0$61b196a0$@telus.net>
 <CAJZ5v0jf-NGa4-xaNaxehkLGPVqwhZrUhLXw2cJ1avtjgT5yPA@mail.gmail.com>
Date:   Tue, 19 Apr 2022 23:11:17 +0200
Message-ID: <87bkwwvkwa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19 2022 at 20:49, Rafael J. Wysocki wrote:
> On Tue, Apr 19, 2022 at 7:32 PM Doug Smythies <dsmythies@telus.net> wrote:
>> For intel_pstate (active), both HWP enabled or disabled, the behaviour
>> of scaling_cur_freq is inconsistent with prior to this patch set and other
>> scaling driver governor combinations.
>>
>> Note there is no issue with " grep MHz /proc/cpuinfo" for any
>> combination.
>>
>> Examples:
>>
>> No-HWP:
>>
>> active/powersave:
>> doug@s19:~/freq-scalers/trace$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:2300418
>> /sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
>> /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:2300006
>> /sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:2300005
>> /sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0
>
> That's because after the changes in this series scaling_cur_freq
> returns 0 if the given CPU is idle.

Which is sensible IMO as there is really no point in waking an idle CPU
just to read those MSRs, then wait 20ms wake it up again to read those
MSRs again.

> I guess it could return the last known result, but that wouldn't be
> more meaningful.

Right.

Thanks,

        tglx
