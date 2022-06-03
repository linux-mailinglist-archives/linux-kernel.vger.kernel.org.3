Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FD53CD96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbiFCQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiFCQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:55:59 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F17515B5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 09:55:58 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id s12so9859616ejx.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 09:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MFtoHW1bgltDv8sgWfWuiBl/gfDMFhsXm0Yso4Y2E0E=;
        b=hCc35urOJAatJKdmxEUPPVZo/kEu0RWsL8d7WRhb+W8E/OkY6zC4DzocIxOwVdhvGY
         rgn7ZXCnUNz1u/M5j1XUAFhuFQEZSO2ew3PxNdqMzllc5eR66+4fm+W89Dp5Vl1qb957
         EzuM0RZQYVBOGmItX5htlFH/tAwWUclK7Jl0ffkIIP4CLc8RUtEafxDeEKK8d/JEeJNt
         k5yHT3II64kPqzgmN+dbV1QmxRx15M03W+KVR7X0wLp3FoKPglllaEZOCV68N1OCSIqP
         qxGbpRdms40CIjsa6D+QirAGsw7sxJkeVdttfTHZpWZhTBocmfnZzCxvbIhPU7eAY88p
         +lJQ==
X-Gm-Message-State: AOAM5313w7MGf2DOn7SajTJgN7mWLa5nmpyX2C38JJy020NSSmeZVXY1
        EIAez4/xZD+mMPblIZ66c5o=
X-Google-Smtp-Source: ABdhPJyU0Bn1azYIg4Wh8a0Ih9Tg14FzbYzn/WtcAWiOnfAYhx7sfTIOSRq4gMbRe33lX07ahgPewA==
X-Received: by 2002:a17:907:1689:b0:6fe:fcf4:128e with SMTP id hc9-20020a170907168900b006fefcf4128emr9746715ejc.446.1654275356418;
        Fri, 03 Jun 2022 09:55:56 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id lt9-20020a170906fa8900b006fec56a80a8sm2983714ejb.115.2022.06.03.09.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 09:55:55 -0700 (PDT)
Message-ID: <58e7e80d-204e-be39-2033-f02c59e122d1@linux.com>
Date:   Fri, 3 Jun 2022 19:55:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 07/13] stackleak: rework poison scanning
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-8-mark.rutland@arm.com>
 <268ea8f7-472b-f1d4-6b8b-0c8fefccc0fa@linux.com>
 <YnplFtdEr8dBOvZU@FVFF77S0Q05N>
 <02e40030-52a5-f23c-85be-be59a7d3211c@linux.com>
 <YozeTA/69F7rYvVi@FVFF77S0Q05N>
 <73e3a82b-fbf6-5448-56ba-adda130230d3@linux.com>
 <202205311108.40D216E6@keescook>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <202205311108.40D216E6@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2022 21:13, Kees Cook wrote:
