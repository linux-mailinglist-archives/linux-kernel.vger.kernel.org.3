Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6274AB4F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbiBGGgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357454AbiBGF6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:58:07 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD06C0401D9;
        Sun,  6 Feb 2022 21:57:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a8so11189159pfa.6;
        Sun, 06 Feb 2022 21:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=y9bBJY7cXiMSLjJXu6FtT0/ZdOjOHaxztxJ2W6Z5PDY=;
        b=SE/UvV4nuWEyJNCKqeFVG0LpaDXbJYRc2mBxsRKnE+46ojhus1bZcvgg89G1F97MHM
         PgZR7+Ud/fiyEixebOhpSg6npVoluVyJHkUoPTCtKewhRtttRxVZwC3knqC2p4yhCJPV
         gV9Wu+ON5uRH5miDOhgWCNlgKvYR1clS3pOuwZx6gio0u9eoJZl/11A5ibHg3jZJmMCD
         MbQlG1cqO+79Y3JK6bpNwxOWafxAS2UOW8McK0e0jdND5DeYezx0zck4iBmfRbb4s90S
         lg7Mm0bGYUN2rWrTPDQCRBdXYRIGztCoVqDY2N9FxhSRUAhwlEvK/FAVBYjuoQnEEnFu
         zFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9bBJY7cXiMSLjJXu6FtT0/ZdOjOHaxztxJ2W6Z5PDY=;
        b=bdJXp0V0ZrMgVuL8/Yaqt+6RRnNrKpA56vvR11Loyh6WF+mR7FS0BhCECuU8fNy6e4
         rL3B1SwSECyh91epj1q2UsMAePoUGqjAm9PZDGJPeN67ifCYxdNEzY9aZnBeZ5j3ra6H
         95A4IAWObyAazVx31wq7D/phgKUyKL9y/tRMnml3y+5AQFuu0Cc+jpIpbDsqVkAaZREr
         h8kNNNItkjAISyuIL8u93SUqAmJR+Vx9HDT70pjfDw0CzrWcsS7WSwl5dk/it+7LEoTT
         7ooGgyZ8f/Jsjnxv0z5I5KEAJyWfqZGA5Fe6UK094y4KgCjF3sgYt9KlhrI9h5lZK2LT
         6NYg==
X-Gm-Message-State: AOAM533F/MAdPEeWU46lGnpEtLlKAuta+vNcqYNM4fXKlicwYEBO6d1S
        O/MzJTqFWVCMoGmitZ6Qw+w=
X-Google-Smtp-Source: ABdhPJxS9pXgWqX26P+8yIm8vzdwU/pQTCkthp/tbV6esJrl3tIof3G3e+lqhkSI8EhqRiI6rHAmfw==
X-Received: by 2002:a62:7bcf:: with SMTP id w198mr14203384pfc.12.1644213470284;
        Sun, 06 Feb 2022 21:57:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id g17sm10529264pfj.148.2022.02.06.21.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Feb 2022 21:57:50 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v7 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Mon,  7 Feb 2022 13:57:59 +0800
Message-Id: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
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
 drivers/tty/serial/sunplus-uart.c                  | 762 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 853 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.7.4

