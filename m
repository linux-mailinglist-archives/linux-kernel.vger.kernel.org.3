Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECF4BB6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiBRKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:16:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiBRKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038532AC909;
        Fri, 18 Feb 2022 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645179369; x=1676715369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b6jyNc5TsAM7TWNnI+hOWz6Q72t0GMAoWfyakMBe+ag=;
  b=lcF7sf8RTBUWT2NzSSTqAQvdaiccC/Z+IhL5KuCtqZPuOTbviKoZlAG2
   q1O1c1EsCtGBDIUwfKHxGuErO2T3e7CvEf+CrO21ySEfNcNIRJRJXGo1e
   odPaHGxcRpXPu6iXNXfmo3esuFBc6bVtg+S0of5BYRthjq9+SMWmuFesX
   lfY9/GcUIeX0E1Rv91qzraDkslvMLaG50eSCrWuIbbmeQXnm76/cdVhZD
   pnSZgN4yW/lWRp0b7A1MXqZoImd5z+oUAWs0vNSrIwRNemtmXu53e1+dV
   Wc7vALCRsqExqBzAKEKCm4jX6OKn//b9NsZTJunPF9Tv0CZnYcL1xD/ZV
   A==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="146491107"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:16:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:16:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:16:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/7] hwrnd: atmel - add runtime pm support
Date:   Fri, 18 Feb 2022 12:17:05 +0200
Message-ID: <20220218101712.530576-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds runtime PM support for atmel-rng driver. Along with
this some cleanup and fixes patches were added to the series.

Thank you,
Claudiu Beznea

Claudiu Beznea (7):
  hwrng: atmel - add wait for ready support on read
  hwrnd: atmel - disable trng on failure path
  hwrnd: atmel - rename enable/disable functions to init/cleanup
  hwrng: atmel - move set of TRNG_HALFR in atmel_trng_init()
  hwrnd: atmel - use __maybe_unused and pm_ptr() for pm ops
  hwrnd: atmel - add runtime pm support
  hwrnd: atmel - remove extra line

 drivers/char/hw_random/atmel-rng.c | 148 ++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 57 deletions(-)

-- 
2.32.0

