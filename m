Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D875F4965AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiAUTfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiAUTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0351FC06173B;
        Fri, 21 Jan 2022 11:35:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso28559091wma.1;
        Fri, 21 Jan 2022 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OG5i1U75JFlGEp4vAP5hCTScqw6mwFeMzIFBq2Z1cfw=;
        b=m02Lkjdhv80VuCwMmiK7vgoUvaXS40pRgrTKEN6fEHyaqxZ6LWpVTn2sDesVjrNKyt
         eBRgYP8VATt2Vxy8pMNZP3vbzgQgDxPIYD1gTpCoN1APiqL/14WqnpMy8pfcgPx1AhXD
         14GG38V8pJLhflytCOevs0sCdDqFhNdTXi73Ba9r33HfUwB5IPCxCoxkXZRdCNk7S+rU
         Y41cb80GbS8GPt7BTmeJfsLJC1y9lRMZGE4x1yP1ohPr0cyd9IriqBcf5MBm35bWra1Y
         stIoY39m3P5bETrJGeyViTC4NML4R+yiCFQrSppiUwy2M1qV4bN+K7kvK8o6HZ3DTTBm
         p6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OG5i1U75JFlGEp4vAP5hCTScqw6mwFeMzIFBq2Z1cfw=;
        b=AnLrUANtDVnldOkkD4mamQytUepKMk03rcKKtRklZzQc9G2X4/qkN4ERbiGpO2OvJ+
         9c+bwDhUrh5ToExnFvbgjGv+1lx1hvR7M/xT7JrTiZM5Ha6/M6W5QU5BVhipAnzJiIP0
         MZfKwCkOohVcHTgRDr1Y5GAuOocDdl2ExjOwqf6UuXt9L7BlNUkijDA2iiY1UDYW/hfR
         iyLOix5CbLZtgxNkj3Wol2B9ciMbl8FBnLpM1xmyTKZ3LI9OKUwbTlipkvO3tFKpFKBA
         gDm1g5Lpj7kHnutT0YeOVLhJnkiqUtg19Y5TogJrK+PPKxwRI3g27QpwdGg78wHe93ZC
         egyA==
X-Gm-Message-State: AOAM531drI3azkVR6ZvJcu4VWOdWh1D3pS1ppNLc7nap7cd++qFWgOH+
        0Vo6lYAvsxCBFfV4DX1kwkwWmPVZv+kkvA==
X-Google-Smtp-Source: ABdhPJw+2RKyMVqaHbLpTxd5iL40TOcowFWOfAIbNkFsfqxSc1E8Ptqj7zKspbq4dYYlHa4aa2XBEg==
X-Received: by 2002:a05:600c:5028:: with SMTP id n40mr1972112wmr.10.1642793749133;
        Fri, 21 Jan 2022 11:35:49 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id z1sm11473860wmk.32.2022.01.21.11.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:48 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] ARM: mstar: cpupll
Date:   Fri, 21 Jan 2022 20:35:35 +0100
Message-Id: <20220121193544.23231-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a basic driver for the PLL that generates
the cpu clock on MStar/SigmaStar ARMv7 SoCs.

Unfortunately there isn't much documentation for this thing
so there are few magic values and guesses.

This needs to come after the MPLL DT changes.

Changes since v2:
- Re-ordered Kconfig by name
- Re-ordered includes alphabetically and removed useless ones
- Used timeout for cpu_relax
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_frequencyforreg()
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_regforfrequecy()
- Reduced the number of lines for msc313_cpupll_of_match
- Removed CLK_IS_CRITICAL

Changes since v1:
- Re-worked the series and ensure that 'make dt_binding_check' passes.
  The required commit is merged now, so it is okay.
- Fixed coding style issues in the driver and makes check_patch.pl happy
- Added one more commit for extending the opp_table for infinity2m.

Daniel Palmer (8):
  dt-bindings: clk: mstar msc313 cpupll binding description
  clk: mstar: msc313 cpupll clk driver
  ARM: mstar: Add cpupll to base dtsi
  ARM: mstar: Link cpupll to cpu
  ARM: mstar: Link cpupll to second core
  ARM: mstar: Add OPP table for infinity
  ARM: mstar: Add OPP table for infinity3
  ARM: mstar: Add OPP table for mercury5

Romain Perier (1):
  ARM: mstar: Extend opp_table for infinity2m

 .../bindings/clock/mstar,msc313-cpupll.yaml   |  45 ++++
 arch/arm/boot/dts/mstar-infinity.dtsi         |  34 +++
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |  17 ++
 arch/arm/boot/dts/mstar-infinity3.dtsi        |  58 +++++
 arch/arm/boot/dts/mstar-mercury5.dtsi         |  36 +++
 arch/arm/boot/dts/mstar-v7.dtsi               |   9 +
 drivers/clk/mstar/Kconfig                     |   8 +
 drivers/clk/mstar/Makefile                    |   2 +-
 drivers/clk/mstar/clk-msc313-cpupll.c         | 221 ++++++++++++++++++
 9 files changed, 429 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

-- 
2.34.1

