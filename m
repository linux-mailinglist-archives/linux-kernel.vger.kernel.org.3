Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB54591E96
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiHNF7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHNF7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:59:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589211EAE1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:59:40 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3246910dac3so42567917b3.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5oLColQvmc38EgwYlwNaR7xBXm39Ucdba1pf+UlgEWM=;
        b=q558+3KYcrL9bSgXbqgz+VMfCDEAs5hVJ5ccWO//m+mAokgegGdQBnpL3jxS+nIvOY
         qEoMF5tpHG433ffy1Vr6SFeg8zDPLv/qwEbO7l1qL2HpplmRX8NDRJmzhkVJ9CbwwyZx
         aJe6qOinM4F+sPLgPpwG5yh4iE7oE4HU+JmaENM/Dj05J+lWvcw5FESz2GzQ4s75YlFW
         uWaueRVofMCpZUXjaI3zV1hB8/xifg2KyHvaLraJug1K1R0X17Ao7qB3vftV83DEutHS
         8z5i2In2F71MzT2IvXtLy18B7lggPdaxaEm3cQoL2E978jXxBens3Xc9ct8HV1xQsM6U
         bzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5oLColQvmc38EgwYlwNaR7xBXm39Ucdba1pf+UlgEWM=;
        b=Doai3WqO1puCov2+KsENzf6hZNW20iZe6jLlxkf8nCEw2L+6BsVK4ZlxxGtLmg1G2O
         ZzAoOCmR2Z+n9+m86Zf0nnt7EYpjXP975B0d/wgmrbXTlvlM6uEyIMpS3D9agAzilaxQ
         aViDNktsrZ534o+xm0ycRkfudsvLtxnlNaJXGiwPUtB7tJIf2x/N5Slg+xKl0nWFtqMm
         ifKviei3RjPaeJNxxHMkAabeCP4j5orHTW5Le2FYO3HEtX+nnH/t1RNxE2kgTbjOdNAJ
         jv+0XBR1/5IVZnWr25y+WDT6ghS0xYKAB8jpx5G2hCu8OEs5Lh7b25oBPeItXMV14Dp3
         1eOg==
X-Gm-Message-State: ACgBeo0KKy6khtZQlHrHTeDj6qW9t2HOywM26Pv59KSen5i/ToIlZx/4
        hljIT/nuoZc65yC7C2JSBu+XSoR9mNixS2rPPjWdrw==
X-Google-Smtp-Source: AA6agR4ruZp6kLLHNNcriPdt5yfdexRiAWfgjuySPdNmZUSR6mw/ugLvr7aOQkMBoJG00d4Yxeu6h7IlNmfH6rYiWRo=
X-Received: by 2002:a0d:fd05:0:b0:329:3836:53ac with SMTP id
 n5-20020a0dfd05000000b00329383653acmr9498030ywf.455.1660456779360; Sat, 13
 Aug 2022 22:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 13 Aug 2022 22:59:04 -0700
Message-ID: <CAGETcx_nVXbHzZ3+_aR4SZtSnSBU=Rfp8Qm2jOs7zGZRaH_88A@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
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

+Naresh Kamboju

On Tue, Aug 9, 2022 at 11:00 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This patch series improves fw_devlink in the following ways:
>
> 1. It no longer cares about a fwnode having a "compatible" property. It
>    figures this our more dynamically. The only expectation is that
>    fwnode that are converted to devices actually get probed by a driver
>    for the dependencies to be enforced correctly.
>
> 2. Finer grained dependency tracking. fw_devlink will now create device
>    links from the consumer to the actual resource's device (if it has one,
>    Eg: gpio_device) instead of the parent supplier device. This improves
>    things like async suspend/resume ordering, potentially remove the need
>    for frameworks to create device links, more parallelized async probing,
>    and better sync_state() tracking.
>
> 3. Handle hardware/software quirks where a child firmware node gets
>    populated as a device before its parent firmware node AND actually
>    supplies a non-optional resource to the parent firmware node's
>    device.
>
> 4. Way more robust at cycle handling (see patch for the insane cases).
>
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
>
> 6. Simplifies the work that needs to be done by the firmware specific
>    code.
>
> This took way too long to get done due to typo bugs I had in my rewrite or
> corner cases I had to find and handle. But it's fairly well tested at this
> point and I expect this to work properly.
>
> Abel & Doug,
>
> This should fix your cyclic dependency issues with your display. Can you
> give it a shot please?
>
> Alexander,
>
> This should fix your issue where the power domain device not having a
> compatible property. Can you give it a shot please?
>
> Tony,
>
> This should handle the odd case of the child being the supplier of the
> parent. Can you please give this a shot? I want to make sure the cycle
> detection code handles this properly and treats it like it's NOT a cycle.
>
> Geert,
>
> Can you test the renesas stuff I changed please? They should continue
> working like before. Any other sanity test on other hardware would be
> great too.
>
> Sudeep,
>
> I don't think there are any unfixed issues you had reported in my other
> patches that this series might fix, but it'll be nice if you could give
> this a sanity test.
>
> Guenter,
>
> I don't think this will fix the issue you reported in the amba patch, but
> it's worth a shot because it improves a bunch of corner case handling. So
> it might be better at handling whatever corner cases you might have in the
> qemu platforms.

Hi Naresh,

Thanks for testing these patches in the other thread. Mind giving your
tested-by here? I know you tested these patches in X15, but were there
also other boards these patches were tested on as part of the run?

Thanks,
Saravana


>
> Thanks,
> Saravana
>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
>
> Saravana Kannan (9):
>   driver core: fw_devlink: Don't purge child fwnode's consumer links
>   driver core: fw_devlink: Improve check for fwnode with no
>     device/driver
>   soc: renesas: Move away from using OF_POPULATED for fw_devlink
>   gpiolib: Clear the gpio_device's fwnode initialized flag before adding
>   driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
>   driver core: fw_devlink: Allow marking a fwnode link as being part of
>     a cycle
>   driver core: fw_devlink: Consolidate device link flag computation
>   driver core: fw_devlink: Make cycle detection more robust
>   of: property: Simplify of_link_to_phandle()
>
>  drivers/base/core.c             | 437 +++++++++++++++++++++-----------
>  drivers/gpio/gpiolib.c          |   6 +
>  drivers/of/property.c           |  84 +-----
>  drivers/soc/renesas/rcar-sysc.c |   2 +-
>  include/linux/device.h          |   1 +
>  include/linux/fwnode.h          |  12 +-
>  6 files changed, 323 insertions(+), 219 deletions(-)
>
> --
> 2.37.1.559.g78731f0fdb-goog
>
