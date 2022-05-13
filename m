Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B16525AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354111AbiEMEqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbiEMEqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:46:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868121837;
        Thu, 12 May 2022 21:46:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g8so6691069pfh.5;
        Thu, 12 May 2022 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UqisS9BsqoN7NE34BDBHzDMr7C0u4ZczSMdixLZaL2M=;
        b=muTQcvBvEBehbwEJr5lu/dv9mmytHGQPwdeM7Srht1IfdYICOGy65uEZ+us+jM3ssd
         ecOXl7Rge/5rYF/G9hwPV7+odyOdQ3eOsXiAgQmc3Wiuf+KUtx9Bv/sLJjbBUVvoHaRp
         ZyabX56E2xjsw5y/j2whHm8wV/eh7II8pLrtPtyzVZmOcBOsFnhayjzv//oYY1tCh0qB
         3PGL2bT1VDbczlg36wKUdNPM5vJGbruEFusbgAKYKl1M9az8MEm8H9cphUh7CLcwm/6y
         /acBdG0+OFWEWdEMeOv2r7ESqwQwkAvDi7Ep094gXK4UYh7Q/3xbu628TTZyyd4m2gUl
         gkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UqisS9BsqoN7NE34BDBHzDMr7C0u4ZczSMdixLZaL2M=;
        b=6/Jvv3TFnLkKbX6yzPSXnhg43dojoypkQR/rydKpSxxefNvKhYBuyR33qMHAimvWGt
         1VfaxpQ4CtPJUKT0LzdsHKb6irAOU9eSc54lOz1Ob3Lb+hK8/2O6zMLckJVVC9oiZeeQ
         tTpLqIigaRdYIAZ9NOLLohCsrKOx0DOpHO7ClKHuAkBPKOpiCYQY7oSq322yf8AkfF/s
         fax8xn1Cj5/YdrdNH5liXFeLB2tfb5nlwpF9wpZBUPRCPsI20X+GpKXBqf5LesRyqgNO
         YfwAHwN3V8f6fJRremfYkrnPYu93GcEK2HapGTFeZUlb/94uZwIWev4BAXFs34uGEYU0
         JJqg==
X-Gm-Message-State: AOAM5310H827evGek4jKR3Hpeji0Doeup/Cr/oO+ea/eWzIH45/6aNfn
        4YzEq5X4m+XLDQ/89Iv7qeI=
X-Google-Smtp-Source: ABdhPJy7yVESTHuuca+BM0O0A+x8x4iI6xMI/IGaQEo2GLRsENn6X0wt0aMy71PdLnNQAwGqsGu9lg==
X-Received: by 2002:a63:82c6:0:b0:3ab:71d0:1a05 with SMTP id w189-20020a6382c6000000b003ab71d01a05mr2414071pgd.599.1652417178317;
        Thu, 12 May 2022 21:46:18 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b0050dc762819asm675201pfw.116.2022.05.12.21.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 21:46:18 -0700 (PDT)
Message-ID: <ccb50e50-7cbe-6452-73eb-862b9b09f0c2@gmail.com>
Date:   Fri, 13 May 2022 13:46:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
References: <20220511093554.17535-1-cw00.choi@samsung.com>
 <20220511093554.17535-3-cw00.choi@samsung.com>
 <CGME20220512223450eucas1p203b702e114dd2cd1bafcfd7d4c80b638@eucas1p2.samsung.com>
 <7ecd0d6a-cbf2-448c-92ef-2adb5184342c@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <7ecd0d6a-cbf2-448c-92ef-2adb5184342c@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 13. 07:34, Marek Szyprowski wrote:
