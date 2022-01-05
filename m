Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CEC484D62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiAEFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiAEFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:20:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B1C061761;
        Tue,  4 Jan 2022 21:20:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p14so28565546plf.3;
        Tue, 04 Jan 2022 21:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3THBOt4+Je34kiFSuTjJhmdhvQDSlELOuWF7/HxfB9A=;
        b=kIE8KPJ+tl2xGT8oZuFqjAI+U4S7G/qRYyd6v/XPFS+JHtpD4DU4mIYF8Bj8DocXzP
         WscMGEgz/VQB9tdXumHAkPximFDohBL3CgnDSt45xF+OxtjDm+3rAxfNWJUygEriM5fz
         jC74Q1TVCyZ+zYTkacAJt9rIG6oaD2JuKzTSkPYz5YAAE9aOkhMid/MWB0zdPx3FMf2J
         plJxmPugXPk8cE6jEIOlAhg/3tBY16jrFO/umfY9M97UOcb5iW4qboY47b/5xp88r+q/
         SOJltZZhLY6F6Bf0NUrfC20ZfLatMqI3vwM2N0ADdSl0QgNhoaUbCKc/7qWoPY1dOZ9Y
         BwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3THBOt4+Je34kiFSuTjJhmdhvQDSlELOuWF7/HxfB9A=;
        b=VOk3839Km+3aReNcg7Yy+mlvlg6+gWBFLwi3j/kFxoQl8CBpoZWTesEazFj5N6+3dn
         s/31xYDYWD0HgtgA/ZoJbL4BKnMp6Wu34lITe9NSQnHEY+CdneI5XCGcaBDJjAQCaVWX
         lSqe2E9ga5ou8Pq/MGew2ycUE1TgNQIoN2CUir61FdUkx0Msi1V/4aGFwOPvze0RgbGi
         1RepklL306JLwLm2azyZaqbtXxwAXYPuzlnarx8FGS5OTqrvtDPnYc4SrBU44z6UwNwL
         CF9o5xzyyHuamx3YTa8QSvgPoKCTX8jafK6tuZrQGrX2oYAor7TnXP5hNFREipfNB2dw
         vFyw==
X-Gm-Message-State: AOAM532crLt+MmE5ps1naCyJbYU3W+j95K/admQT4k/CkUs1YPm82Vvp
        chkaHz42o3LiER8ctHhVTeg=
X-Google-Smtp-Source: ABdhPJxe5SzsnmicQyhLO3YyQwLt+E/jjKTYfelDHVI63X+I9pYPvGHLY0U1NsJ+4sOZ+wKv65uoCA==
X-Received: by 2002:a17:90b:3903:: with SMTP id ob3mr2188296pjb.178.1641360048084;
        Tue, 04 Jan 2022 21:20:48 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 6sm34427187pgc.90.2022.01.04.21.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jan 2022 21:20:47 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kerenl.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v2 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Wed,  5 Jan 2022 13:20:55 +0800
Message-Id: <cover.1641354285.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for mmc driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
  mmc: Add mmc driver for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus-mmc.yaml       |   60 +
 MAINTAINERS                                        |    6 +
 drivers/mmc/host/sunplus_mmc.c                     | 1204 ++++++++++++++++++++
 3 files changed, 1270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus_mmc.c

-- 
2.7.4

