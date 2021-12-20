Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7647A4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhLTFhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhLTFh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:37:28 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5DC061574;
        Sun, 19 Dec 2021 21:37:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x15so6796841plg.1;
        Sun, 19 Dec 2021 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/0zv1TjvAkVlbENIOA+6biuuFqisgttdoQp5hK0Vkr4=;
        b=I4xuZrsfOPw/wkNDIP0axQiMXaBEJ9LjC846VAwVA/wkpNEyS1QMn7NNAvUw/diqCh
         D837D2RBpRcv2bJHkUGIoKm3Sz8wo1gqL40TyhMWGpUb3vxjlc8YXfRFz3aghyHovuVR
         7fB8XwWQYuU36odAWft8DI/5GkFNgllzIeQTT6ytaKSMWxf27uKm62m48Zu+swfwrWhV
         0FGzZTrLlffJkVbklahcaTciSsRkzru49Yu1zUi/TILFXDJ+G6Aqm0jhH1wtU/xI/utZ
         l53AfrRrI/Q5VwEJu4Va5KFjDGqxvpiJxFJk02p4aAdGXAg54L/zN3JA9ofVDAB5KQA6
         +DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/0zv1TjvAkVlbENIOA+6biuuFqisgttdoQp5hK0Vkr4=;
        b=H+2YHG0SgzIIhjyZaZbXZcNdX37GfZ/CYmlMY/qRJZks642wN/qu2WGK+MAsMMQz5x
         in28sN4WB83fba0l3nkL963l4ZaKIkZB3k7gntoFiqbMNdEHrhZ9Hw8oh+/3eL0PE5ws
         DSxAhahD5c5ea4Dj8Ig8dB+UDzE1TkS+2qfu1qMO7GurHCaKRrW1RC+nD3SVC+1H3nP/
         K4X5sQZoZLhbp7ERLdFnwCoeDyzSW7tEGJ1ynoUVhVxZgfJqyVoO3KNQLXnBIca85oqc
         phBAxgvaV9ARXkpZZBAmILD/eJ4dRcthHwelrctEyEBl50zei4tNk1fSmcaJzMXn+FWD
         Q7Sg==
X-Gm-Message-State: AOAM5332xoicOUxVLyAyWTDBzyJrbOykWrslwlHufTbfiSa4wOgvwrjP
        MJFLEvx9QHCLXrgcCkl6ozE=
X-Google-Smtp-Source: ABdhPJwy3uqJ0YNIr/FEAiQtAAEqqQ8op/kTaNNCb4F0yFv1JqQRERuFZbMim5H1NPhYXNkpkQXVLQ==
X-Received: by 2002:a17:90b:19c7:: with SMTP id nm7mr10189947pjb.107.1639978647883;
        Sun, 19 Dec 2021 21:37:27 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d3sm7491501pfv.192.2021.12.19.21.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Dec 2021 21:37:27 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, edwin.chiu@sunplus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v2 0/2] Add cpuidle driver for Sunplus SP7021
Date:   Mon, 20 Dec 2021 13:37:30 +0800
Message-Id: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for cpuidle driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and 
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Edwin Chiu (2):
  dt-bingings:arm:sunplus:add sp7021 compatible string to
    sunplus,idle-state.yaml
  cpuidle:sunplus:create cpuidle driver for sunplus sp7021

 .../bindings/arm/sunplus/sunplus,idle-state.yaml   |  55 +++++++
 MAINTAINERS                                        |   9 ++
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-sunplus.c                  | 180 +++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h      |  13 ++
 6 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

-- 
2.7.4

