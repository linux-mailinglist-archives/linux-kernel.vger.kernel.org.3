Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDAF47318F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhLMQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbhLMQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:21:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E3C061574;
        Mon, 13 Dec 2021 08:21:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso14410524wms.3;
        Mon, 13 Dec 2021 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Im6iY3zW0S0Z6ltWuhFASnUE80CMWPIOaX4Xrfe5xgs=;
        b=AuSxf0fGuCRBJ+mDDmtQsGcmHYcodcbO3B9ivjLVVJYvMZfb1/V3l1V2e9Ylj5scCR
         paUtofz2lJZrjW4BWweQB45k3mYI5odOSVqckD+7jkC8Et304ZLtL1Mn6VszYJnd4LC3
         b6leJiT67HK6TCBL5TjX7+AdAR51/2iffYubpZLzvDCJyv9PmZGpNDXAc2/+TH1XkW+r
         DeJrLqZxUuEsExzxwpNliGekmUIVCYPUhshzCIovc1+3cmHnsmP7I1BefWf05wkllS2r
         3CJ4HSlZzMxeCdUoVQIhXJxue+Cq846WI5p/s73zyfjjl7O2AgEHg5qGCN6tZvYZPxQL
         K5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Im6iY3zW0S0Z6ltWuhFASnUE80CMWPIOaX4Xrfe5xgs=;
        b=nO8d+3gNN+zRwfmg25vBCgg2eAppGSc4oa0hUdZVAf4rE6kgK809mH7315QtfX+WN5
         jAshsk9pb4NcxHV7Xs6bIKF4T6tt24sL06cRvaM///ebboV4DLi4X9Hc8eKAMJjwIgfJ
         cYLffZC1+nE0NAa/rkUp/FJZCGc8Ypxh7xB2mIqZNRzZzBjgE60lML7j9iPd+o+8nJIm
         y7S/IAuGlfOYHiNS2Uki3tV/bYhbn/aNC9HvYYUJoEy1xGwJPh+/2gjuN7Lr5AFDKROM
         JdIkySKxzcYOPdrtiHV5HqKYYYQSZRBO9CeIE0szcDNwQDQX2Y38/3jJSslQPXWG708J
         w09w==
X-Gm-Message-State: AOAM531BFIRKFp8qmw1M0WVB3qwAUi2buTV9twdp7RJ4fMbmLMB6WeeK
        /fRPDrMRMfoSNuVeOegtwGgQST9397Gc+A==
X-Google-Smtp-Source: ABdhPJwQkz5J2TdxFkzegnCdvNHrBVsEAf+K1U/6vtZFgNFlzWVQcsLDNVGBeeyWjk+r+1q1sMAsFA==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr38904070wmb.33.1639412514319;
        Mon, 13 Dec 2021 08:21:54 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id f19sm8391955wmq.34.2021.12.13.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:21:53 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] memory: tegra: Add Tegra234 support
Date:   Mon, 13 Dec 2021 17:21:45 +0100
Message-Id: <20211213162151.916523-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

this series adds support to the Tegra memory controller driver for the
version found on the new Tegra234 SoC. It is mostly similar to that on
earlier chips, except that the memory clients differ.

This also updates the device tree binding with a missing property and
ensures that all versions of the memory controller device tree nodes can
be properly validated.

Finally, the device trees for Tegra234 are updated and memory client
nodes are hooked up to the memory controller via interconnect
properties. Once the bindings are reviewed I plan to apply patches 4-6
to the Tegra tree.

Changes in v3:
- update commit message of patch 1

Changes in v2:
- addressed all review comments on the DT schema
  - most of the conditionals weren't necessary because I found out that
    all three generations end up using the same set of interrupts for MC
    and EMC and we were assigning them wrongly
- added one patch to fix the Tegra194 EMC interrupt

Thierry


*** BLURB HERE ***

Thierry Reding (6):
  dt-bindings: memory: tegra: Update for Tegra194
  dt-bindings: memory: tegra: Add Tegra234 support
  memory: tegra: Add Tegra234 support
  arm64: tegra: Add EMC general interrupt on Tegra194
  arm64: tegra: Add memory controller on Tegra234
  arm64: tegra: Hook up MMC and BPMP to memory controller

 .../nvidia,tegra186-mc.yaml                   | 98 ++++++++++++++++---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 57 +++++++++++
 drivers/memory/tegra/Makefile                 |  1 +
 drivers/memory/tegra/mc.c                     |  3 +
 drivers/memory/tegra/mc.h                     |  7 +-
 drivers/memory/tegra/tegra186-emc.c           |  3 +
 drivers/memory/tegra/tegra234.c               | 81 +++++++++++++++
 include/dt-bindings/clock/tegra234-clock.h    |  9 ++
 include/dt-bindings/memory/tegra234-mc.h      | 32 ++++++
 10 files changed, 280 insertions(+), 12 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra234.c
 create mode 100644 include/dt-bindings/memory/tegra234-mc.h

-- 
2.34.1

