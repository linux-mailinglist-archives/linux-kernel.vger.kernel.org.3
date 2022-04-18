Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF6505E16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347473AbiDRSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiDRSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:52:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F23815822;
        Mon, 18 Apr 2022 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650307794; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=2BK97mq3stH76aJyLSl7KHfmMsGVZ7tU/h6VhW5taF0=;
        b=nOyKHM7B/LETcMj/yQAveTcBM1y06m8Yczonn72LiAHOMiSSm0PFfAgzTrimXV0v3eC2TV
        qyQRIocOWoXQR4ScIFGeIYT+AV8XB2rsLEdllrhy9gCga0noK2JD/wHkBvkApj4ZT6yGC+
        Z8zJg5ej1Xrgn9f9QllAgnZEh2CXksE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     list@opendingux.net, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/5] rtc: ingenic: various updates
Date:   Mon, 18 Apr 2022 19:49:28 +0100
Message-Id: <20220418184933.13172-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a set of patches for the Ingenic RTC driver (jz4740-rtc).

Patch [1/5] and [4/5] update the DT binding documentation and update the
driver to support the CLK32K pin. This pin optionally supplies a 32 kHz
clock, which is required on the MIPS CI20 board for the WiFi/Bluetooth
chip to work.

Patch [2/5] is a code cleanup. Patch [3/5] fixes the RTC time yielding
an impossible value after a power loss.

Finally, patch [5/5] is *RFC*. I do not know if it works, as I have
absolutely no idea about how to test it.

Cheers,
-Paul

Paul Cercueil (5):
  dt-bindings: rtc: Rework compatible strings and add #clock-cells
  rtc: jz4740: Use readl_poll_timeout
  rtc: jz4740: Reset scratchpad register on power loss
  rtc: jz4740: Register clock provider for the CLK32K pin
  rtc: jz4740: Support for fine-tuning the RTC clock

 .../devicetree/bindings/rtc/ingenic,rtc.yaml  |   7 +-
 drivers/rtc/rtc-jz4740.c                      | 137 +++++++++++++++---
 2 files changed, 125 insertions(+), 19 deletions(-)

-- 
2.35.1

