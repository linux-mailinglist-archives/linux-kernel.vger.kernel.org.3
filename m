Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA64E98F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiC1OH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiC1OHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:07:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AC20187
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:05:39 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y38so23546978ybi.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pwEzM3BVWnQ/EvlHm3wB1klIRYMyFKneOQkX+wIwdXs=;
        b=ZL1OTesnf0OYajbRG1LFkJuSlcJdZq5bYH/y2PxxKLqX/bD99q5svcBYN2kwykhtiG
         XYTsGzQ/1bDx1HziubSmMwNO9kuRPzV/ZIroyHDsvU0ScUYiD7N5+bR+A7rYrJcF1XIZ
         mMTiw9rPLl8nJFHfTCnDidwDaQfHpGiIZ93o6cAHs+hjUyzR767iwgTt3EOH2yLfodiv
         jMZvRE2ZfbDO5vNKe8qbnDVrSzLK2JsW8ucb5h5Nw2Ua7W3fo8rgK2veIArJhzEFDcPP
         GQfo0EoxoaYGn7ihbXfCjJ+WWK3QyZeBn+bJyx4tnB+RGf0cNg5g49tgDkHHdeNOwPBS
         uE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pwEzM3BVWnQ/EvlHm3wB1klIRYMyFKneOQkX+wIwdXs=;
        b=cieFC9nZC2pVIWdhSNYbjpp+XJ0q2Tu5zxR2nRLuO70guhxqhGWYJmaaWVZFIKy+MI
         4oHmbK3oa2vVKxUI9gADeajZuNTELy0+3m1MyGoBCQiUCsjwwurnDZAZw5HMoZNMroqO
         /ouRlTFA2462lGlItp0Qh6FaDg7I+E4eLdnE7sWSjN427EegOVANTPAOpVCdkgJxizot
         UM5145PAnThP8aSOgqyIEHWb6F9IZAOZcJ3jJIKMbkboqxDto5owGHREsYVDqg9lRCmG
         vhBnYxkNyYDRAOzoqVXWThgQ/h+lFdxNGFXkkrL3dXDDK8z2Owk1TQ1nBT6KJv/L+BGm
         xsBg==
X-Gm-Message-State: AOAM532/W6mSTQVwXhuaGOxM7Q+CPvEnlukDVx1LEqkTaDVRxzDW5ywK
        SBIljNHk52VRiNWSBX4wC6VnLgdpXL9OTU8oGAZOuA==
X-Google-Smtp-Source: ABdhPJzFR7pwH3A1bw0+6EQ+AMvuEO565hTLQyf4vqzc0e2Q/jFTzH9hLyoZLK2lmnYkH9coEqChxcg1uw5+fOackTw=
X-Received: by 2002:a25:d002:0:b0:633:c5c5:bcb2 with SMTP id
 h2-20020a25d002000000b00633c5c5bcb2mr23827627ybg.123.1648476337704; Mon, 28
 Mar 2022 07:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <76f6f5d2b35543bab3dfe438f268609c@hyperstone.com>
In-Reply-To: <76f6f5d2b35543bab3dfe438f268609c@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Mar 2022 16:05:01 +0200
Message-ID: <CAPDyKFq+YumWsLmYMZNxuN+LG7euStAyrmv7Eqs2cSR3fr-Kwg@mail.gmail.com>
Subject: Re: [PATCHv5] mmc: block: Check for errors after write on SPI
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 at 15:18, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Introduce a SEND_STATUS check for writes through SPI to not mark
> an unsuccessful write as successful.
>
> Since SPI SD/MMC does not have states, after a write, the card will
> just hold the line LOW until it is ready again. The driver marks the
> write therefore as completed as soon as it reads something other than
> all zeroes.
> The driver does not distinguish from a card no longer signalling busy
> and it being disconnected (and the line being pulled-up by the host).
> This lead to writes being marked as successful when disconnecting
> a busy card.
> Now the card is ensured to be still connected by an additional CMD13,
> just like non-SPI is ensured to go back to TRAN state.
>
> While at it and since we already poll for the post-write status anyway,
> we might as well check for SPIs error bits (any of them).
>
> The disconnecting card problem is reproducable for me after continuous
> write activity and randomly disconnecting, around every 20-50 tries
> on SPI DS for some card.
>
> Fixes: 7213d175e3b6f ("MMC/SD card driver learns SPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
>   - Reorder err and status check for err to take precedence and look clea=
ner
> v3:
>   - Move the logic into its own function
> v4:
>   - Move block layer handling out of the spi-specific function
> v5:
>   - reorder err and status check
>
>  drivers/mmc/core/block.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..be2078684417 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1880,6 +1880,31 @@ static inline bool mmc_blk_rq_error(struct mmc_blk=
_request *brq)
>                brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
>  }
>
> +static int mmc_spi_err_check(struct mmc_card *card)
> +{
> +       u32 status =3D 0;
> +       int err;
> +
> +       /*
> +        * SPI does not have a TRAN state we have to wait on, instead the
> +        * card is ready again when it no longer holds the line LOW.
> +        * We still have to ensure two things here before we know the wri=
te
> +        * was successful:
> +        * 1. The card has not disconnected during busy and we actually r=
ead our
> +        * own pull-up, thinking it was still connected, so ensure it
> +        * still responds.
> +        * 2. Check for any error bits, in particular R1_SPI_IDLE to catc=
h a
> +        * just reconnected card after being disconnected during busy.
> +        */
> +       err =3D __mmc_send_status(card, &status, 0);
> +       if (err)
> +               return err;
> +       /* All R1 and R2 bits of SPI are errors in our case */
> +       if (status)
> +               return -EIO;
> +       return 0;
> +}
> +
>  static int mmc_blk_busy_cb(void *cb_data, bool *busy)
>  {
>         struct mmc_blk_busy_data *data =3D cb_data;
> @@ -1903,9 +1928,16 @@ static int mmc_blk_card_busy(struct mmc_card *card=
, struct request *req)
>         struct mmc_blk_busy_data cb_data;
>         int err;
>
> -       if (mmc_host_is_spi(card->host) || rq_data_dir(req) =3D=3D READ)
> +       if (rq_data_dir(req) =3D=3D READ)
>                 return 0;
>
> +       if (mmc_host_is_spi(card->host)) {
> +               err =3D mmc_spi_err_check(card);
> +               if (err)
> +                       mqrq->brq.data.bytes_xfered =3D 0;
> +               return err;
> +       }
> +
>         cb_data.card =3D card;
>         cb_data.status =3D 0;
>         err =3D __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS,
> --
> 2.34.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
