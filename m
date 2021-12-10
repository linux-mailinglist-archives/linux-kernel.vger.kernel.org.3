Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDF46FD45
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhLJJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhLJJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:06:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B9C061746;
        Fri, 10 Dec 2021 01:02:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m24so5831931pls.10;
        Fri, 10 Dec 2021 01:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zjGrLEJQQKxdlnPKbJJ8rsTwPtpYOohHU907jjB+Mzc=;
        b=ZE4Fp+fTi63cl/sylsyNDEtXaauHjbcMpEoFh/4WnWdtV70Ez/pT6YdAO6TDpZk1/u
         cYS1jS2fE8iD9M5lnzbR3vswN6cgDpmbQ6hWcTM+hPx21C2mfM7xum6iEw9w9qnZimAV
         tJJAZ1Zhd/xi62aoBETOXioltb21rVyYBwyizKn/8UvJcBy3YGHb8u/qPgLbP4yQOS7Q
         S9OO/DYsrdX0VBg9qekO3iHcUPElULKdIdI0eIZqg9sqdBdrhp6fu+c6an0WxaPyEjuo
         dB0LVi1bnA4YyG2V5cZef7STnhfQcTfvSRKiu9Ey0C9V2/1DsG4aj5+nEtbH7Zasv4kR
         6QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zjGrLEJQQKxdlnPKbJJ8rsTwPtpYOohHU907jjB+Mzc=;
        b=xgfyP20aa8pY0DJYvEzG8MUw8E3vJVjUvNe9Lquyk1ptgK3FuTgduF3dYFq4oVnz8i
         pvbjp6iQe0CV2toyZe8GQhUySm5fabNQAj70vH0X3DWHhh9Hw5wcweqqbHRN3FWIoSOG
         X7guRfpT+vVqu4fDeyQYi0PWbHSB5xM/0QxUcPDCrFj/+Hr91DtqGuxuswe6Zucuew4x
         eulv1SRfjhB8kbp0UQS7JevcdR0w6XYx2YlEkzbMG/c3/85VAitH5R3w+/COkY8fxeGu
         le0HIyonszFGKmMeG3UMxZw7fIqa6XebbABjhLyJk8e2+pISq1qqFMj8z/j1ZycIpySj
         Qf0w==
X-Gm-Message-State: AOAM530IbeuBAUeoM0CRLIciij/pFpwzB3j42R0ecc9kZ/CKiAmdlgPA
        cMXY3fFqPABFGiPA48mk0CY=
X-Google-Smtp-Source: ABdhPJx1oMfzN1r5NOaYNNJNEkhs4jlLGQX5RklNyt7Nyls++EZH5cc9hJTANChqv/BpPZ7PgeyYbg==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr22435897pjb.12.1639126964605;
        Fri, 10 Dec 2021 01:02:44 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h15sm2540790pfc.134.2021.12.10.01.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:02:44 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        "Li-hao Kuo" <lhjeff911@gmail.com>
Subject: [PATCH v4 0/2] Add SPI control driver for Sunplus SP7021 SoC
Date:   Fri, 10 Dec 2021 17:02:46 +0800
Message-Id: <cover.1639123362.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Li-hao Kuo" <lhjeff911@gmail.com>

This is a patch series for SPI driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

LH.Kuo (2):
  SPI: Add SPI driver for Sunplus SP7021
  devicetree: bindings SPI Add bindings doc for Sunplus SP7021

 .../bindings/spi/spi-sunplus-sp7021.yaml           |  81 +++
 MAINTAINERS                                        |   7 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sunplus-sp7021.c                   | 609 +++++++++++++++++++++
 5 files changed, 709 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 create mode 100644 drivers/spi/spi-sunplus-sp7021.c

-- 
2.7.4

