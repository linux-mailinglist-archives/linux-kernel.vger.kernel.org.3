Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2007C470626
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbhLJQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbhLJQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B23AC061B38;
        Fri, 10 Dec 2021 08:47:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7535178wmh.0;
        Fri, 10 Dec 2021 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Jrp+PC6nh+B8tJ4czKe4KozPT/uVhH3uHLrtpfR12c=;
        b=ULB7XspqbV+izGB2QsP3x67SBC9oE5UcSrGD2Ef93/yVfF3gqEsU4hIAsVLgVEOZMP
         ql7s4a6ecgkbZre9CdF87TJGJ9QkmZ/HACyH51Cwkxfs4eoSE9IvbZGiETmsb5XVps8u
         DsY66pOO0FSzaLTqnAoxpZ5xttjIXSqP+pBVEO+VRWmnO5qHY+0KJ79zT6i1XBHPf2Lr
         7W+s1U1FoZEPuHd9gKSx/9GWBfW6JsLenxMHkIgOBjtQfWYjFKqKsOnXeMl+AJftG4q5
         +K5sQr1fbbnQetJsKhbrTJw4m4JEGsWaxUZbZelHPYtCBsoe/1vr9d7EsejkJ4gWIXuD
         Q1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Jrp+PC6nh+B8tJ4czKe4KozPT/uVhH3uHLrtpfR12c=;
        b=yePZyNesfWHHHe3RJAwaHsxda0NRoemnRtLeX3ZjEenByL3x2d3lkzcV4x7Ya6hE0B
         oIbzcBUuSDse5msteHzVrBDNUnIGDMN/EUkTt9zNE5jaNvJbNV4vr4+cdfVv3PDLU1/x
         PfkL9l5hAMpgDO/dTNTDuLd+pun6cBk1EdmNq4onRjWWLsgCTuhcCFI9C5R60s/1/vhx
         jhn3d8FZC41IcYddtyMviCqDsX9Vkg2nU1EFPPQhBSbc7s5zZ23d8/xsigSVQIFx6/iP
         VUKXK2ot1Uwfyw1YAaYl6IXA59/7J+sVHbFSKYsiQPC/JuNhfQNFod0bnuoRWc1eWy5v
         3fbg==
X-Gm-Message-State: AOAM530urhZDRhzPiSt/+5yvsAhjW6Ejz+1GcMR7AfR2SZQ/d//CPgli
        UeUZTSo6+q/Ou6egdq1q4D4=
X-Google-Smtp-Source: ABdhPJwRfHF5Zzx7y1/PbeYUyvlfFRHaXGKWeu2uleV+ynQgU3DoNZqjWlxl5xFGumphqa8ztrp7Cg==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr17662710wmq.22.1639154863807;
        Fri, 10 Dec 2021 08:47:43 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id 9sm4142515wry.0.2021.12.10.08.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:47:42 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] memory: tegra: Add Tegra234 support
Date:   Fri, 10 Dec 2021 17:47:35 +0100
Message-Id: <20211210164741.881161-1-thierry.reding@gmail.com>
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

Changes in v2:
- addressed all review comments on the DT schema
  - most of the conditionals weren't necessary because I found out that
    all three generations end up using the same set of interrupts for MC
    and EMC and we were assigning them wrongly
- added one patch to fix the Tegra194 EMC interrupt

Thierry

Thierry Reding (6):
  dt-bindings: memory: tegra: Document #interconnect-cells property
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

