Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1D510CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356285AbiD0AAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356253AbiDZX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:59:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D0488A9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017398; x=1682553398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tA/0dx3kOuM/bOmv9rB+8wuyPRn5khLhY2aFJCWhgdE=;
  b=E2zxf8Mm/87/BTPpgZ1Z2iAhIno3PIqS8lta4ejBUoo5sTxUf42A7myT
   k7oS8/e8RrMzSUraAPN61abbehxb4u5vtuK/wh+MwFS7yFXzO/SM+Fkbh
   1Az1LELSNLOTl0t0QH5shYWh9HxBipjG7AR7K7Gpex9Mc3sq5gCtJgP2u
   xGiXAq+C3CJjlFTGj12gtrKAcY7WZX0yXqOuUp/MtoSLZvY8t84EkEXP8
   6t5G/Mvk1aCg+1zAs2OWHEMgjZ5sQzKNCGZyyBvowKmRMDTPyiOQ3mCGk
   ORpOPuZsfPWGsg9MpBr7+82XcsGpeYc0xMF7qcdRQvlZHVKJYQHpPqX7i
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245682880"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245682880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730515038"
Received: from htamura-mobl2.gar.corp.intel.com (HELO bard-pc.domain.name) ([10.252.185.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/5] soundwire: cadence: use pm_runtime_resume_and_get()
Date:   Wed, 27 Apr 2022 07:56:21 +0800
Message-Id: <20220426235623.4253-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
pm_runtime_put_noidle() pattern.

No functional changes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 558390af44b6..a53a777f2241 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -386,12 +386,11 @@ static int cdns_parity_error_injection(void *data, u64 value)
 	 * Resume Master device. If this results in a bus reset, the
 	 * Slave devices will re-attach and be re-enumerated.
 	 */
-	ret = pm_runtime_get_sync(bus->dev);
+	ret = pm_runtime_resume_and_get(bus->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(cdns->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(bus->dev);
 		return ret;
 	}
 
-- 
2.25.1

