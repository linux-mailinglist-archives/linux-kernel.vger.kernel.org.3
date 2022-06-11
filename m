Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F467547128
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349621AbiFKBkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:40:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBE3B60B0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:40:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c2so947312edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QABc4YlIjdzNmKMejkI2eOzTrYOoWCevfbBdoFlAxVY=;
        b=tN66Wmxq6Hr6WvGjsoZxrBmeFnAV9ZgYbZN1JIgrbr632Ee4mGX9hJcnFfJ0qiFvGP
         DDmSK/N5LIftb1lz6YgdnbpZDVcN8PMieuG7AQ3LgMTSavBsMJP+zcbDRuJCEJFpFVrQ
         GScpRWsBMbcNQ0T1RpSllFzSqtOhA0Qnmd5OYMq+TD66SubmiIvmyO9g6LOAqDP9LKUw
         /3Wm7liPAogXEBFuJKHQlNIrLlgtntIYFTiljJokx0OBP7H2ikvR49WarrDBoK8fK/7r
         AlT41+ZDbOek9HdLRNa0dt/rKYkrz1wgsgCoeFkpPDYJahuZh+lQasl2Vo5nkv2q2AI7
         MjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QABc4YlIjdzNmKMejkI2eOzTrYOoWCevfbBdoFlAxVY=;
        b=w/AUjufjBfIrLkSc44KHHLG0tHMJscAagU+YwT65kZuNR3SFONiJHFvuk7HJ++eqg0
         AP1mShPjfCrMtJJacqimOEZtr0tqYCyXvye3ZTmwRq6GU8mLpLl4nOmZvA/0lD+WJiNY
         t33yim/RSP7cyK6RcEi6vb1771EDRqpZYTBQMoovlC0KvhesXeZhqAfCWbc+7joy4hbs
         F2RXDOXopdY7ubrLkGzqodlMX+8SjWPcoO9Kc+mZyW+44+RdfLZ7dIqhGJMFeBYQAGp/
         +/qqd8BPG+ABxzgflfo+ihTKmDyKgSNAP/dN2MB9XTit8A9ZnOP5ckRkmk09+z5PZQcY
         Z3iQ==
X-Gm-Message-State: AOAM530pbRiXrP0Fa/DgAcNo8ZgH+FMcuvvZcLpFS99RU8lLI2Meox+/
        1XeuqdQaGmj4ET3Nlcc68vf086Y1uTdkGZPWOqc1Og==
X-Google-Smtp-Source: ABdhPJwJ67aKbfxtJuYIk3/E8mMInJrcvazk99B9VaYCNnV5blyc4ttJlCMPqb+KYVwLq07H9N4E+z+cSW7FhQRtzeg=
X-Received: by 2002:a05:6402:3490:b0:42f:b592:f364 with SMTP id
 v16-20020a056402349000b0042fb592f364mr42426383edc.66.1654911643955; Fri, 10
 Jun 2022 18:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220610223703.3387691-1-swboyd@chromium.org>
In-Reply-To: <20220610223703.3387691-1-swboyd@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 10 Jun 2022 18:40:33 -0700
Message-ID: <CABXOdTfvuHLf=ahN4+iOewyLCNnOZMXS-S+4a_RUtLCC=9t_HA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Always expose last resume result
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 3:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
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
> ---
>
> I originally was going to check for S3 only with !ARCH_X86 but I can't
> convince myself that it's any use to limit the check to s0ix in general.
> This approach assumes the last resume result is valid if the command is
> supported, regardless of whether or not the AP supports s0ix or not.
> This seems to be the case at least on ARM, and looking at the EC
> convinces me that CONFIG_POWER_SLEEP_FAILURE_DETECTION is only enabled
> on x86 devices that have s0ix.
>
>  drivers/platform/chrome/cros_ec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index b3e94cdf7d1a..881d3ad09be0 100644
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
> +           (sleep_event == HOST_SLEEP_EVENT_S0IX_SUSPEND ||
> +            sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {

I am sure I am missing something, but the description doesn't explain
(to me) the switch from HOST_SLEEP_EVENT_S0IX_RESUME to
HOST_SLEEP_EVENT_S0IX_SUSPEND.

Thanks,
Guenter

>                 ec_dev->last_resume_result =
>                         buf.u.resp1.resume_response.sleep_transitions;
>
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> https://chromeos.dev
>
