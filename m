Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30558FAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiHKKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiHKKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:37:31 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Aug 2022 03:37:28 PDT
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E929018E;
        Thu, 11 Aug 2022 03:37:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94B88A5320;
        Thu, 11 Aug 2022 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1660213886; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=LlRYyMFxzR+8bD7PyKB59D9fCelhvAh2RwZ8mF4ga1A=;
        b=czTuahj2avkQIsG1xWBgeYzO/qlOM2gV/U4Flg16szQ2Ib596FpdkX1mFJHD+PANvm0+Ma
        gsXOl/BA/ZWF11pl+NdZ8wUwzZzLKAJrRFmuEKCYTealX4Zvjuu7ix8ZnrpC4KDcS7LXfN
        W8g9e6xYSm/MJ/DozN4DItyeOGyzwP518TmHk784Xhdv0kC7l2eqbVsP7fkSsz8u02emgB
        TIzsK6PUFjOwhuXOdqZFXrPZu9iieLzDWsTFEu43XaBAkl8yWVJZST4Kfg4V3kqGDjmIbw
        c5clMwD31PpuX0PdfQr4E3tkZ1D0skZS8gOdh7jKuHCqzrHyrJWQeuOgrVzh3Q==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 0/2] arm64: meson: add support for JetHome JetHub D1p (j110)
Date:   Thu, 11 Aug 2022 13:31:11 +0300
Message-Id: <20220811103113.3097868-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add support for JetHome JetHub D1p (https://jethome.ru/d1p) is a home
automation controller with the following features:
  - DIN Rail Mounting
  - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
  - no video out
  - 1/2/4GB LPDDR4
  - 8/16/32GB eMMC flash
  - 1 x USB 2.0
  - 1 x 10/100Mbps ethernet
  - WiFi / Bluetooth Realtek 8822CS or similar IEEE 802.11a/b/g/n/ac
  - TI CC2652P1 Zigbee Wireless Module with up to 20dBm output power
    and Zigbee 3.0 support.
  - 2 x gpio LEDS
  - GPIO user Button
  - 1 x 1-Wire
  - 2 x RS-485
  - 4 x dry contact digital GPIO inputs
  - 3 x relay GPIO outputs
  - DC source with a voltage of 9 to 56 V / Active POE

- unify device tree files for JetHub D1/D1p devices

Vyacheslav Bocharov (2):
  arm64: dts: meson-axg: add support for JetHub D1p (j110)
  dt-bindings: arm: amlogic: add bindings for Jethub D1p (j110)

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-axg-jethome-jethub-j100.dts | 338 +----------------
 .../meson-axg-jethome-jethub-j110-rev-2.dts   |  37 ++
 .../meson-axg-jethome-jethub-j110-rev-3.dts   |  27 ++
 .../meson-axg-jethome-jethub-j1xx.dtsi        | 351 ++++++++++++++++++
 6 files changed, 422 insertions(+), 334 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi

-- 
2.30.2

