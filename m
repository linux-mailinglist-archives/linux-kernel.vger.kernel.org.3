Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998105278BA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiEOQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiEOQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:17:24 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4CDF65
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 09:17:22 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id c12so1725277eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 09:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m+papEz+RWVYQ4erdcb0O46hSO9mcyw8EdGsK52iQDQ=;
        b=W51tJtXEwpTJ1OHl3shN+SwRTSodR/sf9c+Bb1f3Ep0oeMZz5vEwC7ZhWtQOrfa/e1
         BbcO4GwAtIiusCde8YnQdC0DcQ+ypL1wmkHiKxRVDvCaw5Cstk0rFV2Xjza0m8O1MAV3
         91/imL8gqoKl6E0Fc21GJmhvh7Whe32ha6WNUjOo8Vq3TDUjxU11qKEkOMxviKuJPSKQ
         X3Tjs8dq3RS+kCKNWRNOS1Ge5F4yN+kNGciiMUr0L3UtZxhxgR/3GA/BcRM7Qlt2NgAX
         jlXsBjS1XO9TMLJz0t1j/zLppklWrEOWDuuIg6PC9MmG06BBrKpGvfXu1ND3PR1NsCEi
         Mrfg==
X-Gm-Message-State: AOAM531XTr92C5d8ZCoXj1wqerfOCu/SsDcEbB2v3XCDYWTXLYG8j1XD
        6t1vsgsRAYnU8r8GYrYr1gk=
X-Google-Smtp-Source: ABdhPJzbk5jxfNgZbkHfRwpJoX6Viho3cdHkj4vdkUG/fHA0J7sETGUZWsM0m/qY9QFMH3Se5dSZoA==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr8842690edz.195.1652631441184;
        Sun, 15 May 2022 09:17:21 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id o23-20020a50fd97000000b0042aaaf3f41csm1171934edt.4.2022.05.15.09.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 09:17:20 -0700 (PDT)
Message-ID: <8d8061c4-2a3e-cb3a-00c9-677fa8899058@linux.com>
Date:   Sun, 15 May 2022 19:17:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
 <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
 <YnpQqBwYjlVffJk8@FVFF77S0Q05N> <202205101958.2A33DE20@keescook>
 <YnttpThLX0tgrw5i@FVFF77S0Q05N>
 <33711C66-BB24-4A75-8756-3CDDA02BC0CD@chromium.org>
 <YnzQDWTw1qdtVJMJ@FVFF77S0Q05N>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <YnzQDWTw1qdtVJMJ@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.2022 12:14, Mark Rutland wrote:
> On Wed, May 11, 2022 at 07:44:41AM -0700, Kees Cook wrote:
>>
>>
>> On May 11, 2022 1:02:45 AM PDT, Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Tue, May 10, 2022 at 08:00:38PM -0700, Kees Cook wrote:
>>>> On Tue, May 10, 2022 at 12:46:48PM +0100, Mark Rutland wrote:
>>>>> On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
>>>>>> On 27.04.2022 20:31, Mark Rutland wrote:
>>>>>>> In __stackleak_erase() we check that the `erase_low` value derived from
>>>>>>> `current->lowest_stack` is above the lowest legitimate stack pointer
>>>>>>> value, but this is already enforced by stackleak_track_stack() when
>>>>>>> recording the lowest stack value.
>>>>>>>
>>>>>>> Remove the redundant check.
>>>>>>>
>>>>>>> There should be no functional change as a result of this patch.
>>>>>>
>>>>>> Mark, I can't agree here. I think this check is important.
>>>>>> The performance profit from dropping it is less than the confidence decrease :)
>>>>>>
>>>>>> With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't
>>>>>> overwrite some wrong kernel memory, but simply clears the whole thread
>>>>>> stack, which is safe behavior.
>>>>>
>>>>> If you feel strongly about it, I can restore the check, but I struggle to
>>>>> believe that it's worthwhile. The `lowest_stack` value lives in the
>>>>> task_struct, and if you have the power to corrupt that you have the power to do
>>>>> much more interesting things.
>>>>>
>>>>> If we do restore it, I'd like to add a big fat comment explaining the
>>>>> rationale (i.e. that it only matter if someone could corrupt
>>>>> `current->lowest_stack`, as otherwise that's guarnateed to be within bounds).
>>>>
>>>> Yeah, let's restore it and add the comment. While I do agree it's likely
>>>> that such an corruption would likely mean an attacker had significant
>>>> control over kernel memory already, it is not uncommon that an attack
>>>> only has a limited index from a given address, etc. Or some manipulation
>>>> is possible via weird gadgets, etc. It's unlikely, but not impossible,
>>>> and a bounds-check for that value is cheap compared to the rest of the
>>>> work happening. :)
>>>
>>> Fair enough; I can go spin a patch restoring this. I'm somewhat unhappy with
>>> silently fixing that up, though -- IMO it'd be better to BUG() or similar in
>>> that case.
>>
>> I share your desires, and this was exactly what Alexander originally proposed, but Linus rejected it violently. :(
>> https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/
> 
> I see. :/
> 
> Thinking about this some more, if we assume someone can corrupt *some* word of
> memory, then we need to consider that instead of corrupting
> task_struct::lowest_stack, they could corrupt task_struct::stack (or x86's
> cpu_current_top_of_stack prior to this series).
> 
> With that in mind, if we detect that task_struct::lowest_stack is
> out-of-bounds, we have no idea whether it has been corrupted or the other bound
> values have been corrupted, and so we can't do the erase safely anyway.

:)

IMO, even if a kernel thread stack is moved somewhere for any weird reason, 
stackleak must erase it at the end of syscall and do its job.

> So AFAICT we must *avoid* erasing when that goes wrong. Maybe we could WARN()
> instead of BUG()?

Mark, I think security features must not go out of service.

The 'lowest_stack' value is for making stackleak faster. I believe if the 
'lowest_stack' value is invalid, stackleak must not skip its main job and should 
erase the whole kernel thread stack.

When I developed 'stackleak_erase()' I tried adding 'WARN_ON()', but it didn't 
work properly there, as I remember. Warning handling code is very complex. So I 
dropped that fragile part.

Best regards,
Alexander
