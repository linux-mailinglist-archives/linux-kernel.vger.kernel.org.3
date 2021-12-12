Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06182471C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhLLSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhLLSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:19:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF845C061714;
        Sun, 12 Dec 2021 10:19:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o13so23484314wrs.12;
        Sun, 12 Dec 2021 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aIkheGXw0yCyl2iBO81AI6AuB3TpavSbnkWQDXLxNfU=;
        b=HbE9UAyx4rBB+w6KPkrSPpU/jsQ5T6WZJ4qtqqeSEvm9nUF7rpNee1Np8BGhD4jGNE
         fQ79GS+kgLe+CRgLn0GXuydPGD6ZFR/Z7wjdnwI+XgmpFGmwaH+CbVReL/AHFgMO0rcd
         yLS4jrcqG/1o67ejn7uSJO8FdZHO1hLy8Z4JaKSsBawHnuvYUbK66dekeQ/q1o7Zozra
         fOcNtsF47ZPsA22A1H9Ji+KGQ+zIvbl4wS4wzW96A85LMWeY+lzAUcn7kPfT+9ktuqxk
         ZnvSR8eIO5umZZkSIlIkQ6OlGecbrSuwLJ1liA50GAR5UUgTaBG2KC4gvGx+PU97NWtk
         B/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aIkheGXw0yCyl2iBO81AI6AuB3TpavSbnkWQDXLxNfU=;
        b=XTjSrg81/owbEK3ApWP5ZRuw7SZJcnpAiQPLVjY5qh5jlsaPnYIU+4yxIYnf8XtYNv
         roRMLvWmWBeD4NFxX3tCg32JWsUGieWMfcWtt1P68aHMCDDOMeoX/kdH2ZENdDEradjk
         sxWZX4z7v9yAcbpZNOpi/3GEEXqiSB6qYPcLoXm2FgEHLpGKcWLeqwrY6iXf/OwjPZwB
         roL16Qlz2/A9jJv9LpH9esXZLhb09qoQqbaGSoukwx63UkzRSj7nLFUSdHqgaj9ysEi8
         bURdQ6pF9aCaHTajfwv6HSE4YVk4p33XgzXtj9NhAs1Nd786NSXlymvjaPNl5/COUh6f
         43Tg==
X-Gm-Message-State: AOAM532J80wqjz+2f8CAenJm4TcQEqBxI7DKs26rhQaUDtCYhCVKULVM
        ko7B9NMjahPLid4zunsUk5Q73/m3nIM=
X-Google-Smtp-Source: ABdhPJw0501lVuahgIQBCaBDRPDtN0GkBb7e+167UcrUTm/oWAcwVAxIFnD82rOGaC/lPsqhI//ytg==
X-Received: by 2002:a05:6000:128b:: with SMTP id f11mr27449270wrx.70.1639333149009;
        Sun, 12 Dec 2021 10:19:09 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id h17sm8110879wrp.34.2021.12.12.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:19:08 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add timers for Mstar SoCs
Date:   Sun, 12 Dec 2021 19:19:00 +0100
Message-Id: <20211212181906.94062-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series adds a new driver for the timers found in the Mstar
MSC313e SoCs and newer. It adds a basic clocksource driver, the
corresponding devicetree bindings and its documentation.

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
2.33.0

