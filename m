Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5897486E63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbiAGAOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbiAGAOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5888C061245;
        Thu,  6 Jan 2022 16:14:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so10320395pjj.2;
        Thu, 06 Jan 2022 16:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHp8KHmssnLYTaOK1agSupyvSqkjwpt0DTwhR+0qxuQ=;
        b=OXC+WfjOI7Dw/780ZlSKKOJzpuyxzgwPvAn3vd5y6IIL5/USBcS/+EaFEydk/P9fQW
         I8seI4B9zA0/MGxPODSkOM9ZDZRH+cO8KQ6b0oDrQXmRtDE/44L5wYuaL8ZxDwXL1G3K
         b3XBMgo5lMG9hXK0h5wObvGX5v+4NIBh7krq4ad1ieKoJ4O1jP44XxoEhjGH9jcwJwhz
         ty6BtKXTF2hpc/1tgHTjkmdSf8x0jYj8LiAj69jCG2AOoYo1Q2ZvMX496O7PmOjiBO3d
         CXkf7I9yF7IPB7Qo40feEfYj8pP6Qk3Qido+AHnwlFaM4t/7xP77Vr+tN10CWwrCcs2S
         m5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHp8KHmssnLYTaOK1agSupyvSqkjwpt0DTwhR+0qxuQ=;
        b=W6PyeQnI7bT3TaPL+fArsyh7GkTjV5XvwgDcj9uRqtGpWsHgYYKaGR0AW4D3ItVUKd
         wXwH/eFzblQjL1onUl2fFFzTv5g7+Q5OJin5s5polciu54O+BXKAQJTa7nnAEKUhuCT4
         DSzoj8LU+2d1ToNFJHfgw9vWfS7r9xMa22DX0JsCImDGztiGUjUbWUXhk144yTaO2QPy
         n/bPmvjwscmJi+TrcAbPJaRhNTGp/eaBrsfW2x5D5FgW0mXAegr3GPYQ0rcsdaUv+Olq
         0OuTYbNOjZ75+peZFWyT8RPszGK5splPzHC7aiQTUVDP78IJsglldZ1z9Bn2EoZKMpEr
         H5Hw==
X-Gm-Message-State: AOAM530zngTVuBHh8Bmjj+wj1M3tRVuyBg6xM5APjmRIz0/NrLbARa2i
        1a53bGryg1ZlY7MLV6hvPOE=
X-Google-Smtp-Source: ABdhPJxs5ngIS8diKlG5kij1EnlAAnRL98ICjCAo5rn2ZWpvA4FWNRG7fhGUSWexig/0VqQWjrMFHQ==
X-Received: by 2002:a17:903:300b:b0:149:f48b:e8b8 with SMTP id o11-20020a170903300b00b00149f48be8b8mr4420991pla.108.1641514441399;
        Thu, 06 Jan 2022 16:14:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:00 -0800 (PST)
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
Subject: [PATCH v2 0/9] BCMA support for brcmnand
Date:   Thu,  6 Jan 2022 16:13:19 -0800
Message-Id: <20220107001328.2233896-1-f.fainelli@gmail.com>
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

