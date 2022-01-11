Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5937748B211
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349947AbiAKQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:26:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49858
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241083AbiAKQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:26:15 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C54063F32E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641918373;
        bh=puOvobGfY/I3hOBitRLCMcxZnTzU14JJR6HhloQSBP0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=e39H7Dw8YsS92DohieevTxyA69xVbUM0TbrXSpONEBvzSsoTnFJeutzTe/xv/RXf/
         cBwIYrp/k5tb/x0tVTj/UZcmL2SqERVl9FL3l4W5ojpZ13BfupfQfiHuNBSzCe8/Gw
         wkNFyXwHIGVUxCmPeI9Cc71iM2sIEdP7/uIItDVGd4Fhb0qUrYe2Bx/mcFpeDDYbCe
         NwDETKOdg6TosX+tem+fJv4pXe7v/ZIWBGFGS0KE8Uksj4hDcpQKduQ1LXbVSSs31K
         pqG/nrxNAguLEocQJSfrIXSoSWHB5+fzWZX9GEhLNN/Xn/WqZfC7QPzmDWVHHej2sg
         WwEr2qpJ5BVKQ==
Received: by mail-ed1-f69.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so13796213edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=puOvobGfY/I3hOBitRLCMcxZnTzU14JJR6HhloQSBP0=;
        b=VcRfDjma/lHP55MQ+hj6uSklkc91UIhwTXi1FideTMy3ygtY9maDloGqkKqGWyZl4n
         KCVRItKI4W68EuphlGtMLpK8ec70x/X0XwqRGUZg22yT7pAMNLvdzNyxPGMzta3VDPtG
         QBJGPinuTzxj9K0WDjE84+h+ywWUPEVKAqkpCZrRW6IVwo+N4pw3rvS0KUmc7eplcAAg
         ZWp9cMKE+PNV+IiGQHa7u3HiKgwnd8DCRE+r8Sp3Z+9xkBWKgbrR6LcA8GepJzktys1P
         g3O67ijTvukZTzgNP3inCLTF+9h5lmDmWbT71B45UCI4VxOtfxtK383GDKJC/YkmcMug
         vsQg==
X-Gm-Message-State: AOAM530lYuP4NsESNRGOqo+jGCegPjeXLdiPFXLS30/aDDb1Zhr7XUbn
        eJn8sq3ANlg+CcWUuzqcQpgsgEl86J++/sUP7vavmU+JJ+0hCDcVGj+43A6Ha9YCiaebPTVGx3b
        9/WQF0jIW1r7FgU4YPvLjcdxiDwZItal1krUVNTg+zw==
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr4245185ejb.364.1641918373508;
        Tue, 11 Jan 2022 08:26:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0WB7kXHdSOBmqAzj8OY2NGoRe81KUh+8ODpxEz+TNyF7Q2q490El0I+0sV/r9OOnYaBP5zg==
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr4245172ejb.364.1641918373301;
        Tue, 11 Jan 2022 08:26:13 -0800 (PST)
Received: from [192.168.0.25] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e18sm5155101edq.77.2022.01.11.08.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:26:12 -0800 (PST)
Message-ID: <585a7c40-ede2-cadb-6f64-04477b3d93e3@canonical.com>
Date:   Tue, 11 Jan 2022 17:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/4] regulator: dt-bindings: maxim,max77693: convert to
 dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
 <20211228163930.35524-4-krzysztof.kozlowski@canonical.com>
 <YdRn5cvksYXK4icV@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YdRn5cvksYXK4icV@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2022 16:29, Rob Herring wrote:
> On Tue, Dec 28, 2021 at 05:39:29PM +0100, Krzysztof Kozlowski wrote:
>> Convert the regulator bindings of Maxim MAX77693 MUIC to DT schema format.
>> The existing bindings were defined in ../bindings/mfd/max77693.txt.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/regulator/maxim,max77693.yaml    | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
>> new file mode 100644
>> index 000000000000..81242c8cd77c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/maxim,max77693.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX77693 MicroUSB and Companion Power Management IC regulators
>> +
>> +maintainers:
>> +  - Chanwoo Choi <cw00.choi@samsung.com>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description: |
>> +  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
>> +  Circuit (MUIC).
>> +
>> +  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
>> +  additional information and example.
>> +
>> +patternProperties:
>> +  "^ESAFEOUT[12]$":
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +    description: |
>> +      Safeout LDO regulator.
>> +
>> +    properties:
>> +      regulator-min-microvolt: true
>> +      regulator-max-microvolt: true
> 
> If you want to define which properties are valid from regulator.yaml, 
> then you need to define all of them (regulator-name is missing), and use 
> 'additionalProperties: false'. Or you can just drop these. 
> 
>> +
>> +    required:
>> +      - regulator-name
>> +
>> +  "^CHARGER$":
> 
> Fixed string, not a pattern. Place under 'properties'.
> 

Thanks, I'll fix both.


Best regards,
Krzysztof
