Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30AE4B0361
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiBJCdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:33:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBJCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:33:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5655C237D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644460423; x=1675996423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dYsIVK1AfB36+8GaquEQ87fKf8oN7bkQ3uKk1U5DdBc=;
  b=0HnUn/72CMihySohp1yhVCL75wCGiwHCpZiEm6NUaehstCedu4swvL16
   gZukbzU1JSVuZy4F9cqjV0AoH0sGDPa0mJfTXrCUwl075oeX9tXgRaD3s
   kFQOcnZeExNome3gNOTaZbfUx8XbJZiOIBWCvQNFIdTWGUeTACPKyBKXG
   Ltn5DbJGxfRyKwzRdb6yEwRemWs+V/sp/eTGD7y396mYSkIsN2UsGIUWd
   6mXO9S1z93h9YVgq1b+AYjUspucY8hg4huR79Yrv1sRjMhyEchljln7pI
   AsdublYKqJeVkGluR9742xhbXwfADpS6rO/xrl5wIn54rgvT293H69ahm
   A==;
IronPort-SDR: GXFH9gi5i94h/9Gu9Wc/AM0kkABlz6qgRkg37NfI7iVocwyWBAfeJPOCQNikIMUz/WF/Q/IQSl
 Nmfeggjj8OavE0umqWzTWe3ZcOzys7fdGB1tAR81WhgMjtyihyHns2xPfv/vJS7lHTzZj81AhO
 DN23UlXRaP8a7ZnkRRDC1OLAZ47c9fXWq/pcDiS59P160JxgBzy4mQfZd6Krv1m0PZKlYF/I47
 rN2jGkENGDCQJQ82soSIuNylqWsI0GZQnCUjYAsDVcgp1MtNpixbHY8Y3vSkO8OzSYjNxR3qnp
 GhNNikxiaZZyjCLCgv9JEKjw
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="153075474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 19:33:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 19:33:41 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 19:33:37 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>,
        <Takahiro.Kuwano@infineon.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>, <Bacem.Daassi@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/3] mtd: spi-nor: Rework Octal DTR enable methods
Date:   Thu, 10 Feb 2022 04:33:31 +0200
Message-ID: <20220210023334.408926-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are manufacturers that use registers indexed by address. Some of
them support "read/write any register" opcodes. Provide core methods that
can be used by all manufacturers.
Update the Octal DTR enable manufacturer methods: introduce templates for
register operations, use the introduced core helpers.

The series depends on:
https://lore.kernel.org/lkml/20220209133656.374903-1-tudor.ambarus@microchip.com/

Tudor Ambarus (3):
  mtd: spi-nor: core: Add helpers to read/write any register
  mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()
  mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()

 drivers/mtd/spi-nor/core.c      |  41 ++++++++++
 drivers/mtd/spi-nor/core.h      |   4 +
 drivers/mtd/spi-nor/micron-st.c | 105 +++++++++++++------------
 drivers/mtd/spi-nor/spansion.c  | 135 +++++++++++++++++---------------
 4 files changed, 172 insertions(+), 113 deletions(-)

-- 
2.25.1

