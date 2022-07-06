Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0A568997
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiGFNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGFNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:33:29 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FB28D;
        Wed,  6 Jul 2022 06:33:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E31643F770;
        Wed,  6 Jul 2022 15:33:25 +0200 (CEST)
Message-ID: <837c6cd8-72d9-e7c8-dfd9-e171d809f0bf@somainline.org>
Date:   Wed, 6 Jul 2022 15:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/13] ARM: dts: qcom: enable usb phy by default for
 ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-7-ansuelsmth@gmail.com>
 <eadf03c4-7e4c-e2a0-b20d-6e2dff3af1e3@somainline.org>
 <62c58b03.1c69fb81.527d5.ecc6@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <62c58b03.1c69fb81.527d5.ecc6@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.07.2022 14:59, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 03:04:44PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 5.07.2022 15:39, Christian Marangi wrote:
>>> Enable usb phy by default. When the usb phy were pushed, half of them
>>> were flagged as disabled by mistake. Fix this to correctly init dwc3
>>> node on any ipq8064 based SoC.
>> Are you sure they are used on *all* devices? If not, you will
>> lose power by enabling unused hw..
>>
>> Konrad
> 
> Well there could be device that have no usb at all... so honestly
> enabling one of them is also wrong. Should I disable the other and
> enable it for the upstream device?
We generally disable everything that's not obviously being used by the
SoC internally or is required for components like these for function
(think clock controllers etc) and enable peripherals on a per-device
basis.

Konrad
> 
> Also it's all handled by dummy vbus so i think we can ignore the losing
> power thing. (this thing is old)
> 
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Tested-by: Jonathan McDowell <noodles@earth.li>
>>> ---
>>>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> index b2faa4a067e9..9c32c637ea46 100644
>>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> @@ -1177,8 +1177,6 @@ hs_phy_0: phy@100f8800 {
>>>  			clocks = <&gcc USB30_0_UTMI_CLK>;
>>>  			clock-names = "ref";
>>>  			#phy-cells = <0>;
>>> -
>>> -			status = "disabled";
>>>  		};
>>>  
>>>  		ss_phy_0: phy@100f8830 {
>>> @@ -1187,8 +1185,6 @@ ss_phy_0: phy@100f8830 {
>>>  			clocks = <&gcc USB30_0_MASTER_CLK>;
>>>  			clock-names = "ref";
>>>  			#phy-cells = <0>;
>>> -
>>> -			status = "disabled";
>>>  		};
>>>  
>>>  		usb3_0: usb3@100f8800 {
> 
