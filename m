Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB524961EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381508AbiAUPVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351305AbiAUPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7D6C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:21:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id D22CE1F4620F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778470;
        bh=0RwYaKB6A31CeyD2snW+RU5w3kF+gKZk3mxsx5dGz3o=;
        h=From:To:Cc:Subject:Date:From;
        b=FeAyTQsRGtl8aM3fQGPAFZ9FHpvY8LeECyunW8v7+4HmsziWPpG69iVDI2owTckwg
         LyjhM5gjMAVypPwBkX6+lBgWWlfj29VrY8SUjxpG0stXqgv1oOecmBJE3S8oEyyG9y
         HRdoayXQciyog9AVzc5O/Et9JwRDLf9vdnEDWeD0sMTj56oCYzNY3vg8mxjafHVPyo
         NMA8BgvJJYgbdY7OZ4Vtn5kuQZa5j/lKakXDc47zs0nkmW4MgyQo2e5wDjzJ7JodQM
         GvAzWonvMfdMYhh+wEMZG2zFRlKObbP4rX7deFPyov/+QONPvy7pRuWar+cgLC2GQe
         4DYfJj8qJvKNw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 0/9] regulator: rpi-panel: Support official Raspberry Pi 7 inches touchscreen
Date:   Fri, 21 Jan 2022 10:20:47 -0500
Message-Id: <20220121152056.2044551-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides different fixes to the rpi-panel-attiny-regulator driver.

This is a preparation patchset for supporting the official Raspberry Pi 7
inches touchscreen.

It has been tested with a Raspberry Pi 4 B and the official Raspberry Pi 7
inches touchscreen.

Changes in v2:
 * Add a dependency on OF_GPIO for GPIO controlled resets

Dave Stevenson (9):
  regulator: rpi-panel: Register with a unique backlight name
  regulator: rpi-panel: Handle I2C errors/timing to the Atmel
  regulator: rpi-panel: Serialise operations.
  regulator: rpi-panel: Ensure the backlight is off during probe.
  regulator: rpi-panel: Convert to drive lines directly
  regulator: rpi-panel: Add GPIO control for panel and touch resets
  regulator: rpi-panel: Remove get_brightness hook
  regulator/rpi-panel-attiny: Don't read the LCD power status
  regulator/rpi-panel-attiny: Use two transactions for I2C read

 drivers/regulator/Kconfig                     |   1 +
 .../regulator/rpi-panel-attiny-regulator.c    | 285 +++++++++++++++---
 2 files changed, 237 insertions(+), 49 deletions(-)

-- 
2.34.1

