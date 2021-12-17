Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B05478B54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbhLQM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:26:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31965 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLQM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639744002; x=1671280002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICp7QxieuNlzA7BpoPg0TL4ThrGqa6z9393qkPh+MrU=;
  b=DDzAUEauIwDrVHypgPliup4ZibqK6GfFRJD6kr0HZqpDO6bK4NJdMbFt
   j2msX5Uwb6TKOzKejH9PgNsNswwJOOIY5iKrNWOgDKjHAluXaH0CfUPrM
   7yleVpNOKt1HKg6E2fDXElKOWbAgEElhIWlTJTf3PrEz5V/w95SxIrU90
   B9wgoEmmR/TE5LsP5eEBWn/qgDy0H/zKSPJdOgZo0HY2T07hvejHZmGze
   sWvWsRuk5sRlY4rpmPrDN6/yJnNntTAHtgrYc7r3aq6dkSoADTCBFPfKu
   BwU2ftdsfh7gGoyE84Se2UEMYqGxJ7h3svCowsaHwxQFW0/x8ZL3c9+KR
   w==;
IronPort-SDR: jgvwM4SbcnBvPoY2piZfAoPn9qE189AnRcCXzxHnOMkbJzZCZDsNvl1umomrOdRnNi2nV7ibLf
 AE+EAw0WUIIp6TKCJyHAzxlk2Wc49MGzonwAD1OmyZuHMRPs7NkSSGDfRd0t3JUd/aoQ1jIgRn
 Z0uA6ASZACinBfnslpetC+sGi9rEjq2VcGo0nVw5nkJ4pL6KQeMfg9TVbCVnxFKWaOz8833pmK
 uCLjKAKhGpzb/GVEBVUvLSrEL4gMRuiGrQKijgJdXDKcpRezypZZMd/0iKjOgSr79E/qitBt8o
 A7VDQpNzJC8uh0/StU0eb5MN
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="140126594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 05:26:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 05:26:41 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Dec 2021 05:26:39 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] mtd: core: Remove partid and partname debugfs files
Date:   Fri, 17 Dec 2021 14:26:34 +0200
Message-ID: <20211217122636.474976-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI NOR has equivalent sysfs device attributes, thus let's remove the
duplicated debugfs entries. There's no one else using partid and partname
debugfs files, thus remove them from the mtd core as well.

If you find the idea acceptable, I would like to queue these through
spi-nor/next, I'll have some other patches that will depend on these.

Tudor Ambarus (2):
  mtd: spi-nor: Remove debugfs entries that duplicate sysfs entries
  mtd: core: Remove partid and partname debugfs files

 drivers/mtd/mtdcore.c      | 35 +----------------------------------
 drivers/mtd/spi-nor/core.c | 12 ------------
 include/linux/mtd/mtd.h    |  3 ---
 3 files changed, 1 insertion(+), 49 deletions(-)

-- 
2.25.1

