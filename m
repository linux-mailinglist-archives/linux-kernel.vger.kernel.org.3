Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051E4B5365
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiBNOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:33:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBNOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:33:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54724A3FC;
        Mon, 14 Feb 2022 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644849182; x=1676385182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YTJsF71vVRGR3IAd/kstHbIpM3JyQ8idpkTZUwJqpE=;
  b=M6ulQ1qlHyZ3Gdtb8960AOJzfQEutAnm6hPvk16zvRv5aZbZqKQo7HKV
   gnnvp4thh25nN41VzJD9jfnSy2GQ/nAm2HFkgT3h3VFkCsnjYbyaZpIOC
   W7NLYIB7JHkJH2VnFUeIGOO5OZjHPTj+BjgsXkCWrI4tdF3BS85BPHKEA
   mvLXVoSN7FDduHCLuUhI3FjKqSJR3dfiLY+igtCuDCbVjSqDQWbM5gNiu
   rFS+ugM3QLOfBE2OvR5qln7XLpV21JjftJrItObXwGuNHxi6RzgYauM8d
   J5SOJyHGaJ/bwzkRZQFkawjdZYA10uTRF4j/kX8GNrGWZil6z1rQ/bNLC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247695190"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="247695190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:32:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="543629504"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2022 06:32:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F85A30B; Mon, 14 Feb 2022 16:32:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] serial: sh-sci: Switch to use dev_err_probe_ptr()
Date:   Mon, 14 Feb 2022 16:32:48 +0200
Message-Id: <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214143248.502-1-andriy.shevchenko@linux.intel.com>
References: <20220214143248.502-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of
	return ERR_PTR(dev_err_probe(...));
call
	return dev_err_probe_ptr(...);

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b610b27893a8..0fce09c13847 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3199,8 +3199,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
-		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
-					     "failed to get reset ctrl\n"));
+		return dev_err_probe_ptr(&pdev->dev, PTR_ERR(rstc), "failed to get reset ctrl\n");
 
 	ret = reset_control_deassert(rstc);
 	if (ret) {
-- 
2.34.1

