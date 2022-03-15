Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8C4D9FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbiCOQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349910AbiCOQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:10:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F542EEF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:09:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso14272747otr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSKsjh6tlY83BKe3eff069HucMWdRlY6fuyM/Q6C3TE=;
        b=s/z/fAyYr7fl/NxStJ0DOkxbJBO5YREjsOZCIJg2MkVW5YNrj0YtJO2qu3LAIUbjQe
         w8eyu1I0GYr2PHtoAC6ERGvuJaDpiGkr1yMN4BecvRSx/ZebwTfBRh9UktA5y+vBdZlc
         hxpznvlWjW5u7ggYI+usFEow8dUcB+wxoTBJYXd2sMrPOjRWj4APKjAFWkdhOZSEVqkx
         OU82U7McW6/PrErEgTKRiUuTnzyjF+5TxDoVVfBwxHVdCAvn7vtlQBwM7v5WOPVnVGop
         1mLj1r4xORy5JHFBvV2GAxaTx646pjp+4HVccHh/PCYTccy+P+mX4vgK0/ScwCoTQIrC
         Q8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSKsjh6tlY83BKe3eff069HucMWdRlY6fuyM/Q6C3TE=;
        b=1TuLBgS3NYrjiaMKtxADKfr4yQjNVYp5kHUe74hJfxdFstM0GwlrZxbNeiHfmkh2I6
         pJHDly3UI7tl5cTp1DaJm+cy1trl9ntUmbEqnxE8KhbVhuPAYLhU9iSitZueUfXDtM8Q
         WEt58qsMVxQv2FKBRCf5Tmudj4HEaEDNnVoN0QkzUNGN4ecvShkAkPyV8B3RRqsvPLzM
         EppAj397AsmpuQiuYXsdBLav7o+vVI5ufzwSjkxcpg0dGo2x0oD+4WrprWrvBfHKpRmR
         toRgM8clR6e3Dpl+tmuUARVDkBh4949p6g/KSPiRKnXE6sR2tur3fSoAIdidTiAzurSb
         w/IA==
X-Gm-Message-State: AOAM533hgX3P5eGhSolb10jqZpQqnzLDq+ML86ZzMXTzs6E05dAZM+LR
        Bi/uGZATKkM3vwYEJYmDFqUDHQ==
X-Google-Smtp-Source: ABdhPJyYrVxAz6LrDABB0+jQOFQfR8/DmFdUbSP0Em05+RNYEaZX3yLBI/V600XgT3mcQBRRknPcDA==
X-Received: by 2002:a9d:1729:0:b0:5b2:3828:c84c with SMTP id i41-20020a9d1729000000b005b23828c84cmr13359647ota.362.1647360574205;
        Tue, 15 Mar 2022 09:09:34 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id z192-20020a4a49c9000000b003213bf4bf0csm8966672ooa.31.2022.03.15.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 09:09:33 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:09:31 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: qcom,pdc: Add compatible for SM8150
Message-ID: <YjC6O5phACatGyL1@builder.lan>
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
 <20220226184028.111566-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226184028.111566-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26 Feb 12:40 CST 2022, Bhupesh Sharma wrote:

> Add the compatible string for SM8150 SoC from Qualcomm.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> index 98d89e53013d..bd3539644d3f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> @@ -21,6 +21,7 @@ Properties:
>  		    - "qcom,sc7180-pdc": For SC7180
>  		    - "qcom,sc7280-pdc": For SC7280
>  		    - "qcom,sdm845-pdc": For SDM845
> +		    - "qcom,sdm8150-pdc": For SM8150
>  		    - "qcom,sdm8250-pdc": For SM8250
>  		    - "qcom,sdm8350-pdc": For SM8350
>  
> -- 
> 2.35.1
> 
