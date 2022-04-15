Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB9502106
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349211AbiDODv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349182AbiDODvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:51:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B53E82330
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:48:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id n22so6098580pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+p+/01zxqSUmc6ocw4hobbam8/tbNCsFI0sQ5YC4a1o=;
        b=iWMuBihF5xt8NwSbSJXQmQRmR9K/JYLnLbu2vvdWN3LXf38vGqAVI1VYyKb9s7MqzZ
         QyG/PA5W5hEvs/llIv5J41xLaBXmcHIqaL3bQDVkMD2HD+CpLnzAktei/Bxpea8EImyM
         d8kJdgoklat8d3r7qD/a9Ph0ubol5pDCcJ/+v0FBfIBISAdANwNjN47uxMc9pBevjKt1
         +rp8LsVnGBNn0lvHuhz6Z8AroKSh2kG2i4sOSD9jRRYKTng4umA0x5Ls42fv7cXPA40b
         IdPukn6F+CCn54oub7WMeZX4O7ZgeHFzJ6znw1mEgppBXhr7LvTxPhLRyMteOCvYO5O0
         iUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+p+/01zxqSUmc6ocw4hobbam8/tbNCsFI0sQ5YC4a1o=;
        b=g3t8ynIsIwF89XR2e/ngxps5rxJjU1S4aTrpj/mVJLRjEHT2Qk9TsRM4Ln6Ep+9NId
         9U2tOhx3GUh/5YGpjK7XaMoQG8460FpavTlgnA9KYk8wo4Kb8xrN9KmthlBfLvUIZXbv
         x+uDOEpvW2u+auX1/atkOfZhlNrR/1wA88F6oW80Akj3QF+5G2ls/c+/qzk24m5s8LtM
         fi0hr1LVSIU7Kiu2XEUuxBIJzmr/Qa948td+cLVgYlFXYevjZf9Kgyoh5I2YYlVaNi39
         dTCC4/PqNPCh+qO7sMQdPqDULzOuJs4qcRSsChD06rFm2LqEcNFisqTH3DV2wRKkdX7L
         5cjQ==
X-Gm-Message-State: AOAM532ujnM1vclko/o/49maDq5UB0n0/ek2npZzbBAPi3SV3+lDsRk1
        h9+FTYn4Tb4D1Zfk4F+S9so=
X-Google-Smtp-Source: ABdhPJzRKVr+iqMWY04fDUROmbi+6Z/oGSyXSoFDPVg9D5IfLxx3cb07ttDzZgyB2gXXiKJwwraEog==
X-Received: by 2002:a65:568b:0:b0:378:86b8:9426 with SMTP id v11-20020a65568b000000b0037886b89426mr4811328pgs.70.1649994533848;
        Thu, 14 Apr 2022 20:48:53 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm7426380pjb.25.2022.04.14.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 20:48:53 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/3] mtd: spinand: add support for detection with param page
Date:   Fri, 15 Apr 2022 11:48:41 +0800
Message-Id: <20220415034844.1024538-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for spi-nand detection using parameter page.
This helps dealing with future JEDEC ID conflicts introduced by crazy
vendors. Also, the added ability to auto-detect chip capacity can help
reducing number of entries in our spi-nand id table.

Change since v1: extract common functions from raw nand

Chuanhong Guo (3):
  mtd: nand: extract some onfi functions to nandcore
  mtd: spinand: add support for detection with param page
  mtd: spinand: probe Winbond W25N01GV/W using param page

 drivers/mtd/nand/Makefile         |   2 +-
 drivers/mtd/nand/onfi.c           | 115 ++++++++++++++++
 drivers/mtd/nand/raw/internals.h  |   1 -
 drivers/mtd/nand/raw/nand_base.c  |  18 ---
 drivers/mtd/nand/raw/nand_jedec.c |   4 +-
 drivers/mtd/nand/raw/nand_onfi.c  |  70 +---------
 drivers/mtd/nand/spi/Makefile     |   2 +-
 drivers/mtd/nand/spi/core.c       |  23 ++--
 drivers/mtd/nand/spi/onfi.c       | 219 ++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/winbond.c    |  25 ++--
 include/linux/mtd/onfi.h          |   8 ++
 include/linux/mtd/spinand.h       |  53 ++++++++
 12 files changed, 431 insertions(+), 109 deletions(-)
 create mode 100644 drivers/mtd/nand/onfi.c
 create mode 100644 drivers/mtd/nand/spi/onfi.c

-- 
2.35.1

