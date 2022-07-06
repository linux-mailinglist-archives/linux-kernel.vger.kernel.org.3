Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8E568911
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiGFNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiGFNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:11:12 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769020191;
        Wed,  6 Jul 2022 06:11:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 50E293F215;
        Wed,  6 Jul 2022 15:11:06 +0200 (CEST)
Message-ID: <a56f2941-b386-19f3-a6ad-b5a0738c8458@somainline.org>
Date:   Wed, 6 Jul 2022 15:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-10-ansuelsmth@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705133917.8405-10-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 15:39, Christian Marangi wrote:
> Add missing smem node for ipq8064.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
I can't find a downstream kernel for these router SoCs, but
I wonder if the 8x64 family DTs couldn't be somewhat
unified? It looks like they share quite some code..

Konrad
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index b5aede3d7ccf..98527a7d885e 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		sfpb_mutex_block: syscon@1200600 {
> +			compatible = "syscon";
> +			reg = <0x01200600 0x100>;
> +		};
> +
>  		pcie0: pci@1b500000 {
>  			compatible = "qcom,pcie-ipq8064";
>  			reg = <0x1b500000 0x1000
> @@ -1332,4 +1337,17 @@ sdcc3: mmc@12180000 {
>  			};
>  		};
>  	};
> +
> +	sfpb_mutex: sfpb-mutex {
> +		compatible = "qcom,sfpb-mutex";
> +		syscon = <&sfpb_mutex_block 4 4>;
> +
> +		#hwlock-cells = <1>;
> +	};
> +
> +	smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem>;
> +		hwlocks = <&sfpb_mutex 3>;
> +	};
>  };
