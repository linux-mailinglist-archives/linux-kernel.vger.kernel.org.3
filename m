Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F34CD53B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiCDNfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiCDNfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:35:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153E1B7550
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646400893; x=1677936893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7qJjB8s5mj9tcVBmmgR+mJABtjD4cmsjKUaN5U0lI0c=;
  b=bVivDaP8KzKZarmQQ6q9LiLX3mDl376IZOCFIPVEP4slwcQuHuon9mxq
   e/kthxkxgHaO3TuPsY9kK4f2AHaoFGIIgADeKCYbUs9+2aYFTo8B1ohTi
   nU3lWsSQ632u+PG/3TxgEdhMlw+8QU710Z62iH59k/RbHCltir4+szEyn
   9rp2/BOYh0KvCuoAP6hyWvSh05bh5WKVhLCIxD2mQncNUyzzIMD4T1HxZ
   ehFtITOX5blT0HzUxwUuldgIKRyTQdNRXUHXdoHRuFjYa7yvwWcs3msod
   KISkFxrgY0s/luvi6xcV6l9cZllyS7SJGrX18ism/YLWShmmm8ptpBnfG
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164541105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:34:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:34:52 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 06:34:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/6] clocksource/drivers/timer-microchip-pit64b: fixes and improvements
Date:   Fri, 4 Mar 2022 15:35:55 +0200
Message-ID: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series adds one fix and few improvement for PIT64B timer. Patch 1/7
was initially posted at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210707054415.92832-1-claudiu.beznea@microchip.com/

Changes in v3:
- removed patch "clocksource/drivers/timer-microchip-pit64b: remove timer-of depenency"
  as it breaks build on other platforms
- adapt patch 6/6 to comply with kernel-doc specification

Changes in v2:
- removed patch 5/7 "clocksource/drivers/timer-microchip-pit64b: add delay timer"
  to avoid compilation errors on non ARM platforms; will re-introduce it after
  a bit of rework on AT91 specific Kconfig
- added patch "clocksource/drivers/timer-microchip-pit64b: fix compilation warnings"
- in patch "clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
  resume}" remove gclk_unprepare, pclk_unprepare labels and code under them


Claudiu Beznea (6):
  clocksource/drivers/timer-microchip-pit64b: remove mmio selection
  clocksource/drivers/timer-microchip-pit64b: use notrace
  clocksource/drivers/timer-microchip-pit64b: use 5MHz for clockevent
  clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops
    for ce
  clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
    resume}
  clocksource/drivers/timer-microchip-pit64b: fix compilation warnings

 drivers/clocksource/Kconfig                  |  1 -
 drivers/clocksource/timer-microchip-pit64b.c | 72 ++++++++------------
 2 files changed, 30 insertions(+), 43 deletions(-)

-- 
2.32.0

