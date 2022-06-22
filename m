Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41ED554D83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358725AbiFVOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358718AbiFVOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:36:40 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1343C713
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:36:38 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F179D1FF04;
        Wed, 22 Jun 2022 16:36:35 +0200 (CEST)
Message-ID: <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
Date:   Wed, 22 Jun 2022 16:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
 <YrMccQXwsz/zC/gl@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <YrMccQXwsz/zC/gl@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 15:43, Johan Hovold wrote:
> On Wed, Jun 22, 2022 at 02:33:02PM +0200, Konrad Dybcio wrote:
>> On 22.06.2022 06:12, Bjorn Andersson wrote:
> 
>>> +&qup2_i2c5 {
>>> +	clock-frequency = <400000>;
>>> +
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
>>> +
>>> +	status = "okay";
>>> +
>> I think all device DTs generally have 'status = "okay"' at the beginning. Should we change that?
>>
> 
> No, quite the opposite, status go at the end.
Then all other device DTs should be updated, as in dts/qcom/
everybody keeps it first in non-SoC/PMIC files.

Konrad
> 
> (And please break your lines at 72 cols or so).
> 
>>> +
>>> +/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
>> This comment seems redundant.
> 
> Nope, it's a marker that explains why the pinctrl nodes are seemingly
> out of sort order. We've decided to group them all at the end.
> 
> But sure "- additions to nodes defined in sc8280xp.dtsi" could be moved
> since we also have PMIC pinctrl nodes here (as I just did for the x13s
> dts).
> 
>>
>>> +
>>> +&pmc8280_1_gpios {
>>> +	edp_bl_en: edp-bl-en-state {
>>> +		pins = "gpio8";
>>> +		function = "normal";
>>> +	};
>>> +
>>> +	edp_bl_reg_en: edp-bl-reg-en-state {
>>> +		pins = "gpio9";
>>> +		function = "normal";
>>> +	};
>>> +
>>> +	misc_3p3_reg_en: misc-3p3-reg-en-state {
>>> +		pins = "gpio1";
>>> +		function = "normal";
>>> +	};
>>> +};
> 
>>> +	tpad_default: tpad-default-state {
>>> +		int-n {
>> If you aren't gonna add more pins to this touchpad block, I think you could drop this extra level.
> 
> You'd just lose information (what the pin is used for) with no real
> gain.
> 
>>> +			pins = "gpio182";
>>> +			function = "gpio";
>>> +			bias-disable;
>>> +		};
>>> +	};
> 
> Johan
