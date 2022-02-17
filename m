Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B64B9F51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiBQLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:43:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiBQLnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:43:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69106767C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:43:36 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E6BC3F1D0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645098214;
        bh=3aXOIs5DNsSKgW4lPlRH0E+Ngbbzp4EOvtZ59naGoig=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=cjQ6fzIwRzlwVd91PhJZeRn+6TBH9gUF1RtPgvZbSshGgFVuAJZRp85V+zIGK7Oz0
         aVXnbrFLUe6ng6E9yKX4MBZ8EC5a6ZpxBW1zAbmWN4gL5rXdv4U5tLGOTE4YaNluqe
         Kp6/c604HBSQ8uL1FgfXADdGN5ov6HyoOcHCQt6tl9QjX3N7P+yrgxH/k2V3amDoHl
         76kWQGgf+rFNprIK14+X5e5njxkiS/SloRbbH9OoMl9IkCf0nJMOLJQDC0U3bpOfXV
         +QVoo2atdlAKPO+1wq/wwc4WhWjMXFxyV3nsq2g7MB6EZKUw5AkgfwK1Uq8TBHyirT
         NaMkgbrn5Yv2g==
Received: by mail-ed1-f70.google.com with SMTP id dy17-20020a05640231f100b00412897682b4so1570212edb.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3aXOIs5DNsSKgW4lPlRH0E+Ngbbzp4EOvtZ59naGoig=;
        b=uxflf3JC7hT04N7a+S+dFvhgwX2K9agHGIT0Ipkig0VjTiRiCtzo9U5IvNi2/EyBDn
         dSSoI2wP5oMeUFekhBPSkG3FKhI2DJpUWMwuXG7jqZ1co39l9kMqIN7NlasVNn+NPxLh
         XmscaIJYuDXzDxXPTuIyNNKVqrFp6QUYGVWCBFhUgUUsuMvZS83JsqVpQTNMsGK7/+gY
         0h7adrQag1en/VMSscz21K/Ud6FW8WKnSClXfJh8/OgrV6DBgaGHBsLpdLJnqKifpjuQ
         hrje//0TdURNl4nGeWZeZR1eATyGNxm7jYuF9yNan2DiRO84NPJI1TOMjHKSBSiMIXxW
         r8Fg==
X-Gm-Message-State: AOAM533Y89kR14KaBj3opa6DUJ9JgNnmFTZAId5Z/4oRJa877sZrYdL5
        l6Zn5ydX//WWhBz1OiXojrx8+542bhyqWSgsY3lTyH/p5pd2FIA1WwmCe6+vsX0CIO8JkJieOdV
        D8pvrTqKnxZmn8yMOC20amaNK0sTfjWHM+Iq8CHSHHQ==
X-Received: by 2002:a17:906:6158:b0:6ce:61d6:f243 with SMTP id p24-20020a170906615800b006ce61d6f243mr1988830ejl.268.1645098214316;
        Thu, 17 Feb 2022 03:43:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnueVtVPrDA18T6no1BS6n/l07Q8n/Fr3Su2uWY+sD+U260MD/MJML+fbL+MqaXEB6RoP9ig==
X-Received: by 2002:a17:906:6158:b0:6ce:61d6:f243 with SMTP id p24-20020a170906615800b006ce61d6f243mr1988803ejl.268.1645098214033;
        Thu, 17 Feb 2022 03:43:34 -0800 (PST)
Received: from [192.168.0.111] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e27sm1130144ejm.18.2022.02.17.03.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:43:33 -0800 (PST)
Message-ID: <4c1c1a36-2e6f-a061-5c2b-f2aac31b2d0e@canonical.com>
Date:   Thu, 17 Feb 2022 12:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/6] dt-bindings: display: imx: Add EPDC
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alistair@alistair23.me,
        samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
References: <20220206080016.796556-1-andreas@kemnade.info>
 <20220206080016.796556-2-andreas@kemnade.info>
 <36445c86-036e-0942-a9a4-919595886c67@canonical.com>
 <20220217123112.3ba70000@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220217123112.3ba70000@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 12:31, Andreas Kemnade wrote:
> On Thu, 17 Feb 2022 10:21:15 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> 
>> On 06/02/2022 09:00, Andreas Kemnade wrote:
>>> Add a binding for the Electrophoretic Display Controller found at least
>>> in the i.MX6.
>>> The timing subnode is directly here to avoid having display parameters
>>> spread all over the plate.
>>>
>>> Supplies are organized the same way as in the fbdev driver in the
>>> NXP/Freescale kernel forks. The regulators used for that purpose,
>>> like the TPS65185, the SY7636A and MAX17135 have typically a single bit to
>>> start a bunch of regulators of higher or negative voltage with a
>>> well-defined timing. VCOM can be handled separately, but can also be
>>> incorporated into that single bit.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>  .../bindings/display/imx/fsl,mxc-epdc.yaml    | 159 ++++++++++++++++++
>>>  1 file changed, 159 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
>>>
> [..]
> 
>>> +
>>> +  DISPLAY-supply:
>>> +    description:
>>> +      A couple of +/- voltages automatically powered on in a defintive order  
>>
>> Typo, definitive?
>>
> yes, of course.
> 
>>> +
>>> +  VCOM-supply:
>>> +    description: compensation voltage
>>> +
>>> +  V3P3-supply:  
>>
>> All of supplies names - lowercase.
>>
>>> +    description: V3P3 supply
>>> +
>>> +  epd-thermal-zone:
>>> +    description:
>>> +      Zone to get temperature of the EPD from, practically ambient temperature.  
>>
>> Is it a phandle?
>>
> a string used in
>        of_property_read_string(priv->drm.dev->of_node,
>                                 "epd-thermal-zone", &thermal);
>         if (thermal) {
>                 priv->thermal = thermal_zone_get_zone_by_name(thermal);
>                 if (IS_ERR(priv->thermal))
>                         return dev_err_probe(priv->drm.dev, PTR_ERR(priv->thermal),
>                                              "unable to get thermal");
>         }

OK, then:
$ref: /schemas/types.yaml#/definitions/string

> 
> [...]
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/imx6sl-clock.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    epdc: epdc@20f4000 {  
>>
>> Generic node name, e.g. display-controller
>>
> hmm, does IHMO not make too much sense here. E.g. in the imx6sll.dtsi
> we have lcd-controller next to it. So having epd-controller? But that
> is exactly what epdc stands for.

Still we have "lcd-controller", not "lcdc". Since this is only for epd,
then "epd-controller" seems reasonable. The same as we use
"interrupt-controller" (not "ic"), "dma-controller" (not "dmac" or "dc")
and so on. See also list of recommended generic names from DT specification.

Best regards,
Krzysztof
