Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37DE5B0F94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiIGVwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiIGVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:52:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53DC1679
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662587542; x=1694123542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Oosr1efZEAk/bzGsBCuZvDxX6WE7t3HGnW7Kpt3NhY=;
  b=nq03Gq3rIC7xLm/iQUgcvt6sUHq444sA6Kr+qRAE/t715MfQBMoyMgio
   4ExntogdfjkH7x53rqr+OYnliDbexap6BqsTEsY5cWT2gfxCrZ1ah7+WY
   npjWgbo1LHA4wcp/Ww+BHX0fj8ISnfmvrcS+LHbaD5cW0PhvPraemgiSh
   Agm3l5fF0yXBSKL98KGmJAhWDcDBelRBeF5IExh1qnzCX9AuZp5xnLZLC
   z9tJLBND65tB68aF3TLxJMi1+0dmu1XIlpnp4VRqYYnd5fta9v2OxaYBt
   5mpEEMbxXhZTidIJwoDhJKap/Uv1c8qBuzoWVhpklfCkBlDKR8mRAAJ42
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295740375"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295740375"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:52:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="790208060"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:52:18 -0700
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
Subject: [PATCH v9 13/16] mei: drop ready bits check after start
Date:   Thu,  8 Sep 2022 00:51:10 +0300
Message-Id: <20220907215113.1596567-14-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907215113.1596567-1-tomas.winkler@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The check that hardware and host ready bits are set after start
is redundant and may fail and disable driver if there is
back-to-back link reset issued right after start.
This happens during pxp mode transitions when firmware
undergo reset. Remove these checks to eliminate such failures.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
V8: New in the series
V9: Rebase

 drivers/misc/mei/init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 1b4d5d7870b9..bac8852aad51 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -218,16 +218,6 @@ int mei_start(struct mei_device *dev)
 		goto err;
 	}
 
-	if (!mei_host_is_ready(dev)) {
-		dev_err(dev->dev, "host is not ready.\n");
-		goto err;
-	}
-
-	if (!mei_hw_is_ready(dev)) {
-		dev_err(dev->dev, "ME is not ready.\n");
-		goto err;
-	}
-
 	if (!mei_hbm_version_is_supported(dev)) {
 		dev_dbg(dev->dev, "MEI start failed.\n");
 		goto err;
-- 
2.37.2

