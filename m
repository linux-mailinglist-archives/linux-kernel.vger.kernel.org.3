Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F54CEAF2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiCFLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiCFLQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:16:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E86BDDE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:15:42 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 59B563F614
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565341;
        bh=wyammkcETMVkrXCUYgMgwXTQvzjKUephDdK6rDf8ZyE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NH7RIc2F0YE2rJdbLxEsMFy2stcxWIapAC54U4o7HavrNrXU18FNa+okw3n+1CGP+
         6rSmc861ZWyMTdIqUs2Mvg3dYRhM0id13o3WMyDmi5I15AY+JZsMHWihy1OW8AXByt
         TVNpGXw5vV7SAOXJzL6NDrpffYgGhCfF50quVAjE7DJQ5eh0ApCFDHaWhtHn4GQ9zk
         XJGyRSQZsL5A58EaUzz97S33gctmKnvDYhW+6GFwIWoavFHqJRwLcB0FiRJf3qrC99
         vVdhh+XOYrK7XKB5NaBR67L8ytd1cl7MP7DF37jk5LN71t2P+TYwGEcn50+kIRIeCi
         mnw2euxyIwLMQ==
Received: by mail-ej1-f70.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so4100046ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wyammkcETMVkrXCUYgMgwXTQvzjKUephDdK6rDf8ZyE=;
        b=D0pAFlmj4CMu6rmt8zDC0k+1+RaWXwRZ1pP/kM5g85yRYY+6EjSA/Ye2c+tOEOlSQi
         okHOSP65+ZKlhayAj+rFuy49MGKN4PMYAvqzZvtj49+xhzk5+mqFf7UAwSzRI2oIsx56
         ShhhKRfllo4+X3LUgfLr+79G798EaMmvpuDjLV6xYB3hkgLuyLJdWtqNiHkWY0UX8wq4
         NqLwkI9IuY1HGazQJnRE41QefLyBgj1D90qhSUF50ArKkMhA4XV7jp4C8vlhjKZDmrPy
         Sg0nA/JkETwFP+7bTf793aDyZ7MRcvSlB/S57ksD+o5HqZApOHMgIg6qmO7LJudBlu2C
         kpLw==
X-Gm-Message-State: AOAM5304ZUVISu3GaJQJU7iHQM9Y34hJtAAEU5KqszXQ//E8RItx/ZAz
        dQrZIxohZcCrGIbcA5PKQeO2JgJpIicHpEwklaxEy9kkH1peEz4LRkcixhWE6fyiiotpy0CQtiQ
        7TWXwxsTm99XCcZhDL8UdKlp5E/jriIy5/uM6BP/JjQ==
X-Received: by 2002:a17:906:37c3:b0:6cf:8ece:e8e7 with SMTP id o3-20020a17090637c300b006cf8ecee8e7mr5592061ejc.690.1646565340985;
        Sun, 06 Mar 2022 03:15:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhbRMr/4T2U3uNL1LtOd9tdA3aZRpYQJJ6IbPVRuKfFwgRhJ732IjpYPYwbnyUEsPTo33edA==
X-Received: by 2002:a17:906:37c3:b0:6cf:8ece:e8e7 with SMTP id o3-20020a17090637c300b006cf8ecee8e7mr5592032ejc.690.1646565340776;
        Sun, 06 Mar 2022 03:15:40 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id 5-20020a508e45000000b003fe03798eafsm4839466edx.32.2022.03.06.03.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 03:15:40 -0800 (PST)
Message-ID: <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
Date:   Sun, 6 Mar 2022 12:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:
 Convert DT bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
 <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
 <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2022 11:41, Frank Wunderlich wrote:
>> Gesendet: Sonntag, 06. März 2022 um 11:27 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
>>>     add compatibles used together with generic-ahci
>>>       - marvell,berlin2-ahci
>>
>> This is fine, just mention it in commit msg.
>>
>>>       - qcom,apq8064-ahci
>>>       - qcom,ipq806x-ahci
>>
>> These you need to consult with qcom-sata.txt. This could be a following
>> commit which will integrate qcom-sata.txt and remove it.
> 
> this depends on Robs opinion

Then maybe precise the question for Rob...

> 
>> Either you have
>> binding document for all devices or you create a common part, like for UFS:
>> https://lore.kernel.org/linux-devicetree/20220222145854.358646-1-krzysztof.kozlowski@canonical.com/
>> https://github.com/krzk/linux/commits/n/dt-bindings-ufs-v2
>>
>> The choice depends more or less on complexity of bindings, IOW, how big
>> and complicated bindings would be if you combine everything to one YAML.
>>
>> In the case of UFS, the devices differ - by clocks, resets, phys and
>> sometimes supplies. Therefore it easier to have one common shared part
>> and several device bindings.
>>
>> AHCI looks more consistent - except that Qualcomm - so maybe better to
>> have one document.
>>
>>>     increase reg-count to 2 (used in omap5-l4.dtsi)
>>>     increase clock-count to 5 (used in qcom-apq8064.dtsi)
>>
>> This would need allOf+if.
> 
> if i get ok from rob i add only the berlin-compatible and skip the qcom+reg/clock-change in the first applied version. Adding the allOf/if (and making it right) will only delay the sata-binding/dts-change.

I don't get what is the problem with delaying this patch for the time
needed to make the bindings correct? Especially that alternative is to
add bindings document which soon will need to be modified, e.g. split
into common part. Is there a particular hurry with these bindings
conversion?


Best regards,
Krzysztof
