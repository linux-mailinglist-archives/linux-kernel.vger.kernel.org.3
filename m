Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2745D58CE33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiHHTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiHHTAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:00:35 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33ED39C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:00:33 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 278IxxCq011416
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 8 Aug 2022 11:59:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 278IxxCq011416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022080501; t=1659985200;
        bh=xT4zVgVYZD2M2KKjxqc9/0tArQ9kU5/YMmYbg8guPiQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=fcVx8/9GZWVJJZB8jJQ5SSeYdgryT41UC9o/a+CYvwzhZeFyr9nrs6sws4vURRld5
         aBBZzrq76iXK6TdbWxiK3m2CPqWU+ZpFW+1K6pAg6LnQiH8dO8e9MGCZcpY40ganRT
         1Fc02rz5qygc22XiwhWIXziz+59cc53QZtDRbvMBIiQJgc4I3YE/LJOFy9zETQ75oi
         mzn6pdgeBoBsLqqNgLpDOPMlJ9/SW0jt1V5pIHJH5l9vDk8NS1VsUqPwW5SnLe7V9S
         Bm0+Aw3RmH6MN9ZxK4V25zKwdPfh8X04E9zXl+I8kEExUVxNStGUFNSdHzKcnZZEOH
         FvL4xGSduJPQA==
Message-ID: <09d75b16-841b-0eaa-eff6-66673c7c019b@zytor.com>
Date:   Mon, 8 Aug 2022 11:59:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/acrn: Improve ACRN hypercalls
To:     Dave Hansen <dave.hansen@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220804180358.32944-1-ubizjak@gmail.com>
 <91ccae0b-6135-6163-f59b-4e99624090a5@intel.com>
 <CAFULd4YRzEXL1+cvBPT1hmfq=ZLwtrexHt+vDABnA2QMiVMBpg@mail.gmail.com>
 <6c516a7c-ac97-e0b1-b056-06a17d1b7420@intel.com>
Content-Language: en-US
In-Reply-To: <6c516a7c-ac97-e0b1-b056-06a17d1b7420@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 4, 2022 12:03:56 PM PDT, Dave Hansen <dave.hansen@intel.com> 
wrote:
>On 8/4/22 11:56, Uros Bizjak wrote:
>> The %r8 is not preserved across function calls, so your statement
>> above is correct. But as long as there is no function call *between*
>> the variable definition and the assembly, the approach with the local
>> register variable works without any problems. It is even something GCC
>> itself has used in its library for years.
>
>I'm glad it's workout out for GCC.  But, the kernel is not GCC.  I
>specifically asked for the ACRN code to be the way that it is today and
>your argument is not making me reconsider it in the slightest.
>
>So, thanks for the patch, but I don't think we should apply it.

Well, this is universally used, so it isn't going to break. x86 is kind 
of unique in that it often doesn't need it, because it has predicates 
for so many of the specific registers, but even x86 needs it for 
inlining system calls in glibc, for example.

There is a way to do it right, which is to wrap the assignments (which 
don't have to be the declarations, but customarily are) and asm() 
statements in a block (e.g. an inline function, but can also just be a 
plain old statement block.)


