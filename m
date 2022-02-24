Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED484C36A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiBXUM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiBXUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:12:22 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88744BBB2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:11:50 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so4677552oib.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekJG5G8qOYobu4hy5MdAQ+syegNXxA4HGg+ZP3ZwyeQ=;
        b=iN+ib84jcK+deSXePxRnEvpZGPxfXggqQq/303xDtJuX1Ju46TszoyPnm0Xsppey3w
         WFz7ih93fSMwHn5aXXMfJa411lHGkQYmMil7aEWRgMd4HDSuXL/4VcipdU64RyKTiOZ0
         g1jl2cr06zHBOqxKLL3lEdLpSPPzBGSQGhSPEM/rWUXdbecD+MhUWvERG4pQiQhD97z+
         EbDi9nfF3DHgq5VhkgOaSPEbnKBWXteUCKblQ+7UZ+iGZkXrym0FH2+pwKvPZnyIlBBb
         9bliCQcvHSTkochiwiFgvQHGpfii2MXpNtv2lB2S+tofG7unEBBy8I4DEhXnZ0+1TeVB
         AbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekJG5G8qOYobu4hy5MdAQ+syegNXxA4HGg+ZP3ZwyeQ=;
        b=B8skypxOReDLLtwdbVmEZxMyd4bhS8uHOMIQs5ftRsVtlnYwX0C3xx3XvnbuC58zfj
         QCq3Us283bj5rCymGMkaQ/26dNWDD46jx/Sf3a9mMBEiOutDnqOYSIcyd/AOOzC2Zz5W
         6r8rDj9cIT/ypJrtjmXImxkG8EuakalKVGU9NJ28iEg7gmeMQYQXCz+F9lwSuSharJ+O
         yXQNFcyx3yASTpu9Km/CsLeRSLwtVq5yv9eUgeIehOx7I6sk12/sdUICeEgW9/BfzBtT
         SVAlxTHYuchVLe7QSyFPDvQt/8WJZQZgl+RyLM5DSetx6uyACOj/pm0r2lCg/TSVXvk9
         AGqQ==
X-Gm-Message-State: AOAM532RVChtqXxoOKQvVvVpZVUirrT+W/D8yNfIOCpWRCwukwZ5lBmH
        dwwc4bnkcMEtYKt5d08efn8j1Q==
X-Google-Smtp-Source: ABdhPJxxfBYAXQE4a4MShIJEhHE9ZwowoSa5/DZAC6IXOvyO1dx/+N2+rRF67FGwId7kao1AxTBGfA==
X-Received: by 2002:aca:b688:0:b0:2d3:5411:9bc0 with SMTP id g130-20020acab688000000b002d354119bc0mr8152354oif.192.1645733509883;
        Thu, 24 Feb 2022 12:11:49 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id q4-20020a056808200400b002d51db97398sm229191oiw.24.2022.02.24.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:11:49 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:11:46 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: usb: qcom,dwc3: Add msm8953
 compatible
Message-ID: <Yhfmgm2i5h7zEuvA@builder.lan>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
 <20220220201909.445468-4-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220201909.445468-4-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 20 Feb 14:18 CST 2022, Luca Weiss wrote:

> Document the compatible string for the DWC3 controller in msm8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Acked-by: Rob Herring <robh@kernel.org>

Greg, can you please pick this patch through the USB tree.

Thanks,
Bjorn

> ---
> Changes in v2:
> - no changes
> 
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 2d23a4ff702f..ce252db2aab3 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -16,6 +16,7 @@ properties:
>            - qcom,ipq4019-dwc3
>            - qcom,ipq6018-dwc3
>            - qcom,ipq8064-dwc3
> +          - qcom,msm8953-dwc3
>            - qcom,msm8996-dwc3
>            - qcom,msm8998-dwc3
>            - qcom,sc7180-dwc3
> -- 
> 2.35.1
> 
