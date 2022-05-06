Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03051D340
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390074AbiEFIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390053AbiEFIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:24:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864C13F3A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651825275; x=1683361275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SWCtzeQzV0HfQf38xk+FbMTpoar7gBWKe/96+FRMtXQ=;
  b=jtvE2+yHoLyRF4n/gRVwt0MLx7sqbsWedjJoUmTnRqfaesMZzILhw0MZ
   kpqEq/iwHyDlaKW08LZQfa9f0Iem3a9Uw3mOAJQOdWqmqF357E1aIsnqZ
   SsZqwEUCOXoZWzQyzmZsXBrZ6xXNPFLY0F89YKoKk2vp10nzz901LmzZR
   f+KjHim9XOkSZe+0Di7QeJ3YK3TpFGLjUm5scmy0DaVljK/t89die0R/D
   xnB3ZXXIqdaf2wVHnOJp7f6+rDPHo7tx5rTpFNffjzyn0P/cdF3aZ6O3V
   eKiGx1y58f1QjehNa/DLAmWc3U0ca13Oa/i7DwePpft0dwimscyJ5otIJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="155031257"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 May 2022 01:21:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 6 May 2022 01:21:13 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 6 May 2022 01:21:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/4] ARM: at91: pm: add quirks for ethernet
Date:   Fri, 6 May 2022 11:23:31 +0300
Message-ID: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As described in patch 4/4 when receiving WoL packet on Ethernet
interfaces of AT91 SoCs and being in ULP0 or ULP1 AT91 specific power
management modes some SoCs may block other may have Ethernet interfaces
broken after resume. Workaround for this would be to disable clocks
for these Ethernet interfaces. As the MACB driver is common to multiple
vendors and multiple architectures and ULP0, ULP1 PM modes are AT91
specific the fix has been implemented in arch/arm/mach-at91 to avoid
having AT91 specific code in MACB driver.

Along with this patches I took the chance and added few comment style
fixups.

Thank you,
Claudiu Beznea

Changes in v3:
- patch 3/4 is now patch 4/4, patch 4/4 is now patch 3/4
- in patch 4/4:
	- improve failure path in at91_pm_config_quirks()
	- pass struct at91_pm_quirk_eth object to at91_pm_eth_quirk_is_valid()
	- add struct device member to struct at91_pm_quirk_eth
	- guard for_each_wakeup_source() with CONFIG_PM_SLEEP fixing the
	  compilation error Reported-by: kernel test robot <lkp@intel.com>

Changes in v2:
- in patch 4/4: use proper structure name in documentation

Claudiu Beznea (4):
  ARM: at91: pm: keep documentation inline with structure members
  ARM: at91: pm: introduce macros for pm mode replacement
  ARM: at91: pm: use kernel documentation style
  ARM: at91: pm: add quirks for pm

 arch/arm/mach-at91/pm.c | 395 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 362 insertions(+), 33 deletions(-)

-- 
2.34.1

