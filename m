Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB4534B53
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbiEZIQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbiEZIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:15:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A7FAE250
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:15:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o78-20020a254151000000b00655843fc524so998871yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7ovu32HwfTXJZkxeBDrxZ8ZPAGcSmwTvZEaaoxjr5Ec=;
        b=A5IYs6L7vf+F2QJ35kvDWANbcirKT5v6KM8ClXGKhMKZlBtap4tK4FtzcxDnuCZUM2
         1MdoAe53oMAaYvVh0NBFN9zWi/1tedJ/pn3STJRgI5TEod6qqS5bjJ3jgTMLlV99IZhw
         bl3dncSWym4j3vdDRkPBP/r8/LapBYRpkuhgixrNPw8jT1gSt1jGIUlXIVWE+skTmA3c
         UiVFS3E4a6ZW/wMqG/NYeMaiXjyckaYyfNFSNiQXSwHzsKYDmuhGTQK/QI9HHSYBlqd6
         JMuIjD5Suc2/VSV47X/GXl0XsU/o8j5RWYmL6mQ93nQKXWtTvW2fr+ez+gfWLJc3fFan
         uYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7ovu32HwfTXJZkxeBDrxZ8ZPAGcSmwTvZEaaoxjr5Ec=;
        b=c5jGQfyyV8DB921qP9gFuAnUS5OQOWvxZoHvF8QzuVbrqMYR5MiXcvg7r1Bj8NOd4k
         Z65RmbPf1OpwMI1bOBxfk3en4EhwFQ3H7yP3Hk1FOc4uPw2sQ75djt1oT9v7vhNDmkdv
         zk4tCn4srSDGZuTQHfLUZSPeOKEttgTWO4AkRDVFKczoYtTqvWyMX6KF6rRL+7l16RXu
         s4CQE7M1GU8QGTSCV9oIRRs9MXEeJNHZ5p/6xmoXvhMTRZcXFVt/G+w6MWKyrXx8MHqt
         y1mCq8F20xB5wBRmI2xINNo7ewGmIaNW724Ek8oP4coymWat4e8szFYI8DKU3s4vkcKS
         bRQg==
X-Gm-Message-State: AOAM5329yGfY9jLatSelZeGrShCz1iI64ps/+y8mIcu1rBtyK6tzr56v
        51nJs2bcm4I3MaEqf+kpHVwFVQwsCmwiU1s=
X-Google-Smtp-Source: ABdhPJwgygNcXLfgS/GhNtXfKLT0ANRPU/9nFzxb/3BLRPqGqHSVhLefDjnDtbT8PzPoRD3rLYHQCxeGMGeZcX4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a25:ab4a:0:b0:64f:b782:f941 with SMTP id
 u68-20020a25ab4a000000b0064fb782f941mr20119540ybi.408.1653552953895; Thu, 26
 May 2022 01:15:53 -0700 (PDT)
Date:   Thu, 26 May 2022 01:15:39 -0700
Message-Id: <20220526081550.1089805-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <jstultz@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-next + these 2 small patches applies on top:
https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/

A lot of the deferred_probe_timeout logic is redundant with
fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
a few cases.

This series tries to delete the redundant logic, simplify the frameworks
that use driver_deferred_probe_check_state(), enable
deferred_probe_timeout=10 by default, and fixes the nfsroot failure
case.

Patches 1 to 3 are fairly straightforward and can probably be applied
right away.

Patches 4 to 9 are related and are the complicated bits of this series.

Patch 8 is where someone with more knowledge of the IP auto config code
can help rewrite the patch to limit the scope of the workaround by
running the work around only if IP auto config fails the first time
around. But it's also something that can be optimized in the future
because it's already limited to the case where IP auto config is enabled
using the kernel commandline.

Yoshihiro/Geert,

If you can test this patch series and confirm that the NFS root case
works, I'd really appreciate that.

Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: John Stultz <jstultz@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Saravana Kannan (9):
  PM: domains: Delete usage of driver_deferred_probe_check_state()
  pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
  net: mdio: Delete usage of driver_deferred_probe_check_state()
  Revert "driver core: Set default deferred_probe_timeout back to 0."
  driver core: Set fw_devlink.strict=1 by default
  iommu/of: Delete usage of driver_deferred_probe_check_state()
  driver core: Add fw_devlink_unblock_may_probe() helper function
  net: ipconfig: Force fw_devlink to unblock any devices that might probe
  driver core: Delete driver_deferred_probe_check_state()

 drivers/base/base.h            |  1 +
 drivers/base/core.c            | 60 +++++++++++++++++++++++++++++++++-
 drivers/base/dd.c              | 37 ++++-----------------
 drivers/base/power/domain.c    |  2 +-
 drivers/iommu/of_iommu.c       |  2 +-
 drivers/net/mdio/fwnode_mdio.c |  4 +--
 drivers/pinctrl/devicetree.c   |  2 +-
 include/linux/device/driver.h  |  1 -
 include/linux/fwnode.h         |  2 ++
 net/ipv4/ipconfig.c            |  2 ++
 10 files changed, 74 insertions(+), 39 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

