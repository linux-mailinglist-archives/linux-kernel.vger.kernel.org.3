Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9647952A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhLQT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhLQT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:57:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981DC061574;
        Fri, 17 Dec 2021 11:57:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j9so6173960wrc.0;
        Fri, 17 Dec 2021 11:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATS5gBruwanNdU272rerZnhy1vSLEquHj7LuSnNN+Lo=;
        b=qnB4+19/7gSX+9lGawDmaj6g+X36F2uBnDI91uzpLOh2P5eaBu3njsOrPyTBQu1BVw
         Lsqmp2ShVjdbfMSAFVSOmtOw1I7cXU5qHQ1LolYhlffhqjBAFROpketFsHA+im4LbVoR
         YbAlExZyVaA4lQiehGvrxHc5g+dsqCuIt3wPSyQRZhRoZRZSwC5J6sGVFvNxYNm79sdC
         V9/nxK6mx4UnM7IeD6XDv9/9lVsm3ixfe4EY3in9ZgGhYHNR93y1/PxMiwZoh+IZNUj5
         FQRtfQOXDLQioAtpP2yawUPVTpJD7L5xotQb3TUurBcnVXQFoDYwJZqeUxr+z6+jhI8k
         2MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATS5gBruwanNdU272rerZnhy1vSLEquHj7LuSnNN+Lo=;
        b=gOH87lkj6+s4v8428Vu/I19ggWB99ldqyj/yjk4C8g+NQbK+RszYWRS5ef/4E5o85N
         5vqolXjf46VT2ON3sT9Ti2G08xYOKb7yubwKbYgf8j2xTJf2wQxIL8rMBitqfOqgF+Gy
         s/uoiRO1+suQx4ZydEJciQBe51LknUWpvNkrHKBdOb/yKSAOrQ/EJUwQGZkYk2ipPYGk
         B9T+/kQtQeWPRLPuuVZnStiJS4Yz3a8qumEzxXeAWK0qOxjlu+hggexq1hJJ+Q+8cNs1
         wgyIi/nIgEaV/RgnWuCk3i8H5yUpXdQepwoBdgcD455h0t/OFUnrRYAPaWG7kN5V4tT6
         p3tQ==
X-Gm-Message-State: AOAM532wKejCOGmj7S+Jje5Toon5JKv3wIJTIWYXXEOD+ouWDAATVDeQ
        modh2pQLMW9B4/OJtQBK47swwrw/JBA=
X-Google-Smtp-Source: ABdhPJw6p2zR49SGz4yqKVOw4RR/ZHLX0t/soOMRKCFm2BAD2Fbzcx5etmS+xbynExSLWQ7RWQD1IA==
X-Received: by 2002:adf:ec85:: with SMTP id z5mr3735913wrn.568.1639771059023;
        Fri, 17 Dec 2021 11:57:39 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id g18sm13306843wmq.4.2021.12.17.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:57:38 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Add timers for Mstar SoCs
Date:   Fri, 17 Dec 2021 20:57:21 +0100
Message-Id: <20211217195727.8955-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series adds a new driver for the timers found in the Mstar
MSC313e SoCs and newer. It adds a basic clocksource driver, the
corresponding devicetree bindings and its documentation.

Changes since v2:
- Reworded commit 2/6
- Added Rob's 'Reviewed-by:' tag

Changes since v1:
- Make delay conditionnal for ARM, so it builds on all platforms
- Improved commit message for the timer driver
- MSC313E_TIMER is now silent and enabled by platform
- Updated msc313e_timer_setup() to make it safe
- Updated msc313e_timer_current_value() to make it safe
- Renamed the driver variant for ssd20xd to "sstar,ssd20xd-timer"
- Moved timer settings for the ssd202d from
  mstar-infinity2m-ssd20xd.dtsi to mstar-infinity2m.dtsi.
- Select MSC313E_TIMER on mstar platforms
- Fixed wrong dt-bindings doc that included an rtc property (whoops!)

Romain Perier (6):
  clocksource: Add MStar MSC313e timer support
  clocksource: msc313e: Add support for ssd20xd-based platforms
  ARM: mstar: Select MSC313E_TIMER
  dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings
    documentation
  ARM: dts: mstar: Add timers device nodes
  ARM: dts: mstar: Switch to compatible "sstar,ssd20xd-timer" on
    infinity2m

 .../bindings/timer/mstar,msc313e-timer.yaml   |  46 ++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |  18 ++
 arch/arm/boot/dts/mstar-v7.dtsi               |  20 ++
 arch/arm/mach-mstar/Kconfig                   |   1 +
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-msc313e.c           | 253 ++++++++++++++++++
 8 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
 create mode 100644 drivers/clocksource/timer-msc313e.c

-- 
2.34.1

