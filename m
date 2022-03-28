Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C874E9D23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbiC1RPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbiC1RPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:15:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FEE55A4;
        Mon, 28 Mar 2022 10:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E57EDB80DFD;
        Mon, 28 Mar 2022 17:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFECCC340F0;
        Mon, 28 Mar 2022 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487606;
        bh=TtA3tR95Qmttt08KqNM+3KsekqaxWVlybeCoqzra/Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vH6umZX1E/h9Ko6x4z7JCKYF+kj8iHKtSZz32XXUftTHgDEIGWd6htBCgVLqDV/u5
         lcPhpODzlrgagdaCHHK9viBh7mVldMRI46YhUdNZCtYE1edW2MdRPIW6XDc/xs1+FD
         j6vrYe3TQ4hjIy7q0UjerGCTVlTpRwvbHP3z0FgOj+DLIW37wvqpxfbsXR7mEY+My2
         jfQOMUPypJfwKnBQM1dXoyDspvPGjuHqrMDK8zXXQrqLgAYuzEYIF/hUE6fJucfDRW
         HUVeU10Lde8VPTe2P9cWade12RbgGG1757a8vC7InHvYtrhubuQU4Rr7m5iaaW4uuU
         NiPQlPBzCNy6g==
Date:   Mon, 28 Mar 2022 22:43:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250: move wcd938x node out of
 soc node
Message-ID: <YkHssmiGup+LdIBC@matsya>
References: <20220328143035.519909-1-vkoul@kernel.org>
 <20220328143035.519909-6-vkoul@kernel.org>
 <0b43c297-d0d6-f38f-9609-47fca856aa6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b43c297-d0d6-f38f-9609-47fca856aa6d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 17:21, Krzysztof Kozlowski wrote:
> On 28/03/2022 16:30, Vinod Koul wrote:
> > The soc node expects all the nodes to have unit addresses. The wcd codec
> > node does not have that which causes warnings:
> > 
> > arch/arm64/boot/dts/qcom/sm8250-mtp.dts:631.17-648.4:
> > Warning (simple_bus_reg): /soc@0/codec: missing or empty reg/ranges property
> > 
> > Move wcd node out of soc to fix this
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> > index fb99cc2827c7..3876a94b49a9 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> > @@ -156,6 +156,25 @@ vreg_s6c_0p88: smpc6-regulator {
> >  		regulator-always-on;
> >  		vin-supply = <&vph_pwr>;
> >  	};
> > +
> > +	wcd938x: codec {
> 
> This probably should be under "sound" node. Anyway having it under soc
> seemed incorrect.

yeah it might make sense to be under sound. I think this is a slimbus
codec (right Srini..?) and this should be under slim node..

> 
> I actually wonder where this wcd9380 sits? What type of bus?
> 
> 
> > +		compatible = "qcom,wcd9380-codec";
> > +		#sound-dai-cells = <1>;
> > +		reset-gpios = <&tlmm 32 0>;
> > +		vdd-buck-supply = <&vreg_s4a_1p8>;
> > +		vdd-rxtx-supply = <&vreg_s4a_1p8>;
> > +		vdd-io-supply = <&vreg_s4a_1p8>;
> > +		vdd-mic-bias-supply = <&vreg_bob>;
> > +		qcom,micbias1-microvolt = <1800000>;
> > +		qcom,micbias2-microvolt = <1800000>;
> > +		qcom,micbias3-microvolt = <1800000>;
> > +		qcom,micbias4-microvolt = <1800000>;
> > +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> > +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> > +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> > +		qcom,rx-device = <&wcd_rx>;
> > +		qcom,tx-device = <&wcd_tx>;
> > +	};
> >  };
> >  
> >  &adsp {
> > @@ -627,27 +646,6 @@ &slpi {
> >  	firmware-name = "qcom/sm8250/slpi.mbn";
> >  };
> >  
> > -&soc {
> > -	wcd938x: codec {
> > -		compatible = "qcom,wcd9380-codec";
> > -		#sound-dai-cells = <1>;
> > -		reset-gpios = <&tlmm 32 0>;
> > -		vdd-buck-supply = <&vreg_s4a_1p8>;
> > -		vdd-rxtx-supply = <&vreg_s4a_1p8>;
> > -		vdd-io-supply = <&vreg_s4a_1p8>;
> > -		vdd-mic-bias-supply = <&vreg_bob>;
> > -		qcom,micbias1-microvolt = <1800000>;
> > -		qcom,micbias2-microvolt = <1800000>;
> > -		qcom,micbias3-microvolt = <1800000>;
> > -		qcom,micbias4-microvolt = <1800000>;
> > -		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> > -		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> > -		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> > -		qcom,rx-device = <&wcd_rx>;
> > -		qcom,tx-device = <&wcd_tx>;
> > -	};
> > -};
> > -
> >  &sound {
> >  	compatible = "qcom,sm8250-sndcard";
> >  	model = "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";
> 
> 
> Best regards,
> Krzysztof

-- 
~Vinod
