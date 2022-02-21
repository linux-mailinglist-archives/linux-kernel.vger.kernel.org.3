Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B412D4BD397
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbiBUCPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:15:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiBUCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:15:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020AE3206F;
        Sun, 20 Feb 2022 18:14:44 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i21so7396765pfd.13;
        Sun, 20 Feb 2022 18:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=tlAeQm/WbGm0MvCoueMwGsS7nGW/+yZmIDXYYZmGKuU=;
        b=XhhOuCg7SDkrV4zeXdMttervjTANmm6oVGFmSmzFRFQ8uj+gZd3cAB9Tz/yZSph5pe
         fnbQnSxr5TTmJKPKwzTCatSOzHKaWOwqAZXIDFbM4dTz8FFljvZJKvqHyO0wei8fgGad
         pJq9DSbUpqHITE6uQXPqBYwEUH8H9NiXEBXiPLdEIaroU5dE3iO73ZMnPhi2Qc4VbTn6
         DMuj21m6Sw7OKdig6xVHQwTmrqlljXlyDPMIA6KHeuyDPvFZ5x6wQLEjTVVKUyHoMaBr
         9TUCaEYqCEmkX4huwiPYD433cVxzK0eR8uBfseSnT0CbQ71Dq2ZthsTVYk7mfq7I84UI
         cetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tlAeQm/WbGm0MvCoueMwGsS7nGW/+yZmIDXYYZmGKuU=;
        b=U5OHpyX/R4aan43Nwj07oEkDZrO7KL6QSyOaPhW8glC/ZUp5f9QaH2yUsbOuUfudyO
         uMUBKTLJ/7Ia0pEhRiNx/tVwCLIvJ9WQib3Mmm2v+qY1jL+oMh1upGP8HzNtrya1VxVB
         oCw5U4LCVold/UjmdB6BXZoqCRUhN7wIW00WLT7vogMppnoTVwiIuBusM9GSBTKLIpHz
         JMFmMfrEfWhmGFCZM4habhTpC5N8id+25UUemmnRX3WdhwYkM1XwqDegH3O1V+Z8tGaF
         DYmPf3o+PHvm9hfrgDBSh5xX+k2UrAoknltnEm8Ke77lv9RDD/cFsJlLsZxFaZv2U7Vb
         37vA==
X-Gm-Message-State: AOAM531QnTkxF440L8Z/JA8AwEwKCWMiksmBq2VAI1q/MeZph5G+VbTY
        bLxOvPqoC+R+wJ7Y1hcRx4E=
X-Google-Smtp-Source: ABdhPJzsu+/9VkB+rWdznY4nQOp6DmMVYjCjIg72sNslDOj/PISdom4+Mnozn6YUFVfJuE38ibwk2w==
X-Received: by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id j18-20020a056a00131200b004e158c4ddfdmr17995733pfu.65.1645409683535;
        Sun, 20 Feb 2022 18:14:43 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s48sm10022908pfw.111.2022.02.20.18.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 18:14:42 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v9 0/2] Add iop driver for Sunplus SP7021
Date:   Mon, 21 Feb 2022 10:14:53 +0800
Message-Id: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
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

Add iop driver for Sunplus SP7021 SOC

This is a patch series for iop driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: misc: Add iop yaml file for Sunplus SP7021
  misc: Add iop driver for Sunplus SP7021

 .../devicetree/bindings/misc/sunplus-iop.yaml      |  76 ++++
 MAINTAINERS                                        |   6 +
 drivers/misc/Kconfig                               |  20 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 420 +++++++++++++++++++++
 5 files changed, 523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

