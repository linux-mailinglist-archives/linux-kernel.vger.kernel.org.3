Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1842A4B63F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiBOHGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:06:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiBOHGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:06:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FE71C88
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:06:06 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1919E40333
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644908761;
        bh=lfDoRzzxT+Vs2+m3nbv6o1ksboXgYRy90T0RvURbiic=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZIjEWplZvWvEGleYpkAfHZFZ7Lj/w84sJ0y68pkjVA/4iL2+peyPkCzyQsxQmSklN
         AWBgDcXyyVs0nehaT3papLIXR3MCGYUzepc09aBsTLwK/TqHd6p7Us2JIIW2S0NX0B
         PHxdF24JODcmNMaoqu3kTXIS/SzsCErJSJbJalVEbwLUlzSGAb49vKM7ITKZQd9WLl
         //JfAwBRI8FX8kpzvCUFcJ9EE6I5mL/jVw668yCjPR2qwV/5jB7ro0a7k8Nqbl/BDj
         Zb0dSXtn+yo2jVW9YqTNVQsacwrU1ZZZ3c44x/hE0GlmwXHWP0ZbETfu3eZVJoOMUp
         rpnZGnJWpSSBQ==
Received: by mail-wm1-f70.google.com with SMTP id n26-20020a05600c3b9a00b0037c524e6d97so234701wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lfDoRzzxT+Vs2+m3nbv6o1ksboXgYRy90T0RvURbiic=;
        b=7x56ebK13L+7jYCF/wOB/pGaE+0s5PDeFuREwQDRWHVHbkGvjOhQXGWiTrUWCEf+un
         Fov0DTElwbJTTIW3Fip2l5p8oB1X4yfRGsQm/fw5AixJvYXV4lC/3q3Eo9WISh2ttFsg
         TbxRJWqvK/BL1SLyL3glWR62GF6GWb8sfiL8p/4vntIY5gcq0c8IEAMpqDh/Zjv1yADw
         rrg1dRg6onn3p9bLyN3Ss92oZAZ6Eq2jNvRK/PdokaLxGWkILGcZMTxySSpFiENl9bit
         XgMPanms42tvimGiNmN68089mUY6fbPsmETzFehs4ZXEWGleuV8HNolnfGsfhffDsnUD
         rZdw==
X-Gm-Message-State: AOAM531Xqr2hEHTts+PbQn2GbJNscySKzyNG2AQTHAFWOSAbDlbLhGSW
        Op0+ptz7yDfF+P7rweIi51o2q+Bj20qNB8Od4rnQFwPFF9xgdZquiENe3AbjuDivF5KW6lcYIGS
        TTd20IYlQYRJCMODdaSlOdA4ddP6ZcjGftl6fiemnLw==
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id l39-20020a05600c1d2700b0037c74bb2b4dmr1812914wms.82.1644908760567;
        Mon, 14 Feb 2022 23:06:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5mfu1idYoK+BXnawdvWeeqcggIqZHT10OM4kWqo2W0mTucjHmmEvaDjVzViFwtkkLez96bg==
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id l39-20020a05600c1d2700b0037c74bb2b4dmr1812898wms.82.1644908760391;
        Mon, 14 Feb 2022 23:06:00 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id x10sm13884905wmj.17.2022.02.14.23.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 23:05:59 -0800 (PST)
Message-ID: <9d033b4d-544e-ed14-fd5a-10370850c54f@canonical.com>
Date:   Tue, 15 Feb 2022 08:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] input: ps2-gpio: enforce and document open drain
Content-Language: en-US
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
References: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
 <20220211233137.99624-3-danilokrummrich@dk-develop.de>
 <ce5ccbbc-0419-ae3d-5ab1-f8985cb7e792@canonical.com>
 <Ygra3pOhcE18nXRj@pollux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <Ygra3pOhcE18nXRj@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 23:42, Danilo Krummrich wrote:
> On Mon, Feb 14, 2022 at 10:50:21PM +0100, Krzysztof Kozlowski wrote:
>> On 12/02/2022 00:31, Danilo Krummrich wrote:
>>> The PS/2 bus defines the data and clock line be open drain, therefore
>>> document this in the dt-binding and enforce the particular flag in the
>>> driver.
>>>
>>> Without enforcing to flag at least the clock gpio as open drain we run
>>> into the following warning:
>>>
>>> WARNING: CPU: 1 PID: 40 at drivers/gpio/gpiolib.c:3175 gpiochip_enable_irq+0x54/0x90
>>>
>>> gpiochip_enable_irq() warns on a GPIO being configured as output and
>>> using IRQ without being flagged as open drain.
>>>
>>> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
>>> ---
>>>  .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
>>>  drivers/input/serio/ps2-gpio.c                     |  9 +++++++--
>>>  2 files changed, 17 insertions(+), 6 deletions(-)
>>>
>>
>> Bindings as separate patch, please.
> Are you fine with adding this additional documentation directly to the patch
> converting the binding to a json-schema or do you prefer it to be a separate
> patch?

I propose a separate patch, so you will have two bindings patches.

Best regards,
Krzysztof
