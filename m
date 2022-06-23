Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97EC55728B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiFWFXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFWFW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:22:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C36D10BB;
        Wed, 22 Jun 2022 22:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0CC8B821A2;
        Thu, 23 Jun 2022 05:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9030C3411B;
        Thu, 23 Jun 2022 05:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655961775;
        bh=owDuiE+iIDj2pyw4w03M5oR6ZHfgA91fiInMpPvY13Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTlg4+cyCkA0EtoKWKMe3hwZCC6Wre+VNBGmfoeYJmStXxHliAFqgzA3lqJ9SltBq
         STcw4twrXLkLqhX7iobS0TkirvVtQqtqgvgVf8e+YwG9Kfw+V9SGMtFwmo5jNCBYUE
         DlWbBhzG8C3hKyFL96BbGWHlW83fqcR3KViuua9Krn+zyyxsFaHm08yv0ELZNTjvlG
         3SNkpgN4JNjar66tsfnXHFTjPgBX+F5yJw28Cx7r4cTiztoqlK2B7O/KOqm+waAHf0
         AXHOwUx+OSjwCm2vyk5lOJvNqkfCeG16jK7Mbgx+Dj9uxkeh72mgmu4ws0mT4aoHDd
         BRcxpb5rUNjfg==
Date:   Thu, 23 Jun 2022 10:52:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YrP4qs+GIlaS7Wzy@matsya>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607214113.4057684-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-22, 14:41, Bjorn Andersson wrote:

> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";

Generic kryo and not kryoxxx?

> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-sc8280xp", "qcom,scm";

I dont see patch documenting this compatible, was it added earlier, if
not pls add..

> +		};
> +	};
> +
> +	aggre1_noc: interconncet-aggre1-noc {

s/interconncet/interconnect

Hmmm I thought it was required that node name should be interconnect@x

> +		qup1: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0 0x00ac0000 0 0x6000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			iommus = <&apps_smmu 0x83 0>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +		};

why add this, if no i2c/spi/uarts are defined under this..?

> +		usb_0_hsphy: phy@88e5000 {
> +			compatible = "qcom,sc8280xp-usb-hs-phy",
> +				     "qcom,usb-snps-hs-5nm-phy";
> +			reg = <0 0x088e5000 0 0x400>;

this doesn't match with node address above (I think W=1 would warn you
of such mismatches, useful to run on new dts

> +
> +		spmi_bus: spmi@c440000 {

Is the new v7 spmi or older one?

-- 
~Vinod
