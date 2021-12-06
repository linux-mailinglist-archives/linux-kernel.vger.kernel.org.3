Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661B246AA5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245334AbhLFV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbhLFV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:27:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B16C061746;
        Mon,  6 Dec 2021 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oa9RaeVT6AmVJMqbBJ1807zuZU72iNi/1iFGFmnEt5o=; b=dfwmZgNVdo5L2ErolDkr0O/kGd
        qaUMDkrUzVvPmITP29Xf7Qp8oAeXY11tyaSZGWqdSOSpYYB7N94HkbNqF/Bn87p0Ig9Vxszvncdpn
        1HWmbgXqxvVN/2OyAUPwXAsxbyU0yLSKe0bzNOeYk9NYfV2ouZV/LsQX3LgH5gHXWkeHD59QLYm7U
        HeKUzwH6Qxt6kEg+eqk/SJ1MOxRsGo6Fe/ikAIjxPsK+igUI6r9nj0fZnlhvzyY1nzvAvqT9K/Bkp
        umAFu6osANK8seYM+ZW0htIpmY8yo648Hj4KUH93T5EpXCrffsjaIdFQwjYJLoXtHPVOMPbbL1q6b
        WE1gv3WA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muLSz-002dmD-Vg; Mon, 06 Dec 2021 21:24:10 +0000
Message-ID: <9ff94a5f-bb7e-501a-65cf-f260ae75b506@infradead.org>
Date:   Mon, 6 Dec 2021 13:24:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Content-Language: en-US
To:     paulmck@kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <875ys9dacq.ffs@tglx> <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx> <YadU1aSE6/0yGWny@FVFF77S0Q05N> <87v9088a5q.ffs@tglx>
 <Yae9tbtZW5mjcBVt@FVFF77S0Q05N> <87ee6w83yw.ffs@tglx> <87bl2083mu.ffs@tglx>
 <1158239c-4e65-d3d9-41b3-4fedac856622@infradead.org>
 <Ya5KM05XaUBjlthn@FVFF77S0Q05N>
 <20211206175323.GB641268@paulmck-ThinkPad-P17-Gen-1>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211206175323.GB641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 09:53, Paul E. McKenney wrote:
> On Mon, Dec 06, 2021 at 05:36:51PM +0000, Mark Rutland wrote:
>> On Fri, Dec 03, 2021 at 07:48:08PM -0800, Randy Dunlap wrote:
>>> On 12/1/21 12:35, Thomas Gleixner wrote:
>>>> +Aside of that many architectures have to save register state, e.g. debug or
>>>
>>>                                                           state (e.g. debug) or
>>>
>>>> +cause registers before another exception of the same type can happen. A
>>>
>>>    ^^^^^ cannot parse (with or without the change to the previous line)
>>
>> I think the difficulty here is with "cause register"? That' a register which
>> indicates the cause of an exception, e.g.

Oh. I see. Thanks.

>> * MIPS has `cause` (coprocessor 0 register 13)
>> * arm64 / AArch64 has `ESR_ELx` (Exception Syndrome Register, ELx)
>>
>> We could probably clarify this as "exception cause registers" or "exception
>> status registers", if that helps?
> 
> Or to make it word-by-word unambiguous, "exception-cause registers"
> and "exception-status registers".

Any of those works. Or even 'cause' registers.

-- 
~Randy
