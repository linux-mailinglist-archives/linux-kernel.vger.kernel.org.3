Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913874AFF45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiBIVgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:36:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiBIVgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:36:42 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45FC1DC5D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:36:44 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0AC6040012
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644442603;
        bh=IdESQvvFnvm/soylLvwmGAV39LHEOL97ntex11R3FlI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rcHHRwdnPVWAvP+VJoeNEV4kC2kqaiTVLWMrLw5xBebGL3n8CwuNY9dwIzDYfP61c
         YanoaV0DBloTJu20GW2qv/tabV0xjHC3dVtlmWUBm+iqBV5caXaCSlR39JhXg+VZm0
         Kwsq91Hca2lf5DsWuBpkgzO8qdoPfQPJlRkszlWlgJUDVCPrg9FFb0ieZA4vvT5ian
         um2ww7bn+9+MlNYY4aUGWI71ey/iRJeISqBomvYnx9IHpraD8z12grv9rJNC0V8fff
         u5gUx6fKDRqorCb2zXc9XZJ2rmff/haJS2phfg/Tzzeh5NkT1hat270AgPq/QyHFjD
         Yc71vYMD7loNQ==
Received: by mail-ed1-f70.google.com with SMTP id b26-20020a056402139a00b004094fddbbdfso2121942edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 13:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IdESQvvFnvm/soylLvwmGAV39LHEOL97ntex11R3FlI=;
        b=OGwGG7vBTQ9aPkK/7R0siTSW/9MsKUfFDdNQmeFccRByIHnqZPsoTov8jgI+rejtiE
         6W4xEvedvfDcM+M7mOg91wKDqxLXuHGlxcsWX1b1fRcnJdM+qqiTS1ERgwA50b5BF5s8
         jQr199RkLIQSo8ABbzAkyAtUr7HMcee9XuTzdvu+B+BG2N/eWEI+ZhhBe9ooZutYDDDN
         hX5gSakQsoCtmTYJQHPT0kTHeE4zmxrJCB8/OhNPhNYlLUtAfGM6DlsBjR5gG1yJNJys
         ylaIlOPjUjBHehZfDbCobdw6ZaO4U2t19DPAtwk3qlkavQ5tIfwjBNkk2JlV6VVyWhlb
         eZIw==
X-Gm-Message-State: AOAM531cxVBTlWRyj87k7q4m14tq1NA1deDKJWiEMeMnG7cU5Gcde8D3
        lsx1W0CdAj6hlQk3EVBy0Kw78DmOkzQi7my9QUdSVC+YzpD/GednoDPQXfmMqnkuYXZ6vQCJCG/
        gsmnl8f58vjCy8RbTRnFekcwwOQ5NyaHN6gREl0uHbA==
X-Received: by 2002:a17:906:649c:: with SMTP id e28mr3506612ejm.324.1644442602458;
        Wed, 09 Feb 2022 13:36:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/ApgfeERYvn1aa9I9Q2XTwtqIlGwm6mtetkbD7//TUYlnMJyk7AS3O2qnIooVSnQM+/uscw==
X-Received: by 2002:a17:906:649c:: with SMTP id e28mr3506599ejm.324.1644442602256;
        Wed, 09 Feb 2022 13:36:42 -0800 (PST)
Received: from [192.168.0.97] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z6sm6384348ejd.35.2022.02.09.13.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 13:36:41 -0800 (PST)
Message-ID: <167d6936-66a2-2953-702d-b269bc26fc7d@canonical.com>
Date:   Wed, 9 Feb 2022 22:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
 <3221dd42-7a14-7ac6-0b61-634a77a45753@canonical.com>
 <b32d1d4b-4188-2e35-6242-5217f1d955d7@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <b32d1d4b-4188-2e35-6242-5217f1d955d7@ti.com>
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
> Hi Krzysztof,
> 
> On 08/02/22 10:35 pm, Krzysztof Kozlowski wrote:
> [...]
>>
>> (...)
>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
>>> new file mode 100644
>>> index 000000000000..f1a46be27c37
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
>>> @@ -0,0 +1,104 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device Tree Source for AM62 SoC Family
>>> + *
>>> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
>>> + */
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/pinctrl/k3.h>
>>> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
>>> +
>>> +/ {
>>> +	model = "Texas Instruments K3 AM625 SoC";
>>> +	compatible = "ti,am625";
>>
>> This is am625, but the file is am62. Why having the split?
> 
> 
> Hierarchy is:
> 
> am62.dtsi:
> -> base SoC skeleton ie arch timers and interconnects which is common
> across am62xx family of SoCs
>  -> includes am62-main.dtsi, am62-mcu.dtsi and am62-wakeup.dtsi
> representing 3 domains and peripherals in each of these domain
> -> describes all peripherals in the family (except CPU cluster)
> 
> 
> am625.dtsi:
> -> describes CPU cluster (Quad A53s). Since, am625 is a current superset
> device with all peripherals, am625.dtsi includes am62.dtsi completing
> SoC definition.
> -> individual EVMs using this SoC will just need to include am625.dtsi
> thus making things easier for Board and SOM Vendors.
> 
> 
> In future:
> am62{1-9}{1-9}.dtsi:
> -> Includes am625.dtsi
> -> Overrides top compatible: ti,am62{1-9}{1-9}
> -> disables CPUs and peripherals not present (cutdowns of current SoC).
> -> -> individual EVM dts files using this SoC will just need to include
> am625.dtsi as starting point, thus making things easier for Board and
> SOM Vendors.
> 
> Top level compatible is set to "ti,am625.dtsi" which is first device in
> family and superset.
> 
> Hope this clears up? Will add this to commit msg
> 

Hm, if I understand correctly: you might have later some future
am6211.dtsi which includes am625.dtsi and in general is compatible with
am625 but with disabled parts?

It's as bit counter-intuitive - I expect compatible to be extended
instead of overridden. But it looks also ok, if you build entire design
around it.

Best regards,
Krzysztof
