Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CE4C7F47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiCAAcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiCAAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:32:44 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FD56AA79;
        Mon, 28 Feb 2022 16:32:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0V5pNUKO_1646094718;
Received: from 192.168.193.153(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5pNUKO_1646094718)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Mar 2022 08:31:59 +0800
Message-ID: <bf34b523-8477-c18c-e076-e120051cb6a1@linux.alibaba.com>
Date:   Mon, 28 Feb 2022 16:31:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
 <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com>
 <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 14:35, Nick Desaulniers wrote:
> On Sun, Feb 27, 2022 at 11:37 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>>>> +#ifdef CONFIG_SHADOW_CALL_STACK
>>>> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>>>> +#endif
>>>
>>> Since both compilers have it, and I guess the `#ifdef` condition would
>>> work for both, could this be moved into `compiler_types.h` where the
>>> empty `__noscs` definition is, and remove the one from
>>> `compiler-clang.h`?
>>>
>> In the clang documentation I see __has_feature(shadow_call_stack) is
>> used to check if -fsanitize=shadow-call-stack is enabled, so I think
>> maybe it's fine to use "#ifdef CONFIG_SHADOW_CALL_STACK"
>> instead of "#if __has_attribute(__no_sanitize_address__)" here, then
>> move it to `compiler_types.h`.
> 
> Or simply add a #define for __noscs to include/linux/compiler-gcc.h
> with appropriate guard and leave the existing #ifndef in
> include/linux/compiler_types.h as is.  I'd prefer that when the
> compilers differ in terms of feature detection since it's as explicit
> as possible.
> 

To make sure I understand correctly, that means I should keep
the current patch unchanged right?

Thanks,
Dan.

