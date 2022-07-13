Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB397572B11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiGMBtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiGMBtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:49:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B530F67
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:49:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so7406152otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bErvpN7ev2z51mrThK4Hgu7Hu1RI9O6rD8kjQnhV8qI=;
        b=lWMw/oK2XRAciWdm+D60egBwew+3p7ao9Q9uDbs7nBh+whOMEBTyMaHVrbmzTL08e7
         wEYDf4yofg+35r28I9fV8uvi89b7ZzyGW2p7mzJGJF5xX1BM93FGoH2vUcKesibHEl3q
         tHOJQFvEzxB06/+PBF1pdiEKLzyTrbKkoE3NP6Ep1riGHRoL36+2Sv5VniTodb0GRaLP
         vS9baac08sWgqfr7/2wIQbvaA3cZkLi9GVN7zeH8XDzcdAVIdXxVmTmgCDA1FYY9Qp8X
         K3+kvpnfVE8ucW9jXfKH5FdA3nRvQyqW+gE4g/faWkSLSUJbRizBb58Fc5iayKBZ+cCY
         d1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bErvpN7ev2z51mrThK4Hgu7Hu1RI9O6rD8kjQnhV8qI=;
        b=GDJ4KlELKIhrfJXl9v9j9PaeJRpI0Rk+nTEuVgYxtE75JXUVRJFIBZxfVy2NbzFwh+
         7NVKO1RzroYSMFOMgiK9VnE+Vo5v9VM4XvEVfVUyWx1+qPn9iV5G/JrTFGf1KJWr4PaO
         f7OHS4bVCvkUbwvRDYXJOzZdhO5/x2LSS6JP3Sa27mRT9BHG+ZThWcQqyleFCjohknEG
         FaPSbSMyQq2HcveHOXW4ezfFZ7MgyKksjgV9eQSmT030kURuSktUnIYtAqjFGPdfCV4s
         xGYVGufMBlCo84dD0hnPPOtzJxS7QIYLBmlu3cwdvAaMH43Q9gk/dKr+ZsMT5H6ZNpn+
         9Skw==
X-Gm-Message-State: AJIora8TeUnf0WqlzeeahwdRnomM+QZDvRDADCJBvr+WKdP4kkP13D9L
        2WoL2CO8ttoqdR/P0xZa5J6lcQ==
X-Google-Smtp-Source: AGRyM1su3mhYSLe/zS1BVIMxYMxM1iuICQXzpZHD2iwTtpu9eHl+1idrFnYIt7eswUaHo7QJUQd3Jw==
X-Received: by 2002:a9d:6b9a:0:b0:61c:4c90:f94b with SMTP id b26-20020a9d6b9a000000b0061c4c90f94bmr408104otq.245.1657676960219;
        Tue, 12 Jul 2022 18:49:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y9-20020a544d89000000b003331f695f0asm4784882oix.30.2022.07.12.18.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:49:19 -0700 (PDT)
Date:   Tue, 12 Jul 2022 20:49:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppareek@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <Ys4knQAd87bfKW8G@builder.lan>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Jul 11:08 CDT 2022, Bjorn Andersson wrote:

> The timer node needs ranges specified to map the 1-cell children to the
> 2-cell address range used in /soc. This addition never made it into the
> patch that was posted and merged, so add it now.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 2bdb42c88311..37a4cd6f85b6 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1667,6 +1667,7 @@ timer@17c20000 {
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +			ranges = <0 0 0 0x20000000>;
>  
>  			frame@17c21000 {
>  				frame-number = <0>;
> -- 
> 2.35.1
> 
