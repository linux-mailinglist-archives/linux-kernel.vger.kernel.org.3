Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84956B527
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiGHJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGHJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:13:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F80C05
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:13:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m2so15878074plx.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zVyRbR0DGBBDzc8e+tgqABWD25IqCK95uXaIwHTGdIY=;
        b=3805WzIbUsOPuIkyjfCss7sGKG+XrXODUnQ5Glj7CbijUmTsWwJ0CC7+aMsw+StOXi
         R1Q1U0SBWpAC4qBQ2i8caxhRsaPmsUdEw82AxZT6cJQavu0NGE4wizuEnPvDDF3kxVVb
         0LsOTC1yNIA2cvKIuhNPXFdig0/acqOpiq9SYrSxIcyLz3LhZ7sTG6R4JIJBRVo1o9iW
         q0guyEJCMvaxRsNDEtKkj8C9JjpUNXt30Kw1ObjhOziHIVGesTjnx5DsptNT+snWHnpR
         JtQnoFw2Nt/NtF1b2sjPt5XFk5qyPPVASVYK23CrzR+rAToKCvib55eVP4nGFuYX/lgu
         K8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zVyRbR0DGBBDzc8e+tgqABWD25IqCK95uXaIwHTGdIY=;
        b=cnZZDtf1wzYGEPq++M0NgRgEZQ2fPKGYjXJalRd5mcVIr7bO0G4tGWw9PACNMYJ9tp
         q5SWk40kVDxyP5Z/RELV935AS6zqDNvGpdvFcEyZIbFIs6QAjeW11LydZH59+v8kYLK1
         W3x5AwtXjKf8ymKyuQneD1s56eP/evm5tHqbNJtyhipnch080DQgrufENIzWsRIOPQxe
         t55YGRivWAXO69IYdX+gKitZvq6z5Qq+1dRaiWbGDXa8MX9ZR6H2XJgTa98dCYrwDPne
         8ymx9222E2hxEVysGtnaWujGQHAvApKNT+jPboyk0VtVCy8RkmHLkYM9CKfapVaWqXEz
         dKRA==
X-Gm-Message-State: AJIora/VOKE/lUeK9Pu7fDeW0xvQ4JDCDqowLJfHASDh2FDJajEHkUQX
        F0aMVJl4FVIJkYE8wySBSCNoDQ==
X-Google-Smtp-Source: AGRyM1uozoWf82Kr2LZHt+6GXQN0FigtKVj/tNSxFD63eCofnTFa+ROGPha0Jz5M/nBdM+si3z6CwQ==
X-Received: by 2002:a17:902:8345:b0:167:879c:abe8 with SMTP id z5-20020a170902834500b00167879cabe8mr2714707pln.7.1657271625765;
        Fri, 08 Jul 2022 02:13:45 -0700 (PDT)
Received: from [10.4.255.21] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090a008900b001ef8397571asm1054305pja.35.2022.07.08.02.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 02:13:45 -0700 (PDT)
Message-ID: <548be593-2849-a05b-7fef-66605d41bf5c@bytedance.com>
Date:   Fri, 8 Jul 2022 17:13:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-3-zhengqi.arch@bytedance.com>
 <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
 <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com>
 <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
 <33a63e76-fb71-2b9e-3b3c-cc6f7a675cf3@bytedance.com>
 <CAK8P3a1GgnmhHj+_gRYZ52=TvfBQb_xxYt1Hg-jMJ2gZqCD42w@mail.gmail.com>
 <b53dbf64-b824-89b0-dc00-b894cf9771a9@bytedance.com>
 <CAK8P3a3DDEkr0D=dLiXN+Xek_OO-HX5xWaQpzdX1GQxTYWnHLw@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a3DDEkr0D=dLiXN+Xek_OO-HX5xWaQpzdX1GQxTYWnHLw@mail.gmail.com>
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



On 2022/7/8 16:52, Arnd Bergmann wrote:
> On Fri, Jul 8, 2022 at 5:13 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2022/7/8 04:55, Arnd Bergmann wrote:
>>> On Thu, Jul 7, 2022 at 5:00 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>> On 2022/7/7 22:41, Arnd Bergmann wrote:
>>>>> On Thu, Jul 7, 2022 at 3:38 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>>>> On 2022/7/7 20:49, Arnd Bergmann wrote:
>>>>>
>>>>> -asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
>>>>> +asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
>>>>> +{
>>>>> +       if (on_thread_stack())
>>>>> +               call_on_irq_stack(regs, el1_irq);
>>>>
>>>> IMO, this can't work. Because el1_interrupt() will invoke
>>>> arm64_preempt_schedule_irq(), which will cause scheduling on the
>>>> IRQ stack.
>>>
>>> Ah, too bad. I spent some more time looking for a simpler approach,
>>> but couldn't find one I'm happy with. One idea might be to have
>>> callback functions for each combinations of irq/fiq with irq/pnmi
>>> to avoid the nested callback pointers. Not sure if that helps.
>>
>> Maybe nested callback pointers are not always a wild beast. ;)
>> This method does not change much, and we can also conveniently stuff
>> all kinds of things in do_handler() that we want to run on the IRQ
>> stack in addition to the handler().
> 
> Right, your approach is probably the one that changes the existing
> code the least. I see that x86 handles this by having call_on_irq_stack()
> in an inline asm, but this in turn complicates the asm implementation,
> which is also worth keeping simple.

Yes, and I see that the commit f2c5092190f2 ("arch/*: Disable softirq
stacks on PREEMPT_RT.") has been merged into next-20220707, so I will
rebase to the next-20220707 and send the next version.

Thank you very much :)

> 
>           Arnd

-- 
Thanks,
Qi
