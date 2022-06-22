Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293B5545FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355939AbiFVIxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351982AbiFVIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:53:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6833E3A;
        Wed, 22 Jun 2022 01:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDF22B81CEE;
        Wed, 22 Jun 2022 08:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88973C34114;
        Wed, 22 Jun 2022 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888026;
        bh=iSb5M17woSiTADzSijbtIRw8hX+XtC+OWCTSk3ksZCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2RaElH3dn6s/QduGLVM2i8PXTKLbEhqqB6eprDa+Tjfq/QBvyRe7LWGSXIUEBIBG
         MnRXUdAFTKc3k0RDXaNs33NnRz3iXwHASJaFt9JKIriwf1bc6unCWwB9jMp7+nxZgg
         exe3ZNrZgHxM4AXE2KeTppw1SPYlUd/5OxPI4krwZfyqM/88/VfI4u9FnOJFxkPfd1
         om/2Zs8gSTT/Nukijmgu6sNp3fps6e9RQ4kFcuDObcQmq00E2SWMdb6Cx0rYz4fFA1
         Ttn4YR5KP/B+P/0sPUarUyvWVgaWqgeb2PAsmk1f79P4md0kRNQbYc8c7gtgEPypsm
         VWQ46CXvgD+Zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3w7K-0002Vz-A4; Wed, 22 Jun 2022 10:53:43 +0200
Date:   Wed, 22 Jun 2022 10:53:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YrLYluEf292Jqgti@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041224.627803-4-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:21PM -0700, Bjorn Andersson wrote:
> Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> tsens.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Reordered "status" last
> - Fixed invalid unit addresses on USB phys
> - Dropped multiport USB controller for now
> - Fixed system-cache-controller sort ordering
> - Moved &xo_board_clk frequency to board dts
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2145 ++++++++++++++++++++++++
>  1 file changed, 2145 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> new file mode 100644
> index 000000000000..ac13965a181e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi

> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <602>;
> +			next-level-cache = <&L2_100>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			#cooling-cells = <2>;
> +			L2_100: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +

Nit: stray newline you can drop when applying.

> +		};

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
