Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB1535601
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349374AbiEZWJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiEZWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:09:38 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262045F78
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:09:37 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id v15so936715edl.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xw3RyxiUC8IwZIm2AF83OhFYDlDh4DleyI0gQAqH6Io=;
        b=aJMLjbeuljgyt52llHUjqsgfEezKxcSS/PT1eG7kDRB6LaFFge0w5ePze9BURHgmoA
         yRY7Rwx0TTndXs1FdRBdi/Vc/UEwdCDX6ltuPaKcrs+P0e/YBzJ1XxFdO5UbFPQsZD8s
         wAlf6TVpXXLHnTmkoKu39BHnh/BhDoP7B3cdWr7q7vbVNOCbnPxqVWa24MMxvpKJYbf1
         ZGSBdVArk17G3mx0qbgAnfsuoP7ZNyRJcnB9WeppTTlaZVWkQMbQ7cGZr9w4Fa7nzquZ
         CkhMS4HzlJqZaIo1UQUKJNSvxu3FSIpB+yBQ0wUNK7E1/aNoxBxv0H2prnGYtGJmBy00
         HX3A==
X-Gm-Message-State: AOAM533VlvDLovWVcH6SnaEQfHkgxD9xvmEes7Uyq1cnx0CjZPkoO3kc
        yCKL+DImE1NXdz5Z5E0ZeUk=
X-Google-Smtp-Source: ABdhPJykBCe8FFgJwzx5OcXlR76vYMctVcDqWCXmIqqH4q5/ZVrNq2uJGJaFe7ockKmBcX1zFFi0jg==
X-Received: by 2002:aa7:c999:0:b0:42b:def5:86e4 with SMTP id c25-20020aa7c999000000b0042bdef586e4mr4266181edt.163.1653602975510;
        Thu, 26 May 2022 15:09:35 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b006f3ef214e16sm864957ejb.124.2022.05.26.15.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 15:09:35 -0700 (PDT)
Message-ID: <613f3d8a-6d59-18a6-7d31-e403f4e8fa0d@linux.com>
Date:   Fri, 27 May 2022 01:09:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
 <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
 <YnpQqBwYjlVffJk8@FVFF77S0Q05N> <202205101958.2A33DE20@keescook>
 <YnttpThLX0tgrw5i@FVFF77S0Q05N>
 <33711C66-BB24-4A75-8756-3CDDA02BC0CD@chromium.org>
 <YnzQDWTw1qdtVJMJ@FVFF77S0Q05N>
 <8d8061c4-2a3e-cb3a-00c9-677fa8899058@linux.com>
 <YoytaxHgqw5w1kIf@FVFF77S0Q05N>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <YoytaxHgqw5w1kIf@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2022 13:03, Mark Rutland wrote:
