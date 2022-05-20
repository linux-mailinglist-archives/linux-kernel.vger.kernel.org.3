Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9013252ECBF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiETM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiETM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:57:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F38169E27;
        Fri, 20 May 2022 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653051454; x=1684587454;
  h=from:to:cc:subject:date:message-id;
  bh=2+Jz9WHsM/0uEHL0h9e/nusHfWTsJyJTnp0bXCMBStg=;
  b=TLAIQ3gYSwxgV0DWjVvCyXG40tpfQ41i+0oaE1XpXNVcnY5W0KqRFaxC
   lJvjDOzoH5CzmpL5QxeFL07fLyKhSACqFaVwwvpHhL6Rk/xEO7Begrv8L
   f0dDpLbkQ89ujSyKQ0hIJrRmnRasadMcE1+WQQmjE0X9VMu5pxCqhMfD0
   htj21I6a5XuuHhiXpTQE9bRGbH48NU39zTiLZSPXd3q9ljdyhT/EqVbrp
   LFExS6v0VH+kj/QJFdLx2aqZjg0JEnymMlQxNqbrbow3it6/snLOSMEUE
   bTwlyujKwyjUZTyo3LUZ7YN4elME1dUP14o4bnaewlW/V1gprU0RHslms
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272305127"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="272305127"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 05:57:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="546668736"
Received: from monish-nuc11pahi5.iind.intel.com ([10.223.138.76])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 05:57:31 -0700
From:   monish.kumar.r@intel.com
To:     gregkh@linuxfoundation.org, oneukum@suse.com, olebowle@gmx.com,
        davem@davemloft.net, wangjm221@gmail.com, chris.chiu@canonical.com,
        vpalatin@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     monish.kumar.r@intel.com, abhijeet.rao@intel.com
Subject: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for Dell usb gen 2 device to not fail during enumeration.
Date:   Fri, 20 May 2022 18:30:44 +0530
Message-Id: <20220520130044.17303-1-monish.kumar.r@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monish Kumar R <monish.kumar.r@intel.com>

Found this bug on own testing

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 97b44a68668a..f9e149fc4395 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -510,6 +510,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
+	/*DELL USB GEN2 */
+	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM |
+	  USB_QUIRK_RESET_RESUME },
+
 	/* VCOM device */
 	{ USB_DEVICE(0x4296, 0x7570), .driver_info = USB_QUIRK_CONFIG_INTF_STRINGS },
 
-- 
2.17.1

