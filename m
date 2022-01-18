Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C42492173
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbiARImc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbiARImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:42:31 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C284C061574;
        Tue, 18 Jan 2022 00:42:31 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p125so2102336pga.2;
        Tue, 18 Jan 2022 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8YhW7kPz/0dwcgLNR6pHvdAKCVjhZDw2v5KzLLB3Sdw=;
        b=KvVAmjNqIAM5rKgWxpNSO9sTeuTBkTii6FeT8E5Wj2ZUsNw7YvpM0V0oYuAhImPMlx
         G9pCjbFfJmbGqwpavhKsyUCUybbfa5bGvcdxaH3jO1qPbT1UX2m4UhXF60jxrzUirEYB
         ko75WxrIflNlP/blEogSwrKXzH85VGaugUPUJdu6JE4TOy28kErTqGA1SVSWBUfoa/3Y
         QJDf3n+q/rLmigIVMzUYHIwbhRwMvcGpOH5Ma0sSBbvJYQ8WU0QSOhaqNheAR8qUaj3U
         lO8xjxCfP0OdBkB9w+xmmHgQBdHZHda4nC66phqxpL1vR1N6oe8TKpSRxqRsVE5mqgJh
         GwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8YhW7kPz/0dwcgLNR6pHvdAKCVjhZDw2v5KzLLB3Sdw=;
        b=GC8IZu0fgROHnOLx6LXnt33kr8JSVqRM/lwiEBzYxTVF4q0+oCT027gtxU9NTcu7lv
         Y/NsbnTlxTQ8IInmnV5YGZm/NLNGpl8Eg/gNMWoglHqHllxFPklEENhnjLVlTwnjWh18
         iufc++gMz0T9/vcnDYy5zPdfk4ofVxyFA8R+xxQGBsLUgwRZWm/Qr4jFsb7TQCwEWN0u
         F2ObuD+T2N391yKtesDOsMNYj4IqWXIjPp574ScFNOMiMvxu5Jej3GQtqjtIaLrGrHxZ
         OH1dLQTDltyshWZFMkJyQ8UWIdXjZELhyV5L5X0maIdZEugrQ1wUXZsYSBUduxFLAWOD
         dt9A==
X-Gm-Message-State: AOAM5330GvG20kVTfNJeMQuMdVVLCrw5McvOEjqFPeKp6dCNLoRIAXoH
        abfsBDRQe8AV66dkVtgqCqc=
X-Google-Smtp-Source: ABdhPJyEcHzyJwHvMz43RR4Vu4ljXITw8kYN/lExgQk+Xi1sPq1tghV2sVx/fdKxR0cGVQl75EwgKw==
X-Received: by 2002:a63:4554:: with SMTP id u20mr22242363pgk.463.1642495350654;
        Tue, 18 Jan 2022 00:42:30 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t199sm14227787pgb.64.2022.01.18.00.42.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:42:30 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v6 0/2] Add spi control driver for Sunplus SP7021 SoC
Date:   Tue, 18 Jan 2022 16:42:37 +0800
Message-Id: <cover.1642494310.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for SPI driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  spi: Add spi driver for Sunplus SP7021
  dt-bindings:spi: Add Sunplus SP7021 schema

 .../bindings/spi/spi-sunplus-sp7021.yaml           |  81 +++
 MAINTAINERS                                        |   7 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sunplus-sp7021.c                   | 602 +++++++++++++++++++++
 5 files changed, 702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 create mode 100644 drivers/spi/spi-sunplus-sp7021.c

-- 
2.7.4

