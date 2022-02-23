Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256644C0ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiBWJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiBWJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:06:35 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39557B35;
        Wed, 23 Feb 2022 01:06:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V5I3avg_1645607161;
Received: from 192.168.193.152(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5I3avg_1645607161)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 17:06:02 +0800
Message-ID: <c30e464f-6d61-1274-3c47-d0df5d98cada@linux.alibaba.com>
Date:   Wed, 23 Feb 2022 01:06:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, samitolvanen@google.com,
        npiggin@gmail.com, linux@roeck-us.net, mhiramat@kernel.org,
        ojeda@kernel.org, luc.vanoostenryck@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUvp5RHkTlBXX3o@lakrids>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <YhUvp5RHkTlBXX3o@lakrids>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 10:47, Mark Rutland wrote:
> Hi,
> 
> On Tue, Feb 22, 2022 at 01:57:36AM -0800, Dan Li wrote:
>> Shadow call stack is available in GCC > 11.2.0, this patch makes
>> the corresponding kernel configuration available when compiling
>> the kernel with gcc.
> 
> Neat!
> 
> My local GCC devs told me that means GCC 12.x.x rather than 11.2.x or
> 11.3.x, so as others have said it'd be clearer to say `GCC >= 12.0.0`.
> 

Ah, yes, I just saw this flag in gcc/BASE-VER.

> I'd like to try this with a GCC binary before I provide an Ack or R-b;
> but in the mean time I have a few comments below.
> 

Thanks for your test, Mark.
Please let me know if there is any issues :)

>> ---
>> FYI:
>> This function can be used to test if the shadow call stack works:
>> //noinline void __noscs scs_test(void)
>> noinline void scs_test(void)
>> {
>>      register unsigned long *sp asm("sp");
>>      unsigned long * lr = sp + 1;
>>
>>      asm volatile("":::"x30");
>>      *lr = 0;
>> }
> 
> It's probably be better to use __builtin_frame_address(0) to get the
> address of the frame record rather than assuming that fp==sp in the
> middle of the function.
> 

Got it.

>>   config SHADOW_CALL_STACK
>> -	bool "Clang Shadow Call Stack"
>> -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
>> +	bool "Shadow Call Stack"
>> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>>   	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>>   	help
>> -	  This option enables Clang's Shadow Call Stack, which uses a
>> +	  This option enables Clang/GCC's Shadow Call Stack, which uses a
>>   	  shadow stack to protect function return addresses from being
>>   	  overwritten by an attacker. More information can be found in
>>   	  Clang's documentation:
> 
> Is there any additional GCC documentation that we can refer to?
> 

Currently there is only a brief description of
-fsanitize=shadow-call-stack in the user manual.

Since the description of the clang documentation is more detailed, should
I add this gcc link to the configuration description?

Link: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 09b885cc4db5..a48a604301aa 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
>>   config ARCH_HAS_FILTER_PGPROT
>>   	def_bool y
>>   
>> -# Supported by clang >= 7.0
>> +# Supported by clang >= 7.0 or GCC > 11.2.0
> 
> As above, I beleive that should be `GCC >= 12.0.0`.
> 

Yeah.

Thanks,
Dan.
