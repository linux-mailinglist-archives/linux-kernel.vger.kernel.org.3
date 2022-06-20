Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466C8552418
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiFTShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiFTShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:37:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A320C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:37:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so22740950ejg.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=of2w0PHhR5hD/6CAppicreTgy2ChYJ3890K0i0D/L90=;
        b=AhKoMV70z3NzCSB1+F+SsObu+BcbBWWKtmuTyIYxFE3p2wqTmMwVm1PdTtMWLMePSm
         qyiuPrTrI0lPHoLKgy/TvLJVYlsyyRgPF3z/A60LatObwrYxbIwPuXrF/ft9ZPfBn6Cm
         UOeqtDb0X3wvWnRNJOReetdztIlG89v6Rj9aFKNP+A+57Yo3OGQ8kCWCubYxpP6g3e+i
         uZp+itWyzV7D2hnpLqPIHRHGL7ozAC/Wso3Drpep8bd0Zkg7q249yU4kJIpiIbYl6A+k
         ZiuYKRhes8yhITTgIxvBU0sp4VlBz7aQV9Fqc6fvfWXOeIlmbugBm21gLhdVnub6gyMD
         BovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=of2w0PHhR5hD/6CAppicreTgy2ChYJ3890K0i0D/L90=;
        b=n3/4SWxn2Uwhjjwy3wzT7AfzRgmfOT2lL+hxYUDqX4L1by1N1K5Nt64q9tn2pGClP6
         1H/PNLblypBJm8E8qY0YMshWyMN513kzoJk3UrrMds9PsFPvPPdwDP8QZFvOd60vE219
         1JPbBTuo10gdXTDfFszBTpE4Un/lxR/rKDRNcmEyc+NkTSI0YIWqBqNjmT26/ykaBTsM
         dN2sfcfeO98c5reILG/0Kr+Q2BsOVrMkv57rQXaxM49jWckxNGplnOG4FZKWHpr4YfsS
         TSbXzPC01Oqoei1DkJp/jtkVNwzTWLLR61yu9qdgP/FWcyUbwDu0Ce/5p3JokMYpW4/Y
         aKuQ==
X-Gm-Message-State: AJIora8AGvEj6mUSlu+at8Hf2TclKM1T0DtaKW/awcOB0PkpBBK/NOhL
        UrqJELjm/HkDMmAGox+v3Rc6TQ==
X-Google-Smtp-Source: AGRyM1ste2L5o/LjiFIQg7XGmQjRlV4SGaTh4U3FxhvhZ1Su0LsDHiOTFfl5ZybDm8CA3kqep/fvWw==
X-Received: by 2002:a17:907:1686:b0:710:6ff6:1b97 with SMTP id hc6-20020a170907168600b007106ff61b97mr22503989ejc.378.1655750268774;
        Mon, 20 Jun 2022 11:37:48 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b004357b717a96sm4369577edt.85.2022.06.20.11.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:37:48 -0700 (PDT)
Message-ID: <d4972a70-8ddf-a394-3e8f-08fb778622d8@linaro.org>
Date:   Mon, 20 Jun 2022 20:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] rpmsg: qcom: glink: replace strncpy() with
 strscpy_pad()
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>
References: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
 <640d2a3d-4c38-b921-45c1-048c255b5a9d@linaro.org>
In-Reply-To: <640d2a3d-4c38-b921-45c1-048c255b5a9d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 10:56, Krzysztof Kozlowski wrote:
> On 19/05/2022 09:33, Krzysztof Kozlowski wrote:
>> The use of strncpy() is considered deprecated for NUL-terminated
>> strings[1]. Replace strncpy() with strscpy_pad(), to keep existing
>> pad-behavior of strncpy, similarly to commit 08de420a8014 ("rpmsg:
>> glink: Replace strncpy() with strscpy_pad()").  This fixes W=1 warning:
>>
>>   In function ‘qcom_glink_rx_close’,
>>     inlined from ‘qcom_glink_work’ at ../drivers/rpmsg/qcom_glink_native.c:1638:4:
>>   drivers/rpmsg/qcom_glink_native.c:1549:17: warning: ‘strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
>>    1549 |                 strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Split series per subsystem.
> 
> Any comments on these?

I sent first iteration in May, then on 19th of May. There is review from
Stephen.

On 9th of June I pinged but the patchset is still waiting. Anyone minds
me taking these?

Best regards,
Krzysztof
