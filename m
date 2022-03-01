Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD984C9248
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiCAR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiCAR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:56:57 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0675A5BD;
        Tue,  1 Mar 2022 09:56:16 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2db2add4516so120842927b3.1;
        Tue, 01 Mar 2022 09:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7kYrgjJh36E4purVY0Ndu44RP6Lwx7BnIE3PFfMwpk=;
        b=CRQDUtaSYAIsBQk2+FjcjZTi07xlgOEyJZvEk6tyvqzF5JGLWXfcBY6O/qKIj55oti
         z3qbilJW2hIYWUhDLcEJVThzuhedu4gnJfYKQQbhumOYAK2pgFkCp8T3kxb4eoyAtYDq
         u3p3OAY90IYj6oyCX7xumqgG7CQphiFk4bFTE3z7MlSCC/qCa3DEqcR/pEmwn6sA7g4G
         10P2KFK45IXIQ6XJQoZY9Ye8S4eHG2gGRlroC+EkPy3qGosbJI/QIwt1m5wtke+Zxa7g
         JjnRSNqAgMxugekqFGPoanSD935E/+Ub2Rj0UKqLX3jtdf6z6K6jgPI5Cur8GeBLF52F
         Rorw==
X-Gm-Message-State: AOAM533vIm8uRVunp1ult1rFLZ/uTSha29NS42FDVFBbNPZgizhWWt2H
        v2+th7xzOebsqFLrGWezkUOUY3i+FlYqT6L8qG0=
X-Google-Smtp-Source: ABdhPJxMnlD0WIcIo3cR+UaJloB4TYyLioG4bOFeHFq0wlyMZ0jZcvkBixS0oimq5xgY3EWkJhzqMVkVE3ObL39LonQ=
X-Received: by 2002:a0d:e8d2:0:b0:2d6:1743:4023 with SMTP id
 r201-20020a0de8d2000000b002d617434023mr26478895ywe.7.1646157375773; Tue, 01
 Mar 2022 09:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20220228220544.22877-1-rdunlap@infradead.org>
In-Reply-To: <20220228220544.22877-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 18:56:04 +0100
Message-ID: <CAJZ5v0g-EEw4qgXJ4gBjRe-vt3u0XzmOv4wC0gP0JLnpk7ciXQ@mail.gmail.com>
Subject: Re: [PATCH] PM/sleep: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 11:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> If an invalid option is given for "test_suspend=<option>", the entire
> string is added to init's environment, so return 1 instead of 0 from
> the __setup handler.
>
>   Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc5
>     test_suspend=invalid"
>
> and
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc5
>      test_suspend=invalid
>
> Fixes: 2ce986892faf ("PM / sleep: Enhance test_suspend option with repeat capability")
> Fixes: 27ddcc6596e5 ("PM / sleep: Add state field to pm_states[] entries")
> Fixes: a9d7052363a6 ("PM: Separate suspend to RAM functionality from core")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> ---
> Would someone like warning messages added in case of bad option strings?
>
>  kernel/power/suspend_test.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- linux-next-20220228.orig/kernel/power/suspend_test.c
> +++ linux-next-20220228/kernel/power/suspend_test.c
> @@ -157,22 +157,22 @@ static int __init setup_test_suspend(cha
>         value++;
>         suspend_type = strsep(&value, ",");
>         if (!suspend_type)
> -               return 0;
> +               return 1;
>
>         repeat = strsep(&value, ",");
>         if (repeat) {
>                 if (kstrtou32(repeat, 0, &test_repeat_count_max))
> -                       return 0;
> +                       return 1;
>         }
>
>         for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
>                 if (!strcmp(pm_labels[i], suspend_type)) {
>                         test_state_label = pm_labels[i];
> -                       return 0;
> +                       return 1;
>                 }
>
>         printk(warn_bad_state, suspend_type);
> -       return 0;
> +       return 1;
>  }
>  __setup("test_suspend", setup_test_suspend);

Applied as 5.18 material, thanks!
