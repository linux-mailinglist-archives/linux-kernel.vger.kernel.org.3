Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830454A8FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354544AbiBCVQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348776AbiBCVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:16:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D8C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:16:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t199so6056399oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=zSzejEssgOdNs4rfva4sRaZfTKtrXGdpO9wn9P5yFPE=;
        b=MwGOUZWh//pgE0O2Azb1GhqEJrO/J6MovToSHD8MCOOJDKupVk3C32wVyBw8jo9Vyc
         M+cvOX593h8WNzUtQOmKZiAoKxthoBbXvtS6+E6ENIVRcWbVRs9vBskKMVISmZHxWPG5
         cK91/VOTu2i+F4RylsflgHa25uNq1gd8LwbIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=zSzejEssgOdNs4rfva4sRaZfTKtrXGdpO9wn9P5yFPE=;
        b=Nz779ivqjVT+WPiWdwWtNYhVTU5DOJJm8sIlvadFYQeCz6LIppkBQovv7WSajIP8qv
         /zgOpVtYFBAKdKOYpCQtbsl1Vel4fF7QuR8YW6/v8Cj5xo3heP3Q4EL/5wdfQS3yUO/U
         jyfBwd+4f3r6NQ37AgOA4ubK3vb93pRU7n80tvExrsN14MQ5R7Ijb0twwWL+3cHyD0cR
         1hm0ZGpRh3IuGC5gblsXaElqHPI7rFFlrwdq5BmZKMpDTsU5B9PwifR/0fafSYCIRdkp
         I5TXihLJ4vbYZ5zZ4gzJtXU+AnV3zBS7pQHym5t0A3/UyEVIDdrzBRMzqjf2fgUoyfGp
         XYYA==
X-Gm-Message-State: AOAM532WtM91uw1msjo3AKBtPVGI+181DRdbcd+E0Fsu6/YdIhURVXNW
        acBri/FDX/XbzAdOLmPypxjR5KWxiU2+hc/hi000RQ==
X-Google-Smtp-Source: ABdhPJw7vIH3OfZRCbmVHsGzsp3Cr2FMKfJkZlo31VFY4F15UlS2EmSCHmL5Z7p5I3lh8tdD7cFsEapl3AhorTNnuBY=
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr8683791oib.40.1643923016742;
 Thu, 03 Feb 2022 13:16:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:16:56 +0000
MIME-Version: 1.0
In-Reply-To: <20220203010804.20883-3-quic_amelende@quicinc.com>
References: <20220203010804.20883-2-quic_amelende@quicinc.com> <20220203010804.20883-3-quic_amelende@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:16:56 +0000
Message-ID: <CAE-0n51vAD-_0e0sBKECfx51B2a6-BK59LnRp6uGHejU_f3rGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        bjorn.andersson@linaro.org, skakit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anjelique Melendez (2022-02-02 17:08:05)
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index e0240db12d4f..2a42a676b021 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -200,15 +207,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>                         dev_err(&pdev->dev, "failed to locate regmap\n");
>                         return -ENODEV;
>                 }
> +       }
>
> -               error = of_property_read_u32(parent->of_node,
> -                                            "reg", &pwrkey->baseaddr);
> -       } else {
> -               error = of_property_read_u32(pdev->dev.of_node, "reg",
> -                                            &pwrkey->baseaddr);
> +       addr = of_get_address(regmap_node, 0, NULL, NULL);
> +       if (!addr) {
> +               dev_err(&pdev->dev, "reg property missing\n");
> +               return -EINVAL;
> +       }
> +       pwrkey->baseaddr = be32_to_cpup(*addr);
> +
> +       if (pwrkey->data->has_pon_pbs) {
> +               /* PON_PBS base address is optional */
> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
> +               if (addr)
> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpup(*addr);

With the deref dropped.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
