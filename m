Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6403F57393C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiGMOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGMOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09EDD3C14D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657723918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ikv0yYnyHu88PsTI9SYSW6P6SO9b6N9X5DEilUKoCmA=;
        b=Os+QiSbnX7jx5rdZHbSJg99+2yZEUPwH8WgFxiy4Z85kJihkMpcwyw/mWl9Z/FOkcKWrj4
        keHwCNgzTfWgwi5oXS1lRy8NYVUE703QiCS1SB85JiSk3ovJJPFQuTlj6SoZUr4lYVEB7M
        UAGlEn7VVA4PY6UMjSNb4kjqQlAAzDw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-nSd_J7AZM8WVroYSqrn_sQ-1; Wed, 13 Jul 2022 10:51:57 -0400
X-MC-Unique: nSd_J7AZM8WVroYSqrn_sQ-1
Received: by mail-qv1-f72.google.com with SMTP id lp7-20020a056214590700b004733d9feaf6so3863781qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ikv0yYnyHu88PsTI9SYSW6P6SO9b6N9X5DEilUKoCmA=;
        b=gF3pBlBTAJTiMHPp3GwnE1O0QLbNkhuFoAo7CXg1l5nmCCVzTqo2HT+S/hOPZvqR+Q
         QxRfN3NckSVMcDag34MLlb4ZIo7kPSd8RNZZrCzW5jhYJ2jof4wnR5URZNSfMXqBtTxs
         OAJr/uzcP0kYdqGUssjfX50zYq3bcUKUgts4n2GTkptLP+qRFsjmulDtQrq1st0T+E8g
         9MPuE2phgT2a9Jx9SFL+Tt8E0mxJmks1KbdKasByNV0C+WyMYR+HmpImGK4fA/yiKPs1
         AZzr5bseYhzOt223yTiLt2qFXvLsGFFLukSiVPvr7A5y/dTPJLGLLxXkmN1qX3daAlWi
         yx+g==
X-Gm-Message-State: AJIora/2JuSVpbnyGIz0KtgJRzeD1ZpStcu84dpW+J2pZiPQZuO5/qH4
        8TvssZen/7x4DsNaQ84NAOLyzgX0i6n57kjRXosa4inqBfaJ6QpW9XupJXaON60xb7ykD2+xp0n
        LxUF6FMqFMji1BBs2usFKygLJ
X-Received: by 2002:a37:48c:0:b0:6b5:652e:de46 with SMTP id 134-20020a37048c000000b006b5652ede46mr2644414qke.714.1657723916395;
        Wed, 13 Jul 2022 07:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uTFR8vE33A5iuBwNe9uo1BBClQFZiEvQzoa9rbYphjZn84xJH7w0tkL11pTm1Ylbi4ETILLw==
X-Received: by 2002:a37:48c:0:b0:6b5:652e:de46 with SMTP id 134-20020a37048c000000b006b5652ede46mr2644393qke.714.1657723916059;
        Wed, 13 Jul 2022 07:51:56 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id t16-20020a05622a149000b00304e33f21f7sm10645897qtx.68.2022.07.13.07.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:51:55 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:51:52 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix PMU interrupt
Message-ID: <20220713145152.32igy7dmg7qvm6jk@halaneylaptop>
References: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:04:29PM +0530, Manivannan Sadhasivam wrote:
> PPI interrupt should be 7 for the PMU.
> 
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Reported-by: Steve Capper <Steve.Capper@arm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 268ab423577a..2d7823cb783c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -477,7 +477,7 @@ memory@80000000 {
>  
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
> -		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	psci {
> -- 
> 2.25.1
> 

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

