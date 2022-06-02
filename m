Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C053B2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFBE1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiFBE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:27:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625445056
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:27:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so8232284pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 21:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rJJAkVFbshCZ1KNb+eunOqGmqPeRoBTVub1Qbj3oFRY=;
        b=AvJtMzIzvj6uPnVlGWOWinJJZQjRMrC1R04t5mpQEHEroRwkP89gXqYYXM/ymVIM3W
         TgDcR5j9AQ73BFB9G6uZPMOsYzVvpczZ8naGRZpo3WGqZ2rPYzZDy7yGh9E6NiyK/+cM
         z1KlVEjleb2f8CQ4PBcqcBvURiGSKHBYzhQ9WxZEjUib5B7P5ELYID1aDKgdjmZeJyfa
         SNPqyaF693vlFtmyJnpKVzlWi5wFGGvO+/D05xNPVwxO08MJYIGOKmL5wfKjRWfdICLd
         ZDSpvkEtRIwP8+BpgsjUH5bNYKfLkXQPYrDfN7ihCJatDHpfOOeTVCP88OKlnjuU0AJi
         ZHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rJJAkVFbshCZ1KNb+eunOqGmqPeRoBTVub1Qbj3oFRY=;
        b=zfPyyXxQ0kXe3DKagUBRDB6iLgvUy0fOFZpw/JYnxoKb/PTQDxVDeTN6IWOJ+pD6om
         MUoLO7lPY2Qrhyp5x5rs6TWXe4bckPEsczJWvgUwxddQgZmV+69ZDtWGS3XbG/np/Gbx
         pJpMv66EemmmVkNlM4bPtnD/I1fSfISNfbuoC5oUFwnX9lg0WBEllJyh2c+tdttC0gOM
         vK350y8qSnOe1YutlmKJjsOXjm8/dz8AVPuGZPwK3NmMQmkeVH2UfR45a1WQydJHhACc
         xfPlm0GsiRRLaIsD+HIUjDsi4BJ9Ui3ExPlnORoE3MjdXCBNeEaV7b404ZKniJNttAKS
         Mx4w==
X-Gm-Message-State: AOAM532RD8rT6NA4ePcWGL8AZ9ATOSm4poQwSuhyg6xLMhcev6JEiM1r
        RcAztV2qmZAs7mNXzgOfz5ekURJPie2aDw==
X-Google-Smtp-Source: ABdhPJwGRUOHYEmHxnwbfy/AQp5vw7pQiRwUUU6ulDrtcILusjlXBXLw76bOO79j7bI/QIgSPXfipQ==
X-Received: by 2002:a17:90a:e7c6:b0:1e0:9cf7:d042 with SMTP id kb6-20020a17090ae7c600b001e09cf7d042mr3092718pjb.234.1654144044475;
        Wed, 01 Jun 2022 21:27:24 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001df239bab14sm2212622pjd.46.2022.06.01.21.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 21:27:23 -0700 (PDT)
Date:   Wed, 01 Jun 2022 21:27:23 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 21:27:12 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix irq_work when SMP is disabled
In-Reply-To: <11970543.O9o76ZdvQC@phil>
CC:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, samuel@sholland.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org, heiko@sntech.de
Message-ID: <mhng-75fe722b-942d-4184-89d3-1ac2ca7ba9c6@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2022 16:16:26 PDT (-0700), heiko@sntech.de wrote:
> Am Samstag, 30. April 2022, 05:00:23 CEST schrieb Samuel Holland:
>> irq_work is triggered via an IPI, but the IPI infrastructure is not
>> included in uniprocessor kernels. As a result, irq_work never runs.
>> Fall back to the tick-based irq_work implementation on uniprocessor
>> configurations.
>>
>> Fixes: 298447928bb1 ("riscv: Support irq_work via self IPIs")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>
> That uniprocessor part seems a tiny bit neglected - as I saw previously
> with alternatives not getting applied as well, so

Ya, it definately is -- and not just me missing this fix, I'd also 
dropped the CONFIG_SMP=n test from my list by accident.  Luckily it 
still boots in QEMU, so at least it's not as brokn as it could be.

>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> Though somehow I find the arm32 style a tad nicer by defining
> an is_smp() function [0] that holds the necessary checks.
>
> But I guess that is a style preference.

IIUC that's slightly different: this is a compile-time issue related to 
the IPI framework not coming up at all, not a runtime "are we on a 
uniprocessor" issue.

I put this on for-next (no fixes right now, I'm still collecting 5.19 
merge window material).

Thanks!

>
>
> Heiko
>
>
> [0] https://elixir.bootlin.com/linux/latest/source/arch/arm/include/asm/smp_plat.h#L18
>> ---
>> This was found while bringing up cpufreq on D1. Switching cpufreq
>> governors was hanging on irq_work_sync().
>>
>>  arch/riscv/include/asm/irq_work.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/irq_work.h
>> index d6c277992f76..b53891964ae0 100644
>> --- a/arch/riscv/include/asm/irq_work.h
>> +++ b/arch/riscv/include/asm/irq_work.h
>> @@ -4,7 +4,7 @@
>>
>>  static inline bool arch_irq_work_has_interrupt(void)
>>  {
>> -	return true;
>> +	return IS_ENABLED(CONFIG_SMP);
>>  }
>>  extern void arch_irq_work_raise(void);
>>  #endif /* _ASM_RISCV_IRQ_WORK_H */
>>
