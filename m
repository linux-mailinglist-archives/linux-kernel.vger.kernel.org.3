Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31663592F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbiHOMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiHOMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:39:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C2237DD;
        Mon, 15 Aug 2022 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660567167; x=1692103167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZoeSgVqYecYa8dOXcwGrIo4k9Ip/Bxok4jHfP0iqk0s=;
  b=RxRiPoIBIcCDT1kDI/YX1hV7vf8ExuPtme+aHhJIqCHSN8ma928khbT0
   Eez9zl6oULI6EzEc1HCuHizcE+GVmv55luGurc9EbZ7aaPlBIjOysGqpU
   K0TDS1l28lWsFi7tNBeVCKOwDp9uzgJdVd2sBxjhVQvA4IsSlqLFmxFKi
   fSuMJjCIYbpIdkhUOo298dO4riLw/bMH6swlbwPo5Zr7+ckxEepLwxfo6
   X8+2yFDghGyJZElnIjW8hvzznBoL2jke5nlQbGUn0py3/ptpTWXuopu39
   ncLvisAFh8kMFtxWy0k1/8xxG6CFbGDqHe4aDHoEx36J4yQOckGtnQS8u
   A==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654552800"; 
   d="scan'208";a="25605305"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Aug 2022 14:39:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 15 Aug 2022 14:39:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 15 Aug 2022 14:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660567164; x=1692103164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZoeSgVqYecYa8dOXcwGrIo4k9Ip/Bxok4jHfP0iqk0s=;
  b=SRYuP5tro2Iq3C5Ct21jG0BwrComttqC0+848iBBB5Rxzj5oLDsXCf6s
   JF4ghFCSvsmxuLGW+HEaie5rlZKfJbykLh2zr/AmAuAzLYPXuzbyhFC8c
   gVFgpEOhr6GMabGQXphj25oizxKT7ZQSl5xHXv10/G2N7Zum0ngCeXUYZ
   lwclTWC/9linzmcWvJdWWPLJW5J6c86I/hUkkZGJxOkWPNCEcb3lOsqqZ
   Ja81xBdUzxOJ3b50lS6fahYhKG2h614sQKfCxRzqb5jM9n0H1BmEjivYd
   x3YI1hJlrFdY9QQBKUFPSoSXGqhZOCT240LZiirg3gv82dbhYXSgcNs0U
   g==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654552800"; 
   d="scan'208";a="25605304"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Aug 2022 14:39:24 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DCF8A280056;
        Mon, 15 Aug 2022 14:39:23 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
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
        Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
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
Date:   Mon, 15 Aug 2022 14:39:23 +0200
Message-ID: <3601760.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
References: <20220810060040.321697-1-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saravana,

Am Mittwoch, 10. August 2022, 08:00:29 CEST schrieb Saravana Kannan:
> Alexander,
> 
> This should fix your issue where the power domain device not having a
> compatible property. Can you give it a shot please?

thanks for the update. Unfortunately this does not work:

> [    0.774838] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@0
> [    0.775100] imx-pgc imx-pgc-domain.1: __genpd_dev_pm_attach() failed to 
find PM domain: -2
> [    0.775324] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@2
> [    0.775601] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@3
> [    0.775842] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@4
> [    0.776642] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@7
> [    0.776897] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@8
> [    0.777158] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@9
> [    0.777405] PM: Added domain provider from /soc@0/bus@30000000/
gpc@303a0000/pgc/power-domain@a
> [    0.779342] genpd genpd:0:38320000.blk-ctrl: __genpd_dev_pm_attach() 
failed to find PM domain: -2
> [    0.779422] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed to 
attach power domain "bus"
> [    0.848785] etnaviv-gpu 38000000.gpu: __genpd_dev_pm_attach() failed to 
find PM domain: -2
> [    1.114220] pfuze100-regulator 0-0008: Full layer: 2, Metal layer: 1
> [    1.122267] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
> [    1.132970] pfuze100-regulator 0-0008: pfuze100 found.
> [    1.157011] imx-gpcv2 303a0000.gpc: Failed to create device link with 
0-0008
> [    1.164094] imx-gpcv2 303a0000.gpc: Failed to create device link with 
0-0008

The required power-supply for the power domains is still not yet available.
Does this series require some other patches as well?

Whats worse, starting with commit 9/9 [of: property: Simplify 
of_link_to_phandle()], other drivers fail to probe waiting for pinctrl to be 
available.
> $ cat /sys/kernel/debug/devices_deferred
> gpio-leds       platform: wait for supplier gpioledgrp
> extcon-usbotg0  platform: wait for supplier usb0congrp
> gpio-keys       platform: wait for supplier gpiobuttongrp
> regulator-otg-vbus      platform: wait for supplier reggotgvbusgrp
> regulator-vdd-arm       platform: wait for supplier dvfsgrp

Apparently for some reason they are not probed again, once the pinctrl driver 
probed.

Best reagrds,
Alexander



