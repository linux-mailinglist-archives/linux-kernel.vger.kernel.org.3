Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF5F464BE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348775AbhLAKuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348765AbhLAKuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:50:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3606AC061574;
        Wed,  1 Dec 2021 02:46:48 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so17368637plf.3;
        Wed, 01 Dec 2021 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QgI8xfOKbtqJvm3pifM8iV6LJY7gb3a9XtF8BRLsjus=;
        b=ix8S9kprhXYll66e5bza/ClsATBsMxTY00mtPqwtjQb69tlbPV/zss/b7p6jeGUEqX
         GHuZAA/IxBu1qAIyYRC2aceIo3IqdLkSMeRl0huJjN/j1vN1NqVTqwJc/JI6Y38JS9Xh
         pjXh8J8tnahIZRFb9snFsOhpljsnlT3J0bMeJCZ6d4EODmuXzOaIhTj5KaTTt0YFQ+O6
         ee8Pk7ytgxybwgTA6eLIZtUXEVCVuwivedIopApbSEh6p/Cht0wcLgsbpB9ggIW5HI+O
         NoR+d5WScTrrD3FJ8tw1dIaMJiFeZPz6V5GHUXkwibUuJRxqAKbQgLcra2+Tg5BCe9c9
         yyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QgI8xfOKbtqJvm3pifM8iV6LJY7gb3a9XtF8BRLsjus=;
        b=4UvM6zC0FeU5JMHNlYsXkPfDhg/uuqpm6r0mbR1OJ0iiCIP9lqGRic82mZxerORSwb
         2VRRZDcQedNN0UhndhZYSJsuVM7GORpi0Fus1mqeNV/d0lw9rSb6b4OdsN96f1CuB8J7
         CcgEtXo1shz/iFOelikRqDKESJ5v8fkH4hsaEkEv+m1fjIQQF3+RktKmGPs/4Oxnlx6I
         RfzVOv39s1EMMDePwQnLs3oqsY/mAT6DDq4hqhoe2u7rp6jkqKzxX5Q1+IUB1WkQy2CT
         +Kvahzddk3hJL1zyrBwo0+MUg8O/vu9tGHxH8eXHkxb3USdd/bXbFxw7+mAGTuwpk6Ss
         EqDw==
X-Gm-Message-State: AOAM533rEqMMczOT1Cyf1U9foRbrNJh/juoTTjRQkt83OsZ+h9YKN9jp
        5U4Odw9Qrm7JgX2Yni+rlwA=
X-Google-Smtp-Source: ABdhPJwPfbK12znXFavPJ3yqk3Xt9XK8n+hr6qdOJR2JiO0LaP3Paje4qQq1UqINPE1Qtd1NOmBcsQ==
X-Received: by 2002:a17:902:d505:b0:141:f5f7:848e with SMTP id b5-20020a170902d50500b00141f5f7848emr6454307plg.72.1638355607514;
        Wed, 01 Dec 2021 02:46:47 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id f22sm26395318pfj.49.2021.12.01.02.46.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:46:47 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v4 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Wed,  1 Dec 2021 18:46:42 +0800
Message-Id: <1638355604-24002-1-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
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

Hammer Hsieh (2):
  dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
  serial:sunplus-uart:Add Sunplus SoC UART Driver

 .../bindings/serial/sunplus,sp7021-uart.yaml       |  58 ++
 MAINTAINERS                                        |   6 +
 drivers/tty/serial/Kconfig                         |  23 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/sunplus-uart.c                  | 848 +++++++++++++++++++++
 5 files changed, 936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.7.4

