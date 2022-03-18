Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDD94DD3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 05:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiCREUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 00:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiCREUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 00:20:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F7C7494;
        Thu, 17 Mar 2022 21:19:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kd12so5759126qvb.1;
        Thu, 17 Mar 2022 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kcbzzb3Q18Foqg/UI/G6Q3eVQppXaI7cSO8s/lZSlw=;
        b=G4OMexrBtCk0ngOlF0XSIkaCzI6dYKXEDtEVfsDpieKqdAIIL98xZGbXHhExTahC9d
         /JrwnabA10kIh5TLOWfBfqJpB801TlZWAuNcm9109vskjprQviJy/C4ietPbFJJMe0K3
         AJd9hVeeqoPPwijrxfY/H+q1I5bYp5Zde8IMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kcbzzb3Q18Foqg/UI/G6Q3eVQppXaI7cSO8s/lZSlw=;
        b=FcKvMDLrLuJN2pa8k5YcGpvqqrPyTnd2F2uZdSNPm3wUdUcz467umJFHFrzn+AyPyF
         cI7mbsleMW4L605yky0Uavx4GTdkALjajN+kiQv5Cu29ls6mCMT9vUCtLhjkn0Hfp78c
         D0HDF8pqG8NxkYcGmsDfRXlDRjzvn6xqenQu09USXcxw8t9Km1nywNkbGqznABo/03Xk
         AkYxVbl90li4jILGlV9XvOv8WBKOoeftSUsIXO9q/BEYXBKDtDjtOiLK61i0Q0jky+8v
         TYP4ME44tlJz0NbQQBPEd9/Lfm3LtzBXowcOV/Lk4Epkxo41Ml/qQMJr2fT+NBXGmQJ7
         v1tQ==
X-Gm-Message-State: AOAM53236eR5Q00Z2iYcYVfF8W5m8QGrzancqbd4OnFURj+5WvIZbqJ5
        53qRjsz7ZzFrhb4a0bjm4j+1l8ABX2ebFtQEkRU=
X-Google-Smtp-Source: ABdhPJw4eEeIPZiev+YGiA8kFv/XcltV3scqoPQ5ehYGPDeRNHMLJIwI3WfRTdA15nBn/8+56KWImz4dtdFktXjRkb0=
X-Received: by 2002:a05:6214:d82:b0:440:efb8:cbb7 with SMTP id
 e2-20020a0562140d8200b00440efb8cbb7mr3995622qve.65.1647577167220; Thu, 17 Mar
 2022 21:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220317211426.38940-1-eajames@linux.ibm.com>
In-Reply-To: <20220317211426.38940-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 18 Mar 2022 04:19:15 +0000
Message-ID: <CACPK8Xd42+NgTfS8ERagv-1GkAb8XiY8U71Q8Hz0wQ9dEUJekQ@mail.gmail.com>
Subject: Re: [PATCH] spi: fsi: Implement a timeout for polling status
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 at 21:14, Eddie James <eajames@linux.ibm.com> wrote:
>
> The data transfer routines must poll the status register to
> determine when more data can be shifted in or out. If the hardware
> gets into a bad state, these polling loops may never exit. Prevent
> this by returning an error if a timeout is exceeded.

This makes sense. We may even want to put this code in regardless.

However, I'm wondering why the code in fsi_spi_status didn't catch this.

> static int fsi_spi_status(struct fsi_spi *ctx, u64 *status, const char *dir)
> {
>        int rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, status);

You mentioned the error condition is we get back 0xff. That means that
status will be 0xffff_ffff_ffff_ffff ?

Did you observe status being this value?

>        if (rc)
>                return rc;
>
>        if (*status & SPI_FSI_STATUS_ANY_ERROR) {

I think that we're checking against 0xffe0f000.

>                dev_err(ctx->dev, "%s error: %016llx\n", dir, *status);
>
>                rc = fsi_spi_reset(ctx);
>                if (rc)
>                        return rc;

Is the problem here? fsi_spi_reset writes to the clock config
registers, but doesn't read the status.

Obviously doing the writes causes a call to fsi_spi_check_status, but
that checks the FSI2SPI bridge, not the SPI master.

...but it doesn't matter, because we're either going to return an
error from the reset, or return EREMOTEIO, so there's no masking of
the error.

>
>                return -EREMOTEIO;
>        }
>
>        return 0;
> }


>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/spi/spi-fsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
> index b6c7467f0b59..d403a7a3021d 100644
> --- a/drivers/spi/spi-fsi.c
> +++ b/drivers/spi/spi-fsi.c
> @@ -25,6 +25,7 @@
>
>  #define SPI_FSI_BASE                   0x70000
>  #define SPI_FSI_INIT_TIMEOUT_MS                1000
> +#define SPI_FSI_STATUS_TIMEOUT_MS      100

Can you add a comment (or put something in the commit message) about
why you chose 100ms.

>  #define SPI_FSI_MAX_RX_SIZE            8
>  #define SPI_FSI_MAX_TX_SIZE            40
>
> @@ -299,6 +300,7 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
>                                  struct spi_transfer *transfer)
>  {
>         int rc = 0;
> +       unsigned long end;
>         u64 status = 0ULL;
>
>         if (transfer->tx_buf) {
> @@ -315,10 +317,14 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
>                         if (rc)
>                                 return rc;
>
> +                       end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
>                         do {
>                                 rc = fsi_spi_status(ctx, &status, "TX");
>                                 if (rc)
>                                         return rc;
> +
> +                               if (time_after(jiffies, end))
> +                                       return -ETIMEDOUT;
>                         } while (status & SPI_FSI_STATUS_TDR_FULL);
>
>                         sent += nb;
> @@ -329,10 +335,14 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
>                 u8 *rx = transfer->rx_buf;
>
>                 while (transfer->len > recv) {
> +                       end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
>                         do {
>                                 rc = fsi_spi_status(ctx, &status, "RX");
>                                 if (rc)
>                                         return rc;
> +
> +                               if (time_after(jiffies, end))
> +                                       return -ETIMEDOUT;
>                         } while (!(status & SPI_FSI_STATUS_RDR_FULL));
>
>                         rc = fsi_spi_read_reg(ctx, SPI_FSI_DATA_RX, &in);
> --
> 2.27.0
>
