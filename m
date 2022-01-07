Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB69487C55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiAGSq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiAGSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26FCC061574;
        Fri,  7 Jan 2022 10:46:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso11359234pjm.4;
        Fri, 07 Jan 2022 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XB3qeJcSBcf8eMlXphifoGBmW/0nXSWJUuM6PxhB61Y=;
        b=gqglK9N7NIsjzh9fOC0WbaxR2rJcQ4cpFdn+N3B+VaQnr03ZwH7/818GkcX4KZoY16
         tnAHr6bF5ni7u5pi6/Dq2h6EMTjpbbFJFisBj+EEIK7oYy+TY79claJIfbZEL1op5+Nv
         IQrZ+TnYS8CAg2YW55LjHIJ5397SODhNI0k0aEGXAJFu6Nsu9U5gw3sODBBiQJR73VQS
         MUAAnS6bKly9zs0nHxP9qCGNkDJk7C+Up44cISI1SOjB/xecVfUqNpEBLB0kybUjqCcB
         ovH32HzaRMSGAPVL/d4TzmDdRRyKrxND8eJKWvxovIVw15ushuCaVa65HQgowm+DAUuQ
         OOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XB3qeJcSBcf8eMlXphifoGBmW/0nXSWJUuM6PxhB61Y=;
        b=LE6Hbc/3GCEpNEdsaYyiDkusrvjMcex4xWwKyMwce4NVD5tve7cSS/moJUnPLFef8V
         AVNeHvvoEnAzepeU9gvs+PvqA8c3ZqcS7xQ63XONa8OWsrQnCNoskOPuVNDQziWsPNyS
         WbI8t8iWAJjZ1RXMUNyc/GbI1eZtHxrXZUypvKDiRXYGmWIMtSJnQ7m1+MDpfL3wtf0P
         lsnKW+GUHkPR7DM9Zuyn32N8x309TRkTydAojDbmiAusjolsIXA+/461/je+2s7XcQCj
         oTnHg+F7Ip/WjgrYpUG9m/k8EOTCVYFJ9aXECbcCc3pBiQvoduWuh4UTz3dbMDkmHyJr
         DWrA==
X-Gm-Message-State: AOAM530DGT43PH78tHABGi/4PwLFx3b+sZVjDVzqHLsMzzwWNo40ZoER
        88GUw7BkWdyAbkjhB9+D3El+DvIKcHI=
X-Google-Smtp-Source: ABdhPJxMLXEYriYmlPKoBveSZPW5smrNCmITAocarOohLpy1timn0pdDfZwRwiMzquronYWF6W5MoA==
X-Received: by 2002:a17:902:db03:b0:149:50cf:d591 with SMTP id m3-20020a170902db0300b0014950cfd591mr65326057plx.112.1641581186055;
        Fri, 07 Jan 2022 10:46:26 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:25 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: [PATCH v3 0/9] BCMA support for brcmnand
Date:   Fri,  7 Jan 2022 10:46:05 -0800
Message-Id: <20220107184614.2670254-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for the BRCMNAND controller revision 3.4
embedded in MIPS-based SoCs such as 5357, typically found in the Netgear
WNR3500L v2 and other kinds of Wi-Fi routers. The upstream platform that
uses this controller is under arch/mips/bcm47xx/ and does not use Device
Tree (and probably never will by now). BCMA (Broadcom AMBA) is a special
kind of discoverable memory mapped interface which requires the use of
special accessors to read from/write to the hardware block.

The integration of brcmnand into that SoC is a bit quirky in that every
register offering byte level data about the flash (OOB, device ID, etc.)
requires byte swapping. The command shift should also have been 24, but
is in fact 0, took me a while to understand why no reads were actually
working because of that.

This has been tested with Linux 5.10.82 and Linus' master with OpenWrt
and confirmed that the squashfs + jffs2 overlay that OpenWrt creates is
entirely functional and that written data is made persistent.

Changes in v3:

- fixed a few typo/grammar errors in the commit messages, mention when
  changes are non functional changes
- removed the stray hunk in 2 to enable the static key

Changes in v2:

- re-ordered the patch such that the soc variable is initialized as
  early as possible
- corrected bug in the conversion of brcmnand_init_cs() which
  incorrectly used the wrong device_node variable (parent instead of
  child)
- took Andy's feedback to make the test for a valid interrupt to be > 0
  while calling platform_get_irq_optional()
- utilized static branch (disabled by default) and conditional
  compilation and confirm with disassembly that the generated code is
  as efficient as before if not enabling the BCMA shim and as efficient
  as possible if enabling BCMA shim
- updated BCMA shim driver descriptor, author and added helper function
  to encapsulate the container_of usage
- added comment to explain why a slightly different platform device name
  is used for the 5357-style NAND controller

Florian Fainelli (9):
  mtd: rawnand: brcmnand: Assign soc as early as possible
  mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
  mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
  mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
  mtd: rawnand: brcmnand: Allow working without interrupts
  mtd: rawnand: brcmnand: Add platform data structure for BCMA
  mtd: rawnand: brcmnand: Allow platform data instantation
  mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
  mtd: rawnand: brcmnand: Add BCMA shim

 MAINTAINERS                                 |   1 +
 drivers/bcma/driver_chipcommon_nflash.c     |  20 ++-
 drivers/mtd/nand/raw/Kconfig                |  13 ++
 drivers/mtd/nand/raw/brcmnand/Makefile      |   2 +
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c   | 132 ++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 160 +++++++++++++-------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  29 ++++
 include/linux/bcma/bcma_driver_chipcommon.h |   5 +
 include/linux/platform_data/brcmnand.h      |  12 ++
 9 files changed, 321 insertions(+), 53 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c
 create mode 100644 include/linux/platform_data/brcmnand.h

-- 
2.25.1

