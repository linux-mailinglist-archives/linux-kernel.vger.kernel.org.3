Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512C44D41CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiCJH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiCJH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:28:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE5131F5B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:27:16 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A39D93F1A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646897234;
        bh=+acyt1BEYt28lv14s1mevIXPMuYm70g76NXbcp8FI4Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SaIFu3DHMD6KLPrqimQpuybhX1AUlezmi5jCG/bV0YdpuWxQrU/jzStgpq7d3Oq/p
         0fko3rPVmuchvWW0T2FTkelQUXvxhU4Tvp+APrOWg1HaKIeQb1CVHEdkWcHEx/D3UF
         JkjB9iik3SnSqvH1gPURipG3G0kL3PK5BajRIpEBwscaZwvY3NR4kfp90lzQLn6LgZ
         lq4L47LYCiXpsxOxFm/ArAf2AtyqplHDBLjPLYFPpKaUYMbbN17lYF5T4sRY+LK7rY
         vSSTZEu6NITPQS8+vwdvRZP+prXXimSjfInZm0H/PNn+3nd/5ZZd8pLTaBMdn+gwST
         OiPoKp2Nx+u2Q==
Received: by mail-ej1-f69.google.com with SMTP id l24-20020a170906a41800b006da873d66b6so2620547ejz.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+acyt1BEYt28lv14s1mevIXPMuYm70g76NXbcp8FI4Q=;
        b=mfVyiuFisyGvgVvJFPNpUWMNLECcyFMgvXia90JuHZvEUzRq/0lRkzlv07l6+peZrd
         eMHKv7xYl1+rcIYDK9vV/lRCL0BjYtsg4g4s0cFj2o9Q3o71cFx/Iog9wKP+kUuRPfhU
         EoW+Yx7bvhlyyvDoVxy6DlQ0FD0ikT2pmcpBhMuvNi2gXYauzW2EUQtW9eUEGu2T8Nvq
         7/9d/mmxs2zf8g94K5Q5K2cKda2TXEC5Y2nbJu4fyEjWuf0OAVa/zMtfxB0X1w6StVJz
         47YkmSyGlLPXXWva6gl2xEpIwoMpkY+FlgExciXyUZsquAbo7K8dP0eGSKiMAsAJVhh1
         CseQ==
X-Gm-Message-State: AOAM533NIHuh9WUT9WoFEOolZWfGUYr1lAnmYI+6E3q+SrpkeNprXk+1
        KnzL1vGTt8OqR1scWkLQyRwZBNpCfGVSgdqMnx+O4LlP8fitZzFX3e3He+nmc7Wf9sBJ5p6NBrR
        sKsiS9sYIc9mF1A7tJs5IfzLbHaUNsnXr6cBunl0EFQ==
X-Received: by 2002:a05:6402:138c:b0:413:3d99:f2d6 with SMTP id b12-20020a056402138c00b004133d99f2d6mr2952786edv.189.1646897234319;
        Wed, 09 Mar 2022 23:27:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzQuVV4dB21GEZgLzk4Y0WlFO6imhKw5gqs41AlbOenE756SkJgsXrLljtdN3cWc0hbCtd/Q==
X-Received: by 2002:a05:6402:138c:b0:413:3d99:f2d6 with SMTP id b12-20020a056402138c00b004133d99f2d6mr2952776edv.189.1646897234145;
        Wed, 09 Mar 2022 23:27:14 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id kq26-20020a170906abda00b006da87077172sm1528795ejb.29.2022.03.09.23.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 23:27:13 -0800 (PST)
Message-ID: <947f3f39-7f49-d411-8aa6-094ada825c34@canonical.com>
Date:   Thu, 10 Mar 2022 08:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/5] dt-bindings: extcon: maxim,max77843: add MAX77843
 bindings
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <20220111174805.223732-3-krzysztof.kozlowski@canonical.com>
 <CAL_Jsq+cNrh=o7RL=2SH5888=YU9m1QhA5q+eCTFXVbbw57oJA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAL_Jsq+cNrh=o7RL=2SH5888=YU9m1QhA5q+eCTFXVbbw57oJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 22:03, Rob Herring wrote:
> On Tue, Jan 11, 2022 at 11:48 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Document the bindings for MAX77843 MUIC/extcon driver, based on
>> Exynos5433 TM2 devicetree.  These are neither accurate nor finished
>> bindings but at least allow parsing existing DTS files.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/extcon/maxim,max77843.yaml       | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
>> new file mode 100644
>> index 000000000000..f9ffe3d6f957
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/extcon/maxim,max77843.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX77843 MicroUSB and Companion Power Management IC Extcon
>> +
>> +maintainers:
>> +  - Chanwoo Choi <cw00.choi@samsung.com>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description: |
>> +  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
>> +  Integrated Circuit (MUIC).
>> +
>> +  See also Documentation/devicetree/bindings/mfd/maxim,max77843.yaml for
>> +  additional information and example.
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max77843-muic
>> +
>> +  connector:
>> +    $ref: /schemas/connector/usb-connector.yaml#
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/port
> 
> Now failing in -next:
> 
> Documentation/devicetree/bindings/mfd/maxim,max77843.example.dt.yaml:
> pmic@66: extcon:ports: Unevaluated properties are not allowed ('port'
> was unexpected)
>   From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
> 
> s/port/ports/

I'll fix it up. I wonder why I did not see warning before...

Best regards,
Krzysztof
