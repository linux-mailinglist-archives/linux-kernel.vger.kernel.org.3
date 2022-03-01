Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ECB4C8BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiCAMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiCAMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41691364
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646138029; x=1677674029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vF1lcbn5OIYXGBSLM+NFRREG8jhLcGdF5R60Ln2HnZE=;
  b=pJu03cg47i09VoOUFwwwKk2SYEm+Lo94Ob8oD9n5w4jvv1xQtC4GjTpz
   ALq94HYqC/OfNMGsKKtobVVl5hJN63XX6RM7I47BEwQj7Ai5rBnjczAXt
   8znQUJXSKeh2P7vqMNhMOROfPzRn8fF9T5RrBjCjOUmBt3U8xU8vR2EHz
   kRJ6nNsu8StA6JjxKEGPIIPNUPvDFIvWX9QrwsXgvhUmI40cIbUfR8ey6
   iwfYFQCwCfU14jdH2BsvtnTl4QlQ08FVje8oC0sM6G8wB4uUhhofZESB4
   omyMVOpDQOnA0nxxp8nFPA49krBPo++6yB7MOkV7LWn9hG6COjSY6ir1J
   w==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="87382475"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 05:33:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 05:33:48 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 05:33:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/7] clocksource/drivers/timer-microchip-pit64b: fixes and improvements
Date:   Tue, 1 Mar 2022 14:34:42 +0200
Message-ID: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
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

The series adds one fix and few improvement for PIT64B timer. Patches 1/7
and 2/7 were initially posted at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210707054415.92832-1-claudiu.beznea@microchip.com/

Changes in v2:
- removed patch 5/7 "clocksource/drivers/timer-microchip-pit64b: add delay timer"
  to avoid compilation errors on non ARM platforms; will re-introduce it after
  a bit of rework on AT91 specific Kconfig
- added patch "clocksource/drivers/timer-microchip-pit64b: fix compilation warnings"
- in patch "clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
  resume}" remove gclk_unprepare, pclk_unprepare labels and code under them

Claudiu Beznea (7):
  clocksource/drivers/timer-microchip-pit64b: remove mmio selection
  clocksource/drivers/timer-microchip-pit64b: remove timer-of depenency
  clocksource/drivers/timer-microchip-pit64b: use notrace
  clocksource/drivers/timer-microchip-pit64b: use 5MHz for clockevent
  clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops
    for ce
  clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
    resume}
  clocksource/drivers/timer-microchip-pit64b: fix compilation warnings

 drivers/clocksource/Kconfig                  |  2 -
 drivers/clocksource/timer-microchip-pit64b.c | 70 ++++++++------------
 2 files changed, 28 insertions(+), 44 deletions(-)

-- 
2.32.0

