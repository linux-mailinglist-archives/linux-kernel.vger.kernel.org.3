Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDC4C944B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiCATcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiCATcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:32:08 -0500
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885BE4EF64
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:31:27 -0800 (PST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 00BF1E1B40
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:31:27 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id P8BanDD5pRnrrP8Ban6Xee; Tue, 01 Mar 2022 13:29:26 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40046 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nP8BZ-000kds-Uw; Tue, 01 Mar 2022 13:29:26 -0600
Message-ID: <6fd678d8-58fc-5863-fd88-4c8335dd8b38@kernel.org>
Date:   Tue, 1 Mar 2022 20:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
 <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
 <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
 <20220301180509.GQ4285@paulmck-ThinkPad-P17-Gen-1>
 <c3cf7c0c-27fe-4dfa-4249-a7e1747237a5@kernel.org>
 <20220301185823.GS4285@paulmck-ThinkPad-P17-Gen-1>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220301185823.GS4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nP8BZ-000kds-Uw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40046
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 19:58, Paul E. McKenney wrote:
> On Tue, Mar 01, 2022 at 07:44:38PM +0100, Daniel Bristot de Oliveira wrote:
>> On 3/1/22 19:05, Paul E. McKenney wrote:
>>>> I see, as long as it costs < 1 us, I am ok. If it gets > 1us in a reasonably
>>>> fast machine, we start see HW noise where it does not exist, and that would
>>>> reduce the resolution of osnoise. AFAICS, it is not causing that problem, but we
>>>> need to make it as lightweight as possible.
>>> In the common case, it is atomically incrementing a local per-CPU counter
>>> and doing a store.  This should be quite cheap.
>>>
>>> The uncommon case is when the osnoise process was preempted or otherwise
>>> interfered with during a recent RCU read-side critical section and
>>> preemption was disabled around that critical section's outermost
>>> rcu_read_unlock().  This can be quite expensive.  But I would expect
>>> you to just not do this.  ;-)
>>
>> Getting the expensive call after a preemption is not a problem, it is a side
>> effect of the most costly preemption.
>>
>> It this case, we should "ping rcu" before reading the time to account the
>> overhead for the previous preemption which caused it.
>>
>> like (using the current code as example):
>>
>> ------------------------- %< -------------------------------
>> static u64
>> set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
>> {
>>         u64 int_counter;
>>
>>         do {
>>                 int_counter = local_read(&osn_var->int_counter);
>>
>> 		------------> HERE <-------------------------------------
>>
>>                 /* synchronize with interrupts */
>>                 barrier();
>>
>>                 *time = time_get();
>>
>>                 /* synchronize with interrupts */
>>                 barrier();
>>         } while (int_counter != local_read(&osn_var->int_counter));
>>
>>         return int_counter;
>> }
>> ------------------------- >% -------------------------------
>>
>> In this way anything that happens before this *time is accounted before it is
>> get. If anything happens while this loop is running, it will run again, so it is
>> safe to point to the previous case.
>>
>> We would have to make a copy of this function, and only use the copy for the
>> run_osnoise() case. A good name would be something in the lines of
>> set_int_safe_time_rcu().
>>
>> (Unless the expensive is < than 1us.)
> 
> The outermost rcu_read_unlock() could involve a call into the scheduler
> to do an RCU priority deboost, which I would imagine could be a bit
> expensive.  But I would expect you to configure the test in such a way
> that there was no need for RCU priority boosting.  For example, by making
> sure that the osnoise process's RCU readers were never preempted.

So, the noise will not be seeing in the call that Nicolas is doing. but in the
rcu_read_unlock() inside osnoise processes?

If that is the case, then the "noise" would already be accounted to the
previously preempted thread... and we should be fine then.

> 
> Just out of curiosity, why is this running in the kernel rather than in
> userspace?  To focus only on kernel-centric noise sources?  Or are there
> people implementing real-time applications within the kernel?

It is in kernel because it allows me to sync the workload and the trace, getting
more (and more precise) information.

For example, I can read the "noise in time" and how many interrupts happened in
between two reads of the time, so I can look back in the trace to figure out
which sources of noise were the cause of the noise I am seeing - without false
positives. If no "interference" happened, I can safely say that it was a
hardware noise (this saves us time in the debug, no need to run hwlat - I run
two tools in one).

This all with a more cheap access to the data. I also use such information to
parse trace in kernel in a cheaper way, printing less info to the trace buffer.

But the idea is to see the noise for an user-space application as much as
possible (and no, I am not doing application in kernel... but I know people
doing it using a unikernel, but that is another story... a longer one... :-)).

-- Daniel

> 
> 							Thanx, Paul

