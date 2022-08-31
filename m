Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3973E5A8613
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiHaSwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHaSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:52:11 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9EEC0E5D;
        Wed, 31 Aug 2022 11:52:10 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-33da3a391d8so316186017b3.2;
        Wed, 31 Aug 2022 11:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8F+MKnc7NEx1tCUG6AjVWftljzM2XX58i00lGsYN45Y=;
        b=CctjZ1bOnvRwvjh4SiFreXMlclQK4XpuuuhtailPid4NNwoh6NHro4fEUpwFK6BDYC
         OMgnX+x+br+PuXNfV56b0Pm3G3wsz291lhBnD5vwWHdyqtynD6D1X6nSgI6yDZzWDCy9
         lQB/3qpcMvmh+1WRtD2RlQEj5uVWY8t52q40srLSZyqIM0ZNwtXsX2qTrE9Ey8SpmoCk
         PJ6itYrsoMZ9ja5JymEaNrhWldjwqRcXamczxp7IDCkucBVACD/Mhz/dBFRStwX0eQEj
         WPIXhPJ9RM2wXfp8lP3kfCRBV9ZN1TA/y0HyU1hvShGvEOy3vE8M8dX/qroY/fftVlY/
         +imw==
X-Gm-Message-State: ACgBeo0CbISCRuR+3HDO1V/gKRiGfAArJ++ySEIINj8e20cKhaeX4EiU
        1QHjO8fTlIix7x2uyLD11i+etIREG+L2w9Ep5PJQ4BG9
X-Google-Smtp-Source: AA6agR41gg5UpOUbPB+MyjwQbY19lSM7ygPu4k+f+x/vBYfPbFREMuR+cZsss0AeJ9Q5P3hj13hfwYdNMEYlAz4yZSM=
X-Received: by 2002:a0d:e701:0:b0:336:90d7:c67a with SMTP id
 q1-20020a0de701000000b0033690d7c67amr18993617ywe.7.1661971929512; Wed, 31 Aug
 2022 11:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220804135938.7f69f5d9@endymion.delvare>
In-Reply-To: <20220804135938.7f69f5d9@endymion.delvare>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 20:51:58 +0200
Message-ID: <CAJZ5v0gav_OpDE=x=yb6+_2159_F-hPd9b5BJX6PW5LE=cjysw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/thermal_mmio: Drop of_match_ptr()
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Talel Shenhar <talel@amazon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 1:59 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> From: Jean Delvare <jdelvare@suse.de>
> Subject: thermal/drivers/thermal_mmio: Drop of_match_ptr()
>
> Now that the driver depends on OF, we know what of_match_ptr() will
> always resolve to, so we might as well save cpp some work.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Talel Shenhar <talel@amazon.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> This could have been folded into my previous patch, sorry for missing
> it.
>
>  drivers/thermal/thermal_mmio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-5.18.orig/drivers/thermal/thermal_mmio.c      2022-05-22 21:52:31.000000000 +0200
> +++ linux-5.18/drivers/thermal/thermal_mmio.c   2022-08-04 13:50:46.426178245 +0200
> @@ -107,7 +107,7 @@ static struct platform_driver thermal_mm
>         .probe = thermal_mmio_probe,
>         .driver = {
>                 .name = "thermal-mmio",
> -               .of_match_table = of_match_ptr(thermal_mmio_id_table),
> +               .of_match_table = thermal_mmio_id_table,
>         },
>  };
>
>
>
> --

Applied as 6.1 material, thanks!