> Hi Chanwoo,
> 
> On 11.05.2022 11:35, Chanwoo Choi wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>>
>> Many CPU architectures have caches that can scale independent of the
>> CPUs. Frequency scaling of the caches is necessary to make sure that the
>> cache is not a performance bottleneck that leads to poor performance and
>> power. The same idea applies for RAM/DDR.
>>
>> To achieve this, this patch adds support for cpu based scaling to the
>> passive governor. This is accomplished by taking the current frequency
>> of each CPU frequency domain and then adjust the frequency of the cache
>> (or any devfreq device) based on the frequency of the CPUs. It listens
>> to CPU frequency transition notifiers to keep itself up to date on the
>> current CPU frequency.
>>
>> To decide the frequency of the device, the governor does one of the
>> following:
>> * Derives the optimal devfreq device opp from required-opps property of
>>     the parent cpu opp_table.
>>
>> * Scales the device frequency in proportion to the CPU frequency. So, if
>>     the CPUs are running at their max frequency, the device runs at its
>>     max frequency. If the CPUs are running at their min frequency, the
>>     device runs at its min frequency. It is interpolated for frequencies
>>     in between.
>>
>> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>> Tested-by: Johnson Wang <johnson.wang@mediatek.com>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> [Chanwoo: Fix conflict with latest code and cleanup code]
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch landed in today's linux next-20220512 as commit 2ab415d4e4e6
> ("PM / devfreq: Add cpu based scaling support to passive governor").
> 
> It triggers the following NULL pointer dereference on Exynos based boards:
> 
> exynos-bus: new bus device registered: soc:bus-leftbus (100000 KHz ~
> 200000 KHz)
> exynos-bus: new bus device registered: soc:bus-rightbus (100000 KHz ~
> 200000 KHz)
> exynos-bus: new bus device registered: soc:bus-display (160000 KHz ~
> 200000 KHz)
> exynos-bus: new bus device registered: soc:bus-fsys (100000 KHz ~ 134000
> KHz)
> exynos-bus: new bus device registered: soc:bus-peri ( 50000 KHz ~ 100000
> KHz)
> exynos-bus: new bus device registered: soc:bus-mfc (100000 KHz ~ 200000 KHz)
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 0000003c
> [0000003c] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 3 PID: 8 Comm: kworker/u8:0 Not tainted 5.18.0-rc6-next-20220512 #5014
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: devfreq_wq devfreq_monitor
> PC is at __mutex_lock+0x48/0x948
> LR is at lock_is_held_type+0x104/0x1a4
> pc : [<c0b93098>]    lr : [<c0b8f2ec>]    psr: 60000053
> sp : f0889dc0  ip : 600000d3  fp : c1dca624
> r10: c1dca44c  r9 : 00000000  r8 : c1984104
> r7 : c1d7f000  r6 : 00000000  r5 : 00000001  r4 : 00000008
> r3 : 00000000  r2 : 00000000  r1 : 2de44000  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000404a  DAC: 00000051
> Register r0 information: NULL pointer
> Register r1 information: non-paged memory
> Register r2 information: NULL pointer
> Register r3 information: NULL pointer
> Register r4 information: non-paged memory
> Register r5 information: non-paged memory
> Register r6 information: NULL pointer
> Register r7 information: slab task_struct start c1d7f000 pointer offset 0
> Register r8 information: non-slab/vmalloc memory
> Register r9 information: NULL pointer
> Register r10 information: slab kmalloc-2k start c1dca000 pointer offset
> 1100 size 2048
> Register r11 information: slab kmalloc-2k start c1dca000 pointer offset
> 1572 size 2048
> Register r12 information: non-paged memory
> Process kworker/u8:0 (pid: 8, stack limit = 0x(ptrval))
> Stack: (0xf0889dc0 to 0xf088a000)
> ...
>    __mutex_lock from mutex_lock_nested+0x1c/0x24
>    mutex_lock_nested from devfreq_passive_notifier_call+0x24/0x90
>    devfreq_passive_notifier_call from srcu_notifier_call_chain+0x98/0x114
>    srcu_notifier_call_chain from devfreq_set_target+0x6c/0x304
>    devfreq_set_target from devfreq_update_target+0x98/0xe8
>    devfreq_update_target from devfreq_monitor+0x28/0x1c0
>    devfreq_monitor from process_one_work+0x288/0x774
>    process_one_work from worker_thread+0x44/0x504
>    worker_thread from kthread+0xf4/0x128
>    kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf0889fb0 to 0xf0889ff8)
> ...
> ---[ end trace 0000000000000000 ]---
> 
> The issue is caused by the lack of setting devfreq_passive_data->this
> pointer in devfreq_passive_register_notifier. However, after adding:
> 
> @@ -395,6 +395,9 @@ static int devfreq_passive_register_notifier(struct
> devfreq *devfreq)
>           if (!parent)
>                   return -EPROBE_DEFER;
> 
> +       if (!p_data->this)
> +               p_data->this = devfreq;
> +
>           nb->notifier_call = devfreq_passive_notifier_call;
>           return devfreq_register_notifier(parent, nb,
> DEVFREQ_TRANSITION_NOTIFIER);
>    }
> 
> the NULL pointer dereference is gone, but I see the following warnings
> on Odroid U3 board, which were not present before this patch:
> 
> devfreq soc:bus-acp: failed to update devfreq using passive governor
> devfreq soc:bus-c2c: failed to update devfreq using passive governor
> devfreq soc:bus-acp: failed to update devfreq using passive governor
> devfreq soc:bus-c2c: failed to update devfreq using passive governor

Hi Marek,

Thanks for the report. I'll fix it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
