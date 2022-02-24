Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA81D4C366A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiBXUAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiBXUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:00:12 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597D2763F9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:59:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 12so4571890oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HBUQkf1c18D3IhqFKKwGMruvkg+pP4vMasYemb3Ge/g=;
        b=cPb4xYwq2xRZS+pSueX4DQu6ZCDCLqP2zEW/h7owqO6uHVQvOrk1zoIh8Q1RdX66Qh
         UhdMCHKoc+l6RL0gUHi2lJybdQa0+l+lOLGjDnsAT5lHaP+4HBKT1rlAzaGhHG4Z2ghY
         TxnimbdvqiPMQABvzhR7jfiurKiOHqdg6HGzGpzfzTXyjPd1x1INf91bmhVlq8uCMp3K
         LIxxahS79FRl4FMaUlNBEsgXQgq9fRfD4RhET4p6G1xG0tPxUxsRY4bgxnOoNE7aNzuC
         18damqu6g9V8qVAkTVXzRO8LJfvD77VHUTqgCFd2mDt0R7UtU9F6YDh4t7uDieeiWIH6
         3pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBUQkf1c18D3IhqFKKwGMruvkg+pP4vMasYemb3Ge/g=;
        b=ZeIS+RgGmYF6LPPl1LeCv8zw8USF+fsKaDrB6KRwIwj/aQnCuDOl8hJIfINB3oSaTF
         sbsQr1iHQhZWg6ArTRtZ5OcPP8BKdvCl5A3MWktX1B/T0diet7w4CPP9Qfkeu/7FfVzX
         aGs4fHDQpPLgwt71J0z75CzfEjz2aLfRWOVJl7HN5qdkw5JJL1DuIw7v+ePK16v5wQbw
         dNXqSQMpsuLvM7/b4DcY9lGazrkfMN2T3vL8+t9TbOi6jKiUZ7jAJvvBKQ2HoG4JP/hp
         wc3t4EOPIKH+4U4vUwwD9wCChy7zngFVWuJjIAC434iPpERmA25qR/0pcsQCOUEwFFv5
         6ePw==
X-Gm-Message-State: AOAM531gSNtWMs5vGVDAHYB/jw/eR9y6MHgW01JTzaknMCjpYRyTKwVL
        0cHcT7nJCygGI+Q0JLf+3mFzQA==
X-Google-Smtp-Source: ABdhPJygt08vCBVo/UgfpVMiox5duayX+DsGCbmNeAge1yQH/WLLoKbK6XrUt+uABY6Q/U/7ApF/Uw==
X-Received: by 2002:a05:6808:56b:b0:2d4:5f04:f2fa with SMTP id j11-20020a056808056b00b002d45f04f2famr8135225oig.96.1645732781147;
        Thu, 24 Feb 2022 11:59:41 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bf39-20020a056808192700b002d51f615f1csm235794oib.34.2022.02.24.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:59:40 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:59:38 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     robh+dt@kernel.org, ohad@wizery.com, agross@kernel.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, mka@chromium.org,
        krzysztof.kozlowski@canonical.com
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7280: Add proxy interconnect
 requirements for modem
Message-ID: <YhfjqsrHhbU36OqH@builder.lan>
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
 <1644813252-12897-4-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644813252-12897-4-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Feb 22:34 CST 2022, Sibi Sankar wrote:

> Add interconnects that are required to be proxy voted upon during modem
> bootup on SC7280 SoCs.
> 

Looked at this again, and it makes me wonder why do we need to vote on
the path LLCC -> EBI1 and why do we call that path "imem"?

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index 9f4a9c263c35..1969f4cf59fe 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -89,6 +89,8 @@
>  	compatible = "qcom,sc7280-mss-pil";
>  	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
>  	memory-region = <&mba_mem>, <&mpss_mem>;
> +	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> +	interconnect-names = "imem";
>  };
>  
>  /* Increase the size from 2.5MB to 8MB */
> -- 
> 2.7.4
> 
