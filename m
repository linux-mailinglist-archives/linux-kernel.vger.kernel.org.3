Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB359172F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiHLWNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHLWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:13:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F8B56C9;
        Fri, 12 Aug 2022 15:13:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t11so1812270qkt.6;
        Fri, 12 Aug 2022 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1WmEuleUtKFzhNcHuOsLdMzAycKl9X7Wf9lbyjW+VWM=;
        b=mLW8T3W/9epz8BVUrUfp6XlTYkUoFDiiBChX8bppqJQ0TnnPqVmvO10uGlk8p9LF+A
         9cvNiag3MgzvfqKRPl1BrEpPecQUiYfwtp3NVTneOVwlKHtysEDmr7WOE96+AfV2vDXR
         w9AUmlUwU/Fm/eE8Cf93HZUcaMvIp/FAOipG3L/WNlz3ULVyw8zC2bYhDuEAu0/lwuqA
         vhUcHbj0eRzSGJ4T/YAyCreDxbedgCyJnQOGOFNKbwMENFzIBgm0i0C/gvW/bCZO0MjH
         TodSTineiBRY2P8qyTiVx0pdjBhzBJL/a6om1IEQMY8p4K7X3IJPlH5XaWHgYqEzU2C+
         BPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1WmEuleUtKFzhNcHuOsLdMzAycKl9X7Wf9lbyjW+VWM=;
        b=LDjIpY7bag/7KWGYeCqh99opB68qQFV7PV84mjuRtMryG4bs+ctPSBpNegYdPm7aYf
         jeDGEelcIjW0d4dJcmc0Yd+/x+sm02Y7fZHURNhWWsB/yQhwzmGZxV+GsOUlC/2UlmKa
         Wn7Faz8lzuweKvTi+Hj+8SMN3Wd5jeM37NukAK1LX32aCiAgcWBX+FXHTVUTzfoLyd64
         67KAGEzIOaO7IzDJwFjrztFnFCURpkcrPJkdeGEDaXKodORkY6qctuybfB6szxL6MCvp
         5cR4ympRoYjnGfxZQokqGOuRISgArCGkCVP+GT3pdk0WaLGbjVMcHUZY5QC6QJRVKqSJ
         t9iw==
X-Gm-Message-State: ACgBeo3gyCLg4FdELX6cHkDXdg7hMbq7+pHc/6hruYFkGwHaMT9WiCdd
        AzBWtN7d4/OgJCEd/orowxBdX7y+oEsPPgfHPOqzrAlu
X-Google-Smtp-Source: AA6agR7puMvpGoIfdye97PZAuaPYIeCZ+wxBUmcWePY+V8f+x/WY72LP2bkHDVgAwPX9fZliO5QozDXO+zctOhpmdRc=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr2596449qkp.748.1660342416467; Fri, 12
 Aug 2022 15:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220809211246.251006-1-eajames@linux.ibm.com> <20220809211246.251006-3-eajames@linux.ibm.com>
In-Reply-To: <20220809211246.251006-3-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Aug 2022 01:13:00 +0300
Message-ID: <CAHp75VdbRiWxxbnW61SNdj+pC4skeRF3prXgPvKB+btjW3dLKw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:
>
> Corruption of the MEAS_CFG register has been observed soon after
> system boot. In order to recover this scenario, check MEAS_CFG if
> measurement isn't ready, and if it's incorrect, reset the DPS310
> and execute the startup procedure.

Looks like both patches miss the Fixes tag. Can you add them?

...

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

Please, split definition and assignment.

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
> @@ -405,16 +443,26 @@ static int dps310_read_pres_raw(struct dps310_data *data)
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

If you split the condition body to a helper, it can be rewritten like
(also note special definition for positive returned numbers):

  rc = ..._reset_meas_cfg(...);
  if (rc  == DPS310_MEAS_NOT_READY)
    rc = ..._new_helper_func(...);
  if (rc)
    goto done;

and looking at this it might be worth considering calling that
conditional in the middle in the _reset_meas_cfg(), so the latter will
return either 0 or negative error code.

> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
>         if (rc < 0)
>                 goto done;
>
> +       if (rc > 0) {
> +               rate = dps310_get_temp_samp_freq(data);

Okay, I see this function is different, but still you may realize a
helper from below and something like above suggestion can still be
achieved.

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

Why out of a sudden ' < 0'?

> +                       goto done;
> +       }

As per above.

>         rc = dps310_read_temp_ready(data);


-- 
With Best Regards,
Andy Shevchenko
