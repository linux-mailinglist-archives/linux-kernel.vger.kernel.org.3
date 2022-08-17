Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50406596FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiHQNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiHQNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:33:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0AC99244
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:31:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f8so2530385wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=E0iQOazQDO/obbGYZRzh6D7dwqi0LcqsAFY3GtyIoRw=;
        b=DvxtYW38/k0Lm9cACp2Dabef+D2MTdJpxYG8BUjqhqGGndVuajRRfjDrNjZNk4Rt7M
         V8zCSbMxVW/jCs2l/y9kaeCHqz3dA2VWQuDEfkaNh5rMGByjA8aHu+0HwOgPgaGv9cgk
         c1ZqSg8OF+VGXk4zYrj2xRTBLmJOEGPWSSIgZsFDZmt3LMqj+WHxDQrF1Sv3xpn4F4AQ
         UEP0VSi/3cApAnsztS1LpXIj9C2P0Gr9L3i9yzwk3u0Gy4bn2b+hgOWHRQACYXvok6Hn
         cYOLstqE6Y4oLA7nehcusWvm1lEwoFtAg/McDdLC1UzpJ/kYPV7WbsM9Q6nWG4ptwzQF
         lAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=E0iQOazQDO/obbGYZRzh6D7dwqi0LcqsAFY3GtyIoRw=;
        b=kTp20okWvNhPGAsoExu0r10O5kXsjXfeaPfpHyxKVEpZpFstFrlc3H0mPnisQ8n4Kg
         pV8/dOF5auXvefgSOn9QI4Kyb1mxGrmK6D38xPZDB9MTvnkF5Su+zVFxRCIab5BFDq/l
         liG8EG32OnDZ6Ez16z8r+4/0vPTinzvJChhX7rZQtrQ5lGfCkXqVqZVIQWiBI5k2t9Co
         0bFdnKFRbmOXrskVC+wL5pqfHGyO8x6XjSPZLos7Gm2cR5K7I0kZlmE9R4Yjb2sMSi2e
         o99m4+5Olx7t9CzcqPge6lMMp9xXOdtUSc7o9BAJ2QuSKCVHDUurFrYit7ngl6+p2zOF
         3Q6A==
X-Gm-Message-State: ACgBeo3g3GW1iT/tpjY7mxe6v1fMUaTf5n5HCtqoVWfcOMjiBb4QplUT
        8DWibTF4lhwhqksYCzYTZWt+qQ==
X-Google-Smtp-Source: AA6agR7WBqTmQBAeJul9q4fCb/OqNE31bC9f+464k9EY/T94d+BYyelwyzCKOSOVr8Hx9EMdHKyrbw==
X-Received: by 2002:a5d:4283:0:b0:225:2231:3fd0 with SMTP id k3-20020a5d4283000000b0022522313fd0mr2348511wrq.382.1660743061896;
        Wed, 17 Aug 2022 06:31:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a5c:3576:8e69:3edc? ([2a01:e0a:982:cbb0:a5c:3576:8e69:3edc])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b003a4c6e67f01sm2634186wmq.6.2022.08.17.06.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:31:01 -0700 (PDT)
Message-ID: <3725619d-72c5-5c9d-513b-80bbc727dd07@baylibre.com>
Date:   Wed, 17 Aug 2022 15:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/bridge: sii902x: add support for
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     jernej.skrabec@gmail.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent.pinchart@ideasonboard.com
References: <20220113144305.1074389-1-narmstrong@baylibre.com>
 <25976b46-21b4-6e3f-0182-85dd4ca2b654@gmail.com>
 <a4a36360-3f77-17a0-9239-08cb8c08de74@baylibre.com>
 <13bd6440-9a61-d444-518c-f4e8cba0b825@baylibre.com>
 <5a1df5ce-a497-760b-8e2c-130a0e659c0b@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <5a1df5ce-a497-760b-8e2c-130a0e659c0b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 02:15, Dmitry Osipenko wrote:
