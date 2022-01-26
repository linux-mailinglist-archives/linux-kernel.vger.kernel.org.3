Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469FA49D131
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbiAZR4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiAZR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD4C06161C;
        Wed, 26 Jan 2022 09:56:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e2so448276wra.2;
        Wed, 26 Jan 2022 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5baoSdfR6Wb5YhH5TY8BNXC9G0PE57DX3KVy6O/p69w=;
        b=Y8k+nfZQK49z42LeGxxvDz7K+E4+f0h3KxARmxK71A5rQTMtCdK0msenByUwTqkRg4
         8rHxRx+qv6kTZqWvk1+U9KmtAWRMmkFusYTz/UR54Mwa7nU2DwgodWREyHGRUUnJUTfC
         hLYEoCQqk0HKNNQrZIinorlZ3HE3jKytpoQJNkVdSmhoR2ee3Pk/A0Xjg6XK1ObYjQAo
         TK29hi7xxrvcT+B4Gune4Mgb6WtPkBy8YrM5uklIEqjF/CLczrMQMEOnq+yOXZq/1hFp
         Mnvrn45rCeviX8e+kH0WDpndMpnJRvZQk4IotOhO8yZ5z6rUG08a7ECn9xq5oM0wR2e+
         JOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5baoSdfR6Wb5YhH5TY8BNXC9G0PE57DX3KVy6O/p69w=;
        b=C8oQ8m776UWQRiNC+UEz5Nw89vYkejrg2Emm2tH2C0kIKx5J3JUUPa86KMyARltOIL
         BNdg39V2JhamoFwafki1CJPs9ILGHA6R2pz7Ylk2H0cC43WyRiyd1jMhikLKS+VZVHIh
         zVO3gnyLwGSN7yCeb8yXC0EaDntwmwQL34YDIFrt1rcRGfEkqI1jIC9zqP2xqecJ2LXC
         Ij5onc8YC3fNr6iHf5KoNSMOnqnRp9Xujut6XVWmYe1NS+xq1zxY5Q6XETpxi/ObWz33
         2RvI4Ht6R11fvciHbWlfqztnlqSiNCk1yRz4a9hrGSk3VMsTNlC45iQK33HovpEaDcQd
         ncXQ==
X-Gm-Message-State: AOAM532qIyYvvUNAy9tGRCNj38Hiqhy7+wIEjeqPeYlgFz0Fdd6Zebe0
        1lLr4HaD6WRMkbEbwFl9bWNjbsTrH8uH6Q==
X-Google-Smtp-Source: ABdhPJzPFbDjAAEwAau+zswAEibaH6WRbhH01ffoJcxpYb6CahmoWm8iI5+83v8YWYyKgFYR0Vyvig==
X-Received: by 2002:a5d:6309:: with SMTP id i9mr23224155wru.515.1643219772291;
        Wed, 26 Jan 2022 09:56:12 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l4sm8853917wrs.6.2022.01.26.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:11 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] ARM: mstar: cpupll
Date:   Wed, 26 Jan 2022 18:55:56 +0100
Message-Id: <20220126175604.17919-1-romain.perier@gmail.com>
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

Changes since v3:
- Added Reviewed-by on Daniel's patches
- Removed "[PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5"

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

Daniel Palmer (7):
  dt-bindings: clk: mstar msc313 cpupll binding description
  clk: mstar: msc313 cpupll clk driver
  ARM: mstar: Add cpupll to base dtsi
  ARM: mstar: Link cpupll to cpu
  ARM: mstar: Link cpupll to second core
  ARM: mstar: Add OPP table for infinity
  ARM: mstar: Add OPP table for infinity3

Romain Perier (1):
  ARM: mstar: Extend opp_table for infinity2m

 .../bindings/clock/mstar,msc313-cpupll.yaml   |  45 ++++
 arch/arm/boot/dts/mstar-infinity.dtsi         |  34 +++
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |  17 ++
 arch/arm/boot/dts/mstar-infinity3.dtsi        |  58 +++++
 arch/arm/boot/dts/mstar-v7.dtsi               |   9 +
 drivers/clk/mstar/Kconfig                     |   8 +
 drivers/clk/mstar/Makefile                    |   2 +-
 drivers/clk/mstar/clk-msc313-cpupll.c         | 221 ++++++++++++++++++
 8 files changed, 393 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

-- 
2.34.1

