Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50738592DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbiHOLCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbiHOLBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:01:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E55240B6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:01:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so8668370wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6FKn295pNYev8Mu4mgt0CdguxgwFOhEuSmCWwqRDYlY=;
        b=mHwiulbbPxH4SDlPz4iXxByR1+Xl1Rz234T5ygdWXAANUzpvxRqQNfOR9z5kTBGyKY
         zIYJxVkOfmUmD4iNK7NEem28989mXbvExX9Ho+iGlpo8ZmCbkxXlRBLGfwbqxby+6UOl
         jdOYXegykYxiJM7NwMt1BLM1dEby1JE0BG1VTmV/ErNnL3gnnm6EtD6VbbSbFy1YdQGl
         gfCjPXNoWmdEkFQ7SGKkMPIYxtaDfITluHVuQyE9nAMQC0Cw3D+X5RA40IrNpCsqjaaC
         4eadhBdQIf2+NjvAeGzCqFQYdtRa8xPfaTCIvqOD8oGBC1B2yNNsxRGGGIqDY2uj6xvP
         By4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6FKn295pNYev8Mu4mgt0CdguxgwFOhEuSmCWwqRDYlY=;
        b=Y5hCI02Jdi+JA8wvF5PPl/M6XESwXEk0g8FOSwe6jdAdjs5yA5vZpgPQ2rWC2RKNGA
         zWRqeN4loo/gtnNg6PCuw0RhTxAVOOQuprN4Y6tq9Z/aqwRibxkKfwaQR39t4i3EQ20x
         dTKbpFV0QRHqN5CKKSa+bwUnhwNpg6psnPUGPnHmvIF/fqEu3z10vQt9VV+EjVGf723e
         d0LcA2Lx20HkuM0zxOPSLTJKQ7HQkGtq578e4bCUhvkEona9qKpxj4eNomnsc0/+Gs/9
         uDLx4eJQ0rpU6AbWW6Tp02QWadH/QaraDknVoXm3jLhXuh0pBdDZbNwvBb1fAbzQOKWu
         lXzw==
X-Gm-Message-State: ACgBeo2T+k5VW0EYjU9zkXCgnJB17X/04cdm7tkk8LX7Ti7cTj/UsEkj
        K2bnFDcla7XrQ5JEkMylc5G2aA==
X-Google-Smtp-Source: AA6agR5pHfwtw3hqi+PnolqtHH6VPX8PopBTpNA+hz9toNY0+VpTIGZVS/G7CImtyNr5yOYI3nYCaw==
X-Received: by 2002:a5d:4912:0:b0:220:6633:104f with SMTP id x18-20020a5d4912000000b002206633104fmr8488827wrq.625.1660561303286;
        Mon, 15 Aug 2022 04:01:43 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003a5bd9448e5sm9240829wmq.28.2022.08.15.04.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 04:01:42 -0700 (PDT)
Date:   Mon, 15 Aug 2022 14:01:40 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Len Brown <lenb@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
Message-ID: <YvonlAwXAoXTUTZe@linaro.org>
References: <20220810060040.321697-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-09 23:00:29, Saravana Kannan wrote:
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

Tested the specific case we discussed about here:
https://lore.kernel.org/all/CAGETcx8F0wP+RA0KpjOJeZfc=DVG-MbM_=SkRHD4UhD2ReL7Kw@mail.gmail.com/raw

Thanks for fixing this.

Tested-by: Abel Vesa <abel.vesa@linaro.org>

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
