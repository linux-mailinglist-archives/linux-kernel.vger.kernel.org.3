Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8248A9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348995AbiAKIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348971AbiAKIvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:51:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16125C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:51:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so4593935pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CyD9l+2ezhf6QjDxxdO63hYLgAiFV1ZYCShhusA3Zc=;
        b=EQGDnRWIzVflvRC1LoZBEca5vqEcilEfPy7CnUu3mLOtpkgy6w5pKahNh//E5U3xfQ
         crvEswdn9+Jw2nKpYnT1laOXAsAHj+ZsDHWXcC39ec83ibeSMG19vP1c8eGcX/PSrm0B
         xWWSpl3a6wyNpRIl+61dCj24l2FvXfWQLWevlOAfje9O4ZMVbw6yYNFEPn89DJjg3eFo
         1wNVB9CBl9AFVAqxt1zDYzGICrZ4TKipIqU+2hDijnAK3GfZK7AiZ6+uBelBctFUN0wQ
         TX72hOMnbXnfHv316neSjDGnMl7KvIOiyovEZX3g9mnj+HGM+FS9atoldU5UeFftMSwQ
         fAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CyD9l+2ezhf6QjDxxdO63hYLgAiFV1ZYCShhusA3Zc=;
        b=WM6JVfMh8n5UnujkpmFkTc03wFAhJ5YJu8tLmYxbgZmy238U6dZeS5jGJC5LtN6pcf
         7NTpmTvivnriAvyu/p/MSBUJKhYG4Lv65XnQayYBQJmKW2QmHwfliKqx9iaVGJjMgjxl
         Xlrutudm6s9xV9eTJQxgk4rppIPfNg0Qcu/dAKbQRvou/1OGeXKzLOdsEdiZVaSmonR/
         9B00wSVsOQMAwgzoZQZBMPNgZ5OU9zyOxYY+KBsbEp0Ezzh/BfUBGXCZJf3rSW2aEHZ3
         dkeZfUC5YIQht31RV/5ZvlWEJTNcjnr4IFVkUPr3GgjTPi+XPxCu2cDVe9P+enzdmE8D
         RYYA==
X-Gm-Message-State: AOAM531OYDfPxpZppNkTb17SWA4xmgNivujol7L1lB3kD6nSrAbI+qbl
        QxtlAcvEYq/pj22qnPsFPVSwCpBr7WNhFc5T
X-Google-Smtp-Source: ABdhPJwD+RQbLIRJC0BxCTDAflnidt5/NwF1Mtjccg6WfBOp5jBUvuu24w0KyQxWVGPNZVnK8Oba1w==
X-Received: by 2002:a63:3e81:: with SMTP id l123mr3215398pga.41.1641891098542;
        Tue, 11 Jan 2022 00:51:38 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j4sm9447598pfa.149.2022.01.11.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 00:51:38 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/3] Determine the number of DMA channels by 'dma-channels' property
Date:   Tue, 11 Jan 2022 16:51:24 +0800
Message-Id: <cover.1641890718.git.zong.li@sifive.com>
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

Changed in v2:
 - Rebase on tag v5.16
 - Use 4 as default value of dma-channels

Zong Li (3):
  riscv: dts: Add dma-channels property in dma node
  dt-bindings: Add dma-channels for pdma device node
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml      |  7 +++++++
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi |  1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        |  1 +
 drivers/dma/sf-pdma/sf-pdma.c                     | 15 +++++++++------
 drivers/dma/sf-pdma/sf-pdma.h                     |  8 ++------
 5 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.31.1

