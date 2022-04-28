Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9B513E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352979AbiD1WoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352944AbiD1WoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:44:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340BB8C7FD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:41:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651185663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXbnnfydFtroMbNf34p+LMQVaGaqhjbOTNCg6WDSgTo=;
        b=Jr8aBFOkezzGo3wUe/YArrBxSfTDbhAZxqyJN+hdWtYCak3cYpTU/1M17reSak2Ii7f76i
        HTdOVqMYPmCjGsSfS7jm7jG+sbxVLsWxR3uAFYB1+30WrdARXO1LwMbhuRWNnLDm2gzfYn
        rlGbZUVYwM1nJ0ZEWysUXhCQXoSU1qvPmtP199G9N2Fakf4d/qeuA/Qcs/m2BMjjmf/Yfx
        sL+rHe4dFQAUGqfAHZNwaSIKrtf8r+iKVjguaQjJ80D38oLtfXCFJgP1kpOqCNkJf46DHv
        YkoUyL2rcKEMHvwMgaI4+S3h+jw+DGFpyJGSQKlIj1yUI+77UDecXU+ayJVcBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651185663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXbnnfydFtroMbNf34p+LMQVaGaqhjbOTNCg6WDSgTo=;
        b=aIy4s3felbXbltF+ChdPl8SDAn2dEbGGbdXE5jlw5rSqbiPf4QoBcev3Wx3aboiTWNA16V
        cqbPl/EkoVRon/DA==
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "manfred@colorfullife.com" <manfred@colorfullife.com>
Subject: Re: [PATCH v3] ipc: Update semtimedop() to use hrtimer
In-Reply-To: <5FEE7AB6-7560-4998-A7A3-B60A4B32E1DE@oracle.com>
References: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
 <20220428205001.hiuzwpn5emxtrh4s@offworld> <87zgk4ooi6.ffs@tglx>
 <5FEE7AB6-7560-4998-A7A3-B60A4B32E1DE@oracle.com>
Date:   Fri, 29 Apr 2022 00:41:03 +0200
Message-ID: <87tuacomps.ffs@tglx>
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

On Thu, Apr 28 2022 at 22:23, Prakash Sangappa wrote:
>> On Apr 28, 2022, at 3:02 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, Apr 28 2022 at 13:50, Davidlohr Bueso wrote:
>>> On Thu, 28 Apr 2022, Prakash Sangappa wrote:
>>>> -		if (timeout)
>>>> -			jiffies_left = schedule_timeout(jiffies_left);
>>>> -		else
>>>> -			schedule();
>>>> +		timed_out = !schedule_hrtimeout_range(exp,
>>>> +				current->timer_slack_ns, HRTIMER_MODE_ABS);
>>> 
>>> I'm wondering if the slack parameter instead of passing the timer_slack_ns
>>> value immediately, we should do a rt_task() check and pass zero if so.
>> 
>> We should have a wrapper function which takes care of that instead of
>> having checks all over the place.
>
> Ok  it can be an inline function in sched.h which returns appropriate 
> slack time. Use that in  futex_wait() and sigtimedwait() also in addition to 
> semtimedop() & mqueue codepath?

No. What I meant is a function which handles this internally, not an inline
function which has to be invoked on various call sites.

> Should that be a separate patch?

Definitely. That's an orthogonal problem.

Thanks,

        tglx
