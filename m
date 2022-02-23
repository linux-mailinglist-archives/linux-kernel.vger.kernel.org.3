Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E14C13CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiBWNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbiBWNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:15:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21597A9E35
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:14:52 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A67A405D7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645622090;
        bh=luA2pGmBUiuoHCIdDEpQqIZrDzzhrlzhl8j+UonA2Ac=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SE/wFLOUyXOiI4eiUTQNM7fAxLnoIYhR0HPH+u6H6P/Pa1pOEgkj3WiFpX3JyShGL
         6iU6BbSuC834ylUIxvstAaOls101s58kWPTD41GyeW1Yzhd16Ps5IS8AdziwLskueY
         wBmULKIn6Y6f1KrdohkDc91NRfQY3VfwH3eEkN4VL0vwzCjLFngIknP8uaFfKNgqcM
         2p7MoMj4AxwPvkOn5WABQIJpRH2yuF0x9g6C9U69e4TccYdlCc7XxJGYVzDXxahJ9H
         QXop5hjEQMjag48iRyadReWYoEDR+jAJvLyHv5dnpqpE5QCCO+dMzv82SBJ3XuhNuC
         n4uIC7I+LNNNw==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so13444971edh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=luA2pGmBUiuoHCIdDEpQqIZrDzzhrlzhl8j+UonA2Ac=;
        b=Ek9m8wumuFVXM8tQaztDHykomAbVL+je68MrNXJ2rXnnXFuH9orrBjU2NclTvVpP6p
         +NIRPKcULIPHdMnZHFMptmAGkenHfn5jVpLgyguvSiNVC5/Mog5XlV0tvftdrgTU8JcL
         aQyksLzbxWJS4C7wk2d4Zl/BYD6FQHgCw6rj/o5sOqNGZOekfO4RFSae3yda4TNO3xiO
         frLWP3vNeO2qwjAI28bTQpI/f2stlljlYW5NmARIZj7kTqvnWND9plwYsnS4p5mPNUMn
         n35GACdermqWSRaSZWjU5aHBA1M8biNiMMku8rG7FrWpRPHRM++/8c16encmnONQ9sfo
         2ueQ==
X-Gm-Message-State: AOAM532lklItYPZ0FYfgar4Lfgp3yaI7Lx8jXug98x9ND0TdQpbpArRf
        DcRaeklrmAA+eCvddRPlxYmxO1M7f4OinPvSwAdZqwe/bupjKhEY+nyiatyXq11RoOxot9tLUu9
        I2ny3awf0I4WZTfFM1M3YhVn8bNzN3X2MjLq+JUWpNQ==
X-Received: by 2002:a17:906:af79:b0:6ce:61d3:7e9b with SMTP id os25-20020a170906af7900b006ce61d37e9bmr23249847ejb.191.1645622089867;
        Wed, 23 Feb 2022 05:14:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPXOdScuO9l5oh+CHacL1L0JeFIZjGDBcMotv+/pc0BsZ6IXhLfsZQvcbVqSbjklwZ5f51Fg==
X-Received: by 2002:a17:906:af79:b0:6ce:61d3:7e9b with SMTP id os25-20020a170906af7900b006ce61d37e9bmr23249825ejb.191.1645622089612;
        Wed, 23 Feb 2022 05:14:49 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id z13sm603406edb.54.2022.02.23.05.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:14:49 -0800 (PST)
Message-ID: <99c673e7-09ea-ce0f-f8b7-b03ca35e8740@canonical.com>
Date:   Wed, 23 Feb 2022 14:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
References: <20220211115925.3382735-1-clabbe@baylibre.com>
 <f078ac6f-5605-7b86-5734-cbbf7dc52c71@gmail.com> <YhYxLmBYa+DMCnuz@Red>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YhYxLmBYa+DMCnuz@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 14:05, LABBE Corentin wrote:
> Le Tue, Feb 15, 2022 at 03:07:56PM +0100, Johan Jonker a écrit :
>> Hi Heiko,
>>
>> On 2/11/22 12:59, Corentin Labbe wrote:
>>> Convert rockchip-crypto to yaml
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>> Changes since v1:
>>> - fixed example
>>> - renamed to a new name
>>> - fixed some maxItems
>>>
>>> Change since v2:
>>> - Fixed maintainers section
>>>
>>>  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
>>>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>>>  2 files changed, 66 insertions(+), 28 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>>
>> rockchip,crypto.yaml
> 
> 
> Hello
> 
> DT maintainer asked for rockchip,rk3288-crypto, so I will keep it.

I don't insist on keeping rk32880crypto name. It depends whether the
bindings are for a family of devices or rather specific one or few
devices. Based on comments here, it is quite possible that all Rockchip
crypto blocks will fit into this bindings, so the name could be generic.

Having a specific name, even if it contains multiple devices, is also fine.

What I would prefer to avoid is to have a generic name
"rockchip,crypto.yaml" and then in two months one more generic
"rockchip,crypto2.yaml", and then add third...

> 
>>
>>>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>>> new file mode 100644
>>> index 000000000000..2e1e9fa711c4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>>> @@ -0,0 +1,66 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
>>
>> rockchip,crypto.yaml
>>
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Rockchip Electronics And Security Accelerator
>>> +
>>> +maintainers:
>>> +  - Heiko Stuebner <heiko@sntech.de>
>>> +
>>> +properties:
>>> +  compatible:
>>
>>     oneOf:
>>       - const: rockchip,rk3288-crypto
>>       - items:
>>           - enum:
>>               - rockchip,rk3228-crypto
>>               - rockchip,rk3328-crypto
>>               - rockchip,rk3368-crypto
>>               - rockchip,rk3399-crypto
>>           - const: rockchip,rk3288-crypto
>>
>> rk3288 was the first in line that had support, so we use that as fall
>> back string.
> 
> I will dont add compatible which are not handled by the driver unless DT maintainer said I should.

They could be added for completeness because bindings describe rather
hardware, not Linux driver state, but there is no such must. It can also
be added later by another contributor.


Best regards,
Krzysztof
