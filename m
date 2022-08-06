Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574B458B579
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiHFM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiHFM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:28:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1721146C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788874; x=1691324874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jx/RMTHnZHuM76tciVNK6Z7cwRFQrZ3w7f04UahLs84=;
  b=TLvi1hHrvacpwExf0R0kjGShJjHL33wDvGTFoGFJVmvkyYBDKoTv1pGU
   /MBXNHEWhA7KOJVCNJZqomBSxUAysUhZ9zO4YtBtDYDqWCfxkHO+VKrWu
   SFToAcDHrJZcvXi1jDv+qu+QKIPjmOavf6Lax26CauBXdVPatPqXkNkQy
   +o3upyGQ09c3MkSK6FIHLAxVgQPNOMglas15RSeukLKYe9zdWrpnCoc91
   ceUbjFc+52KteQUctcLtcyJdVECs4Sxycth3bNFyRUacVg2ZRIyKIaXRM
   TZLAIw6VYJGL+ddLp2iF0q73pBVOqMJRCQ8Iry2QH2Bq6tu5fpqa5Iob0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289121910"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289121910"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632329136"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:51 -0700
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
Subject: [PATCH v7 12/15] mei: gsc: add transition to PXP mode in resume flow
Date:   Sat,  6 Aug 2022 15:26:33 +0300
Message-Id: <20220806122636.43068-13-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122636.43068-1-tomas.winkler@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Added transition to PXP mode in resume flow.

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/gsc-me.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 6b22726aed55..75765e4df4ed 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -182,11 +182,22 @@ static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
 static int __maybe_unused mei_gsc_pm_resume(struct device *device)
 {
 	struct mei_device *dev = dev_get_drvdata(device);
+	struct auxiliary_device *aux_dev;
+	struct mei_aux_device *adev;
 	int err;
+	struct mei_me_hw *hw;
 
 	if (!dev)
 		return -ENODEV;
 
+	hw = to_me_hw(dev);
+	aux_dev = to_auxiliary_dev(device);
+	adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+	if (adev->ext_op_mem.start) {
+		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
+		dev->pxp_mode = MEI_DEV_PXP_INIT;
+	}
+
 	err = mei_restart(dev);
 	if (err)
 		return err;
-- 
2.37.1

