Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174C947ECD8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbhLXHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhLXHut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:50:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D349C061401;
        Thu, 23 Dec 2021 23:50:48 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r138so7014217pgr.13;
        Thu, 23 Dec 2021 23:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=jPo9yF90yb6Tml8cLFg4vSSw+Zf7GoEQngD5eTEX1OY=;
        b=o6AZ60TksFPsSJSQ72DUDRRzpUTtoGNPTBNGcr+wGf7lQ1LC2fDWb6Wp2pWlMWU+gr
         r+OrkV3RhoGY/YdyXuC7B5NRyUQOrvpLAknVyXgsWzzem4e6FkHsFjK+UHbtzTwTofne
         W1Ff5TsY6ReEsTZdGidJM/4LxxRrprscedzYY0ix/cg9jkuBx4lhIMHZcT6x7i6eqp/c
         aUGXFMzFq37hO+ivg1jmeG7tC2uxvT9JeQEdknzB/IZN3Jc+v+xAM6eRit0kNsjrb1Oc
         wDj3jEONytF9chIcDoEzAFWWPDYxCqWTYd7Ri/jqdbHZkexwZlbkZFjj4QTh4sx4pnl5
         IiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jPo9yF90yb6Tml8cLFg4vSSw+Zf7GoEQngD5eTEX1OY=;
        b=DKATj2wsE/XwaTQ6v5bEoVK/e9Yrci1PgRnkQKyRrtIbHeNTihW7Q2Qk8D7DSDVy2O
         7VOh4ETVKby80BWNx2cBqrAF25+z3vspPfiDl8hP8wmNaTXqC1tufiYWxkUmfAuKKiah
         trvZxBAsH6JruYM+AGdLmOwd/xYNQ8aG9q4IEYSU9S/nD1ImCnErktZF9L1eg7aLnIBL
         /TycLosV2eegtcNPhRMtbevSqLz03Jxz1H8ohdImCP3JuM0Q4ph781+kndpm0uHAUfHt
         JsZ6zCvjt+Tc7BdREnoZ2W4JGaGc6D5UMSPznLwafG3NOEgOMqdPYMNEECqnAJoksLB/
         edaw==
X-Gm-Message-State: AOAM530wQcdzzQSVlVmIg+pjTsdbukFlPGlyCbqh0VvujC2bCZSM6qL1
        hLJ9PCuX92LGXr2RQ9TPXlU=
X-Google-Smtp-Source: ABdhPJyL+M7kwA3RB1jOBULDmZL382fyohtjDHLYMATrFA4XD7buEb0hwEr5OLXp0B5kr89XXQRzGQ==
X-Received: by 2002:a63:7c1b:: with SMTP id x27mr5158267pgc.176.1640332247743;
        Thu, 23 Dec 2021 23:50:47 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h15sm8649164pfc.134.2021.12.23.23.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 23:50:47 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v5 0/2] This is a patch series for pinctrl driver of Sunplus SP7021 SoC.
Date:   Fri, 24 Dec 2021 15:42:57 +0800
Message-Id: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control
applications.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Wells Lu (2):
  dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
  pinctrl: Add driver for Sunplus SP7021

 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |  373 +++++++
 MAINTAINERS                                        |   10 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/sunplus/Kconfig                    |   21 +
 drivers/pinctrl/sunplus/Makefile                   |    5 +
 drivers/pinctrl/sunplus/sppctl.c                   | 1178 ++++++++++++++++++++
 drivers/pinctrl/sunplus/sppctl.h                   |  155 +++
 drivers/pinctrl/sunplus/sppctl_sp7021.c            |  584 ++++++++++
 include/dt-bindings/pinctrl/sppctl-sp7021.h        |  171 +++
 include/dt-bindings/pinctrl/sppctl.h               |   30 +
 11 files changed, 2529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
 create mode 100644 drivers/pinctrl/sunplus/Kconfig
 create mode 100644 drivers/pinctrl/sunplus/Makefile
 create mode 100644 drivers/pinctrl/sunplus/sppctl.c
 create mode 100644 drivers/pinctrl/sunplus/sppctl.h
 create mode 100644 drivers/pinctrl/sunplus/sppctl_sp7021.c
 create mode 100644 include/dt-bindings/pinctrl/sppctl-sp7021.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl.h

-- 
2.7.4

