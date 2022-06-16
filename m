Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36454E2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377513AbiFPN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377430AbiFPN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:58:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8515A14;
        Thu, 16 Jun 2022 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655387885; x=1686923885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ym97UMCJzp/R175RT3xO1NFJ8cZwyDX4UgHmRfmcHZo=;
  b=IezYgq93mGC77la7Sy34xtaA+gh4Gsx1x2oPOMQOGGeqoXrDJeZdfTvL
   tcCLDZzBhG6RdKb4kJ5pVzKF4X9shUXCLmUZybqie1GJdLRDdmecNvy6M
   AEB7+zzO9w8SSPCzd+FYoUV8AT1l08bCKyNJsv8aMOWpoYUHSv0E2lOvN
   iSY7vkqqT7h0Boa4Vb//0ZmuFe+qTUBiux3qmrLRyowyyoxSx7c0J+zJC
   TreFeTZJcxBi9al57oQUnBoLxmubKdmC9dJGOGwD4N/DAM9FwCxYeLowV
   Le50lppR8M5K3gqdOCB6DyQfXEwNRnDvMXGAg4DF/qSlWOqImGYrBzXGQ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="168685529"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 06:57:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 06:57:57 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 06:57:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/4] serial: atmel: cleanup code
Date:   Thu, 16 Jun 2022 17:00:20 +0300
Message-ID: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
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

The following patches does some cleanup for atmel_serial driver by
switching to dev_pm_ops and improving clock management code. Along with
it I took the chance and introduced a patch for st-asc which removes the
include of pm_runtime.h.

Thank you,
Claudiu Beznea

Changes in v3:
- removed "int ret;" from atmel_console_setup() as suggested in
  the review of v1
  
Changes in v2:
- split patch 2/3 from v1 in patch 2/4 and patch 3/4 in this
  series
- collected tags

Claudiu Beznea (4):
  tty: serial: atmel: stop using legacy pm ops
  tty: serial: atmel: use devm_clk_get()
  tty: serial: atmel: remove enable/disable clock due to
    atmel_console_setup()
  serial: st-asc: remove include of pm_runtime.h

 drivers/tty/serial/atmel_serial.c | 94 +++++++++----------------------
 drivers/tty/serial/st-asc.c       |  1 -
 2 files changed, 26 insertions(+), 69 deletions(-)

-- 
2.34.1

