Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBF565E45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiGDUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGDUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:10:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15126654D;
        Mon,  4 Jul 2022 13:10:48 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31cac89d8d6so21020087b3.2;
        Mon, 04 Jul 2022 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSzYUkSr64/MWOHJNv2lZcInEHifTq4lnA5LJoTdWTE=;
        b=SwdCBoRz62Cjj6rsKTCZILy+zDz5wtzRT+JYyDFXbWCvEDMSdlfpDAvA/I0U8dDLt7
         worTk14l2UsThHlqIZCbXuIyYkQJMxpa/Yuq5lSO1R2PZF0R7LCozgFJA9VRY0OkNbVo
         Z94y7SPyCLer6ESZh8zI7qjT8smkU0dv+SmbyUGKZqrdLI34qoXdt/pixKtc2pvm2t7p
         r1JIzX5RmE0DkOnD2W21nFsYxB0S8FzAT5ufZef+dni7yw/2zhHVhce0ZOGLus03PaAs
         imJpVF9KjtBVdRfe3r34lkj2GhjjQSMhxij/6HB8ZkANlchrQEwPaZ91F+aLwwgDDoKM
         b0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSzYUkSr64/MWOHJNv2lZcInEHifTq4lnA5LJoTdWTE=;
        b=uR2pIWxi4ox3sd0kfEQ7osN6/HXoONYKfqEgXgZ4qRFbR6Vq/usrCYopRDTmoZK29a
         ealAD6Cw5kEx2/GWLONMz12lmVxfXDHqabMvX219o5BuUa52oQ3KG4YoP8FSQ9+xPo+b
         2vOzKO2qUQ15oALZnyRKK31jLGcR2ea6HgMPr2SvVsSGpctAr05qbx4uXIUdZK3XUiTV
         tZoMDK1w+VPwdrfjM8w88rFuQcdxBblhy5dsZuRHONrcsWqI9gb1DsrZMOMyoBOKopF0
         sDhwlODSDK2e/Ap5z1CIW9Zb4lQFEkVWS4/KfnhTVrNxG4qYC9DFJP1i7glt/RKlNF3c
         oTkg==
X-Gm-Message-State: AJIora9pir7fHuH0qMU4sLr45zvlrji9qoLS/NpZUIO+QrsHKT12B9ch
        JQamU83/u87lFJ1LVl2BwO7iFyb8p90uQz1yd68=
X-Google-Smtp-Source: AGRyM1tkAD974ujHfctaret4crky38yNU3vVcuHnO6eZ8go4egOJrUlCNmqN7A/B6Nh3hS5FERMyIE/LoNLoZomJ4CY=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr3296654ywc.520.1656965446819; Mon, 04
 Jul 2022 13:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220704002957.207850-1-ang.iglesiasg@gmail.com>
In-Reply-To: <20220704002957.207850-1-ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 22:10:10 +0200
Message-ID: <CAHp75Vcgivf1cDFBqWqoYQKdLYjH5NFsJi18HSy3L4U7WbjnGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: simplify driver
 initialization logic
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jul 4, 2022 at 2:46 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Extended chip_info structure with default values for configuration params
> to simplify and unify initialization logic for different supported sensors

...

> +       ret = data->chip_info->read_calib(data, chip_id);
> +       if (ret < 0) {
> +               dev_err(data->dev,
> +                       "failed to read calibration coefficients\n");
> +               return ret;

return dev_err_probe(...);

>         }


-- 
With Best Regards,
Andy Shevchenko
