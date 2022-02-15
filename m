Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BB4B6531
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiBOIFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:05:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiBOIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:05:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A6A26550
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644912294; x=1676448294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5T63W7GymsrSU9DoEclQ/o11BgSo+l9T4yFhSi4lmSQ=;
  b=PJcISs6ajCagZIqUUrWKgy8e8V8CqZK5grrf3uYIK+gwU62bTDV0DUJn
   oM8JONRX6T2F/2N/bDaZfdSoOo+KEmDZnq64Unsef0+dvVbcTu/R0dOTv
   HQD4LtHoT2o92dxOvyIthB8ct92KpL8cotIbYYEcIIx+/9OEeh84BFVE9
   RuH9Ce2GHEgGVROLwhqijAQlGbYI999HWQrC33wvsrDsuFFeLkVuogMrB
   7iAwoqFx2HxCLwrZ5hEXk01+KEplbPi8SVoPy1iqYAoc12lvyDUhfI/o9
   ReW9u6J17jOFwDlN3U7Ao668eo7fAF1K+SguBy8IValcibdDMIo6cZB6Z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336703244"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="336703244"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:04:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="703498901"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:04:51 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/4] mei: me: fix reset policy on read error in interrupt
Date:   Tue, 15 Feb 2022 10:04:37 +0200
Message-Id: <20220215080438.264876-3-tomas.winkler@intel.com>
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

Avoid link reset in DISABLED and POWERING_DOWN state
if read error is occurred - let shutdown flow finish.
In any state exit interrupt handler if read error occurred.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 3a86c087bc9d..719fee9af156 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1293,12 +1293,14 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 		if (rets == -ENODATA)
 			break;
 
-		if (rets &&
-		    (dev->dev_state != MEI_DEV_RESETTING &&
-		     dev->dev_state != MEI_DEV_POWER_DOWN)) {
-			dev_err(dev->dev, "mei_irq_read_handler ret = %d.\n",
-						rets);
-			schedule_work(&dev->reset_work);
+		if (rets) {
+			dev_err(dev->dev, "mei_irq_read_handler ret = %d, state = %d.\n",
+				rets, dev->dev_state);
+			if (dev->dev_state != MEI_DEV_RESETTING &&
+			    dev->dev_state != MEI_DEV_DISABLED &&
+			    dev->dev_state != MEI_DEV_POWERING_DOWN &&
+			    dev->dev_state != MEI_DEV_POWER_DOWN)
+				schedule_work(&dev->reset_work);
 			goto end;
 		}
 	}
-- 
2.34.1

