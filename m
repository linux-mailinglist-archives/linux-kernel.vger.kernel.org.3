Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3A47C09F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhLUNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhLUNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:18:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B59C061574;
        Tue, 21 Dec 2021 05:18:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E31E61599;
        Tue, 21 Dec 2021 13:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D14CC36AE2;
        Tue, 21 Dec 2021 13:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092685;
        bh=vo8HYA91fJrNzKCM3e/ChCv+UtZgf7w0ko3Vww763Ok=;
        h=From:To:Cc:Subject:Date:From;
        b=d1CD9eLSgsDY50iyZueLU7GJUc+oyul+BlDojq++kIC5nePz8yx/g72Tw1UNGVG+B
         uxFXucfCbEFxUh5o64+06pnL9DDe44Aphmahc+B+x2cLrFvBic87y7162RD9FQqF3q
         hQ6gulHE4ezkvJ72FoT+b1p4AmBf0XnWuYiznsved4kf0SbEvyQMERVgwVOJ8zSHzU
         lF7Etk6upTqlgqHi4ucMv3pJPYPfv/ANoDnq+pMSuzwjLNG4/2ez4c6vdM+wAPjket
         y2GuRLk0RwSBTNY9IBYFTqWm7cv/3Ifo2fIxCHhkK01R1lBp936KTxaFtRMdHWEpz9
         UI6FDxmWDobiA==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, miquel.raynal@bootlin.com,
        tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 0/4] memory: omap-gpmc: Add AM64 SoC support
Date:   Tue, 21 Dec 2021 15:17:53 +0200
Message-Id: <20211221131757.2030-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

TI's AM64 SoC contains one GPMC module. Add driver support for it.

cheers,
-roger

Changelog:
v4
- move compatible match table to header file so it can be used by
GPMC driver even when NAND driver is not enabled or as a module.
GPMC driver is always enabled as built-in.
- Select OMAP_GPMC driver from MTD_NAND_OMAP2 driver config as
OMAP_GPMC is not essential for ARCH_K3 boot.

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
  mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3

 .../bindings/memory-controllers/ti,gpmc.yaml  | 23 +++++++++-
 drivers/memory/omap-gpmc.c                    | 46 ++++++++++++++-----
 drivers/mtd/nand/raw/Kconfig                  |  1 +
 drivers/mtd/nand/raw/omap2.c                  |  5 +-
 include/linux/platform_data/mtd-nand-omap2.h  |  9 +++-
 5 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.17.1

