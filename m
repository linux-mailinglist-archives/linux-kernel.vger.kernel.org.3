Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD135B077D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIGOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIGOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:50:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAEA7216
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:50:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r17so1374739pgr.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zIQoxAw3LYtpSdcJU1ZkuBNR1zcTpHTeKJwNqcd7RDE=;
        b=UdYnXuiVCr3d4PjVhNSoqBbxTHTUyK1uxMwKkaO/SlqFaRTBf+4PQV2Y/2GDcLzZQn
         3M+08npigB7ShIrYDBlHC9nQvKMjGl1KztrdRHVtR5rjAYIUOYT2aphhYeD6UgheWREe
         TvUmJRK2AUCetB9QuXftIgYqpGzf2ub18iQEv92QfVMVyxo8dWHOSPcFr8Z2WbLkCR7S
         bL0BZ5+9iNvefqHmQah2GmV0Bw+TiL+iswTM6kdL82jBJKMH0e4RY1oA0SZzivGwzWDX
         FuvEeuqCkQvUnFMcJ0ncKB5n0U61nbb70V7uxtkCzyrisAO2KWCJdpF37i7ziM0Ir0AR
         3TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zIQoxAw3LYtpSdcJU1ZkuBNR1zcTpHTeKJwNqcd7RDE=;
        b=mnYGebiOZbLCOfeLXlq2oMlsnRoi758ZqWRWv9IDOuBMusDyWzrBuKpiQ0k+xcTvY6
         VmfZM03t8tJh0evRAnm58xAeMr+aeBb7V+i95NfBlHEry1E86tqAcmjWF0G3xV7GZ5li
         Vy1Z1Uut27ScCF52MwofaamS4Q+hzEvvSWvWkh1MEDEkktSdN7domY6PsEOiE2I5hK0p
         En/Va/FA38PlIjOP29tGlWPB4nvoNfcpvJPT2p+03QcaDREgyYdjgcRX71i2vg2yyzfc
         GKm15JPfaPG41USSkALynDkk8PsyXks4WZvTtnjOCzXn/pgbU0NSZc4vNQveRyZthsoK
         WJzg==
X-Gm-Message-State: ACgBeo0wUAm9R16K3a7/FOmxF+rqKNX4+f0gasgZo/AzTVgDQXC6e6HX
        cD4dpmjPU7YB/Epyc3gqAeAT2Q==
X-Google-Smtp-Source: AA6agR6+eDE1Hr4QBhrPcO7Fumnr/Y4cRvN8Zu5VMKx2mYqxve0VyzDMobOhnMERRsQXMx7yT6SQXQ==
X-Received: by 2002:a63:e70c:0:b0:42f:f103:11f4 with SMTP id b12-20020a63e70c000000b0042ff10311f4mr3564064pgi.509.1662562247916;
        Wed, 07 Sep 2022 07:50:47 -0700 (PDT)
Received: from [10.4.126.121] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a16cf00b002005fcd2cb4sm6454594pje.2.2022.09.07.07.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:50:47 -0700 (PDT)
Message-ID: <364fa8ca-80b0-a3b6-6d83-7a9c89b0ac82@bytedance.com>
Date:   Wed, 7 Sep 2022 22:50:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
 <595c912a-1503-d420-f32f-297b824decae@bytedance.com>
 <430e3e5f-d446-6307-cba0-6f859bce560f@bytedance.com>
 <20220907133426.GA30248@willie-the-truck>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220907133426.GA30248@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/7 21:34, Will Deacon wrote:
> On Wed, Sep 07, 2022 at 03:04:48PM +0800, Qi Zheng wrote:
>>
>>
>> On 2022/8/26 12:16, Qi Zheng wrote:
>>>
>>>
>>> On 2022/8/15 20:47, Qi Zheng wrote:
>>>> Currently arm64 supports per-CPU IRQ stack, but softirqs
>>>> are still handled in the task context.
>>>>
>>>> Since any call to local_bh_enable() at any level in the task's
>>>> call stack may trigger a softirq processing run, which could
>>>> potentially cause a task stack overflow if the combined stack
>>>> footprints exceed the stack's size, let's run these softirqs
>>>> on the IRQ stack as well.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>>> Acked-by: Will Deacon <will@kernel.org>
>>>> ---
>>>> v2: https://lore.kernel.org/lkml/20220802065325.39740-1-zhengqi.arch@bytedance.com/
>>>> v1: https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
>>>> RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/
>>>>
>>>> Changelog in v2 -> v3:
>>>>    - rebase onto the v6.0-rc1
>>
>> Hi Will,
>>
>> Are we good to merge this patch? Or if there is anything else I need to
>> do, please let me know. :)
> 
> I'm expecting Catalin to pick this one up for 6.1.

Oh, I see. Looking forward to this.

Thanks a lot.
Qi

> 
> Will

-- 
Thanks,
Qi
