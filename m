Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D837C5320C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiEXCNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiEXCND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:13:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A99CC86;
        Mon, 23 May 2022 19:13:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h14so23698580wrc.6;
        Mon, 23 May 2022 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HU2fErSCW64cphVZzBXmy0McbhLZkYkOtnsLhgiAR0=;
        b=ACIOOrPXOorcGgBjqSJ80cC9PiWUL9CWObjTQHc3WFhpZz7xVIKl+DkllbcAqKxf88
         JMGqGWg/HFlda3peBL7y/Lm2w2XeSIkXvDIdcJPE6RM1gjdOpocosIkAmyLS5vY1QPuf
         5TMKhhlKFqO/TU60aEt+arnlWA3u0Oe8MbyIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HU2fErSCW64cphVZzBXmy0McbhLZkYkOtnsLhgiAR0=;
        b=mS753HCzXkpc4hAPxA5IJ6t6C7jIJzOlVCqXovXD4RXg8w67uJ8/33n16Ry323ho+z
         lIVL07mNinnp2v+ex893+YGqEXQwCVw+HmYyigTx/PTjtaTaZkvigjk2PfBtJ76TmXFS
         pIF0rN7zHhR5LOjyj9S/cjt7Pn8bB9gk9bve0vAOFJOFx3ksLF28qmPjRjxCH9Z09evy
         +pI1Oo5NLYJlE0NOGEznpLzQpLHgeuSuQswIXVRJCOPJ/Vol+jw+BAH9DjRm4ecYOhOa
         sP/nMsI0PViYWtZ5J0bijvYlgVTB0RT9YgMbkm/rOpNKz7v5wCZcmUYKn1S4e+Sinylc
         8Tfw==
X-Gm-Message-State: AOAM530rMDd2vTIbj4uh442N7bZZRp8swhihY9DkG2Jwiobjr9zdqRAG
        7KT8e4VB5B1mMOfZrW/v+6sOdZzcnd7PnFSd3P8=
X-Google-Smtp-Source: ABdhPJxq45wGU4YL3HmpZtgAJOnWLg8dwUX5ssBb89Y9i8L6UqGmdmarf4s98wOPz6IOHL16NV5piQTGVJP1FY8PQ44=
X-Received: by 2002:a5d:47c9:0:b0:20f:e7da:6a48 with SMTP id
 o9-20020a5d47c9000000b0020fe7da6a48mr4252616wrc.315.1653358379867; Mon, 23
 May 2022 19:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220518144818.12957-1-eajames@linux.ibm.com> <20220518144818.12957-3-eajames@linux.ibm.com>
In-Reply-To: <20220518144818.12957-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 24 May 2022 02:12:45 +0000
Message-ID: <CACPK8XeOT6NvEe=oBZ9dUJynHougj-mTMAC2FCwDkvpzBaTKDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
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

On Wed, 18 May 2022 at 14:48, Eddie James <eajames@linux.ibm.com> wrote:
>
> Corruption of the MEAS_CFG register has been observed soon after
> system boot. In order to recover this scenario, check MEAS_CFG if
> measurement isn't ready, and if it's incorrect, reset the DPS310
> and execute the startup procedure.

I have some suggestions below on how to rework to make the code easier
to understand. But before we got to that, I had some high level
questions:


You don't seem to be setting the en bits in the CFG register after
doing the reset. Is that required?

Are we ok to sleep for 2.5ms in the iio_info->read_raw callback?


>
> Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/iio/pressure/dps310.c | 89 ++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index f79b274bb38d..c6d02679ef33 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -397,6 +397,39 @@ static int dps310_get_temp_k(struct dps310_data *data)
>         return scale_factors[ilog2(rc)];
>  }
>
> +/* Called with lock held */

Perhaps add this to your comment: Returns a negative value on error, a
positive value when the device is not ready (and may have been reset
due to corruption), and zero when the device is ready.

