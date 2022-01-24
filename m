Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C782499FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842771AbiAXXCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:02:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578083AbiAXWBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:01:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 3AA7C1F438C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643061698;
        bh=0Msy4226NLwE17t/axQjarV+mN6lo7oBS5c5lPbX94w=;
        h=From:To:Cc:Subject:Date:From;
        b=FKSs7oOBt3aJnecF9SlzakeU5PRipKrmbgUjG9ZuEB0Q1BOmSGUXUTUunC6y1JGBD
         fgjuslKj7Mp0Tt5EKxzhBiLI3CzsKguvUXpte7TCPSCp+kFcHUZvapwqIjMDR9wXsr
         E/S3SfbkVldFUzoUsi/hH5Q+nru1u/pe0AI+OjWFljcValfxShghM3DXrcWbO/QRBr
         AZ6L1ZwvFcxtVkri543wVzPfalW52QxRSwC9fcLpzi/HFZZWilWO2ULR5jNOlrLS9V
         T5gIC/gr7gAQtU4ltzAWJwmyWuuPxHvDNE49mo1sc2i9G9QkXskSPyx+9m/lRshUxm
         iaDHoERKj6jpg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 0/9] regulator: rpi-panel: Support official Raspberry Pi 7 inches touchscreen
Date:   Mon, 24 Jan 2022 17:01:20 -0500
Message-Id: <20220124220129.158891-1-detlev.casanova@collabora.com>
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

Changes in v3:
 * Add Signed-off-bys
 * Use the regmap cache

Dave Stevenson (9):
  regulator: rpi-panel: Register with a unique backlight name
  regulator: rpi-panel: Handle I2C errors/timing to the Atmel
  regulator: rpi-panel: Serialise operations.
  regulator: rpi-panel: Ensure the backlight is off during probe.
  regulator: rpi-panel: Convert to drive lines directly
  regulator: rpi-panel: Add GPIO control for panel and touch resets
  regulator: rpi-panel: Remove get_brightness hook
  regulator/rpi-panel-attiny: Use the regmap cache
  regulator/rpi-panel-attiny: Use two transactions for I2C read

 drivers/regulator/Kconfig                     |   1 +
 .../regulator/rpi-panel-attiny-regulator.c    | 291 +++++++++++++++---
 2 files changed, 248 insertions(+), 44 deletions(-)

-- 
2.34.1

