Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D44757D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhLOLfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhLOLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:35:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B92C061574;
        Wed, 15 Dec 2021 03:35:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 36-20020a17090a09a700b001b103e48cfaso1406959pjo.0;
        Wed, 15 Dec 2021 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TaGHD7z1uPWVoqBO0eW99qVXK7I8JIm4IUxWWiL69jk=;
        b=ZRB7buEAdPUMdg4qRNJl0QZFOg/ttuxXUZ72SnQGIA9EmDkcx/sPi5n8EiHe8Zfkuz
         deDwSXmBHJe2GHyb69LW0TjsY4iD19cdAETzSf20F2LBprIZYKmtG4HQEf3378up69XI
         R99TmkRgV7wJwT6mrD3ob5GQICyoVKGBtsMxarUuqR6F5m5z0lqhzYOmt5DBR1ZmSZ6/
         quvghAnPZ9CacNWKe+DeFz/AILM2DbrKNk64e1BnQrD3+p3l7ywQX7rDpP0Nb7I9L+v4
         ou+g15089fnr2ETbF0I0unm+B6NonpZ8gO8MdBBSkd7xTEb+p0itDRa+B6YusD30nX52
         b0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TaGHD7z1uPWVoqBO0eW99qVXK7I8JIm4IUxWWiL69jk=;
        b=7F+Pf3K0dTo99tfT/o1KSm+Ny1M5B/pvv2HvqPervrXUV9gCBIDjs32uhr1rOnPx3H
         ii1QS4thL5RAxetgSO326JWGkJjKxCMq0AaH9esMR3iP2UwOOYTnmUhochV+2snEbIIM
         cbqbAL4POvjQYDzudB7USnSjCSM3GPNEsQEd5HWMocMZQTGtCUPLA6g5z1CV/dBXHBNp
         krd9MjYPa0KPLbzCTaMv6KEKX4eM6ha0enQUQzG2zD2DTHmK92b9gqZS/xq/a5W8Nzio
         KUxK3CR9pS9Ui63adNLmSZ7asBl1f9RRH2szPnlRAaNMxwSsv4HsZPLtZeG6RzqCd8/x
         N7Kg==
X-Gm-Message-State: AOAM531tuEJNfEPDMRiWa6pxDO9//ggyp86BTxd5yAMLv7Af22DbKMzz
        0bLSizMv7nFeOLoe7zy/6tY=
X-Google-Smtp-Source: ABdhPJwrVSLtJSqE4KeEdAyFEhmMWKLl28Zif20FZtpcrRW2UjVLBkZsOw0OCPvtHm8ztqGsBfG2CQ==
X-Received: by 2002:a17:90a:af94:: with SMTP id w20mr10976474pjq.223.1639568144654;
        Wed, 15 Dec 2021 03:35:44 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s19sm2558727pfu.104.2021.12.15.03.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 03:35:44 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 0/2] Add driver for OCOTP in Sunplus SP7021
Date:   Wed, 15 Dec 2021 19:35:46 +0800
Message-Id: <1639568148-22872-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for OCOTP driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  nvmem: Add driver for OCOTP in Sunplus SP7021
  dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver

 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |  86 ++++++++
 MAINTAINERS                                        |   6 +
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/sunplus-ocotp.c                      | 244 +++++++++++++++++++++
 5 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 create mode 100644 drivers/nvmem/sunplus-ocotp.c

-- 
2.7.4

