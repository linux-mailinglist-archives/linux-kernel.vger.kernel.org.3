Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23048E73E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiANJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiANJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:17:48 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:17:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b3so3705709plc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJ9jWVX1cVZCB+AdFkPwR6feqDBzuwKx9n9aDB+L7eU=;
        b=I2yvcth0kmZOxW74KiHSV0WxKJxUyNqtsCVuC3+JWwo9CpTjnYKAhYjNx+JMQR2X6O
         zmb4ao5EvvaOvpoyaFAHNSWRRjyx3SgRX6Q6aQ6OWC/BiiHQBmJkXWjjlXlLF87LtJae
         vvSEtbNxr4E1hLssV3cz822trWugBc6hG1XiT81y9V/9gw5O99sLMFJ/PQbou4w9hMYm
         8caGnt1+98lhATlKi0v8eHzTWn9rY9KfvCCCNA7H4MwFsOMsBV+xvGJb02CL5qpvfiT+
         F5v53Ja4zmjWIZRLGGwxmh9oI8lnrhKnxcjtU0evKie/DiVDH69Ik/RzhRkA5/CtV0WW
         TbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJ9jWVX1cVZCB+AdFkPwR6feqDBzuwKx9n9aDB+L7eU=;
        b=zFkdKmgzUzOuX5c3vd1qWFhNst7eZrYOEeHL9FoTWlr1DRxXduVJ0+RBNEaJN9RA9U
         k08BfbQnEPzQpXo6hLL73fgWMiEmlX3a0azABEnc2JPY51YlhWN+G7CIqeyKkzY/WrOX
         uSCG4jZUfVtkYP2X/n6dtIMMW5Z62WHEcuqjKJEnssMHEWTsljdRZYjr8zVuQVEKcqBo
         fbtxuTcNX+2cc5LM1z05UT6qQFP0RhTR7M0b/E+SlOulEXp1WaZnZcLXvSTqX7JSrKHd
         boTfM9fiOc/NBeRy6AEX3u+3DkB7lGwCH4Zm4HjIqmfaAFWFC3/bDwo7aiTJEQ4fKL8u
         /J0g==
X-Gm-Message-State: AOAM531bxpGqOUCgWkANRVO0CyFcmg5tE3D7udLkZiz7k4iyFU0m77FR
        WL9KJ6JEZgr71Tv3dS500uvSmg==
X-Google-Smtp-Source: ABdhPJx75BSifsQTkjSXcEqinHM6jB1Blts8AJKZqvpt94lFvVTRer5DSG20FM2kQzE3HdQKFYRzWA==
X-Received: by 2002:a17:902:c10c:b0:14a:922d:39d5 with SMTP id 12-20020a170902c10c00b0014a922d39d5mr457595pli.66.1642151868162;
        Fri, 14 Jan 2022 01:17:48 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z3sm4237179pgc.45.2022.01.14.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:17:47 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/3] Determine the number of DMA channels by 'dma-channels' property
Date:   Fri, 14 Jan 2022 17:17:38 +0800
Message-Id: <cover.1642151791.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDMA driver currently assumes there are four channels by default, it
might cause the error if there is actually less than four channels.
Change that by getting number of channel dynamically from device tree.
For backwards-compatible, it uses the default value (i.e. 4) when there
is no 'dma-channels' information in dts.

This patch set contains the dts and dt-bindings change.

Changed in v3:
 - Fix allocating wrong size
 - Return error if 'dma-channels' is larger than maximum

Changed in v2:
 - Rebase on tag v5.16
 - Use 4 as default value of dma-channels

Zong Li (3):
  riscv: dts: Add dma-channels property in dma node
  dt-bindings: Add dma-channels for pdma device node
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  7 +++++++
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  1 +
 drivers/dma/sf-pdma/Makefile                  |  2 ++
 drivers/dma/sf-pdma/sf-pdma.c                 | 20 ++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++------
 6 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.31.1

