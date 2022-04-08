Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7C4F9D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiDHSwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiDHSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:52:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7531CA13B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:50:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p135so5796762iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nviX1/6p4CUWbYvt2CnKwJZCiHqpIsejd+tTLUDJVgE=;
        b=eBTekpcLXRlJQPqY+REfGlqCcPVxi/XZA3Q3WxEbTt1zsUER99ENTDo5wxgk1NCYaE
         k+eJK5U+zOCJsc3cIA1Bd0y3TL222fRA2cLUd0pw7Fz7DymFZ5bte2SQ9Ox3W+2bBhqc
         S8nN6a2mDlgmthzBC9hv5f/9jlYb2kl2yR5p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nviX1/6p4CUWbYvt2CnKwJZCiHqpIsejd+tTLUDJVgE=;
        b=XswWtPKk0syiEeDSXrYe7oOO6037+Zm6c8eO2bh1JZisE0i81k4+vJnjntHcw6HFqo
         /5y+y/0y9YQr/kaOq40gjuIbcAyDE1YgjQf3NzCKXhLF44rEWoavPAeGWClIwL44xb/t
         aqF6VGO1Y9rB3c8hdrQ08o5kuq873UrfVJZrUHbS7q8Yts+9IGOOsdBzhok4S0ArFucg
         5tcxkRcvR6oaHTNa5d+XauOeHGWKrDOWafI+AQi1Dfm8ZA6ygGLyFgLXCFeEtb+0j9Z8
         54zfqxHiDg7P+E3aM5xBaKZwSan8riU6xw2OCMHuNIkmgMwRTLHZAa+xguBUpoxt+OSw
         0rlQ==
X-Gm-Message-State: AOAM531bpfbOzEbnRCw/4R6/kqA6bvQWitqKnuQg7Sf2JqAH4jqONrre
        M7XabU2i9v548dMml1Fn3jXkWQ==
X-Google-Smtp-Source: ABdhPJwEoaSzOVNdsm4khb7IeT78P3S4EAlAqrw1X+agbnbmF5Oidu5sdBoIeHF777hmk9a1De1Y2w==
X-Received: by 2002:a6b:580d:0:b0:64d:2495:b598 with SMTP id m13-20020a6b580d000000b0064d2495b598mr2989746iob.89.1649443831599;
        Fri, 08 Apr 2022 11:50:31 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c22-20020a5ea816000000b00649d360663asm15161159ioa.40.2022.04.08.11.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:50:31 -0700 (PDT)
Subject: Re: [PATCH v1] kunit: add support for kunit_suites that reference
 init code
To:     Brendan Higgins <brendanhiggins@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        daniel.gutson@eclypsium.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jk@codeconstruct.com.au,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220311072859.2174624-1-brendanhiggins@google.com>
 <1e1472e8-1813-3903-f934-cb0ae7f09864@linuxfoundation.org>
 <CAFd5g46JiiddNxHW_jK6fjdfjGMjWsXsFuvL6H9xcZc98HWQyQ@mail.gmail.com>
 <CAKgze5bCf+v4PoS92XCDV2cD7d0iUvCvxHbPqAnLoW8pwoKbtQ@mail.gmail.com>
 <CAFd5g44nSfp=3A+VDCY6o-WzgDtnCw4NCChoXv_RKvmZc7Seog@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b5e0221c-5b64-5f60-406c-30f015e09b36@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:50:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44nSfp=3A+VDCY6o-WzgDtnCw4NCChoXv_RKvmZc7Seog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 11:34 AM, Brendan Higgins wrote:
