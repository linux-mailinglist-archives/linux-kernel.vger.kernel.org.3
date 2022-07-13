Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BBB573881
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiGMOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiGMOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C261326FF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657721555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhNVgFhX89B7Or7dxJO6r91xjY7lqXIdMrL3sFKe62o=;
        b=F6qLBuj9pKEp6bXdUjd6VVQrE7ky+YlCw+mVa79DE85vIIGH3+p6pyMpRzAdIrP44/nBic
        l+p8+jJlpcPLYKJ88ale6dC0iW7yodHat9G6MQZG2IUHbUwyQYPsvpSIt36FXo2TOlU6La
        0VDi7amcNGKaVERKuFlcHraFYmW0eKo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-nYOuzBz5Oa-QQHeb58jLNQ-1; Wed, 13 Jul 2022 10:12:33 -0400
X-MC-Unique: nYOuzBz5Oa-QQHeb58jLNQ-1
Received: by mail-oi1-f198.google.com with SMTP id ay32-20020a056808302000b002f96abff093so7051926oib.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YhNVgFhX89B7Or7dxJO6r91xjY7lqXIdMrL3sFKe62o=;
        b=vD0AFl3XE5MSHC0H+eGxUQGh9ZQL1+9F3ti41e3iq3WCQ01QwOVEjx/Ku13hea6YdQ
         xKWtEAvEnWrWq2iN9XCKD8e4wfuU9uDX1MDVWzapW3iKvCtbiRS+xAEy0KihE/Qek4PX
         KBqCduQnZQMfQvZWLlHD2VjsC3hyl0fvAJe5fiH+03zTe1DLyE0bgi2lDcy1zaocEtF1
         +SA286uO2pFC7rfb6C6hkqKmW/WkUTptf1Nbmd4fFWbGIdU5Mtw1cRNSgtyJuB653CTw
         QLekjXYJgRszV6CLRQp+XyCpC8KQNc+yT1kPiZcMZBSYT5tAnQtnEPXUnyS8dKYQVqdX
         o5lQ==
X-Gm-Message-State: AJIora/bkhy8aRxFrnQ6ZF1H4bDhiPFAKsQhupYnUoA0NDdeiGaK3yRP
        cOfm1zwJbt1wB3PUCa4Kmz3NjBxBLPyab5/IXV89CobXOs5h5hrGSpT3A8fNcZRUH2w4JadPb+j
        fKjH17+MM5yrmkaYW+ONAA5Xf
X-Received: by 2002:a05:6870:73c7:b0:10c:24de:63d4 with SMTP id a7-20020a05687073c700b0010c24de63d4mr1824442oan.76.1657721551042;
        Wed, 13 Jul 2022 07:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spJxbEpfi2ss2QX18y+16qhda8NVczHl6f2bXHBKRgiIdBeWnn3ihlz7RHzcUQDgWHPCHuqg==
X-Received: by 2002:a05:6870:73c7:b0:10c:24de:63d4 with SMTP id a7-20020a05687073c700b0010c24de63d4mr1824432oan.76.1657721550855;
        Wed, 13 Jul 2022 07:12:30 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id t17-20020a056830225100b00616929b93d6sm4860341otd.14.2022.07.13.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:12:30 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:12:28 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sc8280xp: fix USB interrupts
Message-ID: <20220713141228.5z5rmgepj6mepjyp@halaneylaptop>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713131340.29401-6-johan+linaro@kernel.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 03:13:38PM +0200, Johan Hovold wrote:
> The two single-port SC8280XP USB controllers do not have an hs_phy_irq
> interrupt. Instead they have a pwr_event interrupt which is distinct
> from the former and not yet supported by the driver.
> 
> Fix the USB node interrupt names so that they match the devicetree
> binding.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 45cc7d714fd2..4a7aa9992f3a 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1875,8 +1875,10 @@ usb_0: usb@a6f8800 {
>  					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 138 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> -					  "dm_hs_phy_irq", "ss_phy_irq";
> +			interrupt-names = "pwr_event",
> +					  "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq",
> +					  "ss_phy_irq";
>  
>  			power-domains = <&gcc USB30_PRIM_GDSC>;
>  
> @@ -1925,8 +1927,10 @@ usb_1: usb@a8f8800 {
>  					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 136 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> -					  "dm_hs_phy_irq", "ss_phy_irq";
> +			interrupt-names = "pwr_event",
> +					  "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq",
> +					  "ss_phy_irq";

For this specific change to pwr_event:

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

That being said, I was reviewing this against the (fairly old)
downstream release I have, and the IRQs defined there look like this:

		interrupts-extended = <&pdc 12 IRQ_TYPE_EDGE_RISING>,
				<&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
				<&pdc 136 IRQ_TYPE_LEVEL_HIGH>,
				<&pdc 13 IRQ_TYPE_EDGE_RISING>;
		interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
				"ss_phy_irq", "dm_hs_phy_irq";

The part I want to highlight is that the "pwr_event" irq downstream maps
to <&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>, but the current upstream
devicetree I'm looking at has it mapped to <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>

Do you happen to have any source you can also check to confirm if this
is a bug or not?

Thanks,
Andrew

>  
>  			power-domains = <&gcc USB30_SEC_GDSC>;
>  
> -- 
> 2.35.1
> 

