Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3A4C290E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiBXKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiBXKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:14:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F028B630
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:14:20 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C5C83F1BC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645697654;
        bh=R2XzFGsa+EKmA5bAQUzuu09BXbD6MYmLaXLgYZlWR5Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=H9yJlbwPbmWZN4SlZsuarVphwBuYWZnn666W0MTUW8Ls4vRUVON+EQmwheOpvqIZ2
         miNcbBzsKdlmD0ls2lMyLEcZVySRUlIzkzmaDUEtKEeObI0OKPEwuB7T5DZvlyKYzz
         G4J5sWIDhh0vhoJP7UkArbioRsNzlqwr/aEmuo7Q/wkiWEsYa9huo/0XLCosdRfC7J
         WFqjBglh7h9Dc3cWjbKEJVLB6EGudaFv//LJrwT+UmY3HNXLadp57LYjfSqm7xsiFN
         gHHVVbH0ZQ2V1W4n/sWITz8D/WflqaaWvaj8uZ9bKPlrFK+d8xAgUMsOvtjEvwGfs/
         9QZowr3GNJhVg==
Received: by mail-ej1-f72.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso978725eje.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R2XzFGsa+EKmA5bAQUzuu09BXbD6MYmLaXLgYZlWR5Y=;
        b=lHCn/VgFwKDiROFuyl00NSi/F3KuTzW+zZ7hDEbNOqASzpdZ8EttR+chGyKZH+zbyV
         1MYWrdboCWuk1cNMl8vFRg7nOLI3HY3jDpW834pfzz53wswk5IlbNoTIV/5EcG1e2vzG
         VScTOHripEc0zzl1dkFlF62f2c7MqqltZteeBqy/9MLP5PeiQ4RrOh6DkaQMXZMwMY69
         0tzXCSZYdqypTmRXX6l+iFCKcOYhv17m0yYVp17jdEI2vD1D1uTwozD5PxXJxZt6+3uQ
         lLmfWH12DD9ZNwQ+MOd2abBqMvtLP9+T8W/GakxuRf1OszU32fPMPHMJ8VYf/dzOAtYv
         0TrQ==
X-Gm-Message-State: AOAM530Iwpw6xdV7TW6et/Zhaz7fErN5QGNg2OPETbstEs6urO8LXBGt
        TlbeXCdw1EBiTBocFmQ24GiXRRe0+LjmvFEoBZ43k0nG69SMtGH2IWVE0thscmvfx3eesud+xYR
        Heg7X/qC9nBxslNFS33f4C4HJNqvfUb6dpK17W03zFQ==
X-Received: by 2002:a17:907:766a:b0:6cf:bb20:70c with SMTP id kk10-20020a170907766a00b006cfbb20070cmr1665296ejc.94.1645697653730;
        Thu, 24 Feb 2022 02:14:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/sLltZSTx8KWRJjI2K/qwIBaOPcUKmFt3AKY4TZ4EYzdTbH9CKy+iaxTYab7Mf5+E65BCKA==
X-Received: by 2002:a17:907:766a:b0:6cf:bb20:70c with SMTP id kk10-20020a170907766a00b006cfbb20070cmr1665264ejc.94.1645697653535;
        Thu, 24 Feb 2022 02:14:13 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id o10sm1117979ejj.6.2022.02.24.02.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 02:14:12 -0800 (PST)
Message-ID: <ad6e347b-a25b-5309-2a6a-8fd3faba256c@canonical.com>
Date:   Thu, 24 Feb 2022 11:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic pwm
 schema
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <3248917.W5uN0jUHDo@phil> <YhdXyBvAbdHzc4gH@google.com>
 <1817486.VeUe9BSz9F@phil>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1817486.VeUe9BSz9F@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 11:06, Heiko Stuebner wrote:
> Am Donnerstag, 24. Februar 2022, 11:02:48 CET schrieb Lee Jones:
>> On Wed, 23 Feb 2022, Heiko Stuebner wrote:
>>
>>> Hi Lee,
>>>
>>> Am Mittwoch, 23. Februar 2022, 10:16:01 CET schrieb Lee Jones:
>>>> On Mon, 14 Feb 2022, Krzysztof Kozlowski wrote:
>>>>
>>>>> Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
>>>>> the old name in bindings as deprecated.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
>>>>
>>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> what is your expectation regarding this patch?
>>>
>>> Are you planning to merge it or are you expecting this to go through
>>> some other tree?
>>>
>>> The binding-change here is backward-comaptible in that the old
>>> node-name is still in it, only marked as deprecated, so in theory
>>> this patch should be able to be applied on its own without
>>> causing defects.
>>
>> In an ideal world, it would be broken up and I would take the MFD
>> part.   Is that possible or are there dependencies?
> 
> That is also what Krzysztof had in mind - see his reply to patch4.
> Binding going through the MFD tree and soc maintainers applying
> the individual dts patches.
> 
> As written the binding change is backward compatible, so no harm.
> 
> I was just confused by the "Acked-by" and wanted to clarify how you
> see it ;-)
>

The bindings patch should not be split more, but itself can be taken
alone. DTS patches can go via SoC maintainer trees.


Best regards,
Krzysztof
