Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04A24D7A81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiCNFwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCNFwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:52:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CF3FD8D;
        Sun, 13 Mar 2022 22:51:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b8so13478577pjb.4;
        Sun, 13 Mar 2022 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vWu/ETSZNoHOJrD7BGAJ22j0JvzvgibtxRQEo0x/cEk=;
        b=WohuxuSd4UsK09plXPhFahmIBDESyrk6S3SGq6ruiOe9IuQXAmeiIsbmF1Fa/Al3af
         VaTLgc1eb7ecWWBPxZfAJNJ//YWoUfdxfPPs0Bx4oJhRqI2LWhigDTguTuZisvBrLIrp
         kKn7aYRMO3G+SzyVUpUoG/o//68W20h2ZEYYAhyqn4PYeIC3AP5RcW2hu0htiKz+y12U
         IwIWLacaxX4zWL/E6lw//0E7fhXkJ5BTQP90LhL/7QRonYogeTx/NHiLx5vEJrHJGbTv
         d+fulX6EkB/FHNg9/zUydjMPH/BHzCHQCaUoM1GGmpK3M/axDIweA1vN5jmnBeTjgW59
         jWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vWu/ETSZNoHOJrD7BGAJ22j0JvzvgibtxRQEo0x/cEk=;
        b=RTiO5Bi6EpcfRsrq8/wxepqZqY2G+RMOr6MyT9RubQY5NimopIyEWab+tPILF037+w
         v93MIxTcMqTkXhaCBfwGvx2nirtvXBgX0XkXukNvVWsGh1InZCjhnzfGaxWLGyvP+tKO
         LnkhALmSVRqP7z14vH2oZzfEFQp2dI2Bmeo9JFIxxxtsAUuxbL2kPtf6h3wUeyCRax8K
         dw/nuak6AnJbGeyfS6IFaYmu4sziCWJH6oPkSa+CSpfXOJ4guY7IpMR0TMJymnFKXfRg
         E2Ee/R/nqJeQXwAYRQaPRpl7NgGkhzYmd65VeqkcV7BrzRODlUprHjRtANqNGJepBRbV
         fysQ==
X-Gm-Message-State: AOAM532pHNpehBVg3nx86duBcha+Iqk2+bMKi0EXpMEl8QNSKRr8G1MX
        AiN91AbU6YkGpsSZ/HEKj5I=
X-Google-Smtp-Source: ABdhPJzVOzlqCJDv1HzcCefmoDM4h44gH43NEh+xsBEWPthb5ETAQFkSP1Umr/PZ1jlZBtzZME2kGA==
X-Received: by 2002:a17:902:7102:b0:151:ef50:32ec with SMTP id a2-20020a170902710200b00151ef5032ecmr22430264pll.50.1647237080527;
        Sun, 13 Mar 2022 22:51:20 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm15238115pgj.85.2022.03.13.22.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:51:20 -0700 (PDT)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v3 0/2] Add PWM driver for Suplus SP7021 SoC
Date:   Mon, 14 Mar 2022 13:51:35 +0800
Message-Id: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for PWM driver for Suplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Refer to (PWM):
https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+Pulse+Width+Modulation+PWM

Hammer Hsieh (2):
  dt-bindings: pwm: Add bindings doc for Sunplus SoC SP7021 PWM Driver
  pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver

 .../bindings/pwm/sunplus,sp7021-pwm.yaml           |  42 ++++
 MAINTAINERS                                        |   6 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sunplus.c                          | 232 +++++++++++++++++++++
 5 files changed, 292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sunplus.c

-- 
2.7.4

