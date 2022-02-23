Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0A4C1A63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbiBWR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiBWR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:59:50 -0500
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791EF3DDDC;
        Wed, 23 Feb 2022 09:59:19 -0800 (PST)
Received: from [77.244.183.192] (port=62116 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nMvv3-00039p-3o; Wed, 23 Feb 2022 18:59:17 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 0/8] Add MAX77714 PMIC minimal driver (RTC and watchdog only)
Date:   Wed, 23 Feb 2022 18:59:00 +0100
Message-Id: <20220223175908.191618-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds minimal drivers for the Maxim Semiconductor MAX77714
(https://www.maximintegrated.com/en/products/power/power-management-ics/MAX77714.html).
Only RTC and watchdog are implemented by these patches.

This is almost a bare resend of v5. Changes are minimal, trivial and only
in comments (see list below).

All implemented functionality is tested and working: RTC read/write,
watchdog start/stop/ping/set_timeout.

Patches 1-3 are trivial cleanups to the max77686 drivers.

Patches 4-8 add dt bindings, mfd driver, watchdog driver and rtc driver.

Changes in v6:
 - patch 6: removed, now in mainline
 - patch 5: describe as "Core driver", not "MFD driver" in comment
   (Lee Jones)
 - update copyright years
 - add review tags

Changes in v5:
 - patch 7: fix (and simplify) watchdog_info code
 - patch 8: remove amibguity in comment

Changes in v4:
 - do not add a new wdog driver for MAX77714, extend the MAX77620 wdog
   driver; this means removing v3 patch 7, now replaced by patches 7+8
 - added review tags

Changes in v3:
 - fixed all issues reported on v1 patches
 - removed patch 1 of v2, already applied
   ("mfd: max77686: Correct tab-based alignment of register addresses")

Changes in v2:
 - fixed all issues reported on v1 patches
 - added patch 7 ("watchdog: Kconfig: fix help text indentation")
 - additional minor improvements

Luca

Luca Ceresoli (8):
  rtc: max77686: convert comments to kernel-doc format
  rtc: max77686: rename day-of-month defines
  rtc: max77686: remove unused code to read in 12-hour mode
  dt-bindings: mfd: add Maxim MAX77714 PMIC
  mfd: max77714: Add driver for Maxim MAX77714 PMIC
  watchdog: max77620: add support for the max77714 variant
  watchdog: max77620: add comment to clarify set_timeout procedure
  rtc: max77686: add MAX77714 support

 .../bindings/mfd/maxim,max77714.yaml          |  68 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/mfd/Kconfig                           |  14 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77686.c                        |   2 +-
 drivers/mfd/max77714.c                        | 152 ++++++++++++++++++
 drivers/rtc/Kconfig                           |   2 +-
 drivers/rtc/rtc-max77686.c                    |  75 +++++----
 drivers/watchdog/Kconfig                      |   2 +-
 drivers/watchdog/max77620_wdt.c               |  85 ++++++++--
 include/linux/mfd/max77686-private.h          |   4 +-
 include/linux/mfd/max77714.h                  |  60 +++++++
 12 files changed, 421 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
 create mode 100644 drivers/mfd/max77714.c
 create mode 100644 include/linux/mfd/max77714.h

-- 
2.25.1

