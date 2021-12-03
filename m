Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6844E4670E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378373AbhLCDwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhLCDwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:52:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23253C06174A;
        Thu,  2 Dec 2021 19:49:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id iq11so1327499pjb.3;
        Thu, 02 Dec 2021 19:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KgfSCFQ7JrRVIZuvjzUnHetvB78ohW0lRAXIwauhI78=;
        b=FS/ctSLtrmX57aIo3OO8dWoQ4ze14a67gQ0QTGyf+nTmkpxSg+0zNSZClT9+DSWJBo
         mmW9mrRs+1mH3Yrb6Ts7PKgX3fjZSaRpm2fQkrgZz8ApdzZCoOF8Xxw4J2X2xfRO9xA9
         6WXZ/yRG8AAAkp4of1qcEJk5T2p2AN7DTbXdofdxCgcnvDIp8Jn8PPShLPb7tWKdlOWz
         Aa6I53pI40QI0Lp64XkHSEcUoFSza3Sxo/5u2vLvrxl1+F5C3FcS9heqAxr2m7Ys3u7z
         UtIPpfae+DfVEThAPsihADc3Dj1OUqfE2+DDO9Y9gBehr2VFVhhsnQF1Zdj1zcxkm3rZ
         /bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KgfSCFQ7JrRVIZuvjzUnHetvB78ohW0lRAXIwauhI78=;
        b=FyRjmuTaOZ4A791e8jAg982tbhUyfcD1/dylu0lw8zkURzHk5GsS/Bf4wkWwI4LZvb
         5DIMFsBcnJLzH75yuHbTtA3AdOH3XBL3FibxzCKeWUH0hxed1honmXT6J4rYvYH4+kxI
         vnWA3HDh33YMMOXoXVpBpt5LCbUaedu79Pmjjxg387LLi0YdIP7kbLmVGNCfWarGSLRj
         m0q/Ju0kRUdT1aCw0JBZkj2dL6eC1/RP92GjI+yWiSEo8iVOTPKkdr14+VShmOHu3Njg
         j1Ylvxp9pGO4vpuEj0Q4LTgroafFjD+UVoohsw95Q3rvjS2V60lzrXUdg8q2PrZnW4DQ
         7dzw==
X-Gm-Message-State: AOAM533gviVTfZYDjj/c0UrRhR2DFthyjXa4jJFBGW/LTjI+i5bskR13
        RH6Nbpjbi4kyq+3bwM3JjOk1LDX0aWo=
X-Google-Smtp-Source: ABdhPJwEqWxnY9d6WkCi+w8POsGw9vrSJ0ESsJ3uocGdLsX1WFdcewhjoNAmnXbNsSfbjIlUu8lTxw==
X-Received: by 2002:a17:902:bd88:b0:143:d318:76e6 with SMTP id q8-20020a170902bd8800b00143d31876e6mr20000523pls.66.1638503353711;
        Thu, 02 Dec 2021 19:49:13 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oj11sm4022039pjb.46.2021.12.02.19.49.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 19:49:13 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v2 0/2] Add iop driver for Sunplus SP7021
Date:   Fri,  3 Dec 2021 11:48:43 +0800
Message-Id: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
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

 .../devicetree/bindings/misc/sunplus-iop.yaml      |  61 +++
 MAINTAINERS                                        |   6 +
 drivers/misc/Kconfig                               |   1 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/iop/Kconfig                           |  13 +
 drivers/misc/iop/Makefile                          |   6 +
 drivers/misc/iop/sunplus_iop.c                     | 518 +++++++++++++++++++++
 drivers/misc/iop/sunplus_iop.h                     |  64 +++
 8 files changed, 670 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
 create mode 100644 drivers/misc/iop/Kconfig
 create mode 100644 drivers/misc/iop/Makefile
 create mode 100644 drivers/misc/iop/sunplus_iop.c
 create mode 100644 drivers/misc/iop/sunplus_iop.h

-- 
2.7.4

