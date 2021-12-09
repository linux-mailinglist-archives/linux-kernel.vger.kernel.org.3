Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8246E50C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhLIJJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhLIJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B75C0698D2;
        Thu,  9 Dec 2021 01:05:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F8BEB8235A;
        Thu,  9 Dec 2021 09:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6161DC004DD;
        Thu,  9 Dec 2021 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040704;
        bh=+Uks86XpZtorbWZGFtvvEcGW8QVq+3G7N42yvIktwrk=;
        h=From:To:Cc:Subject:Date:From;
        b=NC0kBq1IL64fhjw5ghq+QUvQD5x9SwnDRKPAyQUo5W5qHuoLfeo1+Ji1fUCzyW0WM
         UsxydwVmeMN4ane9FpvxnabG/7ng4GFZ5drHA/qeEzUD2+2Vi+VipaKucXLi3btwhV
         EjG+eXYXYPyZEIqO/YoP+vGgDangZPKj1Lp+aeavV0Ql7fGMyDGZzX7G8R7IE0zeSO
         ZGlvrFGEi+Y2f4f+wdJH3G7uPqfyqOUn0T0IXs29LjhdbZqJz3IZ82DKRjPLnhv4Zb
         9m7Y2+6gCpR+HW62QBjhi0ziZsiZ20P7mj6du4kW7xNoIhvB+28iFTVdGmcoMhq5hz
         G3IZe0IoHb7qw==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/6] mtd: nand: omap2: Switch to exec_ops, support AM64 SoC
Date:   Thu,  9 Dec 2021 11:04:52 +0200
Message-Id: <20211209090458.24830-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series gets rid of the Legacy ops and switches to exec_ops framework.

Also add support for TI's AM64 SoC which contains a GPMC NAND controller.

Changelog:
v2
- Dropped the quirk code for AM64 SR1.0. Will add this later when
there is more clarity on compatible ID that will be used for this SoC.
Production version of AM64 SoC shouldn't require this quirk.
- Changed commit message title to "mtd: rawnand: omap2:"
- Added 2 new patches.
	1) fixes force_8bit behaviour for DMA mode
	2) drops unused variable

Roger Quadros (6):
  dt-bindings: mtd: ti,gpmc-nand: Add compatible for AM64 NAND
  mtd: rawnand: omap2: Allow build on K3 platforms
  mtd: rawnand: omap2: move to exec_op interface
  mtd: rawnand: omap2: Add compatible for AM64 SoC
  mtd: rawnand: omap2: fix force_8bit flag behaviour for DMA mode
  mtd: rawnand: omap2: drop unused variable

 .../devicetree/bindings/mtd/ti,gpmc-nand.yaml |   5 +-
 drivers/mtd/nand/raw/Kconfig                  |   2 +-
 drivers/mtd/nand/raw/omap2.c                  | 503 ++++++++----------
 3 files changed, 226 insertions(+), 284 deletions(-)

-- 
2.17.1

