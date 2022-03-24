Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1084E6288
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbiCXLhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiCXLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:37:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421449C84
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:35:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w27so7533051lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sdMwxxqpTlrw+iN+UbgiQwypGP4k5xrNt/T4xZE2AIQ=;
        b=zqjQGoGY73lsLpjpdJSi/PH3dkMnWyidUsMnl4lCE+eCcIK5rYlMO3OdiY06CPIUUd
         3rrGHeWzSBgJ8CfB3ujYxxRf+NcCoaUfUedXXRBaJcTKle72nplyHFmLRuRds2FMEc1L
         R7nwhLho+d8qnm4TzkaFQrG2NS8/DwEc5ocLKbOE6kDsBB5zg46hhy5Mt+ONLQ2xd17C
         etqd0r4MvPQsU5/FSoZ2MYpf2SVALAZJBVncn53/ghb7qYPz/P8hvR9GqeD9CtQ2JjQi
         JhQo70+rVb7pEISi82SaYTTUSvNLxOpgHuXDrMVtGc0QavTRIGe7QQeYC60ckCePV/EF
         bzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sdMwxxqpTlrw+iN+UbgiQwypGP4k5xrNt/T4xZE2AIQ=;
        b=Z85DsJ8Uv0s0ZYl1Zxzh+58qbA0cL+3YaczCq+JjuRlsCQzOesfIziM8JFgq/2vcLt
         Rl+z3/oWbUCS97L8D2ZtcqpSY7+oj4eCRxb1/n6c8G+v2L/9wkV1++3coS+buVdWiVT3
         iB4WZBi646nbQ7tBp9bAalp/O0Lfo3QdXGHtmEJdH09jFVgjyxBNhL/5kQnKMHKNXTym
         EILsoil1n4qja0ScxxdlwjQfdsZP27j00jkSB+ks/uK71hsSBnkuUA5kUBhRUcqXNRpz
         yIurIfRcWlFzPVsrZS/ns3DxSp175igFSkY2vsgPQcJkUqVPKG0qs8s3piNUNBn6ivTF
         hoVQ==
X-Gm-Message-State: AOAM5329ZWm0+NWHEu8i3gjSQwi80jeNcDiQlkWBeVqDeUMmeZab0VTs
        rYS9ja9iltJBmr9oncKZCyDa3aCSwJrtP4a+BvqFdQ==
X-Google-Smtp-Source: ABdhPJxfU5ZQVmxXGrMv91JwsBOiy7wIgFSQZmmfMGT455EIQ9ObutumGWufC05TBESjNX8FCgyS3kU1eLusrqPu96E=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr3676359lfr.233.1648121726506; Thu, 24
 Mar 2022 04:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <9d1ea819e4bb4222a227a02d5f6ad97c@hyperstone.com> <cf04ac31665c48be9f275ed21332763b@hyperstone.com>
In-Reply-To: <cf04ac31665c48be9f275ed21332763b@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Mar 2022 12:34:50 +0100
Message-ID: <CAPDyKFrg5T_EU48TYZwaKAGL8tnRCKYBf=74OU0t8iMc7Cp+sg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: block: Check for errors after write on SPI
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "cloehle@posteo.de" <cloehle@posteo.de>,
        Avri Altman <avri.altman@wdc.com>,
        "david-b@pacbell.net" <david-b@pacbell.net>
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

On Wed, 23 Mar 2022 at 15:12, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
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
> ---
> v2:
>   - Reorder err and status check for err to take precedence and look clea=
ner
>
>  drivers/mmc/core/block.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..54c2009f398f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1903,9 +1903,34 @@ static int mmc_blk_card_busy(struct mmc_card *card=
, struct request *req)
>         struct mmc_blk_busy_data cb_data;
>         int err;
>
> -       if (mmc_host_is_spi(card->host) || rq_data_dir(req) =3D=3D READ)
> +       if (rq_data_dir(req) =3D=3D READ)
>                 return 0;
>
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
> +       if (mmc_host_is_spi(card->host)) {
> +               u32 status =3D 0;
> +
> +               err =3D __mmc_send_status(card, &status, 0);
> +               /* All R1 and R2 bits of SPI are errors in our case */
> +               if (err || status) {
> +                       mqrq->brq.data.bytes_xfered =3D 0;
> +                       if (err)
> +                               return err;
> +                       return -EIO;
> +               }
> +               return 0;
> +       }

Nitpick: Would you mind moving the above spi specific code into a
separate function instead?

> +
>         cb_data.card =3D card;
>         cb_data.status =3D 0;
>         err =3D __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS,

Other than the above, this looks good to me.

Kind regards
Uffe
