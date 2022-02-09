Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C94AF01B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiBILuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiBILuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:50:17 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A309E01C885;
        Wed,  9 Feb 2022 02:40:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso1873363pjg.0;
        Wed, 09 Feb 2022 02:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=F4dvlEAApq4sbNi12hDnWabgWkGNsJts8xnpPYqukvU=;
        b=UXGDXsRlds35agIJYEneaEhMi0hvXSjblyL2c7Q0UBkC0yZVKHqdxrIVLozRIiOBJh
         8xR1PvUU0j1jXV5ubvhkLpdkSKoiSsP1pjwv8nFnCzPB2z9ZqfVqAbnglkFrNhxMZuUC
         ayHIyEBZNZP6s7WaW2T4Ksl9D5x4rLY6Zn3t8TWbWb6Ux97ATYmgEd9ydcTcukEdKUOW
         KEwvl0x6bFw2X4d8Ls9es/JIwvzFQTnA1UDQHuRzwBZV4H/qrAPQYAi9JGo+aautVcr6
         gGaC0qxdMTbeaOxGPO85HiwhfMaBHrQF8eOnt/hrNTvp+kVv/A5FWHQzPWtSDkvXtMvg
         9OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F4dvlEAApq4sbNi12hDnWabgWkGNsJts8xnpPYqukvU=;
        b=ykURN8qmOzeiwll+ihIdn7QnOczkx2ctKP3nBtPXkLD1g+l/gW1LYxHROLRf9IQC7u
         90w2ROQOJv9L7mvH79Yrly2xk1uKafiWv3QC3/X8gQu1MoxcXfn7AoaSjpY5CG4ZKX8V
         HsJknqXBUgK4M30Ocw8GchFs/LIfAn7cQ0iC7coBPy2QoVnrPnNhVACnyBcXXK0NRBzC
         lUGt11eovtlFjxTvp2CHFec3BVLXXM9BU65azOCnrgfjeHEyjyT+yiP4aT0yBqCkYgj4
         MxkK3bIUMG23ijBml3ANqf0JSVlbG5uVPwQ4WSECcFwqInODC2ky5WFgJH/9nb9FlhCd
         n7Wg==
X-Gm-Message-State: AOAM530MrLPmyQQtj5pNjwPrzjFwzwohBKI6Fq3N2O9ULWO+l0sx9ZRb
        BNiSgWEGs0ZIrOPhrc9VfE4=
X-Google-Smtp-Source: ABdhPJwrmxUIij4bx8V1Fn58ivpmEEghm+3Hhi0wmRYMhN+PA/z942ewyGvb7a+r+hZcZI57RbZb7g==
X-Received: by 2002:a17:90b:3cf:: with SMTP id go15mr1773859pjb.223.1644403252689;
        Wed, 09 Feb 2022 02:40:52 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m23sm18223272pff.201.2022.02.09.02.40.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 02:40:52 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        tony.huang@sunplus.com, wells.lu@sunplus.com, lh.kuo@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v3 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Wed,  9 Feb 2022 18:41:05 +0800
Message-Id: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

 .../devicetree/bindings/mmc/sunplus-mmc.yaml       |   76 +
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus_mmc.c                     | 2168 ++++++++++++++++++++
 5 files changed, 2261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus_mmc.c

-- 
2.7.4

