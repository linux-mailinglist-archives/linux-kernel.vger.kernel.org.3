Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0B483AC0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiADC6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiADC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:58:49 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7864C061761;
        Mon,  3 Jan 2022 18:58:49 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h1so22884388pls.11;
        Mon, 03 Jan 2022 18:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OQY/hTNMQjXQ3XWIE7F5XZaTxUiq57IOz3DJuepeLhQ=;
        b=B5h1GMCf5Ozq9KbPpMv5cLXTdQga/g5NqMXXlO30jgbsdbrVN+v5v404KQurT8lj4I
         2yZ+6lxHHWkm4kaodAPGeWJMQi7BCbDnemVqadSPchYMuCeMKihB/rvZaW9KHzShAJ8z
         S0PB8qRlYog9BLA4a6vFoTYMrraaNs2E3GkmAdMU17tCXZzTpBAy6BAmr3oXBIbgoSp8
         xEZjex4xvRq8iYWo09FKzboGbgjt0U1RxIXYVQpXe6AKiCFn7kk8DHcip515Tz8qjocb
         jsqQfVD6k95ZKszsigiXsmwT4h0TMhDS4K/5YRFZw4xW2SqQiJknPC7j+GqvgyytMP7B
         kN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OQY/hTNMQjXQ3XWIE7F5XZaTxUiq57IOz3DJuepeLhQ=;
        b=02SlBy4jcun1guhYDT+HVytzYmNBJUiQUyPHjWg8onBVeO5kfMP9B9dk/B2e/cbWGp
         A/48RVlrlVJSTHhwWapdXQgoL+xyG5u4r8U7GVMRktHoRTDyE6H79wL5RHkLrgSC+aWj
         kdrmQHuX1QmyOhCPf4KSft+NqOCXMVeidvs9tTNtKzYNBtsKmmM9BUkaRu2xjYok4Jrr
         9fVVJcwblrZqXpATiINxmsv/Idmxp8v7kZQ4G+KWg44ubw+A0KWi4c9QE/y4eepf6AVc
         g8wSJAmcAzPs7tQrmF0metG1dVsQ+bGhcN8nnVnu70FvvKsScy/FwaqsoWXYUea3Mi5W
         iuuQ==
X-Gm-Message-State: AOAM532BfkqTxwBZivqoLg3XqG9xT0UvpRYv7FYtKJq2IiwpcIcUe9og
        4MMXsWrT8Icw/SMT0L0UYb4=
X-Google-Smtp-Source: ABdhPJxTDkjCEEJTdfh4TFJJnpCILCQhcQ5Sah8XvbCV7NEexq+MLmqOhZeFzts4BVEmGSa6iv/t+Q==
X-Received: by 2002:a17:90a:7e8a:: with SMTP id j10mr16824650pjl.13.1641265128640;
        Mon, 03 Jan 2022 18:58:48 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k23sm573142pji.3.2022.01.03.18.58.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jan 2022 18:58:48 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v3 0/2] Add THERMAL control driver for Sunplus SP7021 SoC
Date:   Tue,  4 Jan 2022 10:58:55 +0800
Message-Id: <cover.1641264908.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for THERMAL driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  THERMAL: Add THERMAL driver for Sunplus SP7021
  devicetree: bindings THERMAL Add bindings doc for Sunplus SP7021

 .../bindings/thermal/sunplus_thermal.yaml          |  49 +++++++
 MAINTAINERS                                        |   7 +
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 161 +++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

