Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6558CE3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiHHTDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244141AbiHHTDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:03:04 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9D25ED
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:03:03 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 278Ixgc9011401
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 8 Aug 2022 11:59:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 278Ixgc9011401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022080501; t=1659985183;
        bh=AnDyp6xDzf+JDZY8vXjlTvzb+vuPwvrQlkUSK9lN8yc=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=hKK9UXjvCaPIGEdjdqyqVbMpdtZL3Y/wj/rvQw3+sVTl6bsYBJvfZj/tIFx60QpkN
         pjr1MdAkq6r5WuKttR1ITq93ESJLIK7IBkrLMR5ZeQW2gEjStBw0l2aWSlUGi+HwLZ
         WvCuu3wEw04npPeq1FmGTwDCJM2yl3n1Rj8wootmvA3Rh3fAeOHcnBb++AQI6OG0g0
         Z+kLyRWzFpRXKcetHDPrFh+OEzUzkIR4yG3WZ0CqNrDmJziS4daNchLvoGk5Cd1E9x
         KFTWzherdWm0BnvHnL/kkRwCcdJTI+e2hkbfP6N5TaY23l3uBVzxlsVWrUZSY7DDhM
         US0bTG/VUt7/A==
Message-ID: <b71d4c4a-10be-a1f5-a95c-90b36e57230a@zytor.com>
Date:   Mon, 8 Aug 2022 11:59:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Kanna Scarlet'" <knscarlet@gnuweeb.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org>
 <20220804152656.8840-2-knscarlet@gnuweeb.org> <Yuvrd2yWLnyxOVLU@zn.tnic>
 <20220804180805.9077-1-knscarlet@gnuweeb.org>
 <126271e264204581a42b079b51481740@AcuMS.aculab.com>
Content-Language: en-US
In-Reply-To: <126271e264204581a42b079b51481740@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 5, 2022 2:26:02 AM PDT, David Laight <David.Laight@ACULAB.COM> 
wrote:
>From: Kanna Scarlet
>> Sent: 04 August 2022 19:08
>> 
>> On 8/4/22 10:53 PM, Borislav Petkov wrote:
>> > Bonus points if you find out what other advantage
>> >
>> > XOR reg,reg
>> >
>> > has when it comes to clearing integer registers.
>> 
>> Hello sir Borislav,
>> 
>> Thank you for your response. I tried to find out other advantages of
>> xor reg,reg on Google and found this:
>> https://stackoverflow.com/a/33668295/7275114
>> 
>>   "xor (being a recognized zeroing idiom, unlike mov reg, 0) has some
>>   obvious and some subtle advantages:
>> 
>>   1. smaller code-size than mov reg,0. (All CPUs)
>>   2. avoids partial-register penalties for later code.
>>      (Intel P6-family and SnB-family).
>>   3. doesn't use an execution unit, saving power and freeing up
>>      execution resources. (Intel SnB-family)
>>   4. smaller uop (no immediate data) leaves room in the uop cache-line
>>      for nearby instructions to borrow if needed. (Intel SnB-family).
>>   5. doesn't use up entries in the physical register file. (Intel
>>      SnB-family (and P4) at least, possibly AMD as well since they use
>>      a similar PRF design instead of keeping register state in the ROB
>>      like Intel P6-family microarchitectures.)"
>
>You missed one, and an additional change:
>
>Use "xor %rax,%rax" instead of "xor %eax,%eax" to save
>the 'reg' prefix.
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>Registration No: 1397386 (Wales)
>
>

You mean the other way around...
