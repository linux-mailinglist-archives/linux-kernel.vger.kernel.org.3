Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9814BF4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiBVJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBVJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:36:15 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB36156C71;
        Tue, 22 Feb 2022 01:35:49 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u5so15125731ple.3;
        Tue, 22 Feb 2022 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kSokq3mwNVmEXiv+4+dH+H1BL4icCF0v47issCuCpjc=;
        b=WRSbUkBKdl/FP1flca2/Wpw4wj4IHKFGsTx3im4n2aKZlaVE789JPtYpB2944u7hKH
         ZqDc8aFFYOx+Uj5Ui7qUdw6YXw6ikvOghnqYJfvfr+Pp05GseVmJQrKlNfYUkjs+fu43
         guL9AWOUVQuc0NJMADK7wJ22VpcSULxuaU0GLfmfiVSf4+d4kM4QcqMHPPcKJDD7Uka3
         bZvOwiy1sUpsq8h18uMXlwMl64+9fmaIeevyeArCPnOhGwFMYblZh+Nfp5Xxy/nFpSaX
         kauMVcsO+dkhaFHEUCQ7/+A2afN0DCJ8KC0SUfRae7y6JLTNpozOr8DnWBfYqGIb+fvy
         Sg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSokq3mwNVmEXiv+4+dH+H1BL4icCF0v47issCuCpjc=;
        b=rHeQphLyjRFQ50srZ5Y4MT0jGwZ5GGEZ3MCvZFw+S/ml6l9k9KAEcMDRbc08kH6ra1
         MF+lbb8LB/QPq1jncG7h53Gc83de00Cw9zZQ7eMsJiBbzSfsUt+FKWznTwFuX0jRFQdl
         o0CX1yrA+IlN7VLPnm0i/rcO3ipt4ia04mudlgQgd1vL8szxnD7eckxzo52PuW39C3dF
         +ispT/qU0wEMMmnzXNMhr6HaVXVhCbY9Odq4HYjPz9NbJWUNOGY1lxHTdWd3OGxmMgVW
         BH8kYU8ZwchuhZspsdlIuD2oH4jtkuK6CoLh/QUHUHK4KSyBb11LZfr+pnw14sal1OHb
         PPDg==
X-Gm-Message-State: AOAM530mA+0WRtWCj0B7wM+3tL6+K9m9HEP5c8doVY4GpC8scVzzsNuU
        VeRt/GrLPtRvSY0l4Nd0JC1YaZ7mwV2VIQ==
X-Google-Smtp-Source: ABdhPJxfCexfzOzl1CTDM3NcW43b6drAGbnWvxMeL2MWrmBM15psiBD+tYHMZMAeaXtvXhhkgk5UYw==
X-Received: by 2002:a17:90a:db90:b0:1bc:529f:7071 with SMTP id h16-20020a17090adb9000b001bc529f7071mr3237535pjv.40.1645522548580;
        Tue, 22 Feb 2022 01:35:48 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h20sm15390650pfq.162.2022.02.22.01.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:35:48 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v9 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Tue, 22 Feb 2022 17:36:01 +0800
Message-Id: <1645522563-17183-1-git-send-email-hammerh0314@gmail.com>
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
 drivers/tty/serial/sunplus-uart.c                  | 770 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 861 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.7.4

