Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AF508525
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbiDTJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiDTJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:45:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5221245AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:42:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z12so1540941edl.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rn9+aR7ucf5Qs0Vd1a84QfPbfL7HErKfiyJaK63fdzI=;
        b=HQMPJdFZ3OUwVe1C8+R8Cckio65mWY8zyespQRGKLt4Ijdmkr9Q9iw11Dj9T5WvO44
         bk11pWw1bC1xY0Q+vWVviNwp7oudqs3tBPXenAzz+bME6Hpp2Y+HmS0q7Q/n5FzLmI2n
         otIdN74LIBW2/29yO9B+QmQ5O8lmsWn93jyQEcP5QKwBMVgacCFYrQQTA+6BX9/t+kf6
         UhSr1g354B2s7xLot41ROfHo0jcZBbeGQh3gOYRkvhf72okwgregKJdyrIL3SCd10op6
         rPBtOJuJvjv0BRCm2BGuxckfyZpObp4ppmefkOwIYuso9bMiIwI24slexsYBdCnCwYWb
         ntUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rn9+aR7ucf5Qs0Vd1a84QfPbfL7HErKfiyJaK63fdzI=;
        b=O9rGgkYxd4wVrKjoTMoRO9lSjV+NSaAHfH9Po44h8wxxSPJBKksoqIEk51rUf6XpsW
         +IP7sISOKi7Hx41iIhC1JRflncxc6v/EQr+cORN6DRkI61zT+S5/uZMfUtMCTKonV3mK
         0MVIafDiyRjGJgxw7RvBhy9YFGeQByWBBaDvi+LqzEVdsMhV03dV0C2/MapEeEsb2IW6
         WPrVexlnO1zm6MV4V+w3ciPVyKbiHMl0EUpnxi4XX+fmQPrxEODbTyQG2D3N8G2CufY0
         gmIu6EeSmBTEq5oiK6ttiycMehvqOdpf0GhVkqQNQY3FW7BBuxM/y7p+CmaO7OgpF8Yv
         4vDA==
X-Gm-Message-State: AOAM531VLv6LsUQTEsOGTwpCwPMHBA1H3TlRQSbGQz0dBkdidt8g9fkL
        qWHLp1tefo8muT4HMa+yunV99I72M2UHKQ==
X-Google-Smtp-Source: ABdhPJyodpwb0BYmTXR0M9qTaRjek4VTZFUEQzLMObA2ycevQY/4bi69l4QL3XHp9hm3koBbFtbHZA==
X-Received: by 2002:a05:6402:2753:b0:423:3895:7031 with SMTP id z19-20020a056402275300b0042338957031mr22097598edd.170.1650447757469;
        Wed, 20 Apr 2022 02:42:37 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b006e889ee7741sm6530550ejc.75.2022.04.20.02.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:42:37 -0700 (PDT)
Message-ID: <1c3cb265-2497-537d-3c7b-ca4766775b46@linaro.org>
Date:   Wed, 20 Apr 2022 11:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
References: <20220405185040.206297-1-maz@kernel.org>
 <20220405185040.206297-3-maz@kernel.org>
 <CGME20220413145922eucas1p2dc46908354f4d2b48db79978d086a838@eucas1p2.samsung.com>
 <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
 <878rs8c2t2.wl-maz@kernel.org>
 <5dcf8d22-e9b3-f306-4c5f-256707e08fbf@samsung.com>
 <877d7sar5k.wl-maz@kernel.org>
 <39f69dfe-32e5-4cb3-118b-5c02b28cbcff@samsung.com>
 <70123e98-046f-f10e-1032-8d112edd3ecf@linaro.org>
 <87mtgg9jok.wl-maz@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87mtgg9jok.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 11:40, Marc Zyngier wrote:
> It was picked up by Thomas and pushed out into tip, which is pulled by
> -next:
> 
> maz@hot-poop:~/arm-platforms$ git describe --contains c48c8b829d2b966a6649827426bcdba082ccf922
> next-20220420~51^2~3^2
> 
> So it definitely is in today's -next.
> 
>> Instead of silent fail there is now "Unable to handle kernel paging
>> request at virtual address f0836644", so it is slightly different.
>>
>> See the dmesg:
>> https://krzk.eu/#/builders/21/builds/3542/steps/15/logs/serial0
> 
> This looks completely unrelated:
> 
> [   10.382010] Unable to handle kernel paging request at virtual address f0836644
> [   10.388597] [f0836644] *pgd=41c83811, *pte=00000000, *ppte=00000000
> [   10.394482] Internal error: Oops: 807 [#1] PREEMPT SMP ARM
> [   10.399567] Modules linked in:
> [   10.402583] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc3-next-20220420 #2
> [   10.410060] Hardware name: Samsung Exynos (Flattened Device Tree)
> [   10.416106] PC is at cpu_ca15_set_pte_ext+0x4c/0x58
> [   10.420952] LR is at handle_pte_fault+0x218/0x260
> [   10.425631] pc : [<c011d588>]    lr : [<c02ab188>]    psr: 40000113
> [   10.431874] sp : f0835df0  ip : f0835e5c  fp : 00000081
> [   10.437069] r10: c0f2eafc  r9 : c1d31000  r8 : 00000000
> [   10.442268] r7 : c1d58000  r6 : 00000081  r5 : befffff6  r4 : f0835e24
> [   10.448773] r3 : 00000000  r2 : 00000000  r1 : 00000040  r0 : f0835e44
> [   10.455273] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   10.462381] Control: 10c5387d  Table: 4000406a  DAC: 00000051
> 
> This is a crash in cpu_ca15_set_pte_ext() when populating the
> userspace page tables, which seems unrelated to interrupt affinity.
> 
> I suggest you bisect this to find the actual problem.

Thanks for checking.


Best regards,
Krzysztof
