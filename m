Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FC549322
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384486AbiFMOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384396AbiFMOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:34:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB4ADBCF;
        Mon, 13 Jun 2022 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655120957; x=1686656957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ip7LDyLvG35PweXXiZXDcl0rYNLBHjbyNoPhnAv4A5k=;
  b=jTEqqbovheovyfWDNgt2SKwbdHEAYvD6WjS84ok6mYYs0hyZ5UmeMipW
   5bAD2a6QphiyQoYwrn+1GAMYumCt3B0JmMYZG+BxJ++x2Ufhg4Xo6MDSS
   MMdb2op62uc76nO0p+OMJj9fPXyAn2lcTMtKBoAfrsAzrtcgeNQR4YFYH
   35PwVG2fxlJ4brs9LdC/yfEqMhggjO9yH4OPKIz6ryb35ZtF9rSEaJI5k
   QUY9YGWJscfDFN6ehWlRTLzTU+pVGZDOMDiuO6FB9c9CTU5PIgkTPeANU
   emtis43FWMQPpHOjfoICtOFViDKA7KVgzJ1Y7n/hIQzefpLIguYAv+sBP
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="177684159"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:48:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:48:29 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Jun 2022 04:48:26 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Date:   Mon, 13 Jun 2022 12:46:41 +0100
Message-ID: <20220613114642.1615292-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bin, Greg,
Short series here adding support for USB on Microchip PolarFire SoC FPGAs.
The kconfig dependency for INVENTRA_DMA has become a bit of a mouthful,
is there a better way of dealing with that?
Thanks,
Conor.

Changes since v1:
- Drop unneeded resource copying as per Rob's changes to the other drivers
- Drop the dts patch

Conor Dooley (2):
  usb: musb: Add support for PolarFire SoC's musb controller
  MAINTAINERS: add musb to PolarFire SoC entry

 MAINTAINERS               |   1 +
 drivers/usb/musb/Kconfig  |  13 +-
 drivers/usb/musb/Makefile |   1 +
 drivers/usb/musb/mpfs.c   | 265 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/musb/mpfs.c


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