> On Fri, May 27, 2022 at 02:25:12AM +0300, Alexander Popov wrote:
>> On 24.05.2022 16:31, Mark Rutland wrote:
>>> [...]
>>> It's also worth noting that `noinstr` code will also not be instrumented
>>> regardless of frame size -- we might want some build-time assertion for those.
>>
>> I developed a trick that shows noinstr functions that stackleak would like to instrument:
>>
>> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
>> index 42f0252ee2a4..6db748d44957 100644
>> --- a/scripts/gcc-plugins/stackleak_plugin.c
>> +++ b/scripts/gcc-plugins/stackleak_plugin.c
>> @@ -397,6 +397,9 @@ static unsigned int stackleak_cleanup_execute(void)
>>   	const char *fn = DECL_NAME_POINTER(current_function_decl);
>>   	bool removed = false;
>>
>> +	if (verbose)
>> +		fprintf(stderr, "stackleak: I see noinstr function %s()\n", fn);
>> +
>>   	/*
>>   	 * Leave stack tracking in functions that call alloca().
>>   	 * Additional case:
>> @@ -464,12 +467,12 @@ static bool stackleak_gate(void)
>>   		if (STRING_EQUAL(section, ".meminit.text"))
>>   			return false;
>>   		if (STRING_EQUAL(section, ".noinstr.text"))
>> -			return false;
>> +			return true;
>>   		if (STRING_EQUAL(section, ".entry.text"))
>>   			return false;
>>   	}
>>
>> -	return track_frame_size >= 0;
>> +	return false;
>>   }
>>
>>   /* Build the function declaration for stackleak_track_stack() */
>> @@ -589,8 +592,6 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>>   				build_for_x86 = true;
>>   		} else if (!strcmp(argv[i].key, "disable")) {
>>   			disable = true;
>> -		} else if (!strcmp(argv[i].key, "verbose")) {
>> -			verbose = true;
>>   		} else {
>>   			error(G_("unknown option '-fplugin-arg-%s-%s'"),
>>   					plugin_name, argv[i].key);
>> @@ -598,6 +599,8 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>>   		}
>>   	}
>>
>> +	verbose = true;
>> +
>>   	if (disable) {
>>   		if (verbose)
>>   			fprintf(stderr, "stackleak: disabled for this translation unit\n");
>>
>>
>> Building defconfig for x86_64 gives this:
>>
>> stackleak: I see noinstr function __do_fast_syscall_32()
>> stackleak: instrument __do_fast_syscall_32(): calls_alloca
>> --
>> stackleak: I see noinstr function do_syscall_64()
>> stackleak: instrument do_syscall_64(): calls_alloca
>> --
>> stackleak: I see noinstr function do_int80_syscall_32()
>> stackleak: instrument do_int80_syscall_32(): calls_alloca
> 
> As you say, these are from RANDOMIZE_KSTACK_OFFSET, and are around
> bounds-checked, and should already be getting wiped since these will
> call into deeper (non-noinst) functions.

Kees, it crossed my mind that for correct stack erasing the kernel with 
RANDOMIZE_KSTACK_OFFSET needs at least one stackleak_track_stack() call during 
the syscall handling.

Otherwise current->lowest_stack would point to the stack address where no stack 
frame was placed because of alloca with random size.

Am I right?

How about calling stackleak_track_stack() explicitly after the kernel stack 
randomization?


>> stackleak: I see noinstr function do_machine_check()
>> stackleak: instrument do_machine_check()
>> --
>> stackleak: I see noinstr function exc_general_protection()
>> stackleak: instrument exc_general_protection()
>> --
>> stackleak: I see noinstr function fixup_bad_iret()
>> stackleak: instrument fixup_bad_iret()
>>
>>
>> The cases with calls_alloca are caused by CONFIG_RANDOMIZE_KSTACK_OFFSET=y.
>> Kees knows about that peculiarity.
>>
>> Other cases are noinstr functions with large stack frame:
>> do_machine_check(), exc_general_protection(), and fixup_bad_iret().
>>
>> I think adding a build-time assertion is not possible, since it would break
>> building the kernel.
> 
> Do these functions share the syscall behavior of always calling into
> non-noinst functions that _do_ have stack depth instrumentation?

This is a right question.

I can't say for sure, but it looks like do_machine_check(), 
exc_general_protection() and fixup_bad_iret() do some low-level exception/trap 
handling and don't affect syscall handling. Do you agree?

>> [...]
>>> In security/Kconfig.hardening we have:
>>>
>>> | config STACKLEAK_TRACK_MIN_SIZE
>>> |         int "Minimum stack frame size of functions tracked by STACKLEAK"
>>> |         default 100
>>> |         range 0 4096
>>> |         depends on GCC_PLUGIN_STACKLEAK
>>> |         help
>>> |           The STACKLEAK gcc plugin instruments the kernel code for tracking
>>> |           the lowest border of the kernel stack (and for some other purposes).
>>> |           It inserts the stackleak_track_stack() call for the functions with
>>> |           a stack frame size greater than or equal to this parameter.
>>> |           If unsure, leave the default value 100.
>>>
>>> ... where the vast majority of that range is going to lead to a BUILD_BUG().
>>
>> Honestly, I don't like the idea of having the STACKLEAK_TRACK_MIN_SIZE option in the Kconfig.
>>
>> I was forced by the maintainers to introduce it when I was working on the stackleak patchset.
>>
>> How about dropping CONFIG_STACKLEAK_TRACK_MIN_SIZE from Kconfig?
>>
>> That would also allow to drop this build-time assertion.
> 
> Should this be arch-specific? (i.e. just make it a per-arch Kconfig
> default, instead of user-selectable into weird values?)

I don't think CONFIG_STACKLEAK_TRACK_MIN_SIZE is arch-specific, since 
STACKLEAK_SEARCH_DEPTH is the same for all architectures that support stackleak.

Best regards,
Alexander


