Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CE4E8B71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiC1BCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiC1BCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:02:31 -0400
X-Greylist: delayed 621 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 18:00:50 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 942314ECD8;
        Sun, 27 Mar 2022 18:00:50 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 67F9414018D;
        Mon, 28 Mar 2022 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1648428627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wNgL5NPptNvEaMXzsU/FjvYBFmKOMWEOsdS7qq2jWGk=;
        b=FAOecvtPyboM4fMdmhr95ZEeSV0+7HkSmZn5oR+qW0cauHZQf3mT76e8qHK1u7zQ8qanKg
        doZvndA+MwMp9c28o2Bx0gZ1TpsxLO3jgbR2Wfd0MUoeWYVO/aY7uIdNTBMSwHGsLo7QdW
        ouNihD05pkGNXGp8GSt2gMQNnyb4E90=
From:   Caleb Connolly <kc@postmarketos.org>
To:     Caleb Connolly <kc@postmarketos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martijn@brixit.nl,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 0/4] rockchip: support configuring pins as input
Date:   Mon, 28 Mar 2022 01:50:01 +0100
Message-Id: <20220328005005.72492-1-kc@postmarketos.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring pins as input to the rockchip pinctrl
driver. This is required for example for devices which use non-standard
configurations for gpio interrupts, specifically for the light/proximity
sensor on the RK3399 powered PinePhone Pro (which will be coming
upstream in a future patch series).

Due to the complicated layout of the RK pinctrl/gpio drivers, some extra
work is required to handle deferring the GPIO configuration. On RK3399
the pinctrl driver always probes before the GPIO controller driver, so
the PIN_CONFIG_OUTPUT and PIN_CONFIG_INPUT_ENABLE params both have to be
deferred, this series also reworks the deferred pin handling to be
generic and support any param rather than only the PIN_CONFIG_OUTPUT
param.

---
Caleb Connolly (4):
  pinctrl/rockchip: support deferring other gpio params
  pinctrl/rockchip: support setting input-enable param
  gpio/rockchip: handle deferring input-enable pinconfs
  arm64: dts: rockchip: rk3399: add an input enable pinconf

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 16 ++++++
 drivers/gpio/gpio-rockchip.c             | 29 ++++++++---
 drivers/pinctrl/pinctrl-rockchip.c       | 64 +++++++++++++++---------
 drivers/pinctrl/pinctrl-rockchip.h       |  7 ++-
 4 files changed, 81 insertions(+), 35 deletions(-)

-- 
2.35.1

