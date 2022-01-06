Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FDD486777
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiAFQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiAFQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:13:17 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACAC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:13:17 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d14so2481508ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5QlOKATkg+9Prd2ezRheoLg8bFfRjYXz/Me8Di8F7c=;
        b=k3wV17DuYBAKkilG5F4sMKLPdAc/udCpFB4Zg7vUaNdHN9hLlS8Y1+LLFS/kzWWNo7
         duV9yRWDKNuuxZ1SkusEk0Bhv/5JHdNKZ3HxDCsIxAvd9u3pgSsGI/9gsKfK3GJP8Zt1
         27kQpJbUxRuz+hcivXUoaFvU8CcUr15OTJpEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5QlOKATkg+9Prd2ezRheoLg8bFfRjYXz/Me8Di8F7c=;
        b=WfCRzeHTkwXRR/z+W7IpjePzHlGpl4CME/dEt3oKnEaHHWdufSmZXCcgv4VvAz6hHF
         fdCh8WGDf0Dw43UZ5oaxXAnqyzYPgV36wiDJDyGwKsnCQxSbzH8I+vJ6b5nBd6SWy4h+
         6Pwkq1BT/P85XBOaLhqeUqSx/SlxWCRMi0zkbN/J+J4JcqJFrck7O6EVE1JeHe/VKDLl
         MBymHsRHuDB0Oi0enEOBt8UGUPt63Aky16SIjULrjvo1Y8v/yfSQo0tOmJCxgYRI/Rkd
         o5/L3NeCXacFkOw41jHRo/hcz3Wnnz/+N2W39a7xJKZdRbXnjIYS6jkBz3t71FPnghL9
         zpeg==
X-Gm-Message-State: AOAM530tYFLZuv6AVM88k2yR6N5kSIEcu6L5hecy6BPr/G9LQzeS1Y5t
        pTApdaZyjbcTMHgX5+89MjxdUnzCpst0FA==
X-Google-Smtp-Source: ABdhPJwV5WmwebO3LU5xdGQ/a9+pcHpWngUm4xU5uzYl8GRFsRD2ayaLYjbDgAu02IrUX1/q9W6xJA==
X-Received: by 2002:a05:6e02:f45:: with SMTP id y5mr522513ilj.96.1641485596293;
        Thu, 06 Jan 2022 08:13:16 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id n10sm542450ioz.17.2022.01.06.08.13.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 08:13:15 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id d3so2430642ilr.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 08:13:15 -0800 (PST)
X-Received: by 2002:a05:6e02:2187:: with SMTP id j7mr27894010ila.120.1641485595294;
 Thu, 06 Jan 2022 08:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20220103071118.27220-1-vkoul@kernel.org>
In-Reply-To: <20220103071118.27220-1-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jan 2022 08:13:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ue9Z+NmqviCXEN2pHxWZaAcTbFzzn=xxfg8d8QzPwp4A@mail.gmail.com>
Message-ID: <CAD=FV=Ue9Z+NmqviCXEN2pHxWZaAcTbFzzn=xxfg8d8QzPwp4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: qcom: geni: set the error code for gpi transfer
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 2, 2022 at 11:11 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Before we invoke spi_finalize_current_transfer() in
> spi_gsi_callback_result() we should set the spi->cur_msg->status as
> appropriate (0 for success, error otherwise).
>
> The helps to return error on transfer and not wait till it timesout on
> error
>
> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>
> Changes in v2:
>  - add missing spi_finalize_current_transfer() for dma error case
>
>  drivers/spi/spi-geni-qcom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 413fa1a7a936..b82f3ddff0f4 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -346,17 +346,21 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
>  {
>         struct spi_master *spi = cb;
>
> +       spi->cur_msg->status = -EIO;
>         if (result->result != DMA_TRANS_NOERROR) {
>                 dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
> +               spi_finalize_current_transfer(spi);
>                 return;
>         }
>
>         if (!result->residue) {
> +               spi->cur_msg->status = 0;
>                 dev_dbg(&spi->dev, "DMA txn completed\n");
> -               spi_finalize_current_transfer(spi);
>         } else {
>                 dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
>         }
> +
> +       spi_finalize_current_transfer(spi);
>  }

What you have here should work and seems fine, though it's a bit
awkward. Every exit path now calls spi_finalize_current_transfer().
IMO this would be slightly cleaner like this (also moving the error
cases to both be first)

if (result->result != DMA_TRANS_NOERROR) {
  dev_err(...);
} else if (result->residue)
  dev_err(...);
} else {
  spi->cur_msg->status = 0;
  dev_dbg(...);
}

spi_finalize_current_transfer(spi);

I'll let Mark decide if he wants it to be respun with the above, wants
a follow-on patch, or doesn't care either way. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