> On Thu, Apr 7, 2022 at 5:34 PM Martin Fernandez
> <martin.fernandez@eclypsium.com> wrote:
>>
>> On 4/4/22, Brendan Higgins <brendanhiggins@google.com> wrote:
>>> On Mon, Apr 4, 2022 at 6:37 PM Shuah Khan <skhan@linuxfoundation.org>
>>> wrote:
>>>>
>>>> Hi Brendan,
>>>>
>>>> On 3/11/22 12:28 AM, Brendan Higgins wrote:
>>>>> Add support for a new kind of kunit_suite registration macro called
>>>>> kunit_test_init_suite(); this new registration macro allows the
>>>>> registration of kunit_suites that reference functions marked __init and
>>>>> data marked __initdata.
>>>>>
>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>> Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>> Reviewed-by: David Gow <davidgow@google.com>
>>>>> ---
>>>>>
>>>>
>>>> I almost applied it ...
>>>>
>>>>> This is a follow-up to the RFC here[1].
>>>>>
>>>>> This patch is in response to a KUnit user issue[2] in which the user
>>>>> was
>>>>> attempting to test some init functions; although this is a functional
>>>>> solution as long as KUnit tests only run during the init phase, we will
>>>>> need to do more work if we ever allow tests to run after the init phase
>>>>> is over; it is for this reason that this patch adds a new registration
>>>>> macro rather than simply modifying the existing macros.
>>>>>
>>>>> Changes since last version:
>>>>>    - I added more to the kunit_test_init_suites() kernel-doc comment
>>>>>      detailing "how" the modpost warnings are suppressed in addition to
>>>>>      the existing information regarding "why" it is OK for the modpost
>>>>>      warnings to be suppressed.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-kselftest/20220310210210.2124637-1-brendanhiggins@google.com/
>>>>> [2] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
>>>>>
>>>>> ---
>>>>>    include/kunit/test.h | 26 ++++++++++++++++++++++++++
>>>>>    1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>>>> index b26400731c02..7f303a06bc97 100644
>>>>> --- a/include/kunit/test.h
>>>>> +++ b/include/kunit/test.h
>>>>> @@ -379,6 +379,32 @@ static inline int kunit_run_all_tests(void)
>>>>>
>>>>>    #define kunit_test_suite(suite)     kunit_test_suites(&suite)
>>>>>
>>>>> +/**
>>>>> + * kunit_test_init_suites() - used to register one or more &struct
>>>>> kunit_suite
>>>>> + *                         containing init functions or init data.
>>>>> + *
>>>>> + * @__suites: a statically allocated list of &struct kunit_suite.
>>>>> + *
>>>>> + * This functions identically as &kunit_test_suites() except that it
>>>>> suppresses
>>>>> + * modpost warnings for referencing functions marked __init or data
>>>>> marked
>>>>> + * __initdata; this is OK because currently KUnit only runs tests upon
>>>>> boot
>>>>> + * during the init phase or upon loading a module during the init
>>>>> phase.
>>>>> + *
>>>>> + * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after
>>>>> boot, these
>>>>> + * tests must be excluded.
>>>>> + *
>>>>> + * The only thing this macro does that's different from
>>>>> kunit_test_suites is
>>>>> + * that it suffixes the array and suite declarations it makes with
>>>>> _probe;
>>>>> + * modpost suppresses warnings about referencing init data for symbols
>>>>> named in
>>>>> + * this manner.
>>>>> + */
>>>>> +#define kunit_test_init_suites(__suites...)                          \
>>>>> +     __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
>>>>> +                         CONCATENATE(__UNIQUE_ID(suites), _probe),   \
>>>>> +                         ##__suites)
>>>>> +
>>>>> +#define kunit_test_init_suite(suite) kunit_test_init_suites(&suite)
>>>>> +
>>>>>    #define kunit_suite_for_each_test_case(suite, test_case)            \
>>>>>        for (test_case = suite->test_cases; test_case->run_case;
>>>>> test_case++)
>>>>>
>>>>>
>>>>
>>>> The naming of the function and macro are rather confusing and can become
>>>> error prone. Let's find better naming scheme.
>>>
>>> Yeah, I wasn't sure about the name. I didn't have any better ideas
>>> initially though. Any suggestions?
>>>
>>
>> What about kunit_test_init_section_suite?
> 
> Sounds fine to me. Shuah, does that sound OK to you?
> 

Sorry for the delay in responding.

As long as the two names are different enough to tell them apart.
The proposed name does that.

thanks,
-- Shuah
