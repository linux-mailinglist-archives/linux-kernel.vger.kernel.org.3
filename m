Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADC24B677E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiBOJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:24:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiBOJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:24:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F46CA40;
        Tue, 15 Feb 2022 01:24:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so14087072pfv.1;
        Tue, 15 Feb 2022 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kNGUHNerHEccDsoMSw8GxnLTWM5pQ0HamEVW+4lsHk4=;
        b=VIM84yxkBHtYYFoPr5aJuwxfiP5Tftq9XztK7O/cr9wKeC4D5txtsob+mwh8XZ4Opb
         4PlBIgMmJWrFuYHgJhqctbE+67a4xDoMRhMVCGM33QwQDwWmam04HqaxVRyKLRsbJDmZ
         M330FyjkImK2/GAfdeAEfU/GuW2KCnlCTnZVYYs1eGOoPG7tr+CtPG2JDLkqF8mpuMBV
         hfi/mtxxY2bs7+AFRBsKI6wlm9pTyBHilxPfBb15R+sSQskskgY9CVcUfsw3y+++9PjD
         wd8TWlrKRcEXyUSw1MSe1Vb+9umrdg7k0zTgT3xN4HJJdKwWx1hpRWTHCklIMfQccvlF
         Eo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kNGUHNerHEccDsoMSw8GxnLTWM5pQ0HamEVW+4lsHk4=;
        b=iGVqP339H//ghBGk7z283c4jQDdDYG6fDHvtNArzqQyE44kI7ApH/CS/4OdZu58mOZ
         KIqjuGskv8t6Khd0xW7k5gGnSyV/K6CbvZHn69hRl+mM12C5fwo2GD0kRH6GD8RueVku
         ca8F29KS0JRbXoJ5SEFaoD+VFdi3NABgTPcsPctnJjgyQEzOo5WbaZ/dp5rI5iAEmJ//
         ZVunwTW7pT+4+O9iSgGMEMUhzMYdPa0blkojgoBZ9egKvpn2dL3RaC9DdOSxN54N7C42
         G/grtf/30N5Vd/n4RbPYFKTp6omsjrn9edleIGxXv8AsJ03Gm4/rlbcXVsr99c6JRjAG
         Be4w==
X-Gm-Message-State: AOAM532iFlAY04nzeCKYwUaBENu88I00+9oJ7qJkx3JDD9WCr+at4kAW
        dkTTSAwjkYMGh8V5jJ2I7R8=
X-Google-Smtp-Source: ABdhPJza2GKhb0PP9YVAagg6kiSJHfsivM0DAJT2VMX/ZSAQhD22S/pF6FczQqoKQyRqO0W0nagLtg==
X-Received: by 2002:a05:6a00:1493:: with SMTP id v19mr3397162pfu.40.1644917053362;
        Tue, 15 Feb 2022 01:24:13 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h5sm5503824pfc.69.2022.02.15.01.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 01:24:13 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v8 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Tue, 15 Feb 2022 17:24:23 +0800
Message-Id: <1644917065-23168-1-git-send-email-hammerh0314@gmail.com>
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
 drivers/tty/serial/sunplus-uart.c                  | 776 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 867 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.7.4

