Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76ED4FE959
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiDLUNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiDLUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:13:29 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BFABF40
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:11:06 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so12487825fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U2+moUFzuYmW2nLDdILkEMMPFcu1fW9OOMvVELagHT0=;
        b=uFUqh5B/7L4v3uQRpLJPc1bgYktm5PjrwYLm/KhgNqKjPM+szw7eMYFwx4I9rTatFj
         Y2BM6uJXqAtC6JxkK5A2rWHeyN94anJRs7DvZglJkcyE7rSnDMAMWgyh4Jy+bMrlvxQk
         Xb7neCNJqLZCcEo2ks2gB1d4xkhTwsY8RN5OssA3KhyhlcsgTBEbEm5b4WZnUhr/rj0M
         RjvKRIU9stH/ID1mKDs/srPD6iMgsVdQ/6XAKB3v8Bp5XBXnbQMPPIz3afK1Y92FKFcZ
         1fbt+KjOyi4mX3LWmmFD/Sx5YAaKpbScOEP1iVVfNesWv6lNl5TpvLKBfVmmtDY9LRp+
         AI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2+moUFzuYmW2nLDdILkEMMPFcu1fW9OOMvVELagHT0=;
        b=aPbal+DcjliLbI6dwFIyrh4ANsrclhBak2yctIhw2sQLccZk3PQg2m9/OTw0xxq5U9
         bE++O3+N8NGmq7zQ9dkf9RPJ8PPydwYTr/s88oOy65HHMU6RspM4JUfky0cV73o7SqLZ
         tMFTbzgQgYGtOceDb/8XAEow2gObpW4eB76JmIR6GFHc89PAl8vqwhAKvEZ3n6Ukt5gJ
         CjsL+MV2hGvpnu5gWljHxC4O/DoFgowNLapQO7szi5E+uE7dJf1jBFfQ0dN0bNYR60zl
         BlYetGXWNaxl5VT3L4lj56SQ4QjNjM9ttSclpaF/bwW06RdkUCLprnNyxc3YzrmnNMkO
         f2UA==
X-Gm-Message-State: AOAM531JuIuTsnUj1AaCgokhzp9eJsVkgB60v16xyNHGHYNjN4VfaXu+
        /Cc2SFgE31AA0O3P2KRxOFuJ55BEQW0Qiw9m
X-Google-Smtp-Source: ABdhPJwjv59IHvp5Pc9P6s+LMF2Rx2MBmezIHXzhxPOJzx2Xm8KRN+D5NWQ+25JBLrOvvBYavdEJLQ==
X-Received: by 2002:a05:6870:a994:b0:dd:fe5c:cdbd with SMTP id ep20-20020a056870a99400b000ddfe5ccdbdmr3134194oab.96.1649794079782;
        Tue, 12 Apr 2022 13:07:59 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568301e7100b005b256697d7csm13718768otr.72.2022.04.12.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:07:58 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:07:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 13/18] ARM: dts: qcom: add opp table for cpu and l2
 for ipq8064
Message-ID: <YlXcHJminisFjobl@builder.lan>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-14-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309190152.7998-14-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Mar 13:01 CST 2022, Ansuel Smith wrote:

> Add opp table for cpu and l2 cache. While the current cpufreq is
> the generic one that doesn't scale the L2 cache, we add the l2
> cache opp anyway for the sake of completeness. This will be handy in the
> future when a dedicated cpufreq driver is introduced for krait cores
> that will correctly scale l2 cache with the core freq.
> 
> Opp-level is set based on the logic of
> 0: idle level
> 1: normal level
> 2: turbo level
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 99 +++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 7dd0b901cd30..a1079583def9 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -48,6 +48,105 @@ L2: l2-cache {
>  		};
>  	};
>  
> +	opp_table_l2: opp_table_l2 {

Please don't use '_' in the node names.

> +		compatible = "operating-points-v2";
> +
> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <0>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1150000>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <2>;
> +		};
> +	};
> +
> +	opp_table0: opp_table0 {

Perhaps you can name this opp-table-kryo, to make it consistent with
opp-table-l2 above?

Regards,
Bjorn

> +		compatible = "operating-points-v2-kryo-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +
> +		/*
> +		 * Voltage thresholds are <target min max>
> +		 */
> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
> +			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
> +			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
> +			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <0>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> +			opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> +			opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> +			opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
> +			opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
> +			opp-microvolt-speed0-pvs2-v0 = <995000 945250 1044750>;
> +			opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1150000 1092500 1207500>;
> +			opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
> +			opp-microvolt-speed0-pvs2-v0 = <1025000 973750 1076250>;
> +			opp-microvolt-speed0-pvs3-v0 = <950000 902500 997500>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <1>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1200000 1140000 1260000>;
> +			opp-microvolt-speed0-pvs1-v0 = <1125000 1068750 1181250>;
> +			opp-microvolt-speed0-pvs2-v0 = <1075000 1021250 1128750>;
> +			opp-microvolt-speed0-pvs3-v0 = <1000000 950000 1050000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <2>;
> +		};
> +
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1250000 1187500 1312500>;
> +			opp-microvolt-speed0-pvs1-v0 = <1175000 1116250 1233750>;
> +			opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
> +			opp-microvolt-speed0-pvs3-v0 = <1050000 997500 1102500>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <100000>;
> +			opp-level = <2>;
> +		};
> +	};
> +
>  	thermal-zones {
>  		sensor0-thermal {
>  			polling-delay-passive = <0>;
> -- 
> 2.34.1
> 
