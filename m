Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7F50A222
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389186AbiDUO0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352115AbiDUO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:26:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58D3D49B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:23:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650551038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NeAJXqQY5nZ0YI8gcGwJ8RQjpGp4i1z8VuPafV6qu+g=;
        b=Z/7C4HvINO4nubEVWSU9jjWAneZpemYP3I3mOi3iMpA47RfpJY3gBrsNsz1aDb7tPubXgR
        9RaTr8WrtAVxQwyVtwNYb/BUesAKXrxHohvgjjMgvRRSQn9ZnYGA3AObN7tK4RyodWBl8/
        0ARFiGJW3kgr9CDhJX3oSMXcC9za0/uYezUaIf+7wSIX0WI2j2GatPjMccRel90Tho/pki
        2A8I0pXpHFaVnsA9Wzl/Vc9sAEpp2G2BJHSgDEeJegI/142WEb/I4bXGvrG8P/+R74dmqq
        w3Wr9Ad5Ixws4bbbiX4eJ50Lss6+3H3lN7FOqeWqIeAL/3PCPIJrIN5Zh6gdNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650551038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NeAJXqQY5nZ0YI8gcGwJ8RQjpGp4i1z8VuPafV6qu+g=;
        b=jSc/sGsBBaI7oPfJltZhAbBFCkVuveilvUd2WqzqSzInyhXsoPn2Bk7FykjubNOEmu92Zq
        yPwROULVcxYR48CQ==
To:     David Hildenbrand <david@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Baokun Li <libaokun1@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] kernel/cpu: restart cpu_up when hotplug is disabled
In-Reply-To: <d98bb24d-b8cd-b00b-57c3-d96dae57ad5b@redhat.com>
References: <20220418195402.2986573-1-jsavitz@redhat.com>
 <d98bb24d-b8cd-b00b-57c3-d96dae57ad5b@redhat.com>
Date:   Thu, 21 Apr 2022 16:23:57 +0200
Message-ID: <877d7itszm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19 2022 at 14:34, David Hildenbrand wrote:
> On 18.04.22 21:54, Joel Savitz wrote:
>> The cpu hotplug path may be utilized while hotplug is disabled for a
>> brief moment leading to failures. As an example, attempts to perform
>> cpu hotplug by userspace soon after boot may race with pci_device_probe
>> leading to inconsistent results.
>
> You might want to extend a bit in which situation we observed that issue
> fairly reliably.
>
> When restricting the number of boot cpus on the kernel cmdline, e.g.,
> via "maxcpus=2", udev will find the offline cpus when enumerating all
> cpus and try onlining them. Due to the race, onlining of some cpus fails
> e.g., when racing with pci_device_probe().

maxcpus is a horrible hack and broken vs. MCE broadcasting on x86.

> While teaching udev to not online coldplugged CPUs when "maxcpus" was
> specified ("policy"), it revealed the underlying issue that onlining a
> CPU can fail with -EBUSY in corner cases when cpu hotplug is temporarily
> disabled.

Right. It can fail with -EBUSY and because userspace fails to handle it
gracefully we need to hack around it?

>> Proposed idea:
>> Call restart_syscall instead of returning -EBUSY since
>> cpu_hotplug_disabled seems to only have a positive value
>> for short, temporary amounts of time.
>> 
>> Does anyone see any serious problems with this?

Yes. It's a horrible hack and wrong...
 
>>  	if (cpu_hotplug_disabled) {
>> -		err = -EBUSY;
>> +		/* avoid busy looping (5ms of sleep should be enough) */
>> +		msleep(5);
>> +		err = restart_syscall();

... as it sleeps with cpu_add_remove_lock held, which protects
cpu_hotplug_disabled. IOW, cpu_hotplug_enable() is blocked until
msleep() returns.

> It's worth noting that we use the same approach in
> lock_device_hotplug_sysfs().

That does not make it any better, really. 

> It's far from perfect I would say, but we really wanted to avoid
> letting user space having to deal with retry logic.

What's so hard with retry logic in user space? 

If you can come up with a reasonable argument why user space cannot be
fixed, then there is certainly a better solution than slapping a
msleep(5) at some random place into the code.

Thanks,

        tglx
