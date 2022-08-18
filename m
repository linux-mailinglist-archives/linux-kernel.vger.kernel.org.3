Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01DD598484
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiHRNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244804AbiHRNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:41:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418CB6D70
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:40:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w15so1774278ljw.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GqdFW3oQXAaOy2vD929UNnW4uaTA9ODo4Hnd/8x5r/w=;
        b=YuQDwPUo3DIr0crrpdiKWa7aeyFVRW4wxBAAJDKYqTTesQxo3XNEB7/JwZoqafvALT
         r11HeAmBrv9QiucR0M4IVeb3YctfJRVwDqIC9CNS6ERimqwegYhqz0qJOGA9HYrl+Chs
         pMgMGU+JXY/sTK8TJF/d9B0kYD/ojMFW1HY4YWSi7r6Gg1nnPnRjComN/AVWdpqVvbZg
         ThmVGm3VmvUG0iyuk9kqhUITpc1meIymgB79yc+laAB0OzzkFVlmYjeFCHWm3vAAtixI
         FXifZNAdGxr1Fl7ab5VDZrYCbH2mwR/eSD66rBj74nccZIRCLmh0fiqVkZFlz+awnEm/
         8c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GqdFW3oQXAaOy2vD929UNnW4uaTA9ODo4Hnd/8x5r/w=;
        b=a833Gq9unSyUMmD8X5pmtR5UA/WtdRuyIcNC+/8HNEV1tQNPJRgoeYXIt1RjdjMmGZ
         puhjs8FMvmR1iwTfDMfjUjLpdA29VZO85h2GXUwH8kCxl+ikCBNFf2J+dcgSjJnVvho8
         Lz6lG3532wMsNEzy7vHYM5ZVOm9AkQE04Y4XD7tKfWZzBXXKYN3eegamA4SL0MrMeI3K
         ICkNPx8OBL+LJdHcoGj+kinqtjY3gn0CkVIkcJ98Cw2tj996yy9RkSswiuHl/FaKyNS9
         PvMrmqdq1+ca+DtKa4455Ch1qfO/S7+c4z74XQSIeq8ams9fZbIkiSIaKo2g2V8q6jgI
         R69w==
X-Gm-Message-State: ACgBeo2dLKiMq57BQ7fO2rgo3dfePu3DWXROdB9UJA6BubAYdBkwBA+s
        6zIPTDn5Sojgdk3+aQro8HYYRA==
X-Google-Smtp-Source: AA6agR6canFiyg1kTCJm0l42OJhT+cDmUJ3ZeFSp8L6NUXKQ7yoOlW+9GVvc+6KFzATTGH1C1AljcA==
X-Received: by 2002:a05:651c:12c4:b0:25d:d71c:e249 with SMTP id 4-20020a05651c12c400b0025dd71ce249mr834770lje.17.1660830045692;
        Thu, 18 Aug 2022 06:40:45 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id k8-20020a2ea268000000b0025e53413b6dsm241886ljm.2.2022.08.18.06.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:40:45 -0700 (PDT)
Message-ID: <9947dc76-ab12-f840-3439-ca383c02c598@linaro.org>
Date:   Thu, 18 Aug 2022 16:40:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RESEND] dt-bindings: timer: Add compatible for MediaTek
 MT8188
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Johnson Wang <johnson.wang@mediatek.com>,
        daniel.lezcano@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220818124602.20394-1-johnson.wang@mediatek.com>
 <3d91fe87-feed-d083-9eeb-51293aead67a@linaro.org>
In-Reply-To: <3d91fe87-feed-d083-9eeb-51293aead67a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 15:51, Krzysztof Kozlowski wrote:
> On 18/08/2022 15:46, Johnson Wang wrote:
>> Add dt-binding documentation of timer for MediaTek MT8188 SoC
>> platform.
>>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> index f1c848af91d3..8bbb6e94508b 100644
>> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -25,6 +25,7 @@ Required properties:
>>  	For those SoCs that use SYST
>>  	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
>>  	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
>> +	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
> 
> Where is the driver change implementing this?

Or is there a generic fallback and you just added a specific one (not
visible on the diff)?

Best regards,
Krzysztof
