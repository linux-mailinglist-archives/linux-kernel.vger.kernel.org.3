Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0E526335
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381583AbiEMNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381349AbiEMNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:35:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCE10F0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:35:29 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2B11822248;
        Fri, 13 May 2022 15:35:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652448927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9a3C05i3H9s2knOEOFTZJX5xBjffmFcZg9b98Yc2nfA=;
        b=crrxnZQZKwp9DDY63NSh2FDstmTvQeAH7hOpYpu8dSdlKV4P6+gMSEyTgiTLWYPfZ6CHy6
        N/p+hBI9XxtwsZz1VVTK15O8CcBIckWxtq0xOov2/C6FYxzsjCU2wbGtIgqLplomaBVGld
        R69Mqc80A/4RwkBPyGm3uYMuwIrqjqM=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 0/6] mtd: spi-nor: generic flash driver
Date:   Fri, 13 May 2022 15:35:14 +0200
Message-Id: <20220513133520.3945820-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic flash driver, which is used when we don't find a matching
flash in our database. All the basic features of a flash can be discovered
by SFDP and most (if not all) newer flashes support it.

Michael Walle (6):
  mtd: spi-nor: hide jedec_id sysfs attribute if not present
  mtd: spi-nor: sysfs: hide manufacturer if it is not set
  mtd: spi-nor: remember full JEDEC flash ID
  mtd: spi-nor: move function declaration out of sfdp.h
  mtd: spi-nor: add generic flash driver
  mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver

 .../ABI/testing/sysfs-bus-spi-devices-spi-nor |  6 +++++
 drivers/mtd/spi-nor/core.c                    | 18 +++++++++++++
 drivers/mtd/spi-nor/core.h                    |  3 +++
 drivers/mtd/spi-nor/debugfs.c                 |  2 +-
 drivers/mtd/spi-nor/sfdp.c                    | 27 +++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h                    |  2 --
 drivers/mtd/spi-nor/sysfs.c                   | 20 +++++++++++++-
 include/linux/mtd/spi-nor.h                   |  3 +++
 8 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.30.2

