Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA234A971D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357815AbiBDJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbiBDJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:48:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A6C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:48:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k13so11501505lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cLbSNgwNud0S537oiGIeOdzTSiyjX7YAN9YmrPJXmDY=;
        b=TstzG/VSP5lEgkMG+g4ag/N8chovppXaIUSSNerGbJX3QCcAFmNEurO0W2P+e1Ppv5
         8QMVFeh9ieajzc/+Jcv7WcHtBC7fO6/OaiEoo7F4g/OBJlUm1WhivHzswtc5xb4JYi78
         8/atYSBO5N6mntfqQJmsF884mBOdMJaTpA2+sYwUfP4jq0CHsjOa2qcjtYBj64Z6dQhL
         kmSiS74eAvHk1opOr4SmckY9SicGCIhcTb+28/7PM8EFkcC/DCQ+deWNkd2/T5EX3G2k
         4zhttskv+dWjZSZHLQ2sNbAfFGY3p8/uLokE2jSsRKFyLz/MH3pyqRxXCC9uPhRCuwR/
         gooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cLbSNgwNud0S537oiGIeOdzTSiyjX7YAN9YmrPJXmDY=;
        b=L2dgOP6ccUGVoTeHRmVxjeKbsFPlLRhP4bELOvjcc57Y00fObdK301i3vlfSa+bx2F
         sx5QVCkjfJi30sjot+0tAJcpGD2oDUGBr6+svk1MtFAOTQXaCcLVdNpDHUYMmREr2TzJ
         7OOY13CXYCMDKyIlZcraVrZhHsqc4Kv2SNHDD/Lgd4EA6AYQKAIq3iWOaHMdc5gufOiN
         ZTGUE1/U8zQogAL/hcyMrEXhVE2e9ErLGQ+JF55pjQAdX1T3yuLFA8LgjWE54bUm9AK3
         Rk52riAkMMkX60ip2m8mVBNoY0I9L/PhNWayCzUaY9czHRTnx+OnehTPWlfRpZJep+br
         vvkA==
X-Gm-Message-State: AOAM532PQo2aVDuVIh8dNucQYnvz7HLeyZbC5p2JCe2UXEWSMtkScopo
        NazyUyTKpSBJfxzywhfcw7EdDhgBuyMmdyYaTW0HgwUsmcc=
X-Google-Smtp-Source: ABdhPJzv2kPvIWwSO8K+my0g3jvGsPU5xVRMxRkLA5ciWNOUsOtsuL44JcTmCWZYNGZhB/qu6vDkYkZTu8H5eaAu4r0=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr1710070lfv.184.1643968104666;
 Fri, 04 Feb 2022 01:48:24 -0800 (PST)
MIME-Version: 1.0
References: <5e5f2e45d0a14a55a8b7a9357846114b@hyperstone.com> <7c4757cc707740e580c61c39f963a04d@hyperstone.com>
In-Reply-To: <7c4757cc707740e580c61c39f963a04d@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Feb 2022 10:47:47 +0100
Message-ID: <CAPDyKFr0YXCwL-8F9M7mkpNzSQpzw6gNUq2zaiJEXj1jNxUbrg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: fix read single on recovery logic
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Adrian

On Thu, 3 Feb 2022 at 11:09, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> So could anyone take a long at this so far?
>

Thanks for pinging. Apologize for the delay, it's on top of my "to-review" =
list.

I have added Adrian too, who knows this code very well too.

Kind regards
Uffe

>
>
> From: Christian L=C3=B6hle
> Sent: Wednesday, January 5, 2022 5:43 PM
> To: ulf.hansson@linaro.org; Christian L=C3=B6hle; linux-mmc@vger.kernel.o=
rg; linux-kernel@vger.kernel.org
> Cc: Avri Altman
> Subject: [PATCH] mmc: block: fix read single on recovery logic
>
> On reads with MMC_READ_MULTIPLE_BLOCK that fail,
> the recovery handler will use MMC_READ_SINGLE_BLOCK for
> each of the blocks, up to MMC_READ_SINGLE_RETRIES times each.
> The logic for this is fixed to never report unsuccessful reads
> as success to the block layer.
>
> On command error with retries remaining, blk_update_request was
> called with whatever value error was set last to.
> In case it was last set to BLK_STS_OK (default), the read will be
> reported as success, even though there was no data read from the device.
> This could happen on a CRC mismatch for the response,
> a card rejecting the command (e.g. again due to a CRC mismatch).
> In case it was last set to BLK_STS_IOERR, the error is reported correctly=
,
> but no retries will be attempted.
>
> The patch now will count both command and data errors as retries and
> send BLK_STS_IOERR if there are no retries remaining,
> or BLK_STS_OK if the single read was successful in the meantime.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 90e1bcd03b46..d7d880ce0f8a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1682,31 +1682,31 @@ static void mmc_blk_read_single(struct mmc_queue =
*mq, struct request *req)
>          struct mmc_card *card =3D mq->card;
>          struct mmc_host *host =3D card->host;
>          blk_status_t error =3D BLK_STS_OK;
> -       int retries =3D 0;
>
>          do {
>                  u32 status;
>                  int err;
> +               int retries =3D 0;
>
> -               mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
> +               while (retries++ < MMC_READ_SINGLE_RETRIES) {
> +                       mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
>
> -               mmc_wait_for_req(host, mrq);
> +                       mmc_wait_for_req(host, mrq);
>
> -               err =3D mmc_send_status(card, &status);
> -               if (err)
> -                       goto error_exit;
> -
> -               if (!mmc_host_is_spi(host) &&
> -                   !mmc_ready_for_data(status)) {
> -                       err =3D mmc_blk_fix_state(card, req);
> +                       err =3D mmc_send_status(card, &status);
>                          if (err)
>                                  goto error_exit;
> -               }
>
> -               if (mrq->cmd->error && retries++ < MMC_READ_SINGLE_RETRIE=
S)
> -                       continue;
> +                       if (!mmc_host_is_spi(host) &&
> +                           !mmc_ready_for_data(status)) {
> +                               err =3D mmc_blk_fix_state(card, req);
> +                               if (err)
> +                                       goto error_exit;
> +                       }
>
> -               retries =3D 0;
> +                       if (!mrq->cmd->error && !mrq->data->error)
> +                               break;
> +               }
>
>                  if (mrq->cmd->error ||
>                      mrq->data->error ||
> --
> 2.34.1
>     =3D
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
