Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239F149C07A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiAZBPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:15:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:18573 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbiAZBPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159703; x=1674695703;
  h=from:to:cc:subject:date:message-id;
  bh=cH0XyDQ4K5w193zV62nuPqzVps5xaLQVLtjpTPjw14E=;
  b=PHhYU+W+0fdc5CH3BYQn3GrjSsiu6hIir04I0B3zWq6jw4G3IqI8GCUC
   ok3vQDkha2XshshxOxaofwFloNv7oniKW9VxjJmlO1VFBP13riW9p1OD+
   WKB96PR+g+QREujGfA+BopotImOW/GvZalSTL2s9MS7t+M1YQaPoiDxG9
   ZN+olAohqIrcNe4mvojotovMKCbAM6jwHC5PHh1zAGroDBthn3hs1ORko
   6y9JkdL6Z8v0T67E0T/aHEMLnsK64cM9aKBiV2VtL65c/+ihG/QCjtRqb
   5go50YoGQ/3tbo0rhwvi5WaMTI2qkxuwUubn5E3hPW4KToFp+EjhxsYub
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246673863"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246673863"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:15:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="479719122"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:15:00 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com, libin.yang@intel.com
Subject: [PATCH] soundwire: intel: fix wrong register name in intel_shim_wake
Date:   Wed, 26 Jan 2022 09:14:51 +0800
Message-Id: <20220126011451.27853-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Libin Yang <libin.yang@intel.com>

When clearing the sdw wakests status, we should use SDW_SHIM_WAKESTS.

Fixes: 4a17c441c7cb ("soundwire: intel: revisit SHIM programming sequences.")
Signed-off-by: Libin Yang <libin.yang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 122f7a29d8ca..63101f1ba271 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -448,8 +448,8 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 
 		/* Clear wake status */
 		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
-		wake_sts |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
-		intel_writew(shim, SDW_SHIM_WAKESTS_STATUS, wake_sts);
+		wake_sts |= (SDW_SHIM_WAKESTS_STATUS << link_id);
+		intel_writew(shim, SDW_SHIM_WAKESTS, wake_sts);
 	}
 	mutex_unlock(sdw->link_res->shim_lock);
 }
-- 
2.17.1

