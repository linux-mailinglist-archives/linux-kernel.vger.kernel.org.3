Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302114DC171
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiCQIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiCQIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:38:12 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8A1B98AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:36:55 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 413DF3F1AF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647506214;
        bh=Aenf1r+odjtoHPxCzbMLtD9uL99h+8AF2uxAxyuOS54=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SOY7+yqoqVGrgXOon26npkfqcKGduMBbqY5MBh1VxDRqacF5RDiapODK5PC1ZWIZz
         Pd8VDNun6pquwfWkmVPAbEpW1OgLy4hTOEXixCmOumKolMfFTseHehzL5sjL2zbGi8
         FdS1fNoEMBfwD8KeOZnJkAQXr1UPswvBePD1Rk0RBi7bP6J/pjONDuNrVlanT2vJbO
         823HkSWOsv0rCQiYCyOVdPewqzcQOHdgr4Zm8zUY4QThHM6RxUOeh9zVeCdozyXE21
         +QvsTTQPQIIdH+xyOnShtsb/FDDe64VkaoEW0En9KjdfPHeKJINV+CW1qTQptpiVCs
         SqOph4rF45iZg==
Received: by mail-wr1-f70.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so1307333wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Aenf1r+odjtoHPxCzbMLtD9uL99h+8AF2uxAxyuOS54=;
        b=Gj+xt42wwsmhswRZto8CBBgpLff9jNvOI88REZnVJ7r1o0hPKzRMB+8dXHBWo1joxw
         V7eeqB/ROl6Orrc7Qb86XYN7eO8cCLhd0BnwquAc8L7DYhdqY1EBqffKbMzDOTLHdMss
         Zpm73F4uS+6Kpjulnj0rLln1Qxlh5jFO4rXPr+apVwzQhmSP6tpRUjiDAjGAOm5LSNND
         HRgHRz90OGT1R/oqpyB3sUcXQnOTkU0uKgwO1LaPot4ymYF81u3VdqRSDaPaTi3Lvuul
         GJLvtmbsGz2uImDoTRFvj2mwMjsfaGD59/UclctOLHC1/DPAzTz7XYYUqxNFx+rI/J6A
         ln9A==
X-Gm-Message-State: AOAM532gxY4i20Ae5nx8Dg5CJr04eO0kr/SGR/2ylX9/gymNYcA9if/g
        lpNLICd5UK+c7t1yAdD5FKq1xz7idH5kLy66oBMzo9wHxVuy0f9FvQgNdzNJ/0dQKVuFHIWKeUL
        2J8HmyXat7E2rUTVnnJTtpremYOoHxMQUai9dC+aulQ==
X-Received: by 2002:a5d:6185:0:b0:203:eaa6:7fee with SMTP id j5-20020a5d6185000000b00203eaa67feemr1444639wru.523.1647506213471;
        Thu, 17 Mar 2022 01:36:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJZektFnlITP8f7Plb326+U02zgGEzii73mdienA+JhznN3cxPwQr2vDwz4ClXnOR2D7Jyvg==
X-Received: by 2002:a5d:6185:0:b0:203:eaa6:7fee with SMTP id j5-20020a5d6185000000b00203eaa67feemr1444623wru.523.1647506213260;
        Thu, 17 Mar 2022 01:36:53 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id o41-20020a05600c512900b00389d8c3e2b9sm3787994wms.15.2022.03.17.01.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:36:52 -0700 (PDT)
Message-ID: <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
Date:   Thu, 17 Mar 2022 09:36:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 21:10, Hawkins, Nick wrote:

(...)

>>>>> I think one of previous comments was that you cannot have "generic-ehci"
>>>>> only, right?
>>>
>>> Yes there was, I removed the usb0: ehci@cefe0000. I see now that this is in reference to the compatible. This is our ehci controller. What would be a more appropriate compatible? Do we need hpe,gxp-ehci perhaps?
> 
>> Yes,, see other cases in generic-ehci.yaml bindings. Your current choice would be pointed out by dtbs_check, that it's invalid according to current bindings.
> 
> For some reason when I compile I am not seeing a warning for that file. I have been using "make dtbs_check" and "make dtbs W=1". Perhaps I am missing an important flag?

My bad, I misread the generic-ehci binding, so your compatible is
actually correct from bindings point of view. Still common practice is
to add own compatible which allows later customization.

> In the case of creating a hpe,gxp-ehci binding would I need to add that to the generic-ehci.yaml?

Yes, add your compatible to that big enum with list of many implementations.

(...)

>>>>>>> +
>>>>>>> +		memclk: memclk {
>>>>>>> +			compatible = "fixed-clock";
>>>>>>> +			#clock-cells = <0>>>>;
>>>>>>> +			clock-output-names = "memclk";
>>>>>>> +			clock-frequency = <800000000>>>>;
>>>>>>> +		};
>>>
>>>>> What are these clocks? If external to the SoC, then where are they? On the board?
>>>
>>> This was the internal iopclk and memclk they were both internal to the chip.
>>> For now I am removing osc and memclk and will just have an iopclk that Gxp-timer will refer to.
> 
>> You should rather have a clock controller driver which defines this (and many others). They can stay as a temporary work-around, if you really need them for some other nodes.
> 
> I am trying to picture what you are saying but I am unsure, I know that on a separate review you mentioned that the gxp-timer needed to have clocks, and clock-names inside the node. Would it be improper for the gxp-timer to reference iopclk?

It all depends on the architecture of your SoC. I could imagine such one:
1. Few external (from SoC point of view) oscillators, usually provided
on the board. It could be 24 MHz, could be 32767 Hz for Bluetooth etc.

2. One or several clock controllers inside the SoC which take as input
these external clocks. The clock controller provides clocks for several
other components/blocks. Allows also gating clocks, reparenting and
changing dividers (rate).

3. Other blocks within your SoC, e.g. gxp-timer, use these clocks.

The true question is where is that memclk or iopclk generated? Is it
controllable (gate/mux/rate)? Even some fixed-frequency clocks, coming
out of that clock controller (point 2.), are defined in the clock
controller because that's the logical place for them.


Best regards,
Krzysztof
