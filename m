Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6B4B7C87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiBPBTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:19:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiBPBTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:19:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D59F65EF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:19:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x4so782648plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n3HlZeesmoig6AzcEvE+vVMKK5hAX/6KVNpJ5JEyVT0=;
        b=HErnWS27+ufQ8NMTJ7hAU5qJQcdOuUHum0wucqqZdIejgM4oVbYBv9dz7n+S+NgHgq
         CtO+qahqEdmzfiHlS/+L5kONAoOcQPK34qrMjCSBSnx49jUEUjcTKMUvz34S8GXpgtDN
         kSy/ZGxSksJWuYJrmv6TqoBU+iq2cpEZVDn+tl89zjItgRR5iEctXMiyMS1yILvLR9m8
         jd+bmOOXRfU62lUA4RABx557Fy4+mx9gJj7tA+C/5T8asdWmskTsV8p6Xl5ZlKhz/06L
         eRAX3Do2/AiPdqaFgKNmXaI3CXIe2qtvdc3MpACpVWFSBhucZGEaASa6D8aI7/03/FOX
         Qvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3HlZeesmoig6AzcEvE+vVMKK5hAX/6KVNpJ5JEyVT0=;
        b=xX1OsGQhhzOxTZc16fAqmFrcT67A1qQxdRKZYvfORwlKPyPd7OU8GY8/ajAA4MUSFl
         Xaixc1QQE9NmCPMTt4LMnxUkdle1K4VRJ+/E8Qq8z+tbFuYw8NfE7we80otOVO7S+nii
         xINHzOlZAAkkHI9lmGELUwb2NPfI4Pm0w3TRbGYZuDURd87hNICWg9uQEZaTdITqRfow
         PoYTjapo0DqJ6uWImgIO+RUhBaL/SRS3gBbbKBMpLb4XNV6SSJbDv/pq6Qsv0WOMJlO1
         4PYmNM7sarTYn8xvK+a38iEK/MfBz46HjK+Xl6WhEKr3Pv9qV2IFdWWEJ/3lRQoLuNNt
         4Pog==
X-Gm-Message-State: AOAM532t31RDeUd3bH9rgVLm211tmX2HxvPE6EVTlCRmqKS4zpBOnZ54
        2Hy5bKEotEK/SK7gKu842NwhuU7lwtshgA==
X-Google-Smtp-Source: ABdhPJz//7pCe6QfbeIQekjYzgNrs+uHEYNqvhn8Lf50/8/fqgE551gMWzpa1CMDZA/VAoZVPMfivQ==
X-Received: by 2002:a17:902:e846:b0:14f:4580:4f23 with SMTP id t6-20020a170902e84600b0014f45804f23mr185743plg.63.1644974361125;
        Tue, 15 Feb 2022 17:19:21 -0800 (PST)
Received: from [192.168.10.24] (203-7-124-83.dyn.iinet.net.au. [203.7.124.83])
        by smtp.gmail.com with ESMTPSA id cu21sm17962188pjb.50.2022.02.15.17.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 17:19:20 -0800 (PST)
Message-ID: <8b1d0d57-0bf7-8ca5-8b08-cd5a12f7666f@ozlabs.ru>
Date:   Wed, 16 Feb 2022 12:19:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT
 configurable
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20220211014313.1790140-1-aik@ozlabs.ru>
 <20220211214722.4373ca83@rorschach.local.home>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20220211214722.4373ca83@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/22 13:47, Steven Rostedt wrote:
> On Fri, 11 Feb 2022 12:43:13 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> For whatever reason LLVM does not allow LTO (Link Time Optimization) if
>> FTRACE_MCOUNT_USE_RECORDMCOUNT is enabled.
>>
>> This allows disabling just this option instead of disabling all FTRACE
>> options.
> 
> What FTRACE options are you talking about?

LTO_CLANG_THIN => HAS_LTO_CLANG => !FTRACE_MCOUNT_USE_RECORDMCOUNT =>

FTRACE [=y] && !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [=n] && 
!FTRACE_MCOUNT_USE_CC [=n] && !FTRACE_MCOUNT_USE_OBJTOOL [=n] && 
FTRACE_MCOUNT_RECORD [=y]

A bunch.


> 
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> Or disabling FTRACE is the right thing to do if HAS_LTO_CLANG=y?
>>
>> Came from arch/Kconfig:
>>
>> config HAS_LTO_CLANG
>>          def_bool y
>>          depends on CC_IS_CLANG && LD_IS_LLD && AS_IS_LLVM
>>          depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
>>          depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
>>          depends on ARCH_SUPPORTS_LTO_CLANG
>>          depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT  <======
>>          depends on !KASAN || KASAN_HW_TAGS
>>          depends on !GCOV_KERNEL
>>
>>
>> ---
>>   kernel/trace/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>> index a5eb5e7fd624..87d82d2b0b0b 100644
>> --- a/kernel/trace/Kconfig
>> +++ b/kernel/trace/Kconfig
>> @@ -704,7 +704,8 @@ config FTRACE_MCOUNT_USE_OBJTOOL
>>   	depends on FTRACE_MCOUNT_RECORD
>>   
>>   config FTRACE_MCOUNT_USE_RECORDMCOUNT
>> -	def_bool y
>> +	bool "Enable FTRACE_MCOUNT_USE_RECORDMCOUNT"
>> +	default y
> 
> I don't think this does what you think it does.

Sounds like it.

> This is not something that should be user selectable. What exactly are
> you trying to accomplish here?

I am trying to

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b779603978e1..91c122224f83 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -153,6 +153,8 @@ config PPC
         select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
         select ARCH_WANT_LD_ORPHAN_WARN
         select ARCH_WEAK_RELEASE_ACQUIRE
+       select ARCH_SUPPORTS_LTO_CLANG          if PPC64
+       select ARCH_SUPPORTS_LTO_CLANG_THIN     if PPC64


to get LTO working on powerpc64le with minimal change to 
ppc64le_defconfig which has all these FTRACE_xxx enabled.


> 
> -- Steve
> 
> 
>>   	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>>   	depends on !FTRACE_MCOUNT_USE_CC
>>   	depends on !FTRACE_MCOUNT_USE_OBJTOOL
> 