> 08.08.2022 12:51, Neil Armstrong пишет:
>> On 08/08/2022 11:15, Neil Armstrong wrote:
>>> Hi Dmitry,
>>>
>>> On 31/07/2022 22:07, Dmitry Osipenko wrote:
>>>> 13.01.2022 17:43, Neil Armstrong пишет:
>>>>> This adds support for DRM_BRIDGE_ATTACH_NO_CONNECTOR by adding the
>>>>> bridge get_edid() and detect() callbacks after refactoring the
>>>>> connector
>>>>> get_modes() and connector_detect() callbacks.
>>>>>
>>>>> In order to keep the bridge working, extra code in get_modes() has been
>>>>> moved to more logical places.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> ---
>>>>>    drivers/gpu/drm/bridge/sii902x.c | 129
>>>>> ++++++++++++++++++++++++-------
>>>
>>> 1 file changed, 99 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/sii902x.c
>>>>> b/drivers/gpu/drm/bridge/sii902x.c
>>>>> index 89558e581530..65549fbfdc87 100644
>>>>> --- a/drivers/gpu/drm/bridge/sii902x.c
>>>>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>>
>> [...]
>>
>>>>>        }
>>>>> +    endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
>>>>> +    if (endpoint) {
>>>>> +        struct device_node *remote =
>>>>> of_graph_get_remote_port_parent(endpoint);
>>>>> +
>>>>> +        of_node_put(endpoint);
>>>>> +        if (!remote) {
>>>>> +            dev_err(dev, "Endpoint in port@1 unconnected\n");
>>>>> +            return -ENODEV;
>>>>> +        }
>>>>> +
>>>>> +        if (!of_device_is_available(remote)) {
>>>>> +            dev_err(dev, "port@1 remote device is disabled\n");
>>>>> +            of_node_put(remote);
>>>>> +            return -ENODEV;
>>>>> +        }
>>>>> +
>>>>> +        sii902x->next_bridge = of_drm_find_bridge(remote);
>>>>> +        of_node_put(remote);
>>>>> +        if (!sii902x->next_bridge)
>>>>> +            return -EPROBE_DEFER;
>>>>
>>>> Hi,
>>>>
>>>> This patch broke ARM/QEMU vexpress display because of_drm_find_bridge()
>>>> always fail with -EPROBE_DEFER. Reverting this patch returns display
>>>> back. Please fix or revert, thanks in advance.
>>>
>>> Can you share a QEMU cmdline to reproduce ?
>>
>> Actually the vexpress DT has multiple input ports instead of a single
>> input port at @0
>> and an output port at @1 like documented in the bindings:
>>
>> vexpress-v2m.dtsi#L303-L307:
>> ports {
>>      #address-cells = <1>;
>>      #size-cells = <0>;
>>
>>      /*
>>       * Both the core tile and the motherboard routes their output
>>       * pads to this transmitter. The motherboard system controller
>>       * can select one of them as input using a mux register in
>>       * "arm,vexpress-muxfpga". The Vexpress with the CA9 core tile is
>>       * the only platform with this specific set-up.
>>       */
>>      port@0 {
>>          reg = <0>;
>>          dvi_bridge_in_ct: endpoint {
>>              remote-endpoint = <&clcd_pads_ct>;
>>          };
>>      };
>>      port@1 {
>>          reg = <1>;
>>          dvi_bridge_in_mb: endpoint {
>>              remote-endpoint = <&clcd_pads_mb>;
>>          };
>>      };
>> };
>>
>> bindings:
>>    ports:
>>      $ref: /schemas/graph.yaml#/properties/ports
>>
>>      properties:
>>        port@0:
>>          $ref: /schemas/graph.yaml#/properties/port
>>          description: Parallel RGB input port
>>
>>        port@1:
>>          $ref: /schemas/graph.yaml#/properties/port
>>          description: HDMI output port
>>
>>        port@3:
>>          $ref: /schemas/graph.yaml#/properties/port
>>          description: Sound input port
>>
>> The patch is conform to the bindings, the DT was working but is actually
>> not valid.
> 
> I haven't looked closely at how to fix this properly, but if we can fix
> it using of_machine_is_compatible("arm,vexpress") workaround in the
> driver, then it will be good enough at least as a temporal fix, IMO.

If other maintainers are ok with that, it can be temporary fix until the DT gets fixed.

Neil

