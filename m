Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195151D1DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387897AbiEFHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387510AbiEFHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:06:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2666CAA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:02:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 6so5404703pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=13k3PBLqNjSNAheQGYeJGSc/vGgqstggAS/MUUkmnNo=;
        b=ovO+GtGRnthGiYn9dClvWnTfzAhT4SsoGNH8Ctg3gmnFuAiadmwrRUPosYDyXpUfge
         +zcNLImoDpQmpVG4P3wuLzJxEzpL5JrezqHZKvDPEJ5PAiaP0esJcNRYWY1NSAVZZCtw
         bG6u/5kGZ6PpdZHmaw9nQNDkpN4P3Te0YjyaTQK+1iM9RU8JjLW9I+2TeS1U1NjPdaM6
         9PUhsMJSX81N66uHd6/AU9S+1ZlQvd9YQHwZFj7YOoK3LKiHgYYZUm6TfAignMSnVjJL
         kHD6KQzrpnCi540o+cTBb3i7HSVGmqcepOlysSn3mL3Q0OuIwdzI05tqLQKDC44bDyGz
         LiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=13k3PBLqNjSNAheQGYeJGSc/vGgqstggAS/MUUkmnNo=;
        b=q1nBJEUPNg/nHZOVGQm01yCannTrjCSyNCG2TSBvyFKX4yT1nSsgaGMt1vx/OFvid4
         e0n4Kju757HWCbydVnUskI5QQdtBoTpQMq5DsMEYPsxdY64ksDJ/xGeyU3QkKdZidgNu
         WyMMC+gLWd4wIrI9nLALGxhF89/4fKKjpH0XTSuhqWna4wGrjPH8YiCxDwzeyOjvVSNS
         IzZ/Xzvzg4AWLCzVcnUTDaNxzj7mu30Gyw7FLS9wLrW5Se68PyTHB7bLLf4+nUbCOBcg
         cFbhjn7pJpqFx3RdpoDBAL8gszN5FuRvCQ42j34ZGYu8GUpLTGgB3NnkQhtUvNkN2sFc
         S1FA==
X-Gm-Message-State: AOAM532+PPghaMQMQxedT36r0RQb4n1Yss3NefrdHEET5ZkKbBNDgBoV
        p1zKAtRPxGHrDcUNpWFdjrYx
X-Google-Smtp-Source: ABdhPJwTJUXc4jIEmdkZV2TR1zmpuViWfbET6q7Y2wkf6pw4cmZrF6UvnObA0qGCFbBlmfri/fA4Mg==
X-Received: by 2002:a63:43c2:0:b0:3c1:829a:5602 with SMTP id q185-20020a6343c2000000b003c1829a5602mr1682995pga.252.1651820555533;
        Fri, 06 May 2022 00:02:35 -0700 (PDT)
Received: from thinkpad ([117.207.26.33])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b0015e8d4eb1ddsm868303plp.39.2022.05.06.00.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:02:34 -0700 (PDT)
Date:   Fri, 6 May 2022 12:32:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ARM: dts: qcom: sdx65: Add interconnect nodes
Message-ID: <20220506070229.GB17659@thinkpad>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651482395-29443-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1651482395-29443-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:36:32PM +0530, Rohit Agarwal wrote:
> Add interconnect devicetree nodes in SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 57bda62..d989837 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -139,6 +139,26 @@
>  			status = "disabled";
>  		};
>  
> +		system_noc: interconnect@1620000 {
> +			compatible = "qcom,sdx65-system-noc";
> +			reg = <0x1620000 0x31200>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		mem_noc: interconnect@9680000 {
> +			compatible = "qcom,sdx65-mem-noc";
> +			reg = <0x9680000 0x27200>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		mc_virt: interconnect {

If there is no "reg" property then this virtual node should be moved outside of
"soc" node. Please refer sm8450.dtsi.

Also the rest of the interconnect nodes should be sorted. I know that you are
following sdx55, but the nodes were not fully sorted there :/

So please fix it too.

Thanks,
Mani

> +			compatible = "qcom,sdx65-mc-virt";
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x01f40000 0x40000>;
> @@ -401,6 +421,11 @@
>  					};
>  				};
>  			};
> +
> +			apps_bcm_voter: bcm-voter {
> +				compatible = "qcom,bcm-voter";
> +			};
> +
>  		};
>  	};
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
