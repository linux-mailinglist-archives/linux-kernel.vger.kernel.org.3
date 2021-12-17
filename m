Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6E4788DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhLQK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:29:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhLQK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:29:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F52620DF;
        Fri, 17 Dec 2021 10:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C71C36AE5;
        Fri, 17 Dec 2021 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639736993;
        bh=LQW2iN/F88V8QJ4GnjyQwejxKciaJmiygv2S85Wv3NY=;
        h=From:To:Cc:Subject:Date:From;
        b=D2ZQaRw53MQ6Ri8pkha5li384aWkEDSo3rX4SSuBvIajspvu8G07UqRCRVQqWsjOr
         XYcn1tKrIK2SX+lQR79b129tTnwtafFJQYL/F1ydRcUZbLNcCEUiTRLWZBjWmvcZY8
         fPZ5EDSBJhPUzLQPeX/QVBs3Fgh7UFsIcWt2l3iOEyWvfH4RNOwYV6om9QHtrw1uey
         aAC0NeomvYVBuPMSZA25kolhN6mTHj9UeyGMDiQhF1gn1zRZVGvU1zCby/S5OVM9gE
         2Q+OCBFjW3wurG9WI5nFpa6GtcDbOCO4Sb1vLzv9C6WKRAvMRvSsrWPE6AwB27zBAQ
         YZQ9ToMM+Zruw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/4] memory: omap-gpmc: Add AM64 SoC support
Date:   Fri, 17 Dec 2021 12:29:41 +0200
Message-Id: <20211217102945.17432-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

TI's AM64 SoC contains one GPMC module. Add driver support for it.

cheers,
-roger

Changelog:
v3
- use compatible match table for checking for NAND controller node in
GPMC driver.

v2
- update DT binding doc to make reg-names and power-domains property
required only for specific SoC.

Roger Quadros (4):
  dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
  memory: omap-gpmc: Add support for GPMC on AM64 SoC
  memory: omap-gpmc: Use a compatible match table when checking for NAND
    controller
  arm64: arch_k3: Select GPMC device driver

 .../bindings/memory-controllers/ti,gpmc.yaml  | 23 ++++++++-
 arch/arm64/Kconfig.platforms                  |  1 +
 drivers/memory/omap-gpmc.c                    | 48 ++++++++++++++-----
 drivers/mtd/nand/raw/omap2.c                  |  2 +-
 include/linux/platform_data/mtd-nand-omap2.h  |  5 ++
 5 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.17.1

