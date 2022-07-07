Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9356A691
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiGGPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGGPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:05:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC326AC3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:05:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 145so19006072pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Le4AocDuW7VdQISs6Wd4Al83WpJ581AYhtnychAKbhI=;
        b=GdY1GcMwpWH+ETieCrzFKA7KDi5SkWAc/vhSYHQTIaUfYCto4lOdplCE/XYwm3PBfP
         IdDgsYubOWdtH7e/jae2R7LqSISla4wuA7X21LfHa0wrrIS/tKCiYmfWV5r6S97FO4sW
         IVTJf18uefSG/mLQHHL1v6LgMR9U9YPdajkI9YlD9rpJ9Gi5bplVPO/0wZBGLNpSafSP
         o5iL4rDHEcvWjVdRXZLMoJtL5OrSaVPC3tAm8GT/ITGxL/wUHeEhSl3/4HuFu4EtWA/8
         5MKUmUUk7VTHqjlHvwkQmUVEMcohIac8sfZnVflInFZ+HiPUWfJInfJlzuazSbfurPPP
         RYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Le4AocDuW7VdQISs6Wd4Al83WpJ581AYhtnychAKbhI=;
        b=Yz5Ql7FVt0n/Gvb8/70TcxA52gLVmdpIMBjCL5js2AxjLuOVQdwu4ejIw4NC+LtJyJ
         xzdwsnxFDtD2/ATnyjM4sDikrouaCrC4YSv4BSQ7OVBjOhhcodReq0xta1iAXnol5dAn
         QIM2A4lzEh+VmSEUeF3uPLk8LRt5wqygcd8ax4GKIrNKLgbBzBOPdyDBXLsbHXM68SiS
         7n06KqC4qiq51IIea4g6nJ6ikXCZMaF8dv+TgFNjiuN+soI+ILduN/oHFVYYA+4Cck1M
         CI9zAR2Da0/m6jC9p8wc/NRgsqx+xX/rMXOxVE2aj5ImL0oEK4+IvDhnuh/kciAEZuMS
         ly2A==
X-Gm-Message-State: AJIora8h3v+n2f6IJvy30oHeVHmloqihAJO1aL2LlHBb0qOk9kz+U2Ho
        UK1RDQnW95Rb5FyNrDeJwcNR1w==
X-Google-Smtp-Source: AGRyM1uY0mRO9OJRzfDP0AUAxaAAfJF9CNs/HhFSvvf5KV2IjYdHVA9LDJIgzZhiRel4jJkoDKpQCA==
X-Received: by 2002:a17:90a:6383:b0:1ef:c181:3777 with SMTP id f3-20020a17090a638300b001efc1813777mr5821829pjj.50.1657206333976;
        Thu, 07 Jul 2022 08:05:33 -0700 (PDT)
Received: from [10.4.255.21] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b0016be6a554b5sm8718761plw.233.2022.07.07.08.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 08:05:30 -0700 (PDT)
Message-ID: <ae96bd02-bd6b-b948-405f-973beb7f9a0d@bytedance.com>
Date:   Thu, 7 Jul 2022 23:05:21 +0800
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
 <6802d78e-5aeb-6115-a4ec-73be78ccc577@bytedance.com>
 <CAK8P3a2D1KXY_a952Aw_7hH+yzYpqQaBA5LkmkfF6EwiLUgNSA@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a2D1KXY_a952Aw_7hH+yzYpqQaBA5LkmkfF6EwiLUgNSA@mail.gmail.com>
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



On 2022/7/7 21:53, Arnd Bergmann wrote:
> On Thu, Jul 7, 2022 at 3:43 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2022/7/7 20:58, Arnd Bergmann wrote:
>>> On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>> Are there any architectures left that use IRQ stacks but don't
>>> set HAVE_SOFTIRQ_ON_OWN_STACK? If not, we could
>>> also consider removing the Kconfig symbol and just requiring
>>> it to be done this way (for non-PREEMPT_RT).
>>
>> I haven't taken a close look at other architectures than x86 and arm,
>> but I think it's a good idea.
> 
> I had another look in the meantime, and I think it's only mips and loongarch
> now that don't use HAVE_SOFTIRQ_ON_OWN_STACK. Not sure about
> arch/um/, which is a bit different from the rest.

I just glanced at arch/um/, and it's really different from the rest:

  * Unlike i386, UML doesn't receive IRQs on the normal kernel stack
  * and switch over to the IRQ stack after some preparation.

> 
>         Arnd

-- 
Thanks,
Qi
