Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1BA4B805A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbiBPFre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:47:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiBPFrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:47:32 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED3F1AF6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:47:21 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id bt13so2861070ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elu8Ka2cZem2k4zQRGJEv65TLQWlji0lH04NXcgaWoI=;
        b=LVuSa+60cggKNTvJ1zIakxD1VIAn5f/pbblK/YjQD5LI7TD31BHIqZ24c6BKqeGFCI
         OaEmU2yh7N6fQW6FBGELn61X/aBcQctz+GZJlD44yKuQ8BpCCCk9taP4fVgo/fJyMHo+
         exJd028Ht/JAdX4P236LDPuuUXUe1VYdLdI4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elu8Ka2cZem2k4zQRGJEv65TLQWlji0lH04NXcgaWoI=;
        b=KZqUg80iElXq/6h09imNaCYhaCpFP1ICzFJ8ji3Z6/aLe3k097l7xas/3zaGnUJLfA
         zvIRzf+pfqQXk6SRH/eFs+QvEepDr0CAoxB9ehD8iu2kk2tnTlw6sSBHCnPhZAFSSn6b
         sadHEYFIxOnMr0PiWWsxaPWIwe/4LWup7LvXrQeX/bH4zowJ8nsFMIiGgAJDZWdWDT3H
         S4vfYOXd1EmCo9Loh2a+litNF26og3jRJ5PQmD5nl6J2DoN7D7yT52TeeWps+umGQ35m
         rnfFj0Mk09kRK6SBh/WDT1KvRQ/gSEIMlofhAsxK7C78wWacs7OmxCs8icELO6CO4Zkf
         eV1w==
X-Gm-Message-State: AOAM530hbNVws+1T9p6jhZDuqFkpUQgwlOP9In5mxg9MX8gk9xoYxBdB
        cTvEX8AELQ8ZPnbxD/Li64sKy+Fr+b+uzfJw+UjjZQ==
X-Google-Smtp-Source: ABdhPJwHGG5NOl9rUjmJ5FIROtsaZzXi5k/xwDtwVPIUKH4MttQH+YypSdaXae9uXC3An9ibKfa1nMBwNwSdBnnhYtI=
X-Received: by 2002:a25:8b0a:0:b0:61a:4aab:3e78 with SMTP id
 i10-20020a258b0a000000b0061a4aab3e78mr880886ybl.619.1644990440308; Tue, 15
 Feb 2022 21:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20220216043639.3839185-1-tzungbi@google.com> <20220216043639.3839185-4-tzungbi@google.com>
In-Reply-To: <20220216043639.3839185-4-tzungbi@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 15 Feb 2022 21:47:09 -0800
Message-ID: <CACeCKacKtJ50b2TuuhcVYPq0Fd0unVJdMuNDk1PLNK_r2JHZ+A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] platform/chrome: cros_ec: initialize
 `wake_enabled` in cros_ec_register()
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 8:37 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> `wake_enabled` indicates cros_ec_resume() needs to call
> disable_irq_wake() to undo enable_irq_wake() in cros_ec_suspend().
>
> Initialize `wake_enabled` in cros_ec_register() and determine the flag
> in cros_ec_suspend() instead of reset-after-used in cros_ec_resume().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>

One minor thing to consider, but regardless:

Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
> Changes from v3:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-4-tzungbi@google.com/)
> - Change the patch title.
> - Simplify by initializing wake_enabled in cros_ec_register().
>
> No changes from v2.
>
> Changes from v1:
> (https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
> - Use imperative mood in commit message.
>
>  drivers/platform/chrome/cros_ec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 25cd8df6e7b0..b6604a9ab315 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -191,6 +191,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         ec_dev->max_passthru = 0;
>         ec_dev->ec = NULL;
>         ec_dev->pd = NULL;
> +       ec_dev->wake_enabled = false;
>
>         ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
>         if (!ec_dev->din)
> @@ -383,10 +384,9 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
>                 dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
>                         ret);
>
> -       if (ec_dev->wake_enabled) {
> +       if (ec_dev->wake_enabled)
>                 disable_irq_wake(ec_dev->irq);
> -               ec_dev->wake_enabled = 0;
> -       }
> +

Better to leave it as is, and ensure "wake_enabled" is cleared after resume?
Will result in a smaller diff.

I'll leave it up to you.

-Prashant
