Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9190B54FCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiFQSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347292AbiFQSXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:23:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586871707B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655490217; x=1687026217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iMDQaKo1ZNDhXG5eBnwD6lEJLVOQIIteMogq7Kf3Xjo=;
  b=W5FxT6NIClSA2nRZN3Xt/bMwkaLR7zocTK33PMQSi2h85TtEj7tkD9yX
   XyP2IN1oLEylctU1jvWdLYnjv0NHk8ufjDiR4nJ9jLGrNcVypE4R2AVPf
   sLpi0wUSw+/NA/MZwkjpAixfPEV8h9Ta915ycwOEWxoZTmrvkiLY2QO1T
   4vR+1QbLrIRErSxYEis3yzB+O4gLYwxZAbhrf9ar4z/h7H2g6lcBVY5kE
   pAKoexr38EqXfxyrqlhppz4o+GM5lgOk95lpwYe4hFWgZU75qkKxSUa/e
   jmO1IOxsX8UB+sznTvdOjyYecuEIVi/y9L9CYSpj/Y949jUpAE/kZ4i16
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259989895"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259989895"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 11:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619344439"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2022 11:23:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2519132; Fri, 17 Jun 2022 21:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jack Andersen <jackoalan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/1] mfd: dln2: Automatically detect and fill endpoint pointers
Date:   Fri, 17 Jun 2022 21:23:38 +0300
Message-Id: <20220617182338.32402-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_find_common_endpoints() finds and fills the endpoints
in accordance with their types. Use it to automatically detect
and fill endpoint pointers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/dln2.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 852129ea0766..6cd0b0c752d6 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -91,11 +91,6 @@ struct dln2_mod_rx_slots {
 	spinlock_t lock;
 };
 
-enum dln2_endpoint {
-	DLN2_EP_OUT	= 0,
-	DLN2_EP_IN	= 1,
-};
-
 struct dln2_dev {
 	struct usb_device *usb_dev;
 	struct usb_interface *interface;
@@ -777,16 +772,12 @@ static int dln2_probe(struct usb_interface *interface,
 	int ret;
 	int i, j;
 
-	if (hostif->desc.bInterfaceNumber != 0 ||
-	    hostif->desc.bNumEndpoints < 2)
+	if (hostif->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
-	epout = &hostif->endpoint[DLN2_EP_OUT].desc;
-	if (!usb_endpoint_is_bulk_out(epout))
-		return -ENODEV;
-	epin = &hostif->endpoint[DLN2_EP_IN].desc;
-	if (!usb_endpoint_is_bulk_in(epin))
-		return -ENODEV;
+	ret = usb_find_common_endpoints(hostif, &epin, &epout, NULL, NULL);
+	if (ret)
+		return ret;
 
 	dln2 = kzalloc(sizeof(*dln2), GFP_KERNEL);
 	if (!dln2)
-- 
2.35.1

