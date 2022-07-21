Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01E57CBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiGUNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGUNcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:32:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066662A68
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:32:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so2315275wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YiChl6swvjdNJt4BL7PNpumaZjt7l2oeMRF/EgqNKOU=;
        b=KJ71mRTHjcMfVwNP//9xcFCcC1OBo4d3n+D7jV0IXQn0jU0RVFvVjC+UzZNv1hTdkp
         rbmJXMz0Cu6ENMhNmXpJjh3tMTUGkoMJXCiFqjpV7/C65puZDUJoXZaTu+INoXqWSzQt
         XUc7JDuo4yVxIUSYpe+yCYeirNvHEtCeW/+w7Ke0TDXVFJCe59VOt3CvLZjPYtPna3kv
         7JRi9aSPPvzaLaeaz/Zc2688kIV6P75gNSkAQxx87aI1yH5KD+XIMBgq2Qt3RXa7Gnme
         gON1/dS8zJBUQfAmwgwfxiEkOblleELw+kE41VyCRsu+jBdKgnJqFMWPDifbHFHFV5V8
         4PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YiChl6swvjdNJt4BL7PNpumaZjt7l2oeMRF/EgqNKOU=;
        b=QRvSwRts6/T+rOiS/TJyCSK5Y3At4+X5jI/nBje1BoXJoTc7eV5ALykz+c6bGOOQ5g
         fiF7ZZeluFU3XSIpeZpeAvn7TJaEXMkIshAFn+Dpklni/g5d5GM8N1AYNdetVEI/cfDi
         L4z7M4jP+kmDZuOgbfL+DvPtGhjBU/oCrnoxjSTf0XsxT6r0Gnqo/eJn+GvkWJNrFL2N
         19h5s/TKfr4COhO0CzbYLKHEtxg52+wO/nojI8vdCvUY1MCiLM5RbL6Qn91/9b2y6Jxu
         eGsuGE5V+a3uTJNty8iky3srdDS2ORmwjgf5jzeNALZkOOO3tKkfYljGGWbW4XecKtBY
         MqpA==
X-Gm-Message-State: AJIora+hbjaa84M1vB89F7Uhh5QmN6IgtTx4agQ9OVVMy5BuU//LCsfa
        tcffIU3kR2+3SbkgH0wpVMUKKQ==
X-Google-Smtp-Source: AGRyM1sl5Re6/quP4ss/24GJdvjVTANw3tDDCmdmbHWbEAkcAXG92PF0UHBuWneayHvdT1EvhLLaHQ==
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id f8-20020a0560001a8800b0021daa97cb16mr35374955wry.97.1658410362731;
        Thu, 21 Jul 2022 06:32:42 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003a30fbde91dsm6560975wms.20.2022.07.21.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:32:42 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/6] dt-bindings: mediatek,mt6779-keypad: add
 mediatek,double-keys
In-Reply-To: <98ec7967-d007-46d7-ef54-aa41426b5f9f@linaro.org>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-3-ef9fc29dbff4@baylibre.com>
 <98ec7967-d007-46d7-ef54-aa41426b5f9f@linaro.org>
Date:   Thu, 21 Jul 2022 15:32:41 +0200
Message-ID: <87r12eh9qe.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 19:26, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 20/07/2022 16:48, Mattijs Korpershoek wrote:
>> MediaTek keypad has 2 modes of detecting key events:
>> - single key: each (row, column) can detect one key
>> - double key: each (row, column) is a group of 2 keys
>> 
>> Currently, only single key detection is supported (by default)
>> Add an optional property, mediatek,double-keys to support double
>> key detection.
>
> You focus here on driver implementation and behavior, but should rather
> focus on hardware, like - in such setup two keys are physically wired to
> one (row,column) pin.

Understood. Will reword in v2 to reflect that this is hardware
description, not a software feature.

>
>> 
>> Double key support exists to minimize cost, since it reduces the number
>> of pins required for physical keys.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> 
>> diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>> index ca8ae40a73f7..03c9555849e5 100644
>> --- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>> +++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>> @@ -49,6 +49,12 @@ properties:
>>      maximum: 256
>>      default: 16
>>  
>> +  mediatek,double-keys:
>
> Do you think there could be another MT keypad version with triple-keys?

Of all the SoC's i've worked on (MT8167, MT8183, MT8365, MT8195) I've
never seen a "triple-keys" keypad.

>
>> +    description: |
>> +      use double key matrix instead of single key
>> +      when set, each (row,column) is a group that can detect 2 keys
>> +    type: boolean
>> +
>>  required:
>>    - compatible
>>    - reg
>> 
>
>
> Best regards,
> Krzysztof
