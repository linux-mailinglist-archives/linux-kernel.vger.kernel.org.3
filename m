Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743B465294
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351577AbhLAQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351484AbhLAQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:16:09 -0500
X-Greylist: delayed 289 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Dec 2021 08:12:46 PST
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109FBC061574;
        Wed,  1 Dec 2021 08:12:42 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4DFC1200D9;
        Wed,  1 Dec 2021 17:12:40 +0100 (CET)
Subject: Re: [PATCH 3/3] arm64: dt: qcom: sm6125.dtsi: Add dispcc
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130212137.25303-1-martin.botka@somainline.org>
 <20211130212137.25303-3-martin.botka@somainline.org>
 <20211201155128.sasoiv3awjcfrjhw@SoMainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <cf1d5ff7-ece9-2348-0862-e23c6486f66e@somainline.org>
Date:   Wed, 1 Dec 2021 17:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201155128.sasoiv3awjcfrjhw@SoMainline.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/21 16:51, Marijn Suijten ha scritto:
> On 2021-11-30 22:21:34, Martin Botka wrote:
>> Add the dispcc node from the newly added DISPCC
>> driver for Qualcomm Technology Inc's SM6125 SoC.
>>
>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> index 51286ddbdb10..78f4705e4117 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
>>    */
>>   
>> +#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
>>   #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>>   #include <dt-bindings/clock/qcom,rpmcc.h>
>>   #include <dt-bindings/gpio/gpio.h>
>> @@ -317,6 +318,17 @@ soc {
>>   		ranges = <0x00 0x00 0x00 0xffffffff>;
>>   		compatible = "simple-bus";
>>   
>> +		dispcc: clock-controller@5f00000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "qcom,dispcc-sm6125";
>> +			reg = <0x5f00000 0x20000>;
>> +			clocks = <&gcc GCC_DISP_AHB_CLK>;
>> +			clock-names = "cfg_ahb_clk";
> 
> It looks like this lacks all the clocks that are supposedly required as
> per the yaml DT bindings provided in patch 1/3 - should those be added
> and set to `<0>` where unavailable, otherwise dtbs_check may not pass?
> 

Yes, Marijn. They should.

Please Martin, add the missing clocks for v2.
