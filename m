Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA056A3FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiGGNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiGGNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:43:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274D2FFF0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:43:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z14so18647465pgh.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I8iO68hJz6Yfwz7R2uCfN3QtiaJzykCjLD9OoW4WaLA=;
        b=K0YSWaDf2aj8LSLW6AXBC+0ZYT8Q7zUSw+DKjWrKr2TuprS/EuA9FjkyoXMAnoCJbf
         o8VWEjiEF4FNvBGOE8SmByLi8D5+qqoHV25LguA5qk+COOoi8T5zySQgyuVMOjrid87z
         h3YtR2yWp1igmlhchyWtWzjYboXfqezyX89RtTszmdHjpRgP2wHgvZtd6AFwFlp6/plQ
         APHDUroH0NrV6d4AXwL5NLnzNJkWsYOPEOPlHK5VO0DH0HkP1xXZWppOZA5TrcWAh6BW
         r9V3RkfXof3VEcwcjU/6tH1ponl09PDzqGLvcRfx24Aw6E88UaXWsm9eEPpo58TsxrNc
         KH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I8iO68hJz6Yfwz7R2uCfN3QtiaJzykCjLD9OoW4WaLA=;
        b=P4g8NinNUuGG0OeWh4JJ6cMbOXFOmPKw2cuy4kSJNbVYb6h1BszaXxqNMTpJn29uI8
         1QMu6+rgQicyQ8zhhXMJVqFjgJda2GEFXHM5gS8YN2D5tjGi6lvljPZKAR4QbC+lA1U0
         TsBcUK9OjqwPWDDdhf4b1VIv4yAve0/wHDCm9a+tb9YzC7xhtZ9BenWmpKIBDntGcU3o
         zw9barE1cT5atVIqA6+1JXarYYHEoVsA5LP+7IwbSt+F/QB1v/+3i06a6j1I0NcvBdrN
         cEAxeP7cQP94E0IoE7sOX7Fw6pZJhZVZKlOupwwk/Ihmn5hCM6KkZCm7WImM1FXxx2mY
         Aktg==
X-Gm-Message-State: AJIora9ZiFIHzkBKsMKIF8pr+18h4U3LYIkSuoTMemz9NgjJ4sYARaB8
        NprOjk2bDhbueLoWNE0bEu0/Zg==
X-Google-Smtp-Source: AGRyM1ts6OQrEELFTByvGQUHG6vkur40IAu8he4bkhUKC+YWK8eyEqHzzt/cmPBer5uPxag2k9NT7g==
X-Received: by 2002:a17:90b:1c0d:b0:1ef:a676:8e0a with SMTP id oc13-20020a17090b1c0d00b001efa6768e0amr5241084pjb.88.1657201392364;
        Thu, 07 Jul 2022 06:43:12 -0700 (PDT)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090b0d0900b001ef8912f763sm8693482pjz.7.2022.07.07.06.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:43:09 -0700 (PDT)
Message-ID: <6802d78e-5aeb-6115-a4ec-73be78ccc577@bytedance.com>
Date:   Thu, 7 Jul 2022 21:43:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [RFC PATCH 1/2] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-2-zhengqi.arch@bytedance.com>
 <CAK8P3a0h1rFot013raf+O49pvV0JtyBX4Hwp3dt_85jzsJv3ww@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a0h1rFot013raf+O49pvV0JtyBX4Hwp3dt_85jzsJv3ww@mail.gmail.com>
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



On 2022/7/7 20:58, Arnd Bergmann wrote:
> On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Currently arm64 supports per-CPU IRQ stack, but softirqs
>> are still handled in the task context.
>>
>> Since any call to local_bh_enable() at any level in the task's
>> call stack may trigger a softirq processing run, which could
>> potentially cause a task stack overflow if the combined stack
>> footprints exceed the stack's size, let's run these softirqs
>> on the IRQ stack as well.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> I think this is the correct approach, but your patch conflicts with another
> patch I have queued up in the asm-generic tree, see
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?h=asm-generic&id=f2c5092190f21
> 
> Please adapt accordingly.

OK, will do in the next version.

> 
> Are there any architectures left that use IRQ stacks but don't
> set HAVE_SOFTIRQ_ON_OWN_STACK? If not, we could
> also consider removing the Kconfig symbol and just requiring
> it to be done this way (for non-PREEMPT_RT).

I haven't taken a close look at other architectures than x86 and arm,
but I think it's a good idea.

Thanks,
Qi

> 
>          Arnd

-- 
Thanks,
Qi
