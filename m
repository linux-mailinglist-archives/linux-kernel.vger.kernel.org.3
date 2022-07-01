Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3277563857
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiGAQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGAQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:59:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945B11A38
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:59:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd6so3695375edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51XJmeFGSCpeWpGVJIgYYkXCjZO/7dCyc5nbhZQFE9g=;
        b=btYkkxWkV3SrBUcr1GL9Wh70bDS4aKRkmhJ3E5KKhdhPNHMIPrkdfrqNny4F/v7sUv
         h8eTQihiOMQSCK5RJZiKdKZwucl3L7wHe4mnaXW2+RJJokS3tluWSZEmByI9q58LVq6X
         NvyaGbSo7ITsKWPB1d+r9c7i2J0wV/QzVxOP4Igs2R0IwtVfdRrN53peVlmXDHa+cYqF
         hXS7GwyLGNxoWCzJQvFUcjn826DTM+ygAR8IrZ+yN6R1Dgu9doR3+Jg0SZq29FXqxYOl
         iPNUrk79RYIKpS/yJIx3vFZBXdDnOCccHa8oEXeQJlA8feSrF5fbF5r4ytMpaJXEL2EZ
         +Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51XJmeFGSCpeWpGVJIgYYkXCjZO/7dCyc5nbhZQFE9g=;
        b=PV9NELpb+BqXApI2b4Iu4Hx8QevvP2HmfCCcchb+wywtSMi85uBYJGb/SlEwmyuFbu
         1ftavu98aUOfJ7FjvOqAmlAzd1dA/eDS2dkR3bn1KFfHXgB3Bztj8AK/7n0pvlFXty/I
         ESR5nu4RtlSVrngSma8uZbH27IDNNILBFumWrKOC4NLmlhnIYxXjTiJgwZzNRlipteYV
         SwkYA9Xu59T7SDMi5OC7S+MGJ2mkZIYoRuNSIjNcq2UvIZn+VqtBDkBlYOJNDOv7iVTI
         hIon8PwDNWIR+aVRMqRZsWczl3f2sdhve/Lu/325+WWSpY22qnGzLnDHqb6SXahWp2oZ
         6oNw==
X-Gm-Message-State: AJIora8PGPCk3/XtO/qHTggl7ClYg2v+Lp7r5yXM1f4BBz37vutz3+Y8
        2pjdNH1T4ERWRyDp8Yk9THpmzNLkhE8q9lj/5ty5Hw==
X-Google-Smtp-Source: AGRyM1ukVHnZIKXXd90a1KBf/JucgBk0M9Kzg6bmVGukBHFFeBtewkkuSZM9kshCwi7pvSh2Nrhxy7xirSbm8yURxM0=
X-Received: by 2002:a05:6402:3511:b0:437:7eec:c44c with SMTP id
 b17-20020a056402351100b004377eecc44cmr20456910edd.11.1656694745877; Fri, 01
 Jul 2022 09:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220701095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid>
In-Reply-To: <20220701095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 1 Jul 2022 09:58:54 -0700
Message-ID: <CABXOdTc+2JhmBnxzhpDW4yfZK7-V3H2vx-7QKgH4JBJb84Mveg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tim Van Patten <timvp@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Barnes <robbarnes@google.com>,
        Raul Rangel <rrangel@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>
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

On Fri, Jul 1, 2022 at 8:54 AM Tim Van Patten <timvp@google.com> wrote:
>
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
> .prepare() and cros_ec_lpc_resume() during .complete. This allows the
> EC to log entry/exit of AP's suspend/resume more accurately.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
>  drivers/platform/chrome/cros_ec_lpc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7677ab3c0ead9..783a0e56bf5f3 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -534,19 +534,24 @@ static int cros_ec_lpc_suspend(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
>
> +       dev_info(dev, "Prepare EC suspend\n");

I don't see why that logging noise is necessary and/or adds value. If
every driver did that, the entire kernel log would be polluted by
similar messages.

> +
>         return cros_ec_suspend(ec_dev);
>  }
>
> -static int cros_ec_lpc_resume(struct device *dev)
> +static void cros_ec_lpc_resume(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
>
> -       return cros_ec_resume(ec_dev);
> +       cros_ec_resume(ec_dev);
> +
> +       dev_info(dev, "EC resume completed\n");

Same here.

Guenter

>  }
>  #endif
>
>  static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
> -       SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
> +       .prepare = cros_ec_lpc_suspend,
> +       .complete = cros_ec_lpc_resume
>  };
>
>  static struct platform_driver cros_ec_lpc_driver = {
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
