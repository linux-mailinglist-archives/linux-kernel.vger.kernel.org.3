Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53A4B705D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiBOPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:54:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbiBOPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:54:54 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5979E9DB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:54:43 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F4DD3F071
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644940482;
        bh=+QObaeMvuhGq3vTB+Qm78jkj+7kPIGMxNc28eGSrc+w=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FKtPHJvZkkKwj8a7wqDIjqcZN0bIokFQlpsxGFZzA9YpE17tECUT5vjgIUihVd8UG
         TOp2+oXvK9OjTDIEVCLLaOhCXZgBcrbqoqMga22ARDdIKpIBwNdEofwl8k9JUOYdJd
         5bLVN36ZsG4Fu0tLHCJfVZ+ByTsU4+qxeAGJHpPMyTwfrJ7L9z4KxFW+ih0V+DhubG
         vaC431GIMCw0T/bAQA8GpihnItFyWWJyMWmEB5qluONhHaOVwctBIzw/C+elyvzYzV
         INZPcGcdsykQxkpGlriaXxItf40G/ePJdcFYvAOGXBIW4g0/7uu7//FtnavuImHU/D
         mDVu60oiRXTig==
Received: by mail-wr1-f70.google.com with SMTP id i10-20020adfaaca000000b001e4b2db0303so6554911wrc.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+QObaeMvuhGq3vTB+Qm78jkj+7kPIGMxNc28eGSrc+w=;
        b=nReV4ajssj245ktRDGmSWX3ZOcnaZGJBRHp3YnKK956h76iQlxBWcRQxVHJRdmGN1l
         L15iP8PrwEdRQ1pPg3hQSKC+lLBa3hF50iDkX6yCoby19FAPwXkLUFpUVSA664u1UZcJ
         M06/X/XnL85NkjgRvrmJrpAUt5Vv5Fp4Q2Kx7wdRXrVJCyDuk7OTPNLWsggJ7oZ9mY77
         /DQw5uOCeGFeFBWapHJRmwspYYXsjKe3D/fweOsNhWqoAtx8TYm7Qi4uobckdGZcQ4+F
         oHZkrd4/yVk0sviXPRHgu5rkVZM8Pc1tBwYDUewuBu6+PRvbnvtRIiiYDAnq5mg/FoXW
         vv/g==
X-Gm-Message-State: AOAM5309xy1FfZylGsWpt7X5PXNdo8aih2Ot4+5x0icyPUEvJ9lh2dTL
        GrpxGmKfx1vcZD81mHkaYwHXmlXIAWB0UfExJO2o5Nwp3qAS+maAGFhfuqd3G7BMPbA+Kuo7w4F
        Nuzqbrdz+nc3549eP71NEs8gTA7IkJYa0St1VW/FqOQ==
X-Received: by 2002:a5d:5983:: with SMTP id n3mr3851932wri.382.1644940481889;
        Tue, 15 Feb 2022 07:54:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoVBW/CLXsO/TypyE7MepwQ5iRogRbIei6GF1U49AerV7YaFDlihHa86IrATrYYtw77ahJ0A==
X-Received: by 2002:a5d:5983:: with SMTP id n3mr3851917wri.382.1644940481649;
        Tue, 15 Feb 2022 07:54:41 -0800 (PST)
Received: from [192.168.0.109] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk5sm20865734wrb.10.2022.02.15.07.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:54:41 -0800 (PST)
Message-ID: <0bb07d0a-838d-b772-91ca-aa31b57b2f3c@canonical.com>
Date:   Tue, 15 Feb 2022 16:54:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: input/touchscreen: bindings for
 Imagis
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <1644531943.391463.3262540.nullmailer@robh.at.kernel.org>
 <20220215151527.84634-1-markuss.broks@gmail.com>
 <20220215151527.84634-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215151527.84634-2-markuss.broks@gmail.com>
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

On 15/02/2022 16:15, Markuss Broks wrote:
> This patch adds device-tree bindings for the Imagis
> IST3038C touch screen IC.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../input/touchscreen/imagis,ist3038c.yaml    | 75 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> new file mode 100644
> index 000000000000..7b127817e1f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagis IST30XXC family touchscreen controller bindings
> +
> +maintainers:
> +  - Markuss Broks <markuss.broks@gmail.com>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^touchscreen(@.*)?$"

reg is required, so @ is not optional:
^touchscreen@[0-9a-f]+$

> +
> +  compatible:
> +    items:

Do you expect here multiple compatibles? If not, the items are not needed.

> +      - enum:
> +          - imagis,ist3038c
> +
> +  reg:
> +    description: I2C address

You can skip description because it is fairly obvious, but instead you
need maxItems. Alternatively, a list (items) with description defines
max items.


Best regards,
Krzysztof
