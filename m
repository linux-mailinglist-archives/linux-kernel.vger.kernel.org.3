Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8574ADC26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379707AbiBHPNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379570AbiBHPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:13:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4301C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:12:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u6so12873671lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NY+ZwWuclulJI/EwOyt3HfpGBKh0j1b2t2Y9v5DNXi8=;
        b=auyWIb560YDBZgxQ+7OPHdI3+Lqo83TPiIjcFYkbblxBRMFFEIe2E8bsh3fAURQSLu
         aRXfghU1TI8d+lNsHTcKsoTwbu58W295bQeMVaVtHL/bH2DFE6Y03kUsO13rs8sBm7ZE
         HVKMGWQ0+NDCLpyu2kuDnku/HWQuS26qepMfArKY675ojGrdyrjMtPqLi1+BNDRBqmR0
         airc6G2Mm3Hcw6Mhk1W/XcwR8Kk1rAcws4h/d/oNfcmNdH5isJXYkpktedY+epgoMkFK
         Oeab11MGDoz+xwdm5CAjQzbFsa6Bv398hWNbUR1Cb3pqEzPXGgDlannnzEtFwuqsjVr5
         P9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NY+ZwWuclulJI/EwOyt3HfpGBKh0j1b2t2Y9v5DNXi8=;
        b=GlAZ3XIfFQigQexn1qJTK3Pg0rhvMMfet3+CG0rwDW91Dku5bTN3Atk2jz6ILBIzot
         K4cGcMQqwQM2eoXyolNjFY9unzgO6Jx2tbwf1Ou+0SNW3xbs8j/wILpKP666Cftnrwtc
         mk2JeCVb+ZbL9939g6YNFFpQnNo3WZg8J9fXZqk1CpjhJdY6iJWCEdOkUcsesB8Q8gmr
         QEwWIKdfNRKiSEhPpHMIn4Y2c8cAbUEgNQ0W843CT8jolzM7ZXbS5Kar4KhJ6jiOZAun
         W61i8KtoGncE1ls42YMDunlBSr0V104OkdthlYPviNqCVb6jDRvws6Kfwx1pO01zuVsn
         NwjQ==
X-Gm-Message-State: AOAM533Kovk3Mir8G7w2ePQSEekIWcJNW1GxIL9swquDfycvqib6AByz
        5QXw11+lmf8MGw1G8vpn2TrZnlRFQjfrtukhbgvznmJL074=
X-Google-Smtp-Source: ABdhPJwpIIFNjHK3W8/1s65m+yFXwfDxcycoN/0meGoeCtTH4S7LjjaHRz97NGZxNQWJ4wtJjt3eVrTKsfZPa2uoHkE=
X-Received: by 2002:a05:6512:3ca2:: with SMTP id h34mr1684743lfv.167.1644333178187;
 Tue, 08 Feb 2022 07:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20220202182450.54925-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220202182450.54925-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:21 +0100
Message-ID: <CAPDyKFro1sqxzOYWVbsHud_s6P-zYxOH0WOiosN0kZHsP1OywA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc: Use device_property_string_array_count()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
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

On Wed, 2 Feb 2022 at 19:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use device_property_string_array_count() to get number of strings
> in a string array property.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 99b201921954..3420a7ad6098 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3057,8 +3057,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>                 dev_info(host->dev, "Using internal DMA controller.\n");
>         } else {
>                 /* TRANS_MODE_EDMAC: check dma bindings again */
> -               if ((device_property_read_string_array(dev, "dma-names",
> -                                                      NULL, 0) < 0) ||
> +               if ((device_property_string_array_count(dev, "dma-names") < 0) ||
>                     !device_property_present(dev, "dmas")) {
>                         goto no_dma;
>                 }
> --
> 2.34.1
>
