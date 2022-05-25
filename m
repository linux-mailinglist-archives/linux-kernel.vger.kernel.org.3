Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DD533483
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbiEYBAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiEYBAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:00:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2860AA5;
        Tue, 24 May 2022 18:00:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t13so8797237wrg.9;
        Tue, 24 May 2022 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgfAxiAsPE8AkBGnd4/7cDSRABxZ1l9jVoCOL2Jgh0I=;
        b=nVTAVWiuf/9WxoI6En45T3ayFvK/ooUR4zPTocg4rK/zilo00K0bOE37iocsap9piU
         JZPqlSq9omcMZxsGbGlhzytTo2/jmF24ROG0TUMqJM5ePHJY4+FGVAuQz1g/yrOmxVz7
         BrfvmQRjnjiepZAu89O6BQGtlfYdjfi4N+8o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgfAxiAsPE8AkBGnd4/7cDSRABxZ1l9jVoCOL2Jgh0I=;
        b=YyG792FbOYHNF3cCu+weMtT77FAOz3cgv2r5+axgaKmSkFcop+Aw5xXcIBr/99sKtm
         QNnUg1kEJdDa55JUavY5qAzgKb0Qn2MqlYHZ9H+fR4mRPBtps3BbyGSQhGdleWF4HqCm
         slgv4+toFJrZGFw1LBBbzvcVmCS4x2UXV8LuY1TY4ZBSbC9S9VxaxjWgnFZ/E75jNQy3
         bWc1cnwhGvsZvdbBxtpiMzY3YRX9ZuGLKUVMYLvO7V0cCuUI9NhzSmnZ1IlF6XbcXO7a
         6gduULJitG4xUSO7fkwofwDemvnLnAJNKY/ufV7Ch6mao3Py3zdP/srm2wparglwb8P0
         dYEQ==
X-Gm-Message-State: AOAM531biuehjKPYEoK8VasWgAk9DoI7m1efciRpGUH2rwMJ62jaHYq6
        ae//dW9nLzRRGeit0xYpSFLJ9Oi3ubK4Pk/GXRs=
X-Google-Smtp-Source: ABdhPJxUL6HMCZJ4T64U1K+6VRGdNy8QmujurhWEo5dbxrICK3aYVbI/8dtz9EYYgKFcqLRYjSa6/IZLyYvByVd/b18=
X-Received: by 2002:a5d:47c9:0:b0:20f:e7da:6a48 with SMTP id
 o9-20020a5d47c9000000b0020fe7da6a48mr8196823wrc.315.1653440407755; Tue, 24
 May 2022 18:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220524201729.39503-1-eajames@linux.ibm.com> <20220524201729.39503-3-eajames@linux.ibm.com>
In-Reply-To: <20220524201729.39503-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 25 May 2022 00:59:54 +0000
Message-ID: <CACPK8XdBSKEnOaORrjSeZEYjV8yhgxStUZ0TdTk2H7NQHioFow@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
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

On Tue, 24 May 2022 at 20:17, Eddie James <eajames@linux.ibm.com> wrote:
>
> Corruption of the MEAS_CFG register has been observed soon after
> system boot. In order to recover this scenario, check MEAS_CFG if
> measurement isn't ready, and if it's incorrect, reset the DPS310
> and execute the startup procedure.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/iio/pressure/dps310.c | 88 +++++++++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index f79b274bb38d..fbceaa2cd71c 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -397,6 +397,44 @@ static int dps310_get_temp_k(struct dps310_data *data)
>         return scale_factors[ilog2(rc)];
>  }
>
> +/*
> + * Called with lock held. Returns a negative value on error, a positive value
> + * when the device is not ready, and zero when the device is ready.
> + */
> +static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
> +{
> +       int meas_cfg;
> +       int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
> +
> +       if (rc < 0)
> +               return rc;
> +
> +       /* Device is ready, proceed to measurement */
> +       if (meas_cfg & ready_bit)
> +               return 0;
> +
> +       /* Device is OK, just not ready */
> +       if (meas_cfg & (DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND))
> +               return 1;
> +
> +       /* DPS310 register state corrupt, better start from scratch */
> +       rc = regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
> +       if (rc < 0)
> +               return rc;
> +
> +       /* Wait for device chip access: 2.5ms in specification */
> +       usleep_range(2500, 12000);
> +
> +       /* Reinitialize the chip */
> +       rc = dps310_startup(data);
> +       if (rc)
> +               return rc;
> +
> +       dev_info(&data->client->dev,
> +                "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
> +       return 1;
> +}
> +
>  static int dps310_read_pres_raw(struct dps310_data *data)
>  {
>         int rc;
> @@ -409,16 +447,26 @@ static int dps310_read_pres_raw(struct dps310_data *data)
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
> +       rc = dps310_check_reset_meas_cfg(data, DPS310_PRS_RDY);
> +       if (rc < 0)
>                 goto done;
>
> +       if (rc > 0) {
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
> +
>         rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>         if (rc < 0)
>                 goto done;
> @@ -458,16 +506,26 @@ static int dps310_read_temp_raw(struct dps310_data *data)
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
> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
>         if (rc < 0)
>                 goto done;
>
> +       if (rc > 0) {
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
> +
>         rc = dps310_read_temp_ready(data);
>
>  done:
> --
> 2.27.0
>
