Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D848C0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352016AbiALJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiALJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:23:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84CC06173F;
        Wed, 12 Jan 2022 01:23:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3659342pjp.0;
        Wed, 12 Jan 2022 01:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xoqHD2fGBh/+nC109QIpzVKHDNVPgk6VF0zAraXZPPU=;
        b=jVQB6rE98LmPOOgpYk3AXOPs1FkIMnXp+j+jJb3wfdgB2K+Woja5aXjei+6qR8DL8G
         oLvV4KJjodWKh844Oe45kTaFdNxfV3j5alK22iDdliYYBjFBn1gKU9xiUv6M+fypwiQF
         3ygYyFqUW+HPPFGOczwtJiZjuLoqMXx+Xvzr8qfstNtgjR4MKJSrNJDfdOfegyW+XJcu
         zhvBo2TgBx8Evy6WW4hcxJkX68u4hmAmkBtgSUf9s0jrXbznmJKAlyvZjswaPjdDruEb
         ZYZsLXZhx9TycXq7orz+TUq4xWOMDA2zD+Du1W72xLCJH/cnvCF8iLgZK/2PO9xWjYqT
         NuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xoqHD2fGBh/+nC109QIpzVKHDNVPgk6VF0zAraXZPPU=;
        b=AhnqfP9Sl//o+q8uwJ98UNTX82aZKr1ntdjuf4rAOIVVDYsKuPPQoCKTG8BWZop87u
         wrFOAlEhEiCn/Tvy9/onInE1xQNa/ahcbG2wLLztSuvGyGQIDaoq9zES7DRsio4X9vtR
         sa0g3suvju46oqxmAahXNznW2gCnEEgmBAlaLl62NilaXqCyzODx+PU28t5Qq/8cR4ZV
         fB5Rnd1FxVKEajlDqucTE8BNwXFoHBuK3AjY0LaIi6OGM/+8f1bYKz3mUDoOMj4E2tG9
         7z7JrM4fQM9mFD2pPAYuKTNqCwuanmD1Vuq0aT0E0yGWzKf3HvwdlOJCiTkx967N67JA
         YWDw==
X-Gm-Message-State: AOAM5326eCRfmElZVyZiYKCdReg8H6aznMdGI6eWYyGNNPR3JKUa0e6L
        ccqsAPhFC0MM/aaWDvZez3A=
X-Google-Smtp-Source: ABdhPJzUZz7nksdFPTQeZMQJKHhPbzTNpPBHSV+vvjfihX9xgYGn5aRbJPCxpWW06QyO1PGck6bTZQ==
X-Received: by 2002:a63:7d0e:: with SMTP id y14mr7618945pgc.356.1641979438564;
        Wed, 12 Jan 2022 01:23:58 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h11sm4898527pjs.10.2022.01.12.01.23.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 01:23:58 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v6 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Wed, 12 Jan 2022 17:24:02 +0800
Message-Id: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for UART driver for Suplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Refer to (UART):
https://sunplus.atlassian.net/wiki/spaces/doc/pages/1873412290/13.+Universal+Asynchronous+Receiver+Transmitter+UART

Hammer Hsieh (2):
  dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
  serial:sunplus-uart:Add Sunplus SoC UART Driver

 .../bindings/serial/sunplus,sp7021-uart.yaml       |  56 ++
 MAINTAINERS                                        |   6 +
 drivers/tty/serial/Kconfig                         |  25 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/sunplus-uart.c                  | 756 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 847 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.7.4

