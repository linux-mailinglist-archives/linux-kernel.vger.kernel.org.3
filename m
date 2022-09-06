Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99D5AF62F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIFUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIFUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:37:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993285AA4;
        Tue,  6 Sep 2022 13:37:05 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b9so9121785qka.2;
        Tue, 06 Sep 2022 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DZ0dxIN9tQK5jdKb/Xo71csBd9+xaWx/Qph+h8QMcik=;
        b=bJkWA3f3zbGryciCNoKYUZlQ8sPDE+uuaOiPCWFKDnPVPKv0wE7qYv5u+fHKMffuZJ
         VFdcDtR2OzCOOfHo0KXJgnO0tdOtWCWbzMD1ElXi2F9YaOdDwPggx+dQL0k8BRLGIjOZ
         vOli4dJgZdMHMWwwbMXWkGtAm/5LhFPJ2fZXkjLn2dJ+C28NmnNMGMfWNG0g8/yW/KHk
         muDpL8HhnNz3ndKUfiEstOy49yG8uhY9raY4CjLf2YIQEOJy6UR0kiWPjGc8RKzzfhBP
         LVU8BzBddM9aE+hr2f58b/n5MH0OXT0yEdYbVDQ2cR0bsdII352N110l2obNfhvELGBj
         YBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DZ0dxIN9tQK5jdKb/Xo71csBd9+xaWx/Qph+h8QMcik=;
        b=qWYTorenEWGpdzFXiILBsZkKTIaV+MyG7tZQ25EZLprUpvQ5SI49X8utHFeAm29oyP
         mtTKGlJy7ZLzrxczdDuumMBKxzh1/aaDTW6plN37vapJJI5PPxGfU7Vq1V25AhhQ36EV
         EAdysjWcBclHnqn919+3oe5CBlwArpwq6FAs4FiS4SHzPgVhHxt2AJ9SF375pzxbkGSb
         atNLN/ce8MyQbAnX9ucnI8Qg9/K3VklOYGSPxJfhQ84zq8cUdVknfZlE6KSbF+vB5+sg
         fOu8Uer50dds0DoKEapiNixYqNiuzltOjUMd2Zj0IJ2ryug14vMxhoYHDZpVACSQdQnn
         6hhg==
X-Gm-Message-State: ACgBeo3aUKtRK/J4lgDxoBdKUOTSZ9HPLl3IAWoFPOJvOaNckO5D/Xux
        g9O1UtG5RdFT5hMYNQut+RlBoAhBbtv+ILh2PKs=
X-Google-Smtp-Source: AA6agR63gznhVonHJLFX9gUvtxHuMgp+NLO9da5Bjo90Te+ONTh0M1bKQ3ojMMU78IKD8Q9xatAvVSxsdXt8TMuc2AY=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr384530qkf.320.1662496624827; Tue, 06
 Sep 2022 13:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220906200535.1919398-1-eajames@linux.ibm.com> <20220906200535.1919398-3-eajames@linux.ibm.com>
In-Reply-To: <20220906200535.1919398-3-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 23:36:28 +0300
Message-ID: <CAHp75VcLiCRy_m35Sd4AGpOKQ+5WTXMzHZA7hcwDR-t1v46t2Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: pressure: dps310: Reset chip after timeout
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Tue, Sep 6, 2022 at 11:05 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> The DPS310 chip has been observed to get "stuck" such that pressure
> and temperature measurements are never indicated as "ready" in the
> MEAS_CFG register. The only solution is to reset the device and try
> again. In order to avoid continual failures, use a boolean flag to
> only try the reset after timeout once if errors persist.

If the previous patch is a dependency to this one, you need to use its
Subject in a Cc: stable@ tag as it's pointed out in the documentation.
Otherwise, Fixes go first in the series.

...

> +static int dps310_reset_reinit(struct dps310_data *data)
> +{
> +       int rc;
> +
> +       rc = dps310_reset_wait(data);
> +       if (rc)
> +               return rc;

> +       rc = dps310_startup(data);
> +       if (rc)
> +               return rc;
> +
> +       return 0;

Can be simply return _startup(...);

> +}

...

Can it be a helper here?

int dps310_get_ready_status(data, ready_bit, timeout)
{
  sleep = ...
  int ready;

 return regmap_read_poll_timeout(...);

}

> +static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
> +{
> +       int rc;
> +       int ready;
> +       int sleep = DPS310_POLL_SLEEP_US(timeout);

> +       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready, ready & ready_bit,
> +                                     sleep, timeout);

rc = dps310_get_ready_status(...);

> +       if (rc) {
> +               if (rc == -ETIMEDOUT && !data->timeout_recovery_failed) {
> +                       int rc2;
> +
> +                       /* Reset and reinitialize the chip. */
> +                       rc2 = dps310_reset_reinit(data);
> +                       if (rc2) {
> +                               data->timeout_recovery_failed = true;
> +                       } else {

> +                               /* Try again to get sensor ready status. */
> +                               rc2 = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +                                                              ready, ready & ready_bit, sleep,
> +                                                              timeout);

rc2 = dps310_get_ready_status(...);

> +                               if (rc2)
> +                                       data->timeout_recovery_failed = true;
> +                               else
> +                                       return 0;
> +                       }
> +               }
> +
> +               return rc;
> +       }
> +
> +       data->timeout_recovery_failed = false;
> +       return 0;
> +}

--
With Best Regards,
Andy Shevchenko
