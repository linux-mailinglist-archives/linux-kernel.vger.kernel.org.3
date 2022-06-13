Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15987549BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiFMSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbiFMShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:37:55 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE262130
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:40:11 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f2a4c51c45so8865032fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGAIi+/Ft53DX8CUrCtDAbQTz9ZPUzipX2JK4m40Fyc=;
        b=RPluaBvzdSvJ5njD15mxkw0ob6qmuyOBJo1hMaQ2AFBjUq++UqkyqjMZzoFpoAhmIr
         ec01sWqSFKsJB6FZgwGP7drgPr4gYSWF10aZZIvHqpTM4uKuRPArOtlTZ65e2oWlcIJc
         0gAKcSwnh35acodyjWgGJzwhHUz3FRGrcu+tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGAIi+/Ft53DX8CUrCtDAbQTz9ZPUzipX2JK4m40Fyc=;
        b=jgPCyeeumVTPBk3gR5vo8QDRR0lq1FHjEulJvK3DzyITBf32nzxYKMOSahyn3d7yig
         nE8CDiDjF/bKZYBAjV5h7oQMvdi6ZkSzh6zNsapzxIWqNc5Wdd7BhDzLQpaiZ8/3GcpM
         F+xF+FJl/vBrwcByZQNJOyh6cpQ1EqejHvH051dLUbs8wngn2IUxG4cxZlZ91fj8EHil
         315dBHVwvqfmdw6tFQRBILGsd8Sac3sXkpwjpKDs/OowcRtf1kS44NmAkZrXFt6mB/09
         z1KkbKQVeVAVjLocsXiQxh8ns7MoeaXj8L2miEN4C0rgJ6QePniNRFiCba6XsD5pDY9d
         +78A==
X-Gm-Message-State: AJIora8BzgoICP4PNiYb7ppXphYINEqb7KSkB4LsFfXt02QSio+eWsw7
        NbiAIWY0UoAcrXA9+0f8wfyPsDHtMve1+Q==
X-Google-Smtp-Source: AGRyM1vAMwcuZxsPx/DI9VXQo93C3zKZTAZw7mg0yuWJVCCuLjhTGftPOASOOng0WhDhkQkO9miAWA==
X-Received: by 2002:a05:6871:290:b0:f3:426e:e74e with SMTP id i16-20020a056871029000b000f3426ee74emr177187oae.31.1655134810045;
        Mon, 13 Jun 2022 08:40:10 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id n3-20020a0568301e8300b0060603221281sm3542478otr.81.2022.06.13.08.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:40:08 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-fe51318ccfso8956966fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:40:08 -0700 (PDT)
X-Received: by 2002:a05:6870:5247:b0:fb:2e60:26c6 with SMTP id
 o7-20020a056870524700b000fb2e6026c6mr157351oai.241.1655134808192; Mon, 13 Jun
 2022 08:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220611061825.4119270-1-swboyd@chromium.org>
In-Reply-To: <20220611061825.4119270-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 13 Jun 2022 08:39:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft7ZJ3PP=A8FMUs1O6FnRacjrceeYzeoJ8_9q5AffuLBPw@mail.gmail.com>
Message-ID: <CAE=gft7ZJ3PP=A8FMUs1O6FnRacjrceeYzeoJ8_9q5AffuLBPw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Always expose last resume result
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:18 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The last resume result exposing logic in cros_ec_sleep_event()
> incorrectly requires S0ix support, which doesn't work on ARM based
> systems where S0ix doesn't exist. That's because cros_ec_sleep_event()
> only reports the last resume result when the EC indicates the last sleep
> event was an S0ix resume. On ARM systems, the last sleep event is always
> S3 resume, but the EC can still detect sleep hang events in case some
> other part of the AP is blocking sleep.
>
> Always expose the last resume result if the EC supports it so that this
> works on all devices regardless of S0ix support. This fixes sleep hang
> detection on ARM based chromebooks like Trogdor.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Rajat Jain <rajatja@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Fixes: 7235560ac77a ("platform/chrome: Add support for v1 of host sleep event")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

I looked at the EC code for firmware-hatch-12669.B, which is I think
the oldest board shipping the suspend_transitions support, and saw
that it correctly initializes resume_response.sleep_transitions for
both S0IX_RESUME and S3_RESUME. I think that mitigates my only concern
that we might be interpreting garbage sleep_transitions from the EC on
some older platforms. So,

Reviewed-by: Evan Green <evgreen@chromium.org>

> ---
>
> Changes from v1 (https://lore.kernel.org/r/20220610223703.3387691-1-swboyd@chromium.org):
>  * Fixed typo
>
>  drivers/platform/chrome/cros_ec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index b3e94cdf7d1a..3abef9747482 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>         buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
>
>         ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> -
> -       /* For now, report failure to transition to S0ix with a warning. */
> +       /* Report failure to transition to system wide suspend with a warning. */
>         if (ret >= 0 && ec_dev->host_sleep_v1 &&
> -           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> +           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
> +            sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
>                 ec_dev->last_resume_result =
>                         buf.u.resp1.resume_response.sleep_transitions;
>
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> https://chromeos.dev
>
