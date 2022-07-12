Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C85712A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiGLG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiGLG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:57:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DEA97485
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:57:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so10519070pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wt7MycguGN5t84A6c+lbathd4HawDHnJrnlkQhSwpe0=;
        b=CzwBC2T4Mqa2pzDTBcG633rO5N28nYTPP7bGlbVQV9ojiSG47PESlVsJEsYM6TYa5S
         SCa0CD0atvUVv83Wz8vaUOz3hOwmRj39syMiymUzTjpC3L2X8BvaEEfVIEN4iWoYp7nM
         nldD0Ks1sWeY09r68fIA5kMFBY+7HlaXGr+oEm+N41dA57mAoeUHiBpwotaR1W39JhUG
         oqtRj1a0Jen39VzVZ06wqBa0sj9UEfZI100tVi0NAH1QzwCGP94mzFRTIOJBf9N/jp7K
         999o1bKP8bC0uiCKD8z6aaMFLWRN8BseIEotNtKY+069sZtPalh3fH8RHq1wxFEIsfYb
         crUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wt7MycguGN5t84A6c+lbathd4HawDHnJrnlkQhSwpe0=;
        b=r5xU9SsxKAeDrnscXANntMLv4QNiyFPEUs0+XHMozlEr3PUO00rE1UiAt6RR5ci6zb
         eWQG172O96R4PGPk6tmLK5y9OvUxx1FRIeoolncJUgmoEdpTlPpkFJI9UK+kmVVJBj3L
         JKui/WqGkOzXf5m7XrFl0LYxtvmfxIpVhgWa9AK0Vpj7Ps+rX+BfVHFC6+Jy8YFHoC1D
         y6mFa6pryTwMFKuQUAasu93QMZIkIkoBZQkRxjqFBTiD36Q+a4B+y02yag1caCI1NWir
         2Vrior96Y5XXfg/XwO6B8/Z17j4EzWqxrvdJpunAb9Nl6iGr9VLZqvOWahevfk79nxzA
         10Ow==
X-Gm-Message-State: AJIora8ne6k/EsjR9ryDm3le9/cUaJ9KM8yFMY+Y9LSS5yuKl/swod20
        xcakDa+8PJA0pnlqqOtrIBN5DA==
X-Google-Smtp-Source: AGRyM1tbdv2oUxsRq8y9CVKh8tbYW++1GOJcDl6GNmh5W0CAyCZBUi4oZW4X6cLv2UUMsK0rBeIiVg==
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id n17-20020a170903111100b0016aacf4e951mr22284874plh.72.1657609075494;
        Mon, 11 Jul 2022 23:57:55 -0700 (PDT)
Received: from [10.4.225.66] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a4f0600b001ef9114eb9dsm5910565pjh.42.2022.07.11.23.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 23:57:55 -0700 (PDT)
Message-ID: <8c0e93e2-72e8-bd67-e5a4-c8e3bb888bfe@bytedance.com>
Date:   Tue, 12 Jul 2022 14:57:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v1 0/2] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
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



On 2022/7/8 17:49, Qi Zheng wrote:
> Hi all,
> 
> Currently arm64 supports per-CPU IRQ stack, but softirqs are
> still handled in the task context.
> 
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size. And we did encounter this
> situation in the real environment:
> 
> Call trace:
>   dump_backtrace+0x0/0x1cc,
>   show_stack+0x14/0x1c,
>   dump_stack+0xc4/0xfc,
>   panic+0x150/0x2c8,
>   panic+0x0/0x2c8,
>   handle_bad_stack+0x11c/0x130,
>   __bad_stack+0x88/0x8c,
>   vsnprintf+0x2c/0x524,
>   vscnprintf+0x38/0x7c,
>   scnprintf+0x6c/0x90,
>   /* ... */
>   __do_softirq+0x1e0/0x370,
>   do_softirq+0x40/0x50,
>   __local_bh_enable_ip+0x8c/0x90,
>   _raw_spin_unlock_bh+0x1c/0x24,
>   /* ... */
>   process_one_work+0x1dc/0x3e4,
>   worker_thread+0x260/0x360,
>   kthread+0x118/0x128,
>   ret_from_fork+0x10/0x18,
> 
> So let's run these softirqs on the IRQ stack as well.
> 
> This series is based on next-20220707.
> 
> Comments and suggestions are welcome.
> 
> Thanks,
> Qi
> 
> RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/
> 
> Changelog in RFC -> v1:
>   - fix conflicts with commit f2c5092190f2 ("arch/*: Disable softirq stacks on PREEMPT_RT.")
> 
> Qi Zheng (2):
>    arm64: run softirqs on the per-CPU IRQ stack
>    arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
> 
>   arch/arm64/Kconfig                 |  2 ++
>   arch/arm64/include/asm/exception.h |  4 +++-
>   arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
>   arch/arm64/kernel/entry.S          |  6 ++++--
>   arch/arm64/kernel/irq.c            | 14 ++++++++++++++
>   5 files changed, 43 insertions(+), 13 deletions(-)
> 

Hi all,

Any other suggestions and comments for this patch set? If not, can
this patch set be merged into some trees for testing? :)

Thanks,
Qi
