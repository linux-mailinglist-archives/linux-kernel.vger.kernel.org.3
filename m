Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC274AFF31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbiBIV3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:29:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiBIV3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:29:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC6C0045A5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:29:08 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D9563F324
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644442147;
        bh=9TShvtjM40hZA5vpKCtm1+G42669wQg8EHY6WDDuENg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vUIyZwCkJDhG7fVXJZNYs0ErDukIkhwILoXZtwIpNCMuxlBiPHlY++J+9EfRjh+58
         ouXj08Qn8Oodkz1OqeMMUxkNEzDV9jJI8az6mmWayLxMJZRadZ3EiEZ/LT718cByD8
         ze5aOFfsEAz9Lf4eD43tCxMKUrWq4duuza2Hb/rc3KKny1EO4d4bfowd3iwqNxIaMn
         JiZNY7D4YQHIaHUagJ00Dv4UB771b9pYxigW8nC9Eyovy1sOEX4i3AkwnT93J3iZ03
         SeAnj3dP8iDhHyeqE2ROiVrTTTFyVeSdOnHLalDwF5jCM0Ym5w38mc/R+NqlZ0b3c3
         zqjDXi40D13rA==
Received: by mail-ej1-f71.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso1748943eje.20
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 13:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9TShvtjM40hZA5vpKCtm1+G42669wQg8EHY6WDDuENg=;
        b=QAfWgAMaMNip5h2QD/VFHa3FTOlWPxxFy1p6CW03CiE0a/Shp/l8HZCPUPkyk4iV15
         cKumvKE0pez6VRANidM7QPVHN6UeFMs4LTpB0YIPCtm5ehR/0wY3rAqN5k13FsRz8gZE
         4fqBk0KBQcV5PMAkAYbIRzmr0QGVl4OFvxuLEF8TZllPJD1uPrYygkv1aqDH0RSDei5q
         orlCy2SaC9CFsvhse1rcRkAn7o23DExZcGtWJbFJCLULXMqHJpMFsmX56E/OnB0Lrib6
         S8qZAQ/F3lxQaysXYdwJ/YLjtOWx3eagxSA1cM4irjpo1iNReUNI21ZY/wiB8TatsV9r
         d0yw==
X-Gm-Message-State: AOAM5305rGNHaOPsfI56G32I+OhHY2GZTmcOHoWI9q9wfJ/hgf1blBzc
        LkiRLWl0j7i4FeAInmxou/ff1rwMu6+ePStWb+ssh2JrJASMP8WNsj4VB3CfdO9Agkt5VFQvZOt
        8/nHyruoWULcB8htVZHWVO3E6hJ6GEB2d7wL2nDEHRg==
X-Received: by 2002:a17:906:7489:: with SMTP id e9mr3719911ejl.113.1644442146990;
        Wed, 09 Feb 2022 13:29:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjCqY2kC52KdzLBk3YrmqJ5TDW/193D4g8ooKrOH9ULeyClcLHYjH3c0tFzHy/8RpMgdHYEA==
X-Received: by 2002:a17:906:7489:: with SMTP id e9mr3719894ejl.113.1644442146756;
        Wed, 09 Feb 2022 13:29:06 -0800 (PST)
Received: from [192.168.0.97] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n25sm5339414eds.89.2022.02.09.13.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 13:29:06 -0800 (PST)
Message-ID: <8e987e4a-3667-b541-4d5f-d174ed054ebf@canonical.com>
Date:   Wed, 9 Feb 2022 22:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add bindings for AM625 SoC
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-3-vigneshr@ti.com>
 <9303ca0e-2a83-3c3e-0892-c74a820562a9@canonical.com>
 <aa042432-8e70-19d9-9bde-c6d5bf6688b1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <aa042432-8e70-19d9-9bde-c6d5bf6688b1@ti.com>
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

On 09/02/2022 20:04, Vignesh Raghavendra wrote:
> 
> 
> On 08/02/22 10:31 pm, Krzysztof Kozlowski wrote:
>> On 08/02/2022 14:18, Vignesh Raghavendra wrote:
>>> From: Nishanth Menon <nm@ti.com>
>>>
>>> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
>>> architecture platform, providing ultra-low-power modes, dual display,
>>> multi-sensor edge compute, security and other BOM-saving integration.
>>> The AM62 SoC targets broad market to enable applications such as
>>> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
>>> Automation, Appliances and more.
>>>
>>> Some highlights of this SoC are:
>>>
>>> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>>>   Pin-to-pin compatible options for single and quad core are available.
>>> * Cortex-M4F for general-purpose or safety usage.
>>> * Dual display support, providing 24-bit RBG parallel interface and
>>>   OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
>>>   resolution.
>>> * Selectable GPUsupport, up to 8GFLOPS, providing better user experience
>>>   in 3D graphic display case and Android.
>>> * PRU(Programmable Realtime Unit) support for customized programmable
>>>   interfaces/IOs.
>>> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>>>   external ports (TSN capable).
>>> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
>>>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>>>   1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
>>> * Dedicated Centralized System Controller for Security, Power, and
>>>   Resource Management.
>>> * Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
>>>   enabling battery powered system design.
>>>
>>> AM625 is the first device of the family. Add DT bindings for the same.
>>
>> Don't paste the same huge commit description in several commits.
> 
> Sorry, I think this is the first commit with full description. I will
> probably trim 4/5 at bit
> 
>>
>>>
>>> More details can be found in the Technical Reference Manual:
>>> https://www.ti.com/lit/pdf/spruiv7
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> index b03c10fa2e7a..64f3db3ea9dd 100644
>>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> @@ -53,6 +53,12 @@ properties:
>>>                - ti,am642-sk
>>>            - const: ti,am642
>>>  
>>> +      - description: K3 AM625 SoC
>>> +        items:
>>> +          - enum:
>>> +              - ti,am625-sk
>>> +          - const: ti,am625
>>
>> Why keeping it not alphabetically sorted? What sorting did you choose?
>>
> 
> Above list is not sorted alphabetically, I tried to keep similar SoCs
> bunched together. AM625 and AM642 are of same family, hence chose to add
> the new entry here.

Then maybe it should be before AM642?

> One alternative is to add it to end of the list (chronologically)?
> Or I can add a patch to sort the list alphabetically first and then
> introduce new compatible. Please let me know your preference?

It's not that important, just wondering. I propose to avoid putting at
the end, because this causes conflicts in case of concurrent work. If I
had to choose, I would propose to sort SoCs by name.

Either way is fine - with trimmed commit msg in patch 4 or here:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
