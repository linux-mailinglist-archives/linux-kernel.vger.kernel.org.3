Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2F4C0E80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiBWIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiBWIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:50:54 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A537B55B;
        Wed, 23 Feb 2022 00:50:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V5HHvjC_1645606221;
Received: from 192.168.193.152(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5HHvjC_1645606221)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 16:50:22 +0800
Message-ID: <69d351c6-a69d-6ebb-53bc-b46dfe4da08a@linux.alibaba.com>
Date:   Wed, 23 Feb 2022 00:50:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, linux@roeck-us.net,
        mhiramat@kernel.org, ojeda@kernel.org, luc.vanoostenryck@gmail.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
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



On 2/22/22 08:16, Nathan Chancellor wrote:
> On Tue, Feb 22, 2022 at 01:57:36AM -0800, Dan Li wrote:
>> Shadow call stack is available in GCC > 11.2.0, this patch makes
>> the corresponding kernel configuration available when compiling
>> the kernel with gcc.
>>   config SHADOW_CALL_STACK
>> -	bool "Clang Shadow Call Stack"
>> -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
>> +	bool "Shadow Call Stack"
>> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>>   	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>>   	help
>> -	  This option enables Clang's Shadow Call Stack, which uses a
>> +	  This option enables Clang/GCC's Shadow Call Stack, which uses a
> 
> I wonder if we want to just ditch the mention of the compiler if both
> support it?
> 

My intention is to remind users that this is a compiler feature.
But since there is also a hint in CC_HAVE_SHADOW_CALL_STACK:
+# Supported by clang >= 7.0 or GCC ...

Removing the specific compiler here also looks fine to me.
Would this look better?

"This option enables Shadow Call Stack, which uses a ..."

or maybe:

"This option enables compiler's Shadow Call Stack, which uses a ..."

>>   	  shadow stack to protect function return addresses from being
>>   	  overwritten by an attacker. More information can be found in
>>   	  Clang's documentation:
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
> Same thing here, although eventually there may be a minimum GCC version
> bump to something newer than 11.2.0, which would allow us to just drop
> CONFIG_CC_HAVE_SHADOW_CALL_STACK altogether. No strong opinion.
> 

As Guenter said, I thought maybe we could mark the minimum available
version for users :)

Thanks,
Dan.

