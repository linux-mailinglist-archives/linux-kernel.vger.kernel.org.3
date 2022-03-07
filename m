Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4C04D030A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbiCGPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiCGPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:38:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448791AFC;
        Mon,  7 Mar 2022 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646667440; x=1678203440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HqBJCaUgOl4ABA5A2mBxWwr43jmzmLhKACc11IzWAck=;
  b=aZFLeAZnQ+X0PpmHYWyXWDTrM5qqhBO9MN9hnSm0g17geNqD+mHd+dC9
   /5ZoTa5+AQhSVup5ArQfaBq9RjOlNOeOtFr7fqId33hJH3+4DQpQt/YA3
   2ZLr+5tA3Ch0lIhyGq3gLFo9grA7P5Z8qrYB6MfajtQw6CFTwY0whRVdX
   gEczAVqOcowci00NkmN+Yp3kcwfjEjOeVR/qUliFWhvTyb7Dgrbq0NKZz
   1i2xPkRz8f06biodwzMmd9SY/kmLT9Roy5ZDiqRGN8HBSvLXbOEbOtp24
   YiKKGU9CkHFKnypqFRX4kyh3nU4sSX/abj9+CNJA7I36nqgM9dFbj5wgQ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="148340403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:37:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:37:19 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 08:37:18 -0700
From:   <conor.dooley@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>
CC:     <lewis.hanly@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Conor Dooley" <conor.dooley@microchip.com>
Subject: [PATCH 0/2] Add support for hwrng on PolarFire SoC
Date:   Mon, 7 Mar 2022 15:40:22 +0000
Message-ID: <20220307154023.813158-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As it says on the tin, add support for the hardware rng on PolarFire
SoC, which is accessed via the system controller. While we're at it,
add the rng driver to the list of files included as part of the SoC
support in MAINTAINERS.

Base commit is in arm/soc branch of the soc tree as the hwrng driver
depends on the system controller, which is to be introduced via that
tree in 5.18

Conor Dooley (2):
  hwrng: mpfs - add polarfire soc hwrng support
  MAINTAINERS: update PolarFire SoC support

 MAINTAINERS                       |   1 +
 drivers/char/hw_random/Kconfig    |  13 ++++
 drivers/char/hw_random/Makefile   |   1 +
 drivers/char/hw_random/mpfs-rng.c | 103 ++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 drivers/char/hw_random/mpfs-rng.c


base-commit: a483b1b232e616d0095a59b987ffc739bc1b56bc
-- 
2.35.1

