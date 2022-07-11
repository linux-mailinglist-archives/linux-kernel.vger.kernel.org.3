Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41557034C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiGKMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiGKMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:49:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FFA22B3C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:49:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 20so3690920qky.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO96Ekr9q06iu/5Pdmyxq/9esZoRehZSdWvbBWP49FM=;
        b=kHpbFvw9oU2mnVOfQvL3NGsMKcJOd0ptf7M8NGSI5R0/m0QkXGd/YMnN5PPINWnHpy
         bOrtDzygSvSg3cltELQqFXtcpZaqMFbGfaZnkIfHa3aaFEcZ5B62f6kcomrSSc46niJM
         grHKOoTxL3NTSvsXKY3+jXrXC5BAgWDA48vYiTFgI63LonAw6c1hf9LHQBvLtb7w01gR
         O9ZVk+A78gjRfzjlDnRsWnpiP+za3jebpbF4bHn+zNFVUjIgHoOW0RHOJdXoT1ZxKrU5
         zESZZBVLacPte5b9hE5UiKVLjEysgo7EQ+Jn1+QUCmHRkUs1+cpasVuA2zMLzQoZXzDz
         uOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO96Ekr9q06iu/5Pdmyxq/9esZoRehZSdWvbBWP49FM=;
        b=Cfy3ISw/i+Z43rF4OmmPD8BYRps73WfZsSdcoHhsPqpujVBnXyWyQKYpLPHGV0lLT2
         5VBySINWofIj6xphq9hsFKRGytpVxupzBDmQ/UuDRjjrxfdK3xmYBrryO/bOVdk6bWBX
         ZMGhf80dG2U4vvtDYX11lF6CZab4R9BD2+H3CSrbc+QfTfKQbKhphkEypC32doUume9z
         Ci75ZRJ1VIwcrPcGSzxn9cVhF+4piXA6ImqUvc3qlxnbLh+B07eoMuaqGjETqvCHnlnx
         oqJsmVwwnbHe/qti6RnCBJgji7iK7Vsk0K1QGRgrEVJTGXqNubl0JceqKfXH7wJaKCj8
         cDlw==
X-Gm-Message-State: AJIora9mJc1WRCXdvtg60oAxVvaUZPMK+PTckHuWwy145JNj+ATyKfer
        drfIDVyhFz9UMum395QwpxpsGdhQzKe5ZPZIfYv0g82Pghs=
X-Google-Smtp-Source: AGRyM1shRp1jEA/2WOEywzBO5c50xpYOvrt9O9RsPxpUrSaIa+w8x+w8gXz3dEL9wRddkr7mnBCnC2kwQNwmF1K1yu8=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr10204665qko.363.1657543761561; Mon, 11
 Jul 2022 05:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220711105931.43164-1-robimarko@gmail.com> <20220711105931.43164-3-robimarko@gmail.com>
In-Reply-To: <20220711105931.43164-3-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Jul 2022 15:49:10 +0300
Message-ID: <CAA8EJprjFB6_1cSvBhERJg0uVEi6N-yaUSBLdEDEe15N+P1UKg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock support
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 at 14:26, Robert Marko <robimarko@gmail.com> wrote:
>
> IPQ8074 has the APSS clock controller utilizing the same register space as
> the APCS, so provide access to the APSS utilizing a child device like
> IPQ6018.
>
> IPQ6018 and IPQ8074 use the same controller and driver, so just utilize
> IPQ6018 match data for IPQ8074.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> Changes in v7:
> * Dont max_register modifications
> * Drop custom IPQ8074 match data and use IPQ6018 one as they share the
> controller and driver
>
> Changes in v5:
> * Use lower case hex for max_register
> * Update the APSS clock name to match the new one without commas
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 80a54d81412e..f1f0e87a79e6 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -142,7 +142,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  /* .data is the offset of the ipc register within the global block */
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>         { .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
> -       { .compatible = "qcom,ipq8074-apcs-apps-global", .data = &msm8994_apcs_data },
> +       { .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
>         { .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
>         { .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
>         { .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
