Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F014D99CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347722AbiCOLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347682AbiCOLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:00:26 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135BC3BF8C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:59:15 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e22so21650324ioe.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERUzPoz66Ekz8nytoz/D+JRh+ZH5me7GDLLHYHnWy0A=;
        b=oLKpvcFJhibXQ8KI2qGN+QOZSLwOOyGWaGccHbzLIAwSKFXUj2hpnZW6Hh3AFUyZcp
         mjWZEgiB+oPMxB+8VyagyZxMHpXh8IsowR8YbP8hFHSflEHOXpXwTMhWc1hYRooWNhKt
         DGMh+0RXTQDDUmtnCHQzjkzDNcW191fpe6nEz/FkXN0CfDKOjK5VwVaeIjQ+fM/WxE3L
         TS3FcOzSQucu1DE4BDLCoJXetFEdbuecHA4pJx1Py7vdWAMnU50jm7RflirF/uDA20Te
         Sz/+X7xq7iniqN6gkhKbvGVr70bu0rt9VNCkmufmeJl4pcSolg38cTozvzqHvniMer96
         ihlQ==
X-Gm-Message-State: AOAM532JdW2s3G7eA5EWLIPxNTY9hK3pteZIgoVh+Itd/zFFasFYqDAb
        9E1kzHdBXfBAEKw63iHm+SG7uUAwJCuyd4qVwtpT5il9
X-Google-Smtp-Source: ABdhPJze7jADM6hxsoUDLohxwrGeIietgUF+xluv+LJwGWqkX9IBmJfQx7VEw75753nUERdXj/GevRAwuXVs6OOkMe4=
X-Received: by 2002:a02:6910:0:b0:319:4f4c:eede with SMTP id
 e16-20020a026910000000b003194f4ceedemr22571720jac.301.1647341954431; Tue, 15
 Mar 2022 03:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220312195210.23573-1-rdunlap@infradead.org>
In-Reply-To: <20220312195210.23573-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Mar 2022 11:59:02 +0100
Message-ID: <CAJZ5v0gBYki-PFHiNGuFmpxQGB_+rW0i5D6VThsPHY6GFwGnYg@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource: acpi_pm: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Sat, Mar 12, 2022 at 8:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) environment strings.
>
> The __setup() handler interface isn't meant to handle negative return
> values -- they are non-zero, so they mean "handled" (like a return
> value of 1 does), but that's just a quirk. So return 1 from
> parse_pmtmr(). Also print a warning message if kstrtouint() returns
> an error.
>
> Fixes: 6b148507d3d0 ("pmtmr: allow command line override of ioport")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> From: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Can you please resend this with a CC to linux-acpi?

> ---
> v2: correct the Fixes: tag (Dan Carpenter)
>
>  drivers/clocksource/acpi_pm.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --- linux-next-20220310.orig/drivers/clocksource/acpi_pm.c
> +++ linux-next-20220310/drivers/clocksource/acpi_pm.c
> @@ -229,8 +229,10 @@ static int __init parse_pmtmr(char *arg)
>         int ret;
>
>         ret = kstrtouint(arg, 16, &base);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               pr_warn("PMTMR: invalid 'pmtmr=' value: '%s'\n", arg);
> +               return 1;
> +       }
>
>         pr_info("PMTMR IOPort override: 0x%04x -> 0x%04x\n", pmtmr_ioport,
>                 base);
