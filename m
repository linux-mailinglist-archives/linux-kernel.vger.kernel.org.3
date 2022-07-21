Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3C57CB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiGUNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiGUNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:11:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FEF2B278
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:11:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k11so1754108wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=2GDU2IRydfXQkfqrUDMU1D/n3Z3JpQ7CUV8m7kZHOXo=;
        b=zM6uqqJD0zUpxrXvqvUJTtgzK7C8wI0w7+NobGNxJFW/oU2rftvyIufnMzzsksbQfo
         UPL6bIwDPZSX2erGUifThY2H1sG1qGDQM31W5Umj8L55JPcbgUJ+cO+aXCfAaeSJxRc3
         myUrxdjxtk9d5svXSSZra335QyPA3OCo5I+I3Hnp+g+6il7yE8imHH9KCq0lfrM3YMEg
         HRzpljYsgy8TtyJV8zSBIpAxN9W5F+b4p9vLrSp75U1Jufzo1WbGPolvsp4cUx6Pn5cD
         DsCs0sYDiem6ZuqbEt1ZrQFRxc5RhdUk5wrtjJo5b9rf5hw4s7m0p7UieJO7pPFlbwCz
         wHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2GDU2IRydfXQkfqrUDMU1D/n3Z3JpQ7CUV8m7kZHOXo=;
        b=3aKNJ9bOuTNIcsLDilH4BkJvbjPcASqX5Mza+7hSxng+L0qfTxmBdfjJypJkJ5LVmu
         xLUnBUDXSBbH7D5IVWuMoOf+HVpJJUaIuslqVycx215Tnp9z/6MCsNidggu34tr04QtS
         cA5HfKwp+ef0/N23kfbyMoijDvGnddm8779vm+WaZ+RRm6CEo7eviJb9qZ9Hh+EkTCk7
         coZSJ8Vup7+Hf2KgGSycxTTd5YIwWXgmYFq00pxM+Kr7qKKLkaRPfz0S4SzylOoK4Uc8
         aBlBoygb1Ogc/QYggLtFWhJOhjQDP2DiSpmVQf9VoKXDDDbIGBVuyUS7PrC3dgh0Wl4A
         bXgQ==
X-Gm-Message-State: AJIora897CqMtCggS2EbQLsO9DfSCCN0/wGSZmfW62VGsqsgfhDFysaE
        9bUyWT9T8I9vs1p2bmJGp/TXkg==
X-Google-Smtp-Source: AGRyM1vMWJglV7kWdNrjYZOUhLc5gsJSA6p5P1/egh9annTDsloDA+h8irZ0fOR8tFshFQMxXCNoOQ==
X-Received: by 2002:a05:6000:1d9c:b0:21e:4a6d:664d with SMTP id bk28-20020a0560001d9c00b0021e4a6d664dmr6415826wrb.673.1658409082764;
        Thu, 21 Jul 2022 06:11:22 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003a33227e49bsm1635651wms.4.2022.07.21.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:11:22 -0700 (PDT)
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
Subject: Re: [PATCH v1 2/6] dt-bindings: mediatek,mt6779-keypad: use
 unevaluatedProperties
In-Reply-To: <734ed3cf-1461-6067-e718-663ca4be47a6@linaro.org>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-2-ef9fc29dbff4@baylibre.com>
 <e1ec8511-d1dd-faa5-031f-50c4e55062cd@linaro.org>
 <874jzaj0m5.fsf@baylibre.com>
 <734ed3cf-1461-6067-e718-663ca4be47a6@linaro.org>
Date:   Thu, 21 Jul 2022 15:11:21 +0200
Message-ID: <87tu7ahapy.fsf@baylibre.com>
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

On Thu, Jul 21, 2022 at 11:16, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 21/07/2022 11:06, Mattijs Korpershoek wrote:
>> On Wed, Jul 20, 2022 at 19:14, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> 
>>> On 20/07/2022 16:48, Mattijs Korpershoek wrote:
>>>> writing-bindings.rst states:
>>>>> - If schema includes other schema (e.g. /schemas/i2c/i2c-controller.yaml) use
>>>>>   "unevaluatedProperties:false". In other cases, usually use
>>>>>   "additionalProperties:false".
>>>>
>>>> mt6779-keypad includes matrix-keymap.yaml so replace additionalProperties:false
>>>> by unevaluatedProperties:false.
>>>
>>> This is not sufficient explanation. You now allow all properties from
>>> matrix-keymap.yaml, which might be desired or might be not (e.g. they
>>> are not valid for this device). Please investigate it and mention the
>>> outcome.
>> 
>> Hi Krzysztof,
>> 
>> Thank you for your prompt review.
>> 
>> In mt6779_keypad_pdrv_probe(), we call
>> * matrix_keypad_parse_properties() which requires keypad,num-rows and keypad,num-cols.
>> * matrix_keypad_build_keymap() which uses linux,keymap
>> 
>> Therefore, all properties from matrix-keymap.yaml are
>> required by the mt6779-keypad 
> Better to mention the device, not driver.

I mixed up driver versus device (hardware). Sorry about that.

For successful key detection, the hardware (called MediaTek keypad) 
requires that we program rows/columns via the KP_SEL register.
So num-rows and num-cols are valid properties for this device.

The MediaTek keypad has a set of bits representing keys, from KEY0 to KEY77. 
These keys are organized in a 8x8 hardware matrix.
Therefore, linux,keymap is also a valid property for this device.
>
>> 
>> In v2, I will add the above justification and also add all 3 properties
>> in the "required" list.
>> 
>> Initially, I did not do this because from a dts/code perspective it seemed
>> interesting to split out SoC specific keyboard node vs board specific key configuration:
>> * [PATCH v1 5/6] arm64: dts: mediatek: mt8183: add keyboard node # SoC specific
>> * [PATCH v1 6/6] arm64: dts: mediatek: mt8183-pumpkin: add keypad support # board specific
>> 
>> What would be the recommend approach for above?
>> I see at least 2:
>> * "move the whole keyboard node into the board file (mt8183-pumpkin.dts)" even if it generates
>>   duplication between boards using the same SoC.
>> * "add a "dummy keymap,row,cols" properties in the soc node which can be overriden in board file.
>>   For example, use rows and cols = 0 which would have the driver early exit.
>> 
> SoC DTSI should have only SoC properties. The keyboard module is part of
> SoC. The keys and how it is wired to them - not.

Indeed. So the split I send in v1 is "valid", from a device(hardware)
point of view.
In that case i'll not make the properties from matrix-keymap.yaml
*required* in v2.

Thanks again for your feedback.

Mattijs

>
> Best regards,
> Krzysztof
