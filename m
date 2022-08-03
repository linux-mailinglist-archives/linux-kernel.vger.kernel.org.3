Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273B5890FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiHCRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:07:50 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAF913F4D;
        Wed,  3 Aug 2022 10:07:47 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id o15so29194942yba.10;
        Wed, 03 Aug 2022 10:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=R90OPlqibv5/+FhqLYYfYjv4/EeR2dDMost5OGG8eEE=;
        b=3wJohi0w4LtKOtBSAs35Huuzqbsb9vwzTVlIO7d8QA4zlL8R/YmAH31eY87+KOFr/W
         +KlX+J1UfdVgRgQj8H8EbJloG56bffcNVs6OCNS7lgOHgEcymmQBeQuYbu1IYoym9cRW
         +oQ6rAO5iWvnJmt8qDwmDfCTrAtbILK/3EWunj8MdsMeC4uXCp97mSyENfVvuZT4ey4H
         5kYcupzXqozsMjQSbQvQNSH50G331KaNpGfe/T3hPXJbiFuB3u0u1G702wVZ2Rosqmgb
         LdBhSWKFbfp25oMeQG3ZDVICGRP09LD1DGWp07hvz8fHF11tIZbCt0uXtT8T0R54NaG8
         0pbg==
X-Gm-Message-State: ACgBeo0hgrzsYEIs1C1Iy7wjUvUMsQ09UUA0xxSEXnmt7u9UOpJ6IsBl
        SIxIPsFxAyb8uUTM+nIrYHyXbJTehv8x05iEIds=
X-Google-Smtp-Source: AA6agR6l2hEuaetgvNoAhMJBpHMqeTg/cIWL4Hfx/S/Or4kMLSM6ZoyLlBw3r0fvCGjErEpLpOxgBIDzo6jOSyhjWoA=
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr14953152ybt.365.1659546466495; Wed, 03
 Aug 2022 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220725173755.2993805-1-f.fainelli@gmail.com>
In-Reply-To: <20220725173755.2993805-1-f.fainelli@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 19:07:35 +0200
Message-ID: <CAJZ5v0hL46vdr=f8YiAPnRmmehZs51n+tkgoY7PMTVyJD0cpEA@mail.gmail.com>
Subject: Re: [PATCH] tools/thermal: Fix possible path truncations
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 7:38 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> A build with -D_FORTIFY_SOURCE=2 enabled will produce the following warnings:
>
> sysfs.c:63:30: warning: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 255 [-Wformat-truncation=]
>   snprintf(filepath, 256, "%s/%s", path, filename);
>                               ^~
> Bump up the buffer to PATH_MAX which is the limit and account for all of
> the possible NUL and separators that could lead to exceeding the
> allocated buffer sizes.
>
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Daniel, are you going to pick up this one or should I?

There is also a tmon patch from Florian that seems to be pending.
Should I take care of it?

> ---
>  tools/thermal/tmon/sysfs.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
> index b00b1bfd9d8e..cb1108bc9249 100644
> --- a/tools/thermal/tmon/sysfs.c
> +++ b/tools/thermal/tmon/sysfs.c
> @@ -13,6 +13,7 @@
>  #include <stdint.h>
>  #include <dirent.h>
>  #include <libintl.h>
> +#include <limits.h>
>  #include <ctype.h>
>  #include <time.h>
>  #include <syslog.h>
> @@ -33,9 +34,9 @@ int sysfs_set_ulong(char *path, char *filename, unsigned long val)
>  {
>         FILE *fd;
>         int ret = -1;
> -       char filepath[256];
> +       char filepath[PATH_MAX + 2]; /* NUL and '/' */
>
> -       snprintf(filepath, 256, "%s/%s", path, filename);
> +       snprintf(filepath, sizeof(filepath), "%s/%s", path, filename);
>
>         fd = fopen(filepath, "w");
>         if (!fd) {
> @@ -57,9 +58,9 @@ static int sysfs_get_ulong(char *path, char *filename, unsigned long *p_ulong)
>  {
>         FILE *fd;
>         int ret = -1;
> -       char filepath[256];
> +       char filepath[PATH_MAX + 2]; /* NUL and '/' */
>
> -       snprintf(filepath, 256, "%s/%s", path, filename);
> +       snprintf(filepath, sizeof(filepath), "%s/%s", path, filename);
>
>         fd = fopen(filepath, "r");
>         if (!fd) {
> @@ -76,9 +77,9 @@ static int sysfs_get_string(char *path, char *filename, char *str)
>  {
>         FILE *fd;
>         int ret = -1;
> -       char filepath[256];
> +       char filepath[PATH_MAX + 2]; /* NUL and '/' */
>
> -       snprintf(filepath, 256, "%s/%s", path, filename);
> +       snprintf(filepath, sizeof(filepath), "%s/%s", path, filename);
>
>         fd = fopen(filepath, "r");
>         if (!fd) {
> @@ -199,8 +200,8 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
>  {
>         unsigned long trip_instance = 0;
>         char cdev_name_linked[256];
> -       char cdev_name[256];
> -       char cdev_trip_name[256];
> +       char cdev_name[PATH_MAX];
> +       char cdev_trip_name[PATH_MAX];
>         int cdev_id;
>
>         if (nl->d_type == DT_LNK) {
> @@ -213,7 +214,8 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
>                         return -EINVAL;
>                 }
>                 /* find the link to real cooling device record binding */
> -               snprintf(cdev_name, 256, "%s/%s", tz_name, nl->d_name);
> +               snprintf(cdev_name, sizeof(cdev_name) - 2, "%s/%s",
> +                        tz_name, nl->d_name);
>                 memset(cdev_name_linked, 0, sizeof(cdev_name_linked));
>                 if (readlink(cdev_name, cdev_name_linked,
>                                 sizeof(cdev_name_linked) - 1) != -1) {
> @@ -226,8 +228,8 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
>                         /* find the trip point in which the cdev is binded to
>                          * in this tzone
>                          */
> -                       snprintf(cdev_trip_name, 256, "%s%s", nl->d_name,
> -                               "_trip_point");
> +                       snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
> +                               "%s%s", nl->d_name, "_trip_point");
>                         sysfs_get_ulong(tz_name, cdev_trip_name,
>                                         &trip_instance);
>                         /* validate trip point range, e.g. trip could return -1
> --
> 2.25.1
>
