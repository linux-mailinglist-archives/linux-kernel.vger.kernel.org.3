Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF985AB870
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIBSl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIBSlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:41:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025871037F8;
        Fri,  2 Sep 2022 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662144112; x=1693680112;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/on5oCP1KwPaqtBjm1JAAFKloDtpOWIhGehylfeYbQU=;
  b=h4ExZRTYzIFsHdymt5Gyc9xTkhJ2KKLSq+FhyxTGbjltAwOjUBVrRK1H
   lNwCLVC00M+5KUxVuM5CCBQ5wjanR5Q6vIlUZ6xZq041/TQykdn0Mr/Sa
   blTvppmXOu/9vks20ZDVnqRZ7vN7DmqtctEEWAAUyz88zgHY+kkWkVRK5
   IuekfJ1LT5yfs7wBM4E5mkcgCCHficBY49mq1Cn4VyvrH0pMqyBOhx6eH
   BtK6CQ0YLgDiJ4FBVEwkJEsMwMUydzcbFyKvII+6pSbaPGY2Mj8GmxEqM
   S+PKOGaO6yNLiR/Ps4PK2B1NiqsBWaR1vcCJpo8g6mfiDE8QNTHMuLTt7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="275796130"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="275796130"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="788745380"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2022 11:26:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF6CF41; Fri,  2 Sep 2022 21:26:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/17] pinctrl: cy8c95x0: Allow IRQ chip core to handle numbering
Date:   Fri,  2 Sep 2022 21:26:35 +0300
Message-Id: <20220902182650.83098-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to assign first line number for IRQ chip.
Let IRQ core to decide.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 8bb01f852c54..521acfdeef38 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1177,7 +1177,6 @@ static int cy8c95x0_irq_setup(struct cy8c95x0_pinctrl *chip, int irq)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_simple_irq;
 	girq->threaded = true;
-	girq->first = 0;
 
 	ret = devm_request_threaded_irq(chip->dev, irq,
 					NULL, cy8c95x0_irq_handler,
-- 
2.35.1

