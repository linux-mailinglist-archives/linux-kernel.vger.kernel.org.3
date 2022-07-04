Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C120A5651AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiGDKEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiGDKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:02:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159ADE001
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:01:12 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o8ItB-0007RN-8v; Mon, 04 Jul 2022 12:01:09 +0200
Message-ID: <5735e6a8-b6a1-17f7-586f-7ac2b4f88161@leemhuis.info>
Date:   Mon, 4 Jul 2022 12:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Content-Language: en-US
To:     Vincent Donnefort <vdonnefort@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>
References: <20220523160536.2889162-1-vdonnefort@google.com>
 <87mteg3flp.ffs@tglx> <Yqc9rOIlYhywk3HT@google.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Yqc9rOIlYhywk3HT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1656928872;8d6fd4c6;
X-HE-SMSGID: 1o8ItB-0007RN-8v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.22 15:37, Vincent Donnefort wrote:
> On Mon, Jun 13, 2022 at 02:36:18PM +0200, Thomas Gleixner wrote:
>> Vincent,
>>
>> On Mon, May 23 2022 at 17:05, Vincent Donnefort wrote:
>>> +static int _cpuhp_invoke_callback_range(bool bringup,
>>> +					unsigned int cpu,
>>> +					struct cpuhp_cpu_state *st,
>>> +					enum cpuhp_state target,
>>> +					bool nofail)
>>>  {
>>>  	enum cpuhp_state state;
>>> -	int err = 0;
>>> +	int ret = 0;
>>>  
>>>  	while (cpuhp_next_state(bringup, &state, st, target)) {
>>> +		int err;
>>> +
>>>  		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
>>> -		if (err)
>>> +		if (!err)
>>> +			continue;
>>> +
>>> +		if (nofail) {
>>> +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
>>> +				cpu, bringup ? "UP" : "DOWN",
>>> +				cpuhp_get_step(st->state)->name,
>>> +				st->state, err);
>>> +			ret = -1;
>>
>> I have a hard time to map this to the changelog:
>>
>>> those sections. In that case, there's nothing the hotplug machinery can do,
>>> so let's just proceed and log the failures.
>>
>> That's still returning an error code at the end. Confused.
> 
> It is, but after returning from this function, only a warning will be raised
> (cpuhp_invoke_callback_range_nofail()) instead of stopping the HP machinery
> (cpuhp_invoke_callback_range()). How about this changelog?
> 
>   The DYING/STARTING callbacks are not expected to fail. However, as reported by
>   Derek, drivers such as tboot are still free to return errors within those
>   sections, which halts the hot(un)plug and leaves the CPU in an unrecoverable
>   state.
>   
>   No rollback being possible there, let's only log the failures and proceed
>   with the following steps. This restores the hotplug behaviour prior to
>   453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())

Vincent, what's up here? Did that patch make it further? It looks to me
like things stalled here, but maybe I'm missing something. I'm asking
because that fix was supposed to fix a regression I'm tracking.

BTW, if you respin this patch, could you please add proper 'Link:' tags
pointing to all reports about this issue? e.g. like this:

 Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867

These tags are important, as they allow others to look into the
backstory now and years from now. That is why they should be placed in
cases like this, as Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst explain in more detail.
Additionally, my regression tracking bot ‘regzbot’ relies on these tags
to automatically connect reports with patches that are posted or
committed to fix the reported issue.

Ciao, Thorsten