> +static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
> +{
> +       int en = DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND;
> +       int meas_cfg;
> +       int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
> +
> +       if (rc < 0)
> +               return rc;
> +
> +       if (meas_cfg & ready_bit)
> +               return 0;
> +
> +       if ((meas_cfg & en) != en) {
> +               /* DPS310 register state corrupt, better start from scratch */
> +               rc = regmap_write(data->regmap, DPS310_RESET,
> +                                 DPS310_RESET_MAGIC);
> +               if (rc < 0)
> +                       return rc;
> +
> +               /* Wait for device chip access: 2.5ms in specification */
> +               usleep_range(2500, 12000);
> +               rc = dps310_startup(data);
> +               if (rc)
> +                       return rc;
> +
> +               dev_info(&data->client->dev,
> +                        "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
> +       }
> +
> +       return 1;

I'm confused about this case. We get there when the device doesn't
have ready_bit set in meas_cfg and we've done a reset, but we also get
here when the bit isn't set and we haven't done anything to resolve it
(after re-reading the code I understand now, but perhaps reworking it
as follows will make it clear):

Could we write it like this:

if (meas_cfg & ready_bit) {
  /* Device ready, must be okay */
  return 0;
}

 if (meas_cfg & en) {
   /* Device okay (but not ready), no action required */
   return 1;
}

  /* DPS310 register state corrupt, better start from scratch */
...
 return 1;


> +}
> +
>  static int dps310_read_pres_raw(struct dps310_data *data)
>  {
>         int rc;
> @@ -409,15 +442,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
>         if (mutex_lock_interruptible(&data->lock))
>                 return -EINTR;
>
> -       rate = dps310_get_pres_samp_freq(data);
> -       timeout = DPS310_POLL_TIMEOUT_US(rate);
> -
> -       /* Poll for sensor readiness; base the timeout upon the sample rate. */
> -       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -                                     ready & DPS310_PRS_RDY,
> -                                     DPS310_POLL_SLEEP_US(timeout), timeout);
> -       if (rc)
> -               goto done;
> +       rc = dps310_check_reset_meas_cfg(data, DPS310_PRS_RDY);

can we do this:

 if (rc < 0)
   goto done;

if (rc > 0) {

}

The rework I suggest makes it clearer that we've considered the '0'
case, when the device is ready before this code runs.

> +       if (rc) {
> +               if (rc < 0)
> +                       goto done;
> +
> +               rate = dps310_get_pres_samp_freq(data);
> +               timeout = DPS310_POLL_TIMEOUT_US(rate);
> +
> +               /*
> +                * Poll for sensor readiness; base the timeout upon the sample
> +                * rate.
> +                */
> +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +                                             ready, ready & DPS310_PRS_RDY,
> +                                             DPS310_POLL_SLEEP_US(timeout),
> +                                             timeout);
> +               if (rc)
> +                       goto done;
> +       }
>
>         rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>         if (rc < 0)
> @@ -458,15 +501,25 @@ static int dps310_read_temp_raw(struct dps310_data *data)
>         if (mutex_lock_interruptible(&data->lock))
>                 return -EINTR;
>
> -       rate = dps310_get_temp_samp_freq(data);
> -       timeout = DPS310_POLL_TIMEOUT_US(rate);
> -
> -       /* Poll for sensor readiness; base the timeout upon the sample rate. */
> -       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -                                     ready & DPS310_TMP_RDY,
> -                                     DPS310_POLL_SLEEP_US(timeout), timeout);
> -       if (rc < 0)
> -               goto done;
> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
> +       if (rc) {
> +               if (rc < 0)
> +                       goto done;
> +
> +               rate = dps310_get_temp_samp_freq(data);
> +               timeout = DPS310_POLL_TIMEOUT_US(rate);
> +
> +               /*
> +                * Poll for sensor readiness; base the timeout upon the sample
> +                * rate.
> +                */
> +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +                                             ready, ready & DPS310_TMP_RDY,
> +                                             DPS310_POLL_SLEEP_US(timeout),
> +                                             timeout);
> +               if (rc < 0)
> +                       goto done;
> +       }
>
>         rc = dps310_read_temp_ready(data);
>
> --
> 2.27.0
>
