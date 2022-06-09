Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635DC5447C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbiFIJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiFIJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:38:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2948D2E080
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654767495; x=1686303495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32hAsO1+ERVsJtppF5xPs+0dE3EElahoU3zfp8Y2qTA=;
  b=K8hd73x0ec91QC5jgC3se44y39BnYqztuoXAh4ATgPRIp87iO5P9SVZw
   ZM1phLmB03rBXUmZW5cW2rST5aGZ3caJ7xlJGEnoACd1JVwRZdCWdrNYy
   R5oaIu1+UpfuPcvKV3BScT5sulljp26tn1eUzFxCnLxu2cq8o6lWld44b
   LvAeVgwt319HT8jBMc8qfz5fyZuGsB3ch1U1NifKia3VhbDsQEXMED7pk
   SzfKRZZawvdaRKseadcnrBLLsDtPIs0aOv4yMCAZQxOKnM9SZDw8FUO1E
   hCuk6IyDGTgJbudBzahHhRIwfdx3QqZBKN9knknZnxjTcwdEYlKGN2agv
   w==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="162585280"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 02:38:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 02:38:12 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 02:38:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND][PATCH 0/3] clocksource/drivers/timer-microchip-pit64b: improve clock management
Date:   Thu, 9 Jun 2022 12:40:38 +0300
Message-ID: <20220609094041.1796372-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series improves clock management on PIT64B driver such that PIT64B
clocks to be disabled in case driver has been probed to be used as
clockevent but there is already a better clockevent timer available.

Along with it added a patch to fix compilation warnings.

Patches were initially part of series at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/linux-arm-kernel/80f949af-ddab-b54d-b6ee-0fbcb1f74b51@linaro.org/T/#mc9969713b69f7874dd3bc6de07e8e8bc9568ead5

Claudiu Beznea (3):
  clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops
    for ce
  clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
    resume}
  clocksource/drivers/timer-microchip-pit64b: fix compilation warnings

 drivers/clocksource/timer-microchip-pit64b.c | 64 +++++++++-----------
 1 file changed, 27 insertions(+), 37 deletions(-)

-- 
2.34.1

