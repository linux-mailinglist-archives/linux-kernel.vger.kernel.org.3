Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B29593047
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiHONx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiHONxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:53:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 637FE1EAE8;
        Mon, 15 Aug 2022 06:53:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC6F01D6F;
        Mon, 15 Aug 2022 06:53:22 -0700 (PDT)
Received: from bogus (unknown [10.57.44.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55DBC3F66F;
        Mon, 15 Aug 2022 06:53:17 -0700 (PDT)
Date:   Mon, 15 Aug 2022 14:52:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
Message-ID: <20220815135251.i3pejjtnd3nqeolo@bogus>
References: <20220810060040.321697-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 11:00:29PM -0700, Saravana Kannan wrote:
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

Sure tested this on Juno on top of v6.0-rc1 and found no regressions.
So,

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Just wanted to check if the logs are intentional or do you plan to make
them debug. On Juno with hardly few such dependencies I get below extra
logs during boot, it may add loads on other platforms. I am fine either
way, just thought of checking.

| amba 20040000.funnel: Fixed dependency cycle(s) with /etf@20010000/in-ports/port/endpoint
| amba 20120000.replicator: Fixed dependency cycle(s) with /etr@20070000/in-ports/port/endpoint
| amba 20120000.replicator: Fixed dependency cycle(s) with /tpiu@20030000/in-ports/port/endpoint
| amba 220c0000.funnel: Fixed dependency cycle(s) with /etm@22040000/out-ports/port/endpoint
| amba 220c0000.funnel: Fixed dependency cycle(s) with /funnel@20040000/in-ports/port@0/endpoint
| amba 22140000.etm: Fixed dependency cycle(s) with /funnel@220c0000/in-ports/port@1/endpoint
| amba 230c0000.funnel: Fixed dependency cycle(s) with /etm@23040000/out-ports/port/endpoint
| amba 230c0000.funnel: Fixed dependency cycle(s) with /funnel@20040000/in-ports/port@1/endpoint
| amba 23140000.etm: Fixed dependency cycle(s) with /funnel@230c0000/in-ports/port@1/endpoint
| amba 23240000.etm: Fixed dependency cycle(s) with /funnel@230c0000/in-ports/port@2/endpoint
| amba 23340000.etm: Fixed dependency cycle(s) with /funnel@230c0000/in-ports/port@3/endpoint
| amba 20130000.funnel: Fixed dependency cycle(s) with /stm@20100000/out-ports/port/endpoint
| amba 20140000.etf: Fixed dependency cycle(s) with /funnel@20130000/out-ports/port/endpoint
| amba 20150000.funnel: Fixed dependency cycle(s) with /etf@20140000/out-ports/port/endpoint
| amba 20150000.funnel: Fixed dependency cycle(s) with /etf@20010000/out-ports/port/endpoint
| amba 20150000.funnel: Fixed dependency cycle(s) with /replicator@20120000/in-ports/port/endpoint
| i2c 0-0070: Fixed dependency cycle(s) with /hdlcd@7ff60000/port/endpoint
| i2c 0-0071: Fixed dependency cycle(s) with /hdlcd@7ff50000/port/endpoint

-- 
Regards,
Sudeep
