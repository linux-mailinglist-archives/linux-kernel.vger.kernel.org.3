Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC94B6532
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiBOIFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:05:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiBOIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:05:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907126563
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644912296; x=1676448296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlQlnq2dnqtnhMrkt80trZW3AYKZBV32YQ9EvBHZ6a8=;
  b=b6j3WsR82ZIyP5tb+tJubKhXm1HRSbe8jOV0lNW0wERjBLkKi5PGzEU4
   vBSJTzjNJvFsrYqlmUiuUPeizYoPuYt9qC/Bmerodj952OPxCOePP0X+5
   0oKvNVIk4yLavDvhe74z62Ae8lLo6N1ObYomCaBSwTbqarHIlNNozSUsF
   dinmgh5rC/PB6L5FnCUnqHf0ZjYEWu042Ii4s5iKpzqc0kLWe6fjUl6VI
   ST6WTY63JbcCjdUk4Eme/bQfl1PjGSiGI5uzD95vTdSRqckVPkvegOetq
   kh4quXu94cIr+jpROMsbMDYgnm+ht473JO7PMWh850IWFSFG1ZwY3nNri
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336703253"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="336703253"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:04:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="703498915"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:04:53 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/4] mei: do not overwrite state on hw start
Date:   Tue, 15 Feb 2022 10:04:38 +0200
Message-Id: <20220215080438.264876-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215080438.264876-1-tomas.winkler@intel.com>
References: <20220215080438.264876-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

During the hardware start sequence, do not overwrite the driver state
and do not proceed with the initialization sequence if the state
was changed while the driver was waiting for the start interrupt.

This can happen if the driver's removal/stop procedure was triggered
from the parent level while the driver is waiting for the start
interrupt. This may lead to stray the reset work or the timer
after driver were removed.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index f79076c67256..eb052005ca86 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -161,6 +161,11 @@ int mei_reset(struct mei_device *dev)
 		return ret;
 	}
 
+	if (dev->dev_state != MEI_DEV_RESETTING) {
+		dev_dbg(dev->dev, "wrong state = %d on link start\n", dev->dev_state);
+		return 0;
+	}
+
 	dev_dbg(dev->dev, "link is established start sending messages.\n");
 
 	mei_set_devstate(dev, MEI_DEV_INIT_CLIENTS);
-- 
2.34.1

