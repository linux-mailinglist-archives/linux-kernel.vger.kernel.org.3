Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C14B80B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiBPG2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:28:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiBPG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:28:47 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A10E60D98;
        Tue, 15 Feb 2022 22:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644992908; x=1676528908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7s6sD1LWPbfG0C9fx7gEY8QEL24eAKxRfcYFom9rBv0=;
  b=g1zfSTLATCi8i5/e5+T4JnL7tz/a4G2hGozVkDTScV2qxXxN3zUAO8tq
   yjHsosh1LcWQh9lKwl76pKKCdX97sxpXb9tw4Scl3u9WlkUHvhLueJ8D9
   hJl27Q4XNWa7xnpCODRtWp7z0tmx7wrnchlDyttioSRd6n9lKS7+MkAJO
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 22:28:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:28:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 22:28:03 -0800
Received: from [10.216.36.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 22:27:59 -0800
Message-ID: <bb36a205-fbfe-536e-5bf6-4a717ffd4e6e@quicinc.com>
Date:   Wed, 16 Feb 2022 11:57:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <20220118095255.GB11385@hu-pkondeti-hyd.qualcomm.com>
 <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
 <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
 <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
 <0e006cc0-2760-195a-35b9-0a2f6e8452c5@quicinc.com>
 <47ae3e73-5880-bfb7-fc14-7dd95a75ce14@kali.org>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
In-Reply-To: <47ae3e73-5880-bfb7-fc14-7dd95a75ce14@kali.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steev

On 2/16/2022 8:52 AM, Steev Klimaszewski wrote:
> Hi Sandeep,
>
> On 2/15/22 3:40 AM, Sandeep Maheswaram wrote:
>> Hi Steev,
>>
>>>>>
>>>> Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if 
>>>> you are getting the issue.
>>>>
>>>> Regards
>>>>
>>>> Sandeep
>>>>
>>> I just tested here, changing both of the IRQ_TYPE_LEVEL_HIGH in the 
>>> yoga's dts to EDGE_BOTH and I still do not get a booting system.
>>>
>>> -- Steev
>>>
>> Please let us know what devices are connected to your setup and share 
>> the device tree file you are using.
>>
>> Please share the failure logs also,
>>
>> Regards
>>
>> Sandeep
>>
> The setup is a Lenovo Yoga C630 (Windows on ARM laptop).  I do not 
> have any sort of serial console access to the device, unfortunately.  
> Even when taking it apart, it seems to have some sort of 26pin debug 
> adapter port that I've never seen before which you can see on the far 
> right in this picture of the motherboard at 
> https://i.ebayimg.com/images/g/a2EAAOSwwzZiCxPM/s-l1600.jpg
>
> I do not have anything plugged in to the USB ports (sometimes the 
> power adapter, but I have tried both on mains as well as off.)
>
> I am using this diff
>
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts 
> b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index eab3f00c603235..c54042b9e21df2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -370,7 +370,7 @@
>          reg = <0x15>;
>          hid-descr-addr = <0x1>;
>
> -        interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_BOTH>;
>      };
>
>      tsc2: hid@2c {
> @@ -378,7 +378,7 @@
>          reg = <0x2c>;
>          hid-descr-addr = <0x20>;
>
> -        interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_BOTH>;
>      };
>  };
>
> Which I added as a commit to my kernel tree, and pushed so you can see 
> the full dts here: 
> https://github.com/steev/linux/blob/c8234e664491e35e3edcd211f3b78c04436402b0/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
>
> I am booting with the command line arguments of
>
> clk_ignore_unused verbose module_blacklist=msm video=efifb 
> earlyconsole=efifb
>
> I can't provide a boot log, because I'm not actually getting 
> anything.  Booting a different kernel, and it doesn't appear that 
> anything is logged at all.
>
>
> -- steev
>
Can you try with below change

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0d6286d..0a9c0f7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3796,8 +3796,8 @@

                         interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+                                    <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
+                                    <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
                         interrupt-names = "hs_phy_irq", "ss_phy_irq",
                                           "dm_hs_phy_irq", "dp_hs_phy_irq";

@@ -3844,8 +3844,8 @@

                         interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+                                    <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
+                                    <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
                         interrupt-names = "hs_phy_irq", "ss_phy_irq",
                                           "dm_hs_phy_irq", "dp_hs_phy_irq";

Regards

Sandeep

