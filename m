Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004AD46B670
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhLGI5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:57:23 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C6C061746;
        Tue,  7 Dec 2021 00:53:53 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id jo22so12450162qvb.13;
        Tue, 07 Dec 2021 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gkU8ZGrtdv6KeZ4SARKs+Erno67wfX9YW3loioaG/vI=;
        b=WyZwKDXmOr67lxO+CzCH6lcLOIns0TFP2cDCXQL5Ec4KlNAtLv48Gon6haQwGA/pmt
         /nhgvOSUhv039ZR0oz4Ks58JZ6NuzFMLcfhrbXSU0ygeYn7dgwURIUYYu2lEJxdcavzf
         KAxBt4QTy+/dBPmVoVfHPFgk4m2z29S/gVikNWOFIVt9iPgwaa7vdyYVj8X/7lX4vM6j
         +gy+bWKHxbCDEUZ23Kg/E2ue8JrjRmSAtoz/B7ccL/MXApbD5s8qa4OUoK/ERtxtMY0z
         AXGcuhT7RGqJRS4rJdIZVpdY305BVXURjK1YcokidxJJFePMqHGsALA/7Koy6XgKNUb4
         jArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gkU8ZGrtdv6KeZ4SARKs+Erno67wfX9YW3loioaG/vI=;
        b=E+2gDnLntzp0h/sH69VGUWxVXRMoc2yNcV9LWi+mhkPZFc+3HPbPP4I4AtPvgPCk3K
         A4dAXvpzdH2O/pucx0QlVLgRl5RgBIznlPX8smmAcv3Pfv+BuTUQLNcgZ8XTQaOj6/LA
         pIy2jCcSJjS90s/kpzZERRDzbsztVe5R7wQ3O0Z4TB45nC3x9hPPQ+cbqnHMzBJgnYdy
         qEtqusyaEISHtcMv+vBO8+ISHKleXH3zf8XA17e1uD5LjSG4JxPG5njpHgkf2Oe4tdpR
         fusqVCTeZKRKFBK6Q3QHBESEJg7z+HHOY61mwFt3+QUP7XsGRtI3PJvYCJATVzaZfVp4
         CuRg==
X-Gm-Message-State: AOAM5314COFfv6vNfUGaStOaXpghtEBc3TaHEqFfx9890lYQI+7S/vtk
        U+pRR53NYmZhcPTJFDl4UzQ=
X-Google-Smtp-Source: ABdhPJxbEEwvxKZWa10mczQ9gxuDSJCurhieezGW69b2VSaAyrmDYkskDLgAgw+7lGm69+i1IyHfjg==
X-Received: by 2002:ad4:5f0f:: with SMTP id fo15mr44078462qvb.129.1638867231899;
        Tue, 07 Dec 2021 00:53:51 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id bp38sm7797797qkb.66.2021.12.07.00.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:53:51 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 0/2] Add driver for OCOTP in Sunplus SP7021
Date:   Tue,  7 Dec 2021 16:53:51 +0800
Message-Id: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for OCOTP driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  nvmem: Add driver for OCOTP in Sunplus SP7021
  dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver

 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |  86 +++++++
 MAINTAINERS                                        |   6 +
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/sunplus-ocotp.c                      | 268 +++++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 create mode 100644 drivers/nvmem/sunplus-ocotp.c

-- 
2.7.4

