Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F88590E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiHLJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHLJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:47:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D71B1321;
        Fri, 12 Aug 2022 02:47:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9093080E1;
        Fri, 12 Aug 2022 09:40:29 +0000 (UTC)
Date:   Fri, 12 Aug 2022 12:47:12 +0300
From:   Tony Lindgren <tony@atomide.com>
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
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 9/9] of: property: Simplify of_link_to_phandle()
Message-ID: <YvYhoGdemyKEx++d@atomide.com>
References: <20220810060040.321697-1-saravanak@google.com>
 <20220810060040.321697-10-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810060040.321697-10-saravanak@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Saravana Kannan <saravanak@google.com> [220810 05:54]:
> The driver core now:
> - Has the parent device of a supplier pick up the consumers if the
>   supplier never has a device created for it.
> - Ignores a supplier if the supplier has no parent device and will never
>   be probed by a driver
> 
> And already prevents creating a device link with the consumer as a
> supplier of a parent.
> 
> So, we no longer need to find the "compatible" node of the supplier or
> do any other checks in of_link_to_phandle(). We simply need to make sure
> that the supplier is available in DT.

This patch fixes booting for me, so it should be applied as a fix and
tagged with:

Fixes: 5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")

If there are dependencies to the other patches in this series, it might
make sense to revert commit 5a46079a9645 instead.

Anyways, thanks for fixing the issue, for this patch:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

For the process, looks like the earlier series got merged despite the
issues reported. And we had non-booting Linux next for at least some SoCs
for weeks. And now we are about to have a non-booting -rc1 unless things
get fixed fast. Annoying glitches, sigh..

Regards,

Tony

