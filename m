Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642DF5646FC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiGCLKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiGCLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:10:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7AB9592;
        Sun,  3 Jul 2022 04:10:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j7so3816293wmp.2;
        Sun, 03 Jul 2022 04:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1DVK/Ts7VHDy/P6mH0+7l7l+WUhV88NaSPE8plJv+0=;
        b=Nhmrkx3xOgSZexpcl2xeI6vCK1/7ohi5qhfRxI/7Gi94DPoM+JGNQUPWE77Ks0XCAK
         X2ruoZ1FU+zN0ZoFhtrNL5FinxgmNvkxEKM3zgpIPQb/Cj2PoGGVibZV8iGTBDaGqDcH
         nWE/9Yb+M7n4X/qeKH4n1OVw/FyB8LuC30jD3Gef6QcBLm+3aPRGJ2t9PmdKF5Z989O+
         RSGH4CtytyTC+bfB9HUeOe/QCXeEVQTAy2hMtamwNLl+xW47/V8cZdJ0JWIzqVhmf+4L
         WF0c/2euWTWI/LcjFIH0XbS+RnUQiTgdkGjwmL0+Nm+gskdXL/kq/T/GTEHPTIMhh2Xy
         TzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1DVK/Ts7VHDy/P6mH0+7l7l+WUhV88NaSPE8plJv+0=;
        b=K4jBUGLK4yplc5PxMFuFwud8A3NkwaaPw0wAF+Imw1gVjyC5Gs9PNYiusv4ExC7zja
         6QeV/r0qIXaAKOmd1JSqBZKJShdVKhWam3NsgW8WmnU51V9KoEIEfvZid5yaKuAJhitK
         ulQeKy4GxFPG7y9HcqIKKsw3bzsM11VM4YOuzJIxqW5g7+y1MKLA+W6zHUKdbrg1ECOB
         I846FL55SuzvFMvuEropThO7DUJ2JqTVLU43509Ar8KX9ZKPIMHcEd2dTa3Dn7cdHCwD
         xyYSnqifIUPKnYqXrDor87Hb1walMqmFX+AIrt5zYMyZ6MsXS5TNupDSzYMDBkZNZUHD
         oAMw==
X-Gm-Message-State: AJIora/bX2HXvqxcYw62U+EMnTuvEnGA9+KINFaWcOEqSC2wuRvuPVs0
        uMjOyCQNteZFtWt0yj52MaI=
X-Google-Smtp-Source: AGRyM1v4eTspkYDDLpsuIbGoqv4N1meUpEAwRfosY97Z4phf6ETcSoQfKJmHO8RHXt5FShsMesWSRQ==
X-Received: by 2002:a05:600c:4e56:b0:3a1:7db0:9e35 with SMTP id e22-20020a05600c4e5600b003a17db09e35mr20214797wmq.44.1656846606442;
        Sun, 03 Jul 2022 04:10:06 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b0021b956da1dcsm27239180wrr.113.2022.07.03.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:10:06 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] gpio-regmap support for register fields and other hooks
Date:   Sun,  3 Jul 2022 12:10:54 +0100
Message-Id: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small series to expand the usefulness of gpio-regmap.

Patch 1 allows GPIO direction and level to be mapped to values in a register
field for cases where a one-bit-per-GPIO mapping is insufficient.

Patch 2 allows gpio-regmap to be used for the GPIO portion of a combined
pin control + GPIO driver by deferring some ops to the pin control subsystem.

Patch 3 allows drivers to provide a custom ->to_irq() hook for the GPIO chip
as an alternative to using an IRQ domain.

Aidan MacDonald (3):
  gpio: regmap: Support registers with more than one bit per GPIO
  gpio: regmap: Support combined GPIO and pin control drivers
  gpio: regmap: Support a custom ->to_irq() hook

 drivers/gpio/gpio-regmap.c  | 110 ++++++++++++++++++++++++++----------
 include/linux/gpio/regmap.h |  24 ++++++++
 2 files changed, 103 insertions(+), 31 deletions(-)

-- 
2.35.1

