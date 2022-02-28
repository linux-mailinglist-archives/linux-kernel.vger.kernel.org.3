Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520C4C71DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiB1Qol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiB1Qoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:44:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71B66620
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:43:53 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA9BA3F1BC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646066630;
        bh=gE15medms+dcFLhUfTRQwmk+TxzLnB5fCbYsKe2ucaY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=mmDEz2QIYYnoPzKsSGbAsCOMpJjIvULAeLkhWbhnMDWR+LkEn+mNsYrZo54yTPFuN
         mLcPygQElR1FijLplPU9MgXQEc7V/xorzfQWthxGupvrRgjRaKpPbWL+YwmXNqU5WV
         KvBf8LryN0xEpKgf4fQuw++1pGltHOi0W7UO8nawTwtEZ+Qth756VT8GI4g7qP7Rbq
         eq862ATW0AerPhFFr2cuKBJ9YHTvays4yo2J00pDWryiNp+9D9LhVaiK5Z2s5FIF4E
         0uf1ZNJPiplLBvwyeFgtQAcTSGUWBulxika0OhsOuiBTZuQ5n0EsjVLFJwTfTY/S/f
         dnQAMvOEmPXpg==
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a056402358a00b00410deddea4cso6202110edc.16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gE15medms+dcFLhUfTRQwmk+TxzLnB5fCbYsKe2ucaY=;
        b=OLKlLBIyPCe2TftFn6RvxlmiSPw4huJ0F13rvstXLAAlOzfFeCuRibz/eOyCU4BroZ
         0UZAQTT0Mn0G/GD4kGiEhCl+6rV3WHW2N9oy72IyLYnK4/lkZN1wgtofYp5nISo2+Zrc
         x7BxzC9pdBQW4sKkkqJXioVBUqNY7xOCohrwwSrbbf3RLv66qDPiXtJMJYCubjYPPacO
         U7QMzesHLu5GWJ/BmfttGV+8uqa/X+JOnecWifmeM+hflcdz7/ZPBWZtdiqgWMHuVMOr
         /O4s/D7lU2Fp+wOJirc1YheNZO5aC8l2tLbwE98psNIOuAf2JQA+s74uDWXEHi0Y3CBb
         nioA==
X-Gm-Message-State: AOAM530ktTZB1GvUzW6th0goqgu/8RtR9+5CopSwhVT1dwdQVxTHnsZD
        Ruf4DDooA/DHJf9BNAkaFoBFti/+DKfQedPam91VGGfXMgGex0vs82z3L29ahGT5HLHcWIiExeN
        0AuS9/aS3PeYCbZVM7ANZfu416BcaVwf/KMY9EQl5CQ==
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id zl19-20020a170906991300b006d6dc485d49mr1267932ejb.325.1646066629083;
        Mon, 28 Feb 2022 08:43:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvgO7T3AJwoWB3HdfOSCHyLbt2ivWmDE1hFrSwuA4eK+KgA+RepfnF6kO6p/dK+dBivHS05A==
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id zl19-20020a170906991300b006d6dc485d49mr1267910ejb.325.1646066628836;
        Mon, 28 Feb 2022 08:43:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b006cdeef01456sm4498443ejb.163.2022.02.28.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:43:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] memory: drivers for v5.18
Date:   Mon, 28 Feb 2022 17:43:11 +0100
Message-Id: <20220228164313.52931-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes the material which missed v5.17.

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.18

for you to fetch changes up to a06bf59d07f45a0a6ab4ab8ac69c1d708d3fadcb:

  memory: Update of_memory lpddr2 revision-id binding (2022-02-25 13:36:49 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.18

1. Minor improvements: Mediatek SMI, Freescale/NXP IFC, Tegra20 and
   Tegra30.
2. Convert Freescale/NXP IFC bindings to dtschema.
3. Convert LPDDR bindings to dtschema.
4. Adjust revision ID property in LPDDR2 bindings to match LPDDR3
   bindings.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      memory: mtk-smi: Use ARRAY_SIZE to define MTK_SMI_CLK_NR_MAX

Jason Wang (1):
      memory: brcmstb_dpfe: fix typo in a comment

Julius Werner (2):
      dt-bindings: memory: lpddr2: Adjust revision ID property to match lpddr3
      memory: Update of_memory lpddr2 revision-id binding

Krzysztof Kozlowski (7):
      dt-bindings: memory: lpddr2-timings: convert to dtschema
      dt-bindings: memory: lpddr3-timings: convert to dtschema
      dt-bindings: memory: lpddr3: convert to dtschema
      dt-bindings: memory: lpddr3: adjust IO width to spec
      dt-bindings: memory: lpddr3: deprecate manufacturer ID
      dt-bindings: memory: lpddr3: deprecate passing timings frequency as unit address
      memory: of: parse max-freq property

Li Yang (2):
      dt-bindings: memory: fsl: convert ifc binding to yaml schema
      memory: fsl_ifc: populate child devices without relying on simple-bus

 .../ddr/jedec,lpddr2-timings.yaml                  | 135 +++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |  23 +-
 .../ddr/jedec,lpddr3-timings.yaml                  | 157 ++++++++++++
 .../memory-controllers/ddr/jedec,lpddr3.yaml       | 263 +++++++++++++++++++++
 .../memory-controllers/ddr/lpddr2-timings.txt      |  52 ----
 .../memory-controllers/ddr/lpddr3-timings.txt      |  58 -----
 .../bindings/memory-controllers/ddr/lpddr3.txt     | 107 ---------
 .../bindings/memory-controllers/fsl/fsl,ifc.yaml   | 113 +++++++++
 .../bindings/memory-controllers/fsl/ifc.txt        |  82 -------
 .../memory-controllers/samsung,exynos5422-dmc.yaml |   3 +-
 drivers/memory/brcmstb_dpfe.c                      |   2 +-
 drivers/memory/fsl_ifc.c                           |   9 +
 drivers/memory/mtk-smi.c                           |   3 +-
 drivers/memory/of_memory.c                         |  29 ++-
 14 files changed, 716 insertions(+), 320 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
