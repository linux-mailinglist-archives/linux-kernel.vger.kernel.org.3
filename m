Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0A4E3CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiCVKod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiCVKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:44:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE381192;
        Tue, 22 Mar 2022 03:42:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s8so17764861pfk.12;
        Tue, 22 Mar 2022 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vWu/ETSZNoHOJrD7BGAJ22j0JvzvgibtxRQEo0x/cEk=;
        b=kyI12RBU1GQXfnDGsOllkRVEoMoup+jVu62iiimK4KHdjybPLQ7ip/VlPR1eGIOuPy
         SRcOlwlVc1qKOpw8zbwJc7CjhifwYn72Y2h0cEZL2/lvSd/THftNP1wOvqXS4tbVbME0
         5ZtNDutSExkLc6mjndBDIpwD75Z+b9CTgjoXDCPLC/aL8sUpes1Iw7FlPCn+ULalQ4fn
         k11PpK2WDeN4AUh3pUksyQNggBEy7Rw/dEHQ77us71RmrmmSViw6cFM9qTQ8Jaa1u4tY
         pxeHDUCT1zAXGm6QsnlPE4mH4hZCTYgCp1K9PEkc5XK/tgm3SlwNNi65EuMjxxwJqNX4
         lIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vWu/ETSZNoHOJrD7BGAJ22j0JvzvgibtxRQEo0x/cEk=;
        b=Uoq4g2THxTCFiFxzo5YTbXq5noVr308HYnjdpYUtn/PntO/9oYIayRLhDO4wC1JUDU
         FxPkGOqpzIQCYvcHTOFS6995o190QlU2BDPWvROcuPDT2i5u/baV8ykQRedNSBj9OQWD
         5OB9+w2O2tH+238UufVUGeOfCVDOImOB8WOvG02nxzog0N9EdzuouzroeioNYnBvOrT8
         Yp10QtkRFKtqhpN3/RjQOsU/RrsJjSDTF6UP6jwg1NIhm+CAWFYvEOgXaFdOgGUJKdF4
         AO1MUHS2OwVB5zy6vvWW1Gnv5rqIbcQNzkrCRF6CPDR5HXIA8HWBHxFdKfIVeT4GsqMK
         uowQ==
X-Gm-Message-State: AOAM530QYUAeJ+wLiIbX7Z26JivzeAnXKaNon0BmM38zCcqknPgxAgAY
        EcvYQmdyX9kQsj0plYrt5Cg=
X-Google-Smtp-Source: ABdhPJxnBweUyGwFKlEeXycBDm0aEFbtP8Bgk/CDB9EVBpDzTXaExvXELUjUdspZF5c+ikYDupsvRg==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id k10-20020a056a00168a00b004f7e16183cdmr28338231pfc.56.1647945763655;
        Tue, 22 Mar 2022 03:42:43 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id r26-20020a63a01a000000b00385fe08c264sm78113pge.1.2022.03.22.03.42.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:42:43 -0700 (PDT)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v4 0/2] Add PWM driver for Suplus SP7021 SoC
Date:   Tue, 22 Mar 2022 18:42:59 +0800
Message-Id: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
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

