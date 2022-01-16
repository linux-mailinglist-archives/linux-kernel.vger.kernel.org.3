Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807CA48FF37
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiAPVjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:39:39 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33506 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiAPVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:39:35 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:fcd:c16e:b544:6e84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1A990292933;
        Sun, 16 Jan 2022 22:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1642369174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mw12aa6eEQFSW/ED7mllIqnVmRFcc7d5w9IEtG08jN4=;
        b=UcitKmlMwpXPgomwpABWRRultJy6i5TZVaSS3JaYoqBVzBm2Rb2O9oTfHBYOQCUkhOQiI/
        Zye4Oz2j4iQOJNNCUe20ZBF8zbzCdn77qoB3htcEo2Dh0g33ebX8zvHI1vEa8G5f9XQoS2
        8w98VLO0l2p8LI2QGWyAqUBevAuSD1XtovIiLZRKwpGrcUVOt7MFz+MAKj/N3zFAyvB/mj
        qU1Gd0+6xYO46FgGg+zqSGK+R+O/oOUmjDfvqVCnRbL4f/90DdrjRVYEnNzxg6y7hY2wSn
        C/f/rhWbxTK3qFuHhWZSfEjYH0NKIxyKSxiAtCyTg+9Nw/7e8Wq8TJjZxPzqWA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 0/2] Realtek Otto timer/counter support
Date:   Sun, 16 Jan 2022 22:39:23 +0100
Message-Id: <cover.1642369117.git.sander@svanheule.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek's family of networking SoCs (RTL838x, RTL839x, RTL930x, RTL931x)
have a set of timers. These patches seek to provide a devicetree binding
for them, and a first implementation of the driver.

Most of these SoCs can use the MIPS clocksource and clockevent timers,
but the CEVT_R4K timer on the RTL930x series was left disconnected. This
series therefore requires these timers to be able to function.

Except for the RTL838x series, these SoCs also support some form of SMP,
but this is not yet implemented as the platform's IRQ driver does not
support this yet. The driver also implements a fixed divider for the
timer's internal clock, since this is good enough at this point.

I've tested this driver on RTL8380, RTL8393, and RTL9302 SoCs, running
in single-CPU mode. When replacing the CEVT_R4K timer, these platforms
then function as expected.

There's probably still other things that I missed, but I currently have
the following questions:
- If the internal clock is added later, should this be added to the
  devicetree as a self-referenced clock? It's not possible to use this
  clock outside of the timer, so I guess it would mainly be to allow the
  DT code to build a complete overview of the clock hierarchy.
- When adding SMP support, what would be the best way to configure the
  CPU affinity? And what does FEAT_DYNIRQ imply exactly?

Best,
Sander

Sander Vanheule (2):
  dt-bindings: timer: Add realtek,otto-tc binding
  clocksource/drivers: Add Realtek Otto timer driver

 .../bindings/timer/realtek,otto-tc.yaml       |  64 ++++++
 MAINTAINERS                                   |   6 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-realtek-otto.c      | 216 ++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
 create mode 100644 drivers/clocksource/timer-realtek-otto.c

-- 
2.34.1

