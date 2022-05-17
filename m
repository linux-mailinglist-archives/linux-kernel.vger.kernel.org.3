Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EAA52A276
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbiEQNAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiEQM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12694EF42;
        Tue, 17 May 2022 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652792319; x=1684328319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k/eXXvyIz1G2bo/uK4pQ9GdcfANrco7l6szUxhcJ9g8=;
  b=otY1RGh+uj9RRcS71GLhXL4Jr8a0q4kCDRU1e9mGRzjFTbC34bN/Pmlu
   ZHOubwW5d1EUjGC7DVXsSk1Rd3A8DSIPST4TPkD1aghCup+yWMVxxEkQC
   mQkdgDS4/NlWxryHIGUxNHAgX4SydD8cbFj8uUpFeTj/18/RlhViPsI7a
   gVDq2TVfPRB8vvxKFSMW4jy0TJhwWxXWfpFbGjx2E07jQ7nWas4kkTEff
   /X4UPTRwMLKxvgHJjJuzh80MLWQlgZ+z8sTOcILuyVh/jHXkwRO0rPZGJ
   qD2bRsvtsljotB5tBo5TaUQpe/gtcNEwZn/Tx01pmOlQ0hI6Plfejy6zs
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="96128625"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 05:58:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 05:58:34 -0700
Received: from ROB-ULT-M18063.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 05:58:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] nvmem: add Microchip OTP controller
Date:   Tue, 17 May 2022 15:58:20 +0300
Message-ID: <20220517125822.579580-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

This series adds support for Microchip OTP controller available on
SAMA7G5. The driver gives access to a non-volatile memory which
keeps (at the moment) information like booting media and temperature
calibration data used for thermal measurements.

Thank you,
Claudiu Beznea

Changes in v2:
- updated the bindings (patch 1/2) as follows:
	- included the device name in files names and updated binding
	  content accordingly
	- updated the description
	- removed address-cells, size-cells
	- removed clock include
	- use GPL-2.0 OR BSD-2-Clause license
	- removed OTP_PKT_SAMA7G5_TEMP_CALIB_LEN and keep hardcoded
	  value in examples
	  
- updated MAINTAINERS file with new naming of bindings

Claudiu Beznea (2):
  dt-bindings: microchip-otpc: document Microchip OTPC
  nvmem: microchip-otpc: add support

 .../nvmem/microchip-sama7g5,otpc.yaml         |  50 +++
 MAINTAINERS                                   |   8 +
 drivers/nvmem/Kconfig                         |   7 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/microchip-otpc.c                | 288 ++++++++++++++++++
 .../nvmem/microchip-sama7g5,otpc.h            |  12 +
 6 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml
 create mode 100644 drivers/nvmem/microchip-otpc.c
 create mode 040000 include/dt-bindings/nvmem
 create mode 100644 include/dt-bindings/nvmem/microchip-sama7g5,otpc.h

-- 
2.34.1

