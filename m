Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4E4FA0DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiDIA6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiDIA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:58:34 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417EFCA0CE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:56:29 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t4so2741326qvl.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfKf4vWBXKVDkSg0ucXtRl5Rm+zrC4yREy0YOeH4gUc=;
        b=SbsoGlrpPOxq5eVe2RHS6Fc2qgezVsfsWAPBrsqFY083kKppljMcyKNxf6fxtiQmea
         aBzJD0kBJmjb9PdSYNfNWWUXkxV+z3QetqTr0i2f2Fa0luv9QMmI1KsRSQjDGw4Q7pjE
         /budDdH0oHlvN2fFVV1vBrZh76rPZ30eYwy2OzDUOFI8R/MHqD9g9N37iSvkqQH1rLki
         ldD0q+7NaDD0+d4L47sogdRrZ6h8Mt0wcAP+WMJn0TOE8HP8JqQ6p7V9OzmOB/bw6iZf
         c8vHR4EgzGWHybFWEv3zUnRTSJpUnqzU2XrHxjaUip7gvbhqT+BxayqhtVHq+PpsKWd2
         dfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfKf4vWBXKVDkSg0ucXtRl5Rm+zrC4yREy0YOeH4gUc=;
        b=2I/BhKQ4OsYdyL3RNyD9HkHJArgqQr3GrTOYs7/qossnSv+br3G8lRg1bpU1XYbKVI
         6v5l6d1Ip9iOV4+76uXAsddW3JBQXaqreisavRr5wu4tP0AEc+GT5g8j++d/jzcQc5qI
         l+hQx0VUHbXYJ6k2WhETAv3u4av/U+BY+hA0oCuylHxUlJthD1OjZMnUQbJBdGfy7vFQ
         4HYyDusHcp0ocsXt8PeaLSizoOb+VT8JqxS39Ih8NVJ1IPteHq5ow9OX+lmKr9xF28Ae
         IPLbVsbt/QdRxEdKYL30ldTwfb/Q9lYf6aBBLg5nBJvnc7xl5JDakiPZI2uXB89DMDQ7
         bcVA==
X-Gm-Message-State: AOAM530R7hA+O38/PCJSuosCeUEa2tiylLKwYgTCfAtsKbbYe/XX0+bw
        P9k63pBIpYpAWo3227Je0ClcOAtjYPN1s55hXys7Hg==
X-Google-Smtp-Source: ABdhPJz2DL14RUrS2mQs5G+BjceWY6DRGwYs2DVp88o7IspvTzBgIYnGmtDqdeyP0EjlFaN1l+8GZzgWVN/EFJ3XOaE=
X-Received: by 2002:a05:6214:2aae:b0:440:f701:e8df with SMTP id
 js14-20020a0562142aae00b00440f701e8dfmr18782301qvb.55.1649465788483; Fri, 08
 Apr 2022 17:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220408213336.581661-1-bjorn.andersson@linaro.org> <20220408213336.581661-3-bjorn.andersson@linaro.org>
In-Reply-To: <20220408213336.581661-3-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 9 Apr 2022 03:56:17 +0300
Message-ID: <CAA8EJpo4cRh64T_dCiOZFVQWt18h74x3avBRLtSRvHy=ybxk_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: qcom: llcc: Add MODULE_DEVICE_TABLE()
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2022 at 00:31, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> The llcc-qcom driver can be compiled as a module, but lacks
> MODULE_DEVICE_TABLE() and will therefore not be loaded automatically.
> Fix this.
>
> Fixes: a3134fb09e0b ("drivers: soc: Add LLCC driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/soc/qcom/llcc-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index a76d58195637..918bfd0df0e2 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -809,6 +809,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
>         { .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
>         { }
>  };
> +MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
>
>  static struct platform_driver qcom_llcc_driver = {
>         .driver = {
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
