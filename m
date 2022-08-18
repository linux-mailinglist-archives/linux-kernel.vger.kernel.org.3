Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B25982DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiHRMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244478AbiHRMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:00:55 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1EFC0;
        Thu, 18 Aug 2022 05:00:53 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8F3FA3F5F8;
        Thu, 18 Aug 2022 14:00:51 +0200 (CEST)
Message-ID: <93bf4dde-40e9-6d17-363b-66db124af814@somainline.org>
Date:   Thu, 18 Aug 2022 14:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 14/14] arm64: dts: qcom: sm8150: switch TCSR mutex
 to MMIO
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
 <20220817130342.568396-15-krzysztof.kozlowski@linaro.org>
 <15fb94b1-e901-c139-3f83-21922ae28c35@somainline.org>
 <4aea569f-38c1-953c-8293-25d6fb5e4477@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <4aea569f-38c1-953c-8293-25d6fb5e4477@linaro.org>
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



On 18.08.2022 09:04, Krzysztof Kozlowski wrote:
> On 18/08/2022 00:07, Konrad Dybcio wrote:
>>
>>
>> On 17.08.2022 15:03, Krzysztof Kozlowski wrote:
>>> The TCSR mutex bindings allow device to be described only with address
>>> space (so it uses MMIO, not syscon regmap).  This seems reasonable as
>>> TCSR mutex is actually a dedicated IO address space and it also fixes DT
>>> schema checks:
>>>
>>>   qcom/sm8150-mtp.dtb: hwlock: 'reg' is a required property
>>>   qcom/sm8150-mtp.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 13 ++++---------
>>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>> index 7d509ecd44da..dc6770391813 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>> @@ -585,12 +585,6 @@ scm: scm {
>>>  		};
>>>  	};
>>>  
>>> -	tcsr_mutex: hwlock {
>>> -		compatible = "qcom,tcsr-mutex";
>>> -		syscon = <&tcsr_mutex_regs 0 0x1000>;
>>> -		#hwlock-cells = <1>;
>>> -	};
>>> -
>>>  	memory@80000000 {
>>>  		device_type = "memory";
>>>  		/* We expect the bootloader to fill in the size */
>>> @@ -2054,9 +2048,10 @@ ipa_virt: interconnect@1e00000 {
>>>  			qcom,bcm-voters = <&apps_bcm_voter>;
>>>  		};
>>>  
>>> -		tcsr_mutex_regs: syscon@1f40000 {
>>> -			compatible = "syscon";
>>> -			reg = <0x0 0x01f40000 0x0 0x40000>;
>>> +		tcsr_mutex: hwlock@1f40000 {
>>> +			compatible = "qcom,tcsr-mutex";
>>> +			reg = <0 0x01f40000 0 0x20000>;
>>> +			#hwlock-cells = <1>;
>>>  		};
>> No replacement for the trailing 0x20000?
>>
> 
> There is no user of it, so I did not add. I could add remaining block
> just for completeness.

Please do, maybe even in a separate patch so as not to resend the entire
series needlessly.

Konrad
> 
> 
> Best regards,
> Krzysztof
