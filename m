Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3256B0DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiGHDNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiGHDNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:13:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024C74790
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:13:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m14so15293136plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TGIKBjKJBY8/kMNlD/sj4PFUQud2Ij5fYjoIm5xQg+k=;
        b=BZBSm3XKcCB5MlYwxVGxOfvNI6Wlc/jCHNo9MwhscgxXdUh5B+qLRYZoGeZdh0I75n
         HbLVl5+t8/W/X9dd1nrrb79es2fxskCmaBP5euvE/MoGTXJT7LoTjVFRJjTpzmKjzGU3
         e8YEiU4DuRNiGVyL5KknSXccjMGhFMKsjAKcvYmPffvYA/TESbFg1pKVlHlHKQMH+OiQ
         EWo+Ryn+5OWUbQKobV10qWxULOXY4hIhMjHIKtCf1JJX/ZorXN+IAhe/kXxa+PRjOtH5
         ChD9rCa564h/IsGIFizUsDDR1EfpJt+XguL7fP5O2c9Tdy+gzXIKxGBymdooTd/L14rH
         O4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TGIKBjKJBY8/kMNlD/sj4PFUQud2Ij5fYjoIm5xQg+k=;
        b=CuAuaSB2sAC0xY1dLGP9ck+1BL27coEqd7mvhq6LCHgjR5HicKWOMsKL4vFy6kWiDD
         LNRQv1mC80noeiPo0dDGc/c+H/y21zpEr9WxFg8/9ZKtFRRGVyJX1oLaOTnGD4+zPR99
         NDJVwGfJcB7d5QoeKbtRFAEdxWJStL8cGBF6+3pw7P7APJC0pICt11TxfMpdbRwkYyOn
         T6Cto7ISrd1rsqVL4XPLnMPTxIBlIzVKRRY2pnoBwRvCsB392rmhcMsqpS7FkAYyUolm
         6RPhlAvL88NmfQUuoENkXUFkDZ5Hhkv4JXcsLCuHD9JjokfR3BsJ70vbwfn3L2GfaVKO
         +iWg==
X-Gm-Message-State: AJIora+bvxLsPQOWfynfta1LUw0oMmxo61aYGrR318tUdZ0oCQH5cyRM
        H7b3YdC7PYDFhrediE8G3rqyS+fUpEmBZQ==
X-Google-Smtp-Source: AGRyM1vZH/C+rF9c8VLQlyXtH1D98ngJMfORSNnw/Yf7FcQJA7ubNUyXg3Blm2QKYyakOE+Bsy6/Bg==
X-Received: by 2002:a17:902:e84f:b0:16b:8a74:d572 with SMTP id t15-20020a170902e84f00b0016b8a74d572mr1478266plg.146.1657250027747;
        Thu, 07 Jul 2022 20:13:47 -0700 (PDT)
Received: from [10.4.255.21] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090ae4c200b001ef8a6836e3sm319394pju.55.2022.07.07.20.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 20:13:46 -0700 (PDT)
Message-ID: <b53dbf64-b824-89b0-dc00-b894cf9771a9@bytedance.com>
Date:   Fri, 8 Jul 2022 11:13:34 +0800
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a1GgnmhHj+_gRYZ52=TvfBQb_xxYt1Hg-jMJ2gZqCD42w@mail.gmail.com>
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



On 2022/7/8 04:55, Arnd Bergmann wrote:
> On Thu, Jul 7, 2022 at 5:00 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2022/7/7 22:41, Arnd Bergmann wrote:
>>> On Thu, Jul 7, 2022 at 3:38 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>> On 2022/7/7 20:49, Arnd Bergmann wrote:
>>>
>>> -asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
>>> +asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
>>> +{
>>> +       if (on_thread_stack())
>>> +               call_on_irq_stack(regs, el1_irq);
>>
>> IMO, this can't work. Because el1_interrupt() will invoke
>> arm64_preempt_schedule_irq(), which will cause scheduling on the
>> IRQ stack.
> 
> Ah, too bad. I spent some more time looking for a simpler approach,
> but couldn't find one I'm happy with. One idea might be to have
> callback functions for each combinations of irq/fiq with irq/pnmi
> to avoid the nested callback pointers. Not sure if that helps.

Maybe nested callback pointers are not always a wild beast. ;)
This method does not change much, and we can also conveniently stuff
all kinds of things in do_handler() that we want to run on the IRQ
stack in addition to the handler().

Thanks,
Qi

> 
>         Arnd

-- 
Thanks,
Qi