> On Sun, May 15, 2022 at 07:17:16PM +0300, Alexander Popov wrote:
>> On 12.05.2022 12:14, Mark Rutland wrote:
>>> On Wed, May 11, 2022 at 07:44:41AM -0700, Kees Cook wrote:
>>>>
>>>>
>>>> On May 11, 2022 1:02:45 AM PDT, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>> On Tue, May 10, 2022 at 08:00:38PM -0700, Kees Cook wrote:
>>>>>> On Tue, May 10, 2022 at 12:46:48PM +0100, Mark Rutland wrote:
>>>>>>> On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
>>>>>>>> On 27.04.2022 20:31, Mark Rutland wrote:
>>>>>>>>> In __stackleak_erase() we check that the `erase_low` value derived from
>>>>>>>>> `current->lowest_stack` is above the lowest legitimate stack pointer
>>>>>>>>> value, but this is already enforced by stackleak_track_stack() when
>>>>>>>>> recording the lowest stack value.
>>>>>>>>>
>>>>>>>>> Remove the redundant check.
>>>>>>>>>
>>>>>>>>> There should be no functional change as a result of this patch.
>>>>>>>>
>>>>>>>> Mark, I can't agree here. I think this check is important.
>>>>>>>> The performance profit from dropping it is less than the confidence decrease :)
>>>>>>>>
>>>>>>>> With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't
>>>>>>>> overwrite some wrong kernel memory, but simply clears the whole thread
>>>>>>>> stack, which is safe behavior.
>>>>>>>
>>>>>>> If you feel strongly about it, I can restore the check, but I struggle to
>>>>>>> believe that it's worthwhile. The `lowest_stack` value lives in the
>>>>>>> task_struct, and if you have the power to corrupt that you have the power to do
>>>>>>> much more interesting things.
>>>>>>>
>>>>>>> If we do restore it, I'd like to add a big fat comment explaining the
>>>>>>> rationale (i.e. that it only matter if someone could corrupt
>>>>>>> `current->lowest_stack`, as otherwise that's guarnateed to be within bounds).
>>>>>>
>>>>>> Yeah, let's restore it and add the comment. While I do agree it's likely
>>>>>> that such an corruption would likely mean an attacker had significant
>>>>>> control over kernel memory already, it is not uncommon that an attack
>>>>>> only has a limited index from a given address, etc. Or some manipulation
>>>>>> is possible via weird gadgets, etc. It's unlikely, but not impossible,
>>>>>> and a bounds-check for that value is cheap compared to the rest of the
>>>>>> work happening. :)
>>>>>
>>>>> Fair enough; I can go spin a patch restoring this. I'm somewhat unhappy with
>>>>> silently fixing that up, though -- IMO it'd be better to BUG() or similar in
>>>>> that case.
>>>>
>>>> I share your desires, and this was exactly what Alexander originally proposed, but Linus rejected it violently. :(
>>>> https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/
>>>
>>> I see. :/
>>>
>>> Thinking about this some more, if we assume someone can corrupt *some* word of
>>> memory, then we need to consider that instead of corrupting
>>> task_struct::lowest_stack, they could corrupt task_struct::stack (or x86's
>>> cpu_current_top_of_stack prior to this series).
>>>
>>> With that in mind, if we detect that task_struct::lowest_stack is
>>> out-of-bounds, we have no idea whether it has been corrupted or the other bound
>>> values have been corrupted, and so we can't do the erase safely anyway.
>>
>> :)
>>
>> IMO, even if a kernel thread stack is moved somewhere for any weird reason,
>> stackleak must erase it at the end of syscall and do its job.
> 
> I'm not talking about the stack being *moved*. I'm talking about the pointers
> to it being *corrupted* (wince we use those to determine the bounds).
> 
> The problem is that we don't have a single source of truth here that we can
> rely upon.
> 
> We're stuck between a dichotomy:
> 
> * If we assume an attacker *can* corrupt a word of memory, they can corrupt any
>    of the in-memory values we use to find the stack in the first place. If we
>    detect a mismatch we cannot know which is bad, and if the attacker can
>    corrupt the one(s) we choose to blindly trust, then they can weaponize the
>    erasing code to corrupt memory.
> 
>    That's *worse* than the info leak problem stackleak was originally trying to
>    solve.
> 
>    See below for one way we could avoid that.
> 
> * If we assume the attacker *cannot* corrupt a word of memory, then we know the
>    values must always be within bounds, and there's no need for the check.

Mark, thanks for your reply.

Yes, I agree with this.

>>> So AFAICT we must *avoid* erasing when that goes wrong. Maybe we could WARN()
>>> instead of BUG()?
>>
>> Mark, I think security features must not go out of service.
>>
>> The 'lowest_stack' value is for making stackleak faster. I believe if the
>> 'lowest_stack' value is invalid, stackleak must not skip its main job and
>> should erase the whole kernel thread stack.
> 
> My point is that the conditions which permit `lowest_stack` to become invalid
> (e.g. an attacker having an arbitrary or constrained write gadget) also permit
> all the other stack boundariy values to become invalid.
> 
> If we detect `lowest_stack` is out of bounds, we have no idea which of
> `lowest_stack` or the bounds are corrupt -- so we *cannot* safely erase: if the
> bounds are corrupt we'll corrupt arbitrary memory.
> 
> We *could* do better by always deriving the bounds from an SP value (current
> for on-stack, passed in by asm for off-stack). If we did that, we could more
> reasonably treat the bounds values as more reliable than the `lowest_stack`
> value, and with that I'd be happy with the bounds check (though I still think
> we want to make this WARN()).

I would prefer erasing anyway over WARN_ON() + skipping it.

Ok, let's simply hope that the `lowest_stack` is correct. Let's erase the stack 
without additional checks.

>> When I developed 'stackleak_erase()' I tried adding 'WARN_ON()', but it
>> didn't work properly there, as I remember. Warning handling code is very
>> complex. So I dropped that fragile part.
> 
> Do you recall any specific problem, or just that there were problems?

As I remember, the kernel was hanging without printing full warning.

> I ask because the entry code, and handling of BUG() and WARN() has changed
> quite a bit over the last couple of years. We've fixed some latent issues
> there, though IIUC this late in the exception return flow there are still some
> potential issues with the RCU/lockdep/etc context that would need to be
> saved/restored.
> 
> We need to solve some of that in general anyuway, since there are other BUG()
> and WARN() instances hidden in noinstr entry code. I'm happy to dig into that
> (time permitting).
> 
> Thanks,
> Mark.

