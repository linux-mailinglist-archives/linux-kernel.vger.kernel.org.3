Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60080561ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiF3PJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3PJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:09:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4B2A40D;
        Thu, 30 Jun 2022 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656601783; x=1688137783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dEIauEI3zkRv/Pfdo68/T9rL15iJxOA2RZaefQ/y2OU=;
  b=DWJ4ZPxtk7Mz7hdXrAyTpg4PNkiijCBTlhg9/20qj4SMMcOkisf0kIJ0
   nT9sGa8mAHtlcBiSXvAa8/plJin1ikNABxlRuAYZDG5wk9OTBSO02k5e5
   5rdrO5L+OknUp6dlLR/u4cBvXRQIG0gimS/QARqG3jc5YXYEBzW+1ZqFB
   X76m4wsg1EZxl3KfJqK9h77Y08VFhoFzsw9KP2uLc+DH9cc8sx38+OK/v
   v3OCIKMFjO2A1d7rxiVJgNYlNCcBlHN2o0aJJgDVy/8VJrtFE+VoNBdtF
   YFQPqTkKNPawZGKTp3C5IpQVF4UkYp+eE+N7+2Xa67SfCjoE9FLQsDj37
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="162789649"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 08:09:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 08:09:41 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 08:09:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] clk: do not initialize ret
Date:   Thu, 30 Jun 2022 18:12:05 +0300
Message-ID: <20220630151205.3935560-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220630151205.3935560-1-claudiu.beznea@microchip.com>
References: <20220630151205.3935560-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize ret.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1cff79a7f8a4..af6f8b48a561 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2189,7 +2189,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 {
 	struct clk_core *top, *fail_clk;
 	unsigned long rate;
-	int ret = 0;
+	int ret;
 
 	if (!core)
 		return 0;
-- 
2.34.1

