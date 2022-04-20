Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B885084A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377073AbiDTJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiDTJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:16:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964D31903
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:13:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b24so1412251edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Uy1g3jy53y3AvCDyaRKjx2hZU3M0SE1McFQysYDpJ6g=;
        b=sVkWs6/gEi/kZpvBcOC24xw0AINbon9WeAsEYcuyuHaNIyXz581JzcHqJRG24cekbH
         n+F4/pQInqVwPFVm5eIYZZWpVxUtYksPlTy0mspPAt/A0z5Cz6ahivgTHwae+iD6L3Fo
         +WFLO2XVatgUVO/VWMVAhyR8Z6rjL4/l4gD2iWFkh8QBvAT494ZQFKH93WsPGfYXcaQL
         RMjthriOviw7kDpLcnJ3etJaz36q8REMPGCnv2rD8M5I/Mq7ZmlRhfTeGmSLYmCA/UUi
         NrwJbFGr7tKubU+CcOYAVVur1ZshFunTi+5i4jGabi1zl0GRwec8nqWKhGNHCulg8J4D
         zsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uy1g3jy53y3AvCDyaRKjx2hZU3M0SE1McFQysYDpJ6g=;
        b=tSBoEA5sBKQxUPaGk12sunGToAMronr5i9V1EtaWv5/2Oshv2FXS6KMTe+omgThSL0
         Vkv0ZJTXoFzLIq620+qiaKEYPDp+uTXjwfx0FLTtioHQ1fUQFdvjtwAAeFoYSc0AsocG
         S65LMcllc2aK6LYOMnNDTR6kIXJw06sKpuj/0YfOx+GS9LbeHVBw9pPa0sjuEMBmp8md
         mpH3PFe8TMlWMLbGpmRwgm4EW8GdWoDxkpph4rJROZNKP8qhnwR9Qo/yyIkLVfdUp3xg
         xfW6/a0aht70EFNvaqh0qiko3WSNqtj6K7E1dJQVcmZzNLLHf5dSFZFX45K96vAyKzZo
         xZuw==
X-Gm-Message-State: AOAM530o2ijMLYP5E8yMj53zS6HLCSuMIxSd3w1oceQzfljtgWxhIXHx
        rgG/yLJ8S8Q1pDYvYQgraPSsNg==
X-Google-Smtp-Source: ABdhPJzhCXR47Lz6Jg8EQhQwkQMaGjny0D4OGOKqkfdnhoaDItcp9YDAdYgcnLws0h/27iquyLaUiw==
X-Received: by 2002:a05:6402:358e:b0:423:fd1c:3453 with SMTP id y14-20020a056402358e00b00423fd1c3453mr8528134edc.403.1650446033624;
        Wed, 20 Apr 2022 02:13:53 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709063a8100b006efaf54d9c1sm3189197ejd.81.2022.04.20.02.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:13:52 -0700 (PDT)
Message-ID: <70123e98-046f-f10e-1032-8d112edd3ecf@linaro.org>
Date:   Wed, 20 Apr 2022 11:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <39f69dfe-32e5-4cb3-118b-5c02b28cbcff@samsung.com>
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

On 14/04/2022 13:08, Marek Szyprowski wrote:
>> Thanks for all of the debug, super helpful. The issue is that we don't
>> handle the 'force' case, which a handful of drivers are using when
>> bringing up CPUs (and doing so before the CPUs are marked online).
>>
>> Can you please give the below hack a go?
> 
> This patch fixed the issue. Thanks! Feel free to add my:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Hi Marc,

Linux-next still fails to boot on Exynos5422 boards, so I wonder if you
applied the fix?

Instead of silent fail there is now "Unable to handle kernel paging
request at virtual address f0836644", so it is slightly different.

See the dmesg:
https://krzk.eu/#/builders/21/builds/3542/steps/15/logs/serial0


Best regards,
Krzysztof
