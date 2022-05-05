Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C510A51BCE2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiEEKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355001AbiEEKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:15:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF82B246;
        Thu,  5 May 2022 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651745525; x=1683281525;
  h=from:to:cc:subject:date:message-id;
  bh=+gHnQv0pisHaCzta/ejCsdha3EXubCXWxzwQAwWLTP0=;
  b=YTCAi+YClgi3rNtKaz31m7P9eu1SaI6uXvQp0De7/RHWelGhgOkOFN10
   aHm35T+irRHvngYgeIsLq3ftvhl7Rjv+ZxaZTVuNgO67OJUAS0adhmrd+
   tn0wGNRJpivWGe0hyGIq2scr9HmXSgMAInN9ysMOmhN2bqQ3fw+E4c13N
   qMv1lH5hxutqZ0Lwjl6teIDlp2uwFX3T1FbHqNYqCVKCwwARk4jLhX/gU
   RxQF0EO6cG6Ff9Z8Yd5Hh9DACWQB3mM/+9f095RDJr1P6BToxtUtnvWnt
   1PRBtpRKG63cFDrCYgvj9DDEsHef+sFFLnJ3FNqy0vR5fizc5flKi0/wf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265658815"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="265658815"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:12:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563173393"
Received: from monish-nuc11pahi5.iind.intel.com ([10.223.138.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:12:02 -0700
From:   monish.kumar.r@intel.com
To:     gregkh@linuxfoundation.org, olebowle@gmx.com, oneukum@suse.com,
        vpalatin@chromium.org, wangjm221@gmail.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     monish.kumar.r@intel.com, abhijeet.rao@intel.com
Subject: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for Dell usb gen 2 device to not fail during enumeration.
Date:   Thu,  5 May 2022 15:44:59 +0530
Message-Id: <20220505101459.7804-1-monish.kumar.r@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monish Kumar R <monish.kumar.r@intel.com>

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 97b44a68668a..257ac37464e8 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -515,6 +515,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
        
+	/*DELL USB GEN2 */
+	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_RESET_RESUME },
 
 	{ }  /* terminating entry must be last */
 };
-- 
2.17.1

