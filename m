Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110749EE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiA0WlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiA0WlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:41:06 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C918C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:41:06 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so4036362otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=C79nec5d4UWFoxeuqvc4pTvKWdk7yx+4+JUc6wJBQYE=;
        b=IIkUwq5frbe8Fuxr7LiChay7jMsr50X27LAdiOIiSi6CTTvrZlPi65qZPJ5ZcAd1Ma
         BiTTL5IgCMax9MQJEm5SMrp1iqBP895vbaQ7PzuQVDUMOnGdrEaoqwhrISUH28jJ5Pof
         s9TH1wGmSt5TMSq6VARBdJm3eopMzgfWE3mbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=C79nec5d4UWFoxeuqvc4pTvKWdk7yx+4+JUc6wJBQYE=;
        b=jxQMTTAqFhUW28uJw9rULpc7mW3Apw9FZqf/VHLuWbGB/vWmCn+pzh7Aoqc1jNDbJG
         XKO08pVVbvG/LZWyWh7odgH/OPkNjG9X1qlNtvptBp0h1MRDpZ3HaNgQURClsLa7bgJ+
         MHxicM+IocHrPO7nhD8maoJJz4545A56HZN1Z26tBWLeU0zv22T+lxlW21DpMSIO3Sf/
         DmsztuUa5s+R1v4wuheDUBuneE7rYzd9Db8oC5cfEAx8U9VxM0FZhkEkPZsktqIhsRMK
         OqvG+KCvX2GZY7xa7DRsLXllIkXVsQo8DCMKjUPBLPhiFsVzvXSdTDqr2lYvrOia8T9+
         0Xiw==
X-Gm-Message-State: AOAM530EuFFNeI5ESl/TBvuvg9m6wMp5y4jhLs7+JRlbwhmxkGphJA59
        MZtvrEg9lAsi/JsYG4ezocc8KjQuVBai57+ClDO25tPbi7I=
X-Google-Smtp-Source: ABdhPJwEVMVdW2UZvQhaXtEbQBFp75r9XdNB5RKn5cJ9Z8p872vkLHsuYPuDaieQcnKb114ZraXLMuYgUbl81wcf0gs=
X-Received: by 2002:a9d:6f06:: with SMTP id n6mr3225915otq.159.1643323265903;
 Thu, 27 Jan 2022 14:41:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jan 2022 14:41:05 -0800
MIME-Version: 1.0
In-Reply-To: <20220127210024.25597-3-quic_amelende@quicinc.com>
References: <20220127210024.25597-1-quic_amelende@quicinc.com> <20220127210024.25597-3-quic_amelende@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 27 Jan 2022 14:41:05 -0800
Message-ID: <CAE-0n50UzVw4wqpV1v-T3k2if+m6jv-Tx7+N2kD4O=J60zmuoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] input: misc: pm8941-pwrkey: add support for PON
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

Quoting Anjelique Melendez (2022-01-27 13:00:25)
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index e0240db12d4f..7005aede4f81 100644
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
> +       pwrkey->baseaddr = be32_to_cpu(*addr);

Isn't this supposed to be be32_to_cpup(addr)?

> +
> +       if (pwrkey->data->has_pon_pbs) {
> +               /* PON_PBS base address is optional */
> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
> +               if (addr)
> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpu(*addr);

Isn't this supposed to be be32_to_cpup(addr)?

>         }
> -       if (error)
> -               return error;
>
>         pwrkey->irq = platform_get_irq(pdev, 0);
>         if (pwrkey->irq < 0)
