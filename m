Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC3468FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhLFDvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236642AbhLFDvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638762459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpYoRQheDiMAZvFfnFVOrL2zVbbsGFQnPDsTymriXd0=;
        b=AGC11TqI20F7RNGUgpxXHKvJSuqVddhIrFEGs9vdqMbE4MWjeD+z3oujs6nz9c0obQVsAV
        zJXJY/bZYdWuC0M9NkUQsJm6NWcSAm/yACwpewNbAjLmxT7hJKwJIP9ZNQqaZei+E4NFpc
        OCG80Ru9ybPyncplfVLfHj8m+2AEARw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-NpCrmGPGNzKE8VQu-FmUsQ-1; Sun, 05 Dec 2021 22:47:34 -0500
X-MC-Unique: NpCrmGPGNzKE8VQu-FmUsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B02522F26;
        Mon,  6 Dec 2021 03:47:32 +0000 (UTC)
Received: from [10.22.16.32] (unknown [10.22.16.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C17C45D67;
        Mon,  6 Dec 2021 03:47:31 +0000 (UTC)
Message-ID: <7cf33254-f9b8-8d82-21eb-dfeeeb2d5079@redhat.com>
Date:   Sun, 5 Dec 2021 22:47:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 1/4] clocksource: Avoid accidental unstable marking of
 clocksources
Content-Language: en-US
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20211118191439.1000012-1-longman@redhat.com>
 <20211118191439.1000012-2-longman@redhat.com>
 <20211122030223.GG34844@shbuild999.sh.intel.com>
 <20211125041550.GA1659740@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211125041550.GA1659740@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 23:15, Paul E. McKenney wrote:
> On Mon, Nov 22, 2021 at 11:02:23AM +0800, Feng Tang wrote:
>> On Thu, Nov 18, 2021 at 02:14:36PM -0500, Waiman Long wrote:
>>> Since commit db3a34e17433 ("clocksource: Retry clock read if long delays
>>> detected") and commit 2e27e793e280 ("clocksource: Reduce clocksource-skew
>>> threshold"), it is found that tsc clocksource fallback to hpet can
>>> sometimes happen on both Intel and AMD systems especially when they are
>>> running stressful benchmarking workloads. Of the 23 systems tested with
>>> a v5.14 kernel, 10 of them have switched to hpet clock source during
>>> the test run.
>>>
>>> The result of falling back to hpet is a drastic reduction of performance
>>> when running benchmarks. For example, the fio performance tests can
>>> drop up to 70% whereas the iperf3 performance can drop up to 80%.
>>>
>>> 4 hpet fallbacks happened during bootup. They were:
>>>
>>>    [    8.749399] clocksource: timekeeping watchdog on CPU13: hpet read-back delay of 263750ns, attempt 4, marking unstable
>>>    [   12.044610] clocksource: timekeeping watchdog on CPU19: hpet read-back delay of 186166ns, attempt 4, marking unstable
>>>    [   17.336941] clocksource: timekeeping watchdog on CPU28: hpet read-back delay of 182291ns, attempt 4, marking unstable
>>>    [   17.518565] clocksource: timekeeping watchdog on CPU34: hpet read-back delay of 252196ns, attempt 4, marking unstable
>>>
>>> Other fallbacks happen when the systems were running stressful
>>> benchmarks. For example:
>>>
>>>    [ 2685.867873] clocksource: timekeeping watchdog on CPU117: hpet read-back delay of 57269ns, attempt 4, marking unstable
>>>    [46215.471228] clocksource: timekeeping watchdog on CPU8: hpet read-back delay of 61460ns, attempt 4, marking unstable
>>>
>>> Commit 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold"),
>>> changed the skew margin from 100us to 50us. I think this is too small
>>> and can easily be exceeded when running some stressful workloads on a
>>> thermally stressed system.  So it is switched back to 100us.
>>>
>>> Even a maximum skew margin of 100us may be too small in for some systems
>>> when booting up especially if those systems are under thermal stress. To
>>> eliminate the case that the large skew is due to the system being too
>>> busy slowing down the reading of both the watchdog and the clocksource,
>>> an extra consecutive read of watchdog clock is being done to check this.
>>>
>>> The consecutive watchdog read delay is compared against
>>> WATCHDOG_MAX_SKEW/2. If the delay exceeds the limit, we assume that
>>> the system is just too busy. A warning will be printed to the console
>>> and the clock skew check is skipped for this round.
>>   
>> Reviewed-by: Feng Tang <feng.tang@intel.com>
> I applied #1 and #2 with Feng Tang's Reviewed-by, thank you both!
>
> It turns out that #4 depends on #3, so rather than risk injecting errors
> by sorting that out manually, I will await either an updated #3 and #4
> or a rebased #4, at your option.

I just send out a updated patch 4 that applies on top of the current 
rcu/next branch of linux-rcu git tree. I would still like to see a 
Kconfig option be available.

Feng, if you have any further suggestion on patch 3, please let me know. 
This one is just handling some rare cases that shouldn't happen at all. 
So it is not that important.

Cheers,
Longman

