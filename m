Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD54FE8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358952AbiDLTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358965AbiDLTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:33:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92D48E7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:30:48 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso14050122ots.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aCVxPSm0uTRhRMeo9G7lwXu5Dd9Hg2ilAqo4ZKpYC5E=;
        b=t8lvK28JV09j7gDhXW855zKKcRPxFUomohHzI1FrhYI1GfBMf9IRV07109hIum+ZMy
         /63lrqsPbKLc7q35hKmxaSLVuW9BDiAJ2PiJu0U9hLiBzMaQ8aTsld26t3gpe7m4DNeJ
         eJmhPCZqkx7silh+LsV1FF8k/GFc8ITh11LGtN43SfEJCZhicmMwVl9qgSF+AAkDo5Va
         CfNQxSZI+RQjG1RRHPrrSzHAoDy9DWYCwkAV3UGmRymKxiiwQwcmwOz394k17Rgp7LFi
         pWFU6ryAmPmohP0ZwnQlrhjeuLC3JDxYG7ztEWHNUOneGLJSpykihVcR4rFbG5mgMtrF
         Tfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aCVxPSm0uTRhRMeo9G7lwXu5Dd9Hg2ilAqo4ZKpYC5E=;
        b=c5tbYwKZ4REVWe/2dFN4xGtDKGGdGzan3lS1Oj1qPUHTh90K8sHJSRk1LjeAHe5763
         M7I/QTAs4bwXXWzipyPZ+XhisxMWUgL11/4tQRqqyWqtqyo8hfQB2F8dpwfdA11LOkSi
         u0rSovmmx6qoCVWogcHINPagvRCRIMjFvNVbAwWcTuv0Z1Hu8rrEIqYBCadpAGFREZ04
         +9BvW6JW1utk9mJoE/2B95+iZWox82XNbE2I+beUAetH8nbulvR7X9pqhxRpqc22G7us
         oKy8/4STs4FnJYnds2b+pTXpY+dvzOvq1mUzcbhba9nVUjpZx9kGUUH86o4UqrjoYKH7
         fUFg==
X-Gm-Message-State: AOAM530qmXTcAqYANXWUQE33QIogp86prg8uRFaEFX/Yt33i2iSylHdo
        +do0u39racJWnOv+E7ZMzsUOLg==
X-Google-Smtp-Source: ABdhPJy3LQycPDu4hDJNVv/MgO6q8PgjxQnbVUjw9fu+Cl4bhIOfEIG07xQbOJW9Er4vH2+n/Q4VnQ==
X-Received: by 2002:a05:6830:1483:b0:5cd:a7c4:754c with SMTP id s3-20020a056830148300b005cda7c4754cmr13945610otq.261.1649791847990;
        Tue, 12 Apr 2022 12:30:47 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm12951946oov.3.2022.04.12.12.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:30:47 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:30:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/9] dt-bindings: arm: qcom: Add MSM8996 Pro compatible
Message-ID: <YlXTZRPcOtM++g57@builder.lan>
References: <RHPEoHDkl9-X9DzB2A9P1Z-EowLK-VscTXgVAorSBWFb6yqJY585bMsVSe8otaj4Ahb9ng-CK5jnTt0wlhY_K1DPV3hRf7xg7pZa0mLgxy0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RHPEoHDkl9-X9DzB2A9P1Z-EowLK-VscTXgVAorSBWFb6yqJY585bMsVSe8otaj4Ahb9ng-CK5jnTt0wlhY_K1DPV3hRf7xg7pZa0mLgxy0=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Apr 23:18 CDT 2022, Yassine Oudjana wrote:

> Add a qcom,msm8996pro compatible and move xiaomi,scorpio to the
> same items list as it.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 129cdd246223..dcf2e0102857 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -186,7 +186,12 @@ properties:
>                - sony,kagura-row
>                - sony,keyaki-row
>                - xiaomi,gemini
> +          - const: qcom,msm8996
> +
> +      - items:
> +          - enum:
>                - xiaomi,scorpio
> +          - const: qcom,msm8996pro
>            - const: qcom,msm8996

So we want both platform compatibles in there?

> 
>        - items:
> --
> 2.35.1
> 
