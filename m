Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B14FE4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357079AbiDLPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357043AbiDLPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:31:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902FD5F8D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649777317; x=1681313317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kk9vDsGFP6yJI3cVDAN5JAQXQldQgiHzm+K/w9A/5ho=;
  b=nswFytGKQ1DKSGZ+ZQiJGQ0vGMhtQ6sm+E4Blfmhe2k8/TnYfZVIaKZl
   XnwnZzft3+ZnUIxuVPwrh2DaO7Q/r+NWkaup3WRWPZS5ieqBP/PQpmR73
   NeI7c6W81UWbbcyy+DBLQSf40h1KTLHeO+PWzAXH0byW7glzV09ijmM8X
   jauxUKpPyz/U+VYi5PShVPC9Dhv+Wn6PVGf421/ZB8TRRbXQlpj+/QX+H
   q1z7HUqIbeC/zqNctQHagX4Gs973fl3FzyKROQP0bB+SUccrjCM4KunEm
   QuOe3UX2we8qQX2tmXtuWx+Yaa7WfsW5giUqf8a+hGj1OqBEveVnMJDiW
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643698800"; 
   d="scan'208";a="159838688"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2022 08:28:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Apr 2022 08:28:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 12 Apr 2022 08:28:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/4] ARM: at91: pm: add quirks for ethernet
Date:   Tue, 12 Apr 2022 18:30:42 +0300
Message-ID: <20220412153046.50014-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As described in patch 3/4 when receiving WoL packet on Ethernet
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

Changes in v2:
- in patch 4/4: use proper structure name in documentation

Claudiu Beznea (4):
  ARM: at91: pm: keep documentation inline with structure members
  ARM: at91: pm: introduce macros for pm mode replacement
  ARM: at91: pm: add quirks for pm
  ARM: at91: pm: use kernel documentation style

 arch/arm/mach-at91/pm.c | 367 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 334 insertions(+), 33 deletions(-)

-- 
2.32.0

