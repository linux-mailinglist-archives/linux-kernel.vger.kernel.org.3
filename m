Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50C247DBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbhLWAWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLWAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58497C061574;
        Wed, 22 Dec 2021 16:22:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p14so3047805plf.3;
        Wed, 22 Dec 2021 16:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P39LfhwxkLFrxQ44U3zppl8kfgBNoQrx/J3cE0xenlI=;
        b=K/Ez51dKunsJZ8vBNNFO3KebPxek8mDQ1hC0jf3nixqLPjV4dvpqWn8Iol3nWzoOzc
         pShPnKZ+mjHjBzTNuoKuH/4fto3jz7CtMOjb7vjU+BVTXHqBABOIIVAIlNjvSRngTsp7
         urJ3FfAkuIdI7c5z3QGDDqKghSqfKuoBxaNBUFvTAkeybXsowoL9lbaI/6pjDM4zkaNO
         xRGPZhsUH8Hw5uFesA/7isf1GiZehjH5e9IFpDhlZ1CYfs5onhvwYbeJlQw2IV8/jZL/
         bT7jvwTHYAhunzEdOVlqUcwG1iHuaa0uWeYTh4udQggFvrjcd4+t19ksmcyugT5wr9yu
         k0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P39LfhwxkLFrxQ44U3zppl8kfgBNoQrx/J3cE0xenlI=;
        b=qgVfmtqzeBHhGe+rWNH2GgMgWvmtXXuDn1YMDVqnGf08sTDwrh4grTv2GBfgiAHe8B
         cP96i40/fQjLuS0YoEP5tiTuGqpWCdj+cLUKsSd9/usv0AeSCoIZH+uhrCRsHCK3VXyD
         wLjHN6fXKeOtJ1DlnnjUo+PiiyF1FDwCog/LUYnkGSc0tsnoKV0AauINSXjPaD9QhvNO
         zeyuyojpdLirJcAw++eGB3jpZBWyQIt6Z7l68kPnl7CkkdM5gTc8oMjwm5CUquihk6Rf
         yOXXsgMKaT5pigS7SVYP0a76kQhTrT0vWnFPAReGuRY3agu6pFxuwGPzbbxgbXAjYSMU
         8cXA==
X-Gm-Message-State: AOAM530/WI+UlaB/gbckqOq1w4yHpbFB/04lPn4MeH0HjUidT8NHaUfW
        jUSAuLgIzLRxFzXGIXt/BVQ=
X-Google-Smtp-Source: ABdhPJzl57hPs6LxL73Za49Xak/ITCib73mzXMNU4QF6wDYyiYziBWC0LD2Xi3oGfVVURxLLs6ft+w==
X-Received: by 2002:a17:90b:3e8c:: with SMTP id rj12mr66383pjb.152.1640218950843;
        Wed, 22 Dec 2021 16:22:30 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:30 -0800 (PST)
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
Subject: [PATCH 0/9] BCMA support for brcmnand
Date:   Wed, 22 Dec 2021 16:22:16 -0800
Message-Id: <20211223002225.3738385-1-f.fainelli@gmail.com>
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

There are a number of open questions:

- the flash that is used is a s34ml01g100tf100 part which is said to be
  ONFI 1.0 compliant however the ONFI signature is not ONFI, but the
  device ID of the flash as if read with address 0, is that a known
issue?

- because no ONFI detection is taking place we fallback to the
  identification table matching, but there is no default ECC
  size/strength filed by the rawnand framework, probably made largely
  worse by the absence of a suitable Device Tree information?


Florian Fainelli (9):
  mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
  mtd: rawnand: brcmnand: Assign soc as early as possible
  mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
  mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
  mtd: rawnand: brcmnand: Allow working without interrupts
  mtd: rawnand: brcmnand: Add platform data structure for BCMA
  mtd: rawnand: brcmnand: Allow platform data instantation
  mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
  mtd: rawnand: brcmnand: Add BCMA shim

 MAINTAINERS                                 |   1 +
 drivers/bcma/driver_chipcommon_nflash.c     |  17 ++-
 drivers/mtd/nand/raw/Kconfig                |  11 ++
 drivers/mtd/nand/raw/brcmnand/Makefile      |   2 +
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c   | 131 ++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 142 +++++++++++++-------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  23 ++++
 include/linux/bcma/bcma_driver_chipcommon.h |   5 +
 include/linux/platform_data/brcmnand.h      |  12 ++
 9 files changed, 291 insertions(+), 53 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c
 create mode 100644 include/linux/platform_data/brcmnand.h

-- 
2.25.1

