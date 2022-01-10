Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E997D489055
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbiAJGrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiAJGrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:47:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87CC06173F;
        Sun,  9 Jan 2022 22:47:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso19749763pjm.4;
        Sun, 09 Jan 2022 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VfqpecdRBpzR68VGE/Ls/BL0baItBFBrmdd6HsPhTlM=;
        b=VbSesz9/GvbUuNv9gi1XsPN8HveuT5BnGoSa3FT5VsnP72h0pI7qEIlJQufNFglRpM
         GlCWQnKsSpZDDs03utPSawVqyjykPcXNz1kC9Bmyrt/JPlN0MLQABoY11bo6jCuUThbx
         3Ewe6Dukf+9ad1kOpXTEzwW/xwO4jLKw9Q5cMuM8WGNKBcQ1+NpIocD5womU7Vt4WqJI
         rdn4tpcZpYAxDeq34WWS1uJp7ZZ3yxH07v56nU76y86KqEKVJeYNQxMxcxlcYowgZ5E2
         b4GptNkdCr54O7k+bZlMfRBIRyD4zhlJUH2XMSk4swJ5y3L6u+fGW+WiYrQgrHUM5KPO
         ZTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VfqpecdRBpzR68VGE/Ls/BL0baItBFBrmdd6HsPhTlM=;
        b=Xu3ApPEGufMTra2QUnSPM/IRBWDroHY4cab/YGWWquRKmnJpMJccIS6Fz3Pd1gzFEC
         l880ew16gEwInv3pPqt0oFUNQre72luNJDimUWKIqVz4269kz2uYUtDo9sTjyEZYh3l5
         TKw367PWkTHzy8+Xkf9LJ+tz9G/HGQFHlLCKsboP+gzjEiGgWsfv9aZQo5WYZUlv26PH
         kiiBEUb7rRd7SsggHN3D8f2vejGMZ3eOcL0kAFErhhFnGR4BlgpF2/NqrM6QkXchZsEd
         OOpTVwaqpUlPQhGRgIAFOESlWxF0P9yDIaefCp7/V2P868JNXhOhzmn2aUN7VKajGNsI
         1mAQ==
X-Gm-Message-State: AOAM531FJBKZyS39hUmGnJ/J5YWm5/zjnCCxJ5agyghbRNdxQyVt2nhC
        b+O0HNmnzIMUff/z2NsME+8=
X-Google-Smtp-Source: ABdhPJzp+xKapxhmxgI8Zi9skQ5E3eAktOR69czzG+4QiRafQom0sD9z+kidfTpYw0CKKseqH6uvVA==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr28801124pjb.69.1641797233943;
        Sun, 09 Jan 2022 22:47:13 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h4sm5591031pfi.79.2022.01.09.22.47.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 22:47:13 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v5 0/2] Add SPI control driver for Sunplus SP7021 SoC
Date:   Mon, 10 Jan 2022 14:47:20 +0800
Message-Id: <cover.1641797029.git.lhjeff911@gmail.com>
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
  SPI: Add SPI driver for Sunplus SP7021
  devicetree: bindings SPI Add bindings doc for Sunplus SP7021

 .../bindings/spi/spi-sunplus-sp7021.yaml           |  81 +++
 MAINTAINERS                                        |   7 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sunplus_sp7021.c                   | 603 +++++++++++++++++++++
 5 files changed, 703 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 create mode 100644 drivers/spi/spi-sunplus_sp7021.c

-- 
2.7.4

