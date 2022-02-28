Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920F4C6415
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiB1Hvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiB1Hvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:51:41 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E966F87;
        Sun, 27 Feb 2022 23:51:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V5gZjsZ_1646034657;
Received: from 192.168.193.153(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5gZjsZ_1646034657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Feb 2022 15:50:58 +0800
Message-ID: <3389ef12-81c7-6aba-6c58-63e34008af0c@linux.alibaba.com>
Date:   Sun, 27 Feb 2022 23:50:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, linux@roeck-us.net,
        mhiramat@kernel.org, ojeda@kernel.org, luc.vanoostenryck@gmail.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <202202251243.1E38256F9@keescook>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <202202251243.1E38256F9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 12:58, Kees Cook wrote:
> On Thu, Feb 24, 2022 at 07:24:10PM -0800, Dan Li wrote:
>> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> 
> Thanks for the tweaks!
> 
>> ---
>> FYI:
>> This function can be used to test if the shadow call stack works:
>> //noinline void __noscs scs_test(void)
>> noinline void scs_test(void)
>> {
>>      unsigned long * lr = (unsigned long *)__builtin_frame_address(0) + 1;
>>
>>      asm volatile("str xzr, [%0]\n\t": : "r"(lr) : "x30");
>> }
> 
> Not a big deal, but just FYI, there's a lot of whitespace trailing the
> "}" above...
> 

Ah, sorry for the mistake.
>>
>> If SCS protection is enabled, this function will return normally.
>> If the function has __noscs attribute (scs disabled), it will crash due to 0
>> address access.
> 
> It would be cool to turn this into an LKDTM test... (see things like the
> CFI_FORWARD_PROTO test). I imagine this should be CFI_BACKWARD_SHADOW or
> something...
> 

OK, I'll add it in the next version.

> Also, I assume you're using real hardware to test this? It'd be nice to
> see if qemu can be convinced to run with the needed features. Whenever
> I've tried this it becomes impossibly slow. :)
> 

I also use qemu to test the patch (qemu 6.1.0 with command "-cpu max"),
and can feel the performance drop.

Maybe because my test environment only has simple busybox and ltp,
the feeling of a slow system running is not that strong for me :)

For comparison, I simply tested the difference in kernel boot time
in my test environment:
//run qemu with "-cpu cortex-a57",
[    1.254481] Run /linuxrc as init process
//run qemu with "-cpu max"
[    3.566091] Run /linuxrc as init process

>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index ccbbd31b3aae..deff5b308470 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -97,6 +97,10 @@
>>   #define KASAN_ABI_VERSION 4
>>   #endif
>>   
>> +#ifdef CONFIG_SHADOW_CALL_STACK
>> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>> +#endif
> 
> I initially wondered if we need a separate __no_sanitize(STUFF) patch to
> make the compiler-clang.h macros easier, but I see there are places
> where we do multiple ("address", "hwaddress") and have specialized
> macros, so I think this is fine. And since GCC doesn't support
> "__has_feature", I think this is the correct location for this.
> 

As in:
https://lore.kernel.org/all/26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com/

I think maybe we could use "#ifdef CONFIG_SHADOW_CALL_STACK"
instead of "#if __has_attribute(__no_sanitize_address__)" here,
then move it to `compiler_types.h`.

 From my current test results, __noscs seems to work fine in
clang compilation.

Thanks,
Dan.
