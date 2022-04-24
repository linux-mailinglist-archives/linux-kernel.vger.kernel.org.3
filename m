Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8E50D20B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiDXNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiDXNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:32:42 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409A3983F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:29:41 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f16645872fso125122057b3.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK9TFPztsujq8iRjjPRGHGSrFz5D5Xa1peH3uwOx7B4=;
        b=MeFXajKMHoOCQRrJW5sjUZQsO3JmdeUQ/ybqYY8kbBkjSwRzPAByR2Dn/PUI0Hqd/N
         xnJCo59oqJS1eNdxXkJAmmyrqj1LqOASbsaK6vH4/scPWIbYfwyMLb0+cL1laAWFo4d5
         wva2JYXSxfYO7kImrsiwXZMWpCjxJkK2bMvCqkOLez4ofxGCUbNpxXMqSyxE+2QrFE4V
         0YcNGT/Kr5jURM9vR2x4Msfe7WkmJ9Mpd5eKDOf8Yun0Z0IYqtSOBQ/kWT2xzoc6s0rZ
         JJHW4MvVGQZy4HFS23aKzIJBW190f7/D+xDkyiepJy+UD7KenLFfjX0bDcA3ggMh5IUG
         lI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK9TFPztsujq8iRjjPRGHGSrFz5D5Xa1peH3uwOx7B4=;
        b=53gHB7lALmT1X+EhzHUyd+R6o5+50eN5a3c9N4bFZJSt/hqXVXuEnPUdlHubMr9cG6
         dpHLCxvtcL09DsszGNGGhxOLF+KsbB9kKYVnvj53YwgzFNQthQLzUTK42jfPCWS+AW5f
         hFS2HUPMPZhjbS1flMousdGEmpFiXDIrZ6lNlPKLrh3P/nvA5IJ8+6J9Ka9tz4h0OnQs
         sNiXBgFf3fOMZ1IqUfETjTwSK7mIPZ2bGziLez33zKSeVmoXKHGhU7aReWxJzRQKgjAJ
         hEY+GL2E7tJeod7bShHv6nfw57kZyNfPausJzEDHLBb/4JXX1LQ3VYyZRZESwYHK+av2
         VAZQ==
X-Gm-Message-State: AOAM533NgBFWibAHawNSHU4KOLAxZd2VEOTOUfkwB62BM8SDDa+z87Yv
        qpTumpgtuR83Kj7YQBMiO/OLDJAe3HZluYKiPNL60A==
X-Google-Smtp-Source: ABdhPJyKy/ERfoPPNyl1VM2f0F/66Ks2WQss09NGAgQoOIdadyNRHgCmAWZJdCalVLR8yNdxZxKGZuibDrtGllZ0VkQ=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr12447315ywd.118.1650806981255; Sun, 24
 Apr 2022 06:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-3-huobean@gmail.com>
In-Reply-To: <20220423221623.1074556-3-huobean@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Apr 2022 15:29:29 +0200
Message-ID: <CACRpkdahf5QhUJ-vG6Qs7i0VYbSS02zBrQOtN8EVFu9SyHZA1Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Allows to override the timeout value
 for ioctl() path
To:     Bean Huo <huobean@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:16 AM Bean Huo <huobean@gmail.com> wrote:

> From: Bean Huo <beanhuo@micron.com>
>
> Occasionally, user-land applications initiate longer timeout values for certain commands
> through ioctl() system call. But so far we are still using a fixed timeout of 10 seconds
> in mmc_poll_for_busy() on the ioctl() path, even if a custom timeout is specified in the
> userspace application. This patch allows custom timeout values to override this default
> timeout values on the ioctl path.
>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
(...)
>         if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>                 /*
> -                * Ensure RPMB/R1B command has completed by polling CMD13
> -                * "Send Status".
> +                * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
> +                * allow to override the default timeout value if a custom timeout is specified.
>                  */
> -               err = mmc_poll_for_busy(card, MMC_BLK_TIMEOUT_MS, false,
> -                                       MMC_BUSY_IO);
> +               err = mmc_poll_for_busy(card, idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS,
> +                                       false, MMC_BUSY_IO);

I suppose it's OK (albeit dubious) that we have a userspace interface setting
a hardware-specific thing such as a timeout.

However: is MMC_BLK_TIMEOUT_MS even reasonable here? If you guys
know a better timeout for RPMB operations (from your experience)
what about defining MMC_RPMB_TIMEOUT_MS to something more
reasonable (and I suppose longer) and use that as fallback instead
of MMC_BLK_TIMEOUT_MS?

This knowledge (that RPMB commands can have long timeouts) is not
something that should be hidden in userspace.

Yours,
Linus Walleij
