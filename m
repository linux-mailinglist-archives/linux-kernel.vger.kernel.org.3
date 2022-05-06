Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68C51D1E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388019AbiEFHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388003AbiEFHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:06:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AD66F81
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:03:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i17so6560401pla.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F19jIwyBVlqKMdykt41Q7f//ocpfNmr5NOzeplC5G5w=;
        b=ogrvzM6iqy3KwH0ms6MP6G2/s90Gft5EaGKAX5zfAnX/Hbqzl6R2LRCVLsEQ3yi9On
         Rli7baa78j/LFSUV79NtRRZSlB2EyJOa7tMy+D88ZBFf+QQAMmm18Yf8D89FYyOqnOw7
         Oti+7FdQO15moK1+nZ7zaclJhvzT4djSsW+B9g07dPIxr2VV7ut7hxfor9+RcqBoZAl9
         qUS4JPrQ0W4Y2DGg8a5Bs4iFYjXQLrI6r8ucdKHcGiLaqzlbOx1gvlQ3v5NfFtimR0C0
         cSTCR1PecLbpN4IkB8mIz0kInWQi+GbwWC9bSTWF5ZI4dXMwVrLbV9yVN03e7E6XSWVJ
         ijFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F19jIwyBVlqKMdykt41Q7f//ocpfNmr5NOzeplC5G5w=;
        b=VE7PFAZaosRA7qnQ72r8olVZWXuO7tIg6ndkqcq8t1jEM3xfM7A2qdPR9Efv0tM1bH
         LnjtMsKGbe4R5SJyGp+d8CsGU/s139fJItIw+ImGs8NjwDXwuo4JB1EKhTZ6WpeAdyPs
         J8CepPDoGWAyOuWiNqjvKuYTGnihjBYhOia8YakTCdQ4MSfkY2GhqxR1vgjv7+4B57qv
         nePFsVeZBVScmeeRibJxlcnkYxaTANWSaU9fNNOeGl7pFQJaoL73fE1R/wtYnnZK6ZCe
         sHafZYCgtHOQwBs0hpNHf9Sg72dLnbVrCnnprOKqgI6ztnEKbM1QZAbWUn/HNFHIMhON
         AUYw==
X-Gm-Message-State: AOAM531Ad2f3yNnece9Dafj7fC7G2MQNbxP77RhHk83VzDIIQsZHPDGi
        8AbYACssDxCq2IgA51ztyY+e
X-Google-Smtp-Source: ABdhPJxy607QTlaHdUPAAi2ibFNf8nIKgM1zv7iQwTMBJC/7xtJ96tBBAqwjPdQQVLCki9bQ05PTBQ==
X-Received: by 2002:a17:902:d48a:b0:15e:a142:a9e8 with SMTP id c10-20020a170902d48a00b0015ea142a9e8mr2246780plg.129.1651820585252;
        Fri, 06 May 2022 00:03:05 -0700 (PDT)
Received: from thinkpad ([117.207.26.33])
        by smtp.gmail.com with ESMTPSA id t17-20020a63d251000000b003c574b4a95dsm2529003pgi.53.2022.05.06.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:03:04 -0700 (PDT)
Date:   Fri, 6 May 2022 12:32:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: qcom,dwc3: Add binding for SDX65
Message-ID: <20220506070258.GC17659@thinkpad>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651482395-29443-3-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1651482395-29443-3-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:36:33PM +0530, Rohit Agarwal wrote:
> Add devicetree binding for SDX65 USB controller based on
> Qcom designware IP.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index ce252db..2d73b03 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -24,6 +24,7 @@ properties:
>            - qcom,sdm660-dwc3
>            - qcom,sdm845-dwc3
>            - qcom,sdx55-dwc3
> +          - qcom,sdx65-dwc3
>            - qcom,sm4250-dwc3
>            - qcom,sm6115-dwc3
>            - qcom,sm6350-dwc3
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
