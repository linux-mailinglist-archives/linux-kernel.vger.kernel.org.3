Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162FB5B0966
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiIGP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIGP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:59:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034E2AD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566362; x=1694102362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iy/GwtvTwnOLfIT1uF2eHNyE186PGpbmZLR7bVd678Q=;
  b=TO3m6x/YV5NnN7cX3xkOXGm7qWrXLzWMLKrxdOxbebFiTRigle6iIC0q
   U54oJYLfVTB13BgXlagLDgKlq1JWPuFEih2dmDUjmiCwyHqEhXag0gPcb
   l9kFdhpls45sJ3xiyUUG0J/DBQCLTMnfMQpENdrjtEZc7iLXA2tQ6/H62
   eBIZ9K9HVjtRlx596OiNIHXNcGreDVlG2eeg5NUicShulivXrWh38c6Uh
   xOwQ0UWg4uGIiM2srP1nj2yurVLQF0Vl1tSX2HebEJSo4yM/XRx7JiJ1r
   +Q+HRKQyr2XHSRTBpPZh1lXTM9KOqY2ZxTTpoZCZdzd0TwWEIft6LaNKi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294501509"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="294501509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:58:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676247614"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:58:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v8 03/16] mei: add slow_firmware flag to the mei auxiliary device
Date:   Wed,  7 Sep 2022 18:58:00 +0300
Message-Id: <20220907155813.1427526-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907155813.1427526-1-tomas.winkler@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_firmware flag to the mei auxiliary device info
to inform the mei driver about slow underlying firmware.
Such firmware will require to use larger operation timeouts.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 include/linux/mei_aux.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index a0cb587006d5..4894d8bf4159 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -12,11 +12,14 @@
  * @aux_dev: - auxiliary device object
  * @irq: interrupt driving the mei auxiliary device
  * @bar: mmio resource bar reserved to mei auxiliary device
+ * @slow_firmware: The device has slow underlying firmware.
+ *                 Such firmware will require to use larger operation timeouts.
  */
 struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
 	struct resource bar;
+	bool slow_firmware;
 };
 
 #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
-- 
2.37.2

