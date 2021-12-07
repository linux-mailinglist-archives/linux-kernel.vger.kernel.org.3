Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A783D46B1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhLGEVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLGEVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:21:14 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0958C061746;
        Mon,  6 Dec 2021 20:17:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p4so13475280qkm.7;
        Mon, 06 Dec 2021 20:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YRl2ZXrqWQRWseDojt6V5smgQ3LgIDm++24PeexJCQM=;
        b=Lw5uwm0Lkb+Ifzjbxr5aM1cC/nbRYHM4j/CCs7VwOAHgOqMDypStXHTHT3tanP1i6Q
         oR8Sn+0/a83VNIuZhKhSN/i4uU49bRc4lR7sE6LWO5QCzaugNqvVbJ0YAjoD2ab64nav
         WnsmNtu6aV8Ma5bj+dpFynKq0Fg1xEpWfD/O62/AcIldfkcN3vfRoLG7A1l07KQaD37d
         MdpfM0L/IDRcpHkRMdHk/jshanfyqMdlACyABb4xAbOpL3+9NOfWyUqIzJzOMMOA0NZq
         9kfmChFbF43pDhg+BeYLLzkp429yj0hMW0IviSXKqlCTUI6024bSZtnt4UP47iYZyxli
         etQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YRl2ZXrqWQRWseDojt6V5smgQ3LgIDm++24PeexJCQM=;
        b=NlLwUj7agWjHcxpEteYSgHhkFc897giz3EUc25A5+pHIj3TWAvs2L51C0oW0nCAfqB
         Y4yfnsh2xZmVmpVRqh4yZv2+H8Dh+vpo2D9ecqZttBeDo2Od9b/QsEHfuJSy2FMLYQd/
         buK94z3n80v0+/pULO7K966gRE53J3myUVlCDOFimW4KA5CX5f8jJFwMNOaL+ohqraVJ
         MJXJzrbsa4ZoKJ1B+H9QeaZFmfXbmwNQd0cTh3qNsWxvLYEGpG4vuEJ2okqj+VYdMjVD
         85I8uP+0upvHWgiYBZ5VN7YYiUfEQ7RgiODBlkwe4yfCEAybD2p/l6jkOmWkXQBUgbPk
         MTWQ==
X-Gm-Message-State: AOAM531VVw3us4yuxQ+vgT29CqiRvgZ9SJzZcnva4qVd9mBXROHhcyw7
        4L0ZliM7jcXBy03Hd0jcae0=
X-Google-Smtp-Source: ABdhPJyRKYxCqpH8fKePy1V8UM58DluAKxvPYfONURZjgXjq3d3mJCYdAVpIburVMndIEQIaQ8DzWw==
X-Received: by 2002:a05:620a:4587:: with SMTP id bp7mr37484919qkb.105.1638850663775;
        Mon, 06 Dec 2021 20:17:43 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q12sm8745004qtx.16.2021.12.06.20.17.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 20:17:43 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v3 0/2] This is a patch series for pinctrl driver of Sunplus SP7021 SoC.
Date:   Tue,  7 Dec 2021 12:17:43 +0800
Message-Id: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control
applications.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Wells Lu (2):
  dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
  pinctrl: Add driver for Sunplus SP7021

 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |  293 ++++++
 MAINTAINERS                                        |   10 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/sunplus/Kconfig                    |   21 +
 drivers/pinctrl/sunplus/Makefile                   |    5 +
 drivers/pinctrl/sunplus/sppctl.c                   | 1074 ++++++++++++++++++++
 drivers/pinctrl/sunplus/sppctl.h                   |  154 +++
 drivers/pinctrl/sunplus/sppctl_sp7021.c            |  536 ++++++++++
 include/dt-bindings/pinctrl/sppctl-sp7021.h        |  173 ++++
 include/dt-bindings/pinctrl/sppctl.h               |   40 +
 11 files changed, 2308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
 create mode 100644 drivers/pinctrl/sunplus/Kconfig
 create mode 100644 drivers/pinctrl/sunplus/Makefile
 create mode 100644 drivers/pinctrl/sunplus/sppctl.c
 create mode 100644 drivers/pinctrl/sunplus/sppctl.h
 create mode 100644 drivers/pinctrl/sunplus/sppctl_sp7021.c
 create mode 100644 include/dt-bindings/pinctrl/sppctl-sp7021.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl.h

-- 
2.7.4

