Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A1451255E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiD0Wlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiD0Wl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:41:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6265D6D4D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:38:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651099093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0JjrDY5ZRqnFRcUlqMMWqxBQcbO4A/xkDxTwlnqWFk=;
        b=jszYZzKU9Rvaj4vO0mmsqXhjqNc3Kmos0bvnYLYr6I7iPz7aPlPApzuUorjIW6x9Qa6Fhv
        7eEzpPQJXNOgkJDEnf6hHcR2/mKwP1te6TBEpd2EcgVFsoM4icSOSKh6sqnxbyUgxc25MP
        72WvwH7+rV4Usb/6q6IYHcPvunTHhTjA5GyhMKUcERoS111LzApS9xNqBKbq6dadp+v5To
        om9izSodKsy5lpx39yETJ4Nnm04vMarlcgfJLbIFNfB4N763+ea3MosaTe7/4fn6f8Eu5C
        36yAOsG0CHLJqLk41Xz/f7lG0wh4BfZtXQZjVhZ2bx8GDuStReSKBkKxON5qag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651099093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0JjrDY5ZRqnFRcUlqMMWqxBQcbO4A/xkDxTwlnqWFk=;
        b=9QL4MT7cR7VrfiWOSQecv39bRXF/RRERSU7EgX/+pd70Xr6NKGiSWYYBYCJZ8lz0vnY93a
        DnOyykn5zxBLWrAg==
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>, Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc
 adjustment
In-Reply-To: <68837b1a-f85b-e842-f8c0-1cad162856f4@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
 <20220314194630.1726542-3-longman@redhat.com> <87czhymql2.ffs@tglx>
 <d1a04785-4822-3a3f-5c37-81329a562364@redhat.com> <87levx8kou.ffs@tglx>
 <4f02fe46-b253-2809-0af7-f2e9da091fe9@redhat.com> <87czh50xwf.ffs@tglx>
 <68837b1a-f85b-e842-f8c0-1cad162856f4@redhat.com>
Date:   Thu, 28 Apr 2022 00:38:12 +0200
Message-ID: <87h76ew3sb.ffs@tglx>
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

On Tue, Apr 26 2022 at 11:36, Waiman Long wrote:
> On 4/25/22 15:24, Thomas Gleixner wrote:
>> Yes. It's clear that the initial sync overhead is due to the cache line
>> being remote, but I rather underestimate the compensation. Aside of that
>> it's not guaranteed that the cache line is actually remote on the first
>> access. It's by chance, but not by design.
>
> In check_tsc_warp(), the (unlikely(prev > now) check may only be 
> triggered to record the possible wrap if last_tsc was previously written 
> to by another cpu. That requires the transfer of lock cacheline from the 
> remote cpu to local cpu as well. So sync overhead with remote cacheline 
> is what really matters here. I had actually thought about just measuring 
> local cacheline sync overhead so as to underestimate it and I am fine 
> about doing it.

Fair enough, but what I meant is that when estimating the actual sync
overhead then there is no guarantee that the cache line is remote.

The CPU which does that estimation might have been the last to lock,
there is no guarantee that the reference CPU locked last or wrote to the
cache line last.

>> IOW, TSC runs with a constant frequency independent of the actual CPU
>> frequency, ergo the CPU frequency dependent execution time has an
>> influence on the resulting compensation value, no?
>>
>> On the machine I tested on, it's a factor of 3 between the minimal and
>> the maximal CPU frequency, which makes quite a difference, right?
>
> Yes, I understand that. The measurement of sync_overhead is for 
> estimating the delay (in TSC cycles) that the locking overhead 
> introduces. With 1000MHz frequency, the delay in TSC cycle will be 
> double that of a cpu running at 2000MHz. So you need more compensation 
> in this case. That is why I said that as long as clock frequency doesn't 
> change in the check_tsc_wrap() loop and the sync_overhead measurement 
> part of the code, the actual cpu frequency does not matter here.

I grant you that it does not matter for the loop under the assumption
that the loop runs at constant frequency, but is that a guarantee that
it does not matter later on?

If you overcompensate by a factor of 3 because the upcoming CPU ran at
the lowest frequency, then it might become visible later when everything
runs at full speed.

> However about we half the measure sync_overhead as compensation to avoid 
> over-estimation, but probably increase the chance that we need a second 
> adjustment of TSC wrap.

Half of what?

> With this patch applied, the measured overhead on the same CooperLake
> system on different reboot runs varies from 104 to 326.

Half of something which jumps around? Not convinced. :)

Btw:
>> Yes, I will try that experiment and report back the results.

Could you please do that? I really like to see the data points.

It's so sad that we have still to deal with this nonsense just because
HW people don't give a damn.

Thanks,

        tglx
