Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36843510CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356251AbiDZX7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356147AbiDZX7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:59:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604344750
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017394; x=1682553394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gZI640vB7Fkwj7DXZ769dDtNYXHXh9PsK5UHotqXzY=;
  b=OoK10SN+XU0g5kzEuEO6CBLQwbfCs5dBkHvVt+URdU7TaZzr41/57QNB
   IrWYQwWrFyVfYPSQImyf+b8lEGJZXNT3JfdrTaUiqdufiuViW+6zFr27n
   Dt0nJhVJMzzONrv1TwvcjUVXJrcipUp0MU7FPHrj62Dz76KDvuAYGbjjq
   qiGND87wuRilb9bR8zUVD22iptX+eoRU1evk7tpBlqnY27FSod0c5Li07
   Gq3fc6YKcVMLfzYgHBNadMafMOcYlAHRcXFkx+dUv+MuOtkdtWQPG2YiI
   Xzll8YnASw3D0TfTC/F77Kh2nooD0AXv0wLj0c0ug6VepS9MVobXHf0mo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245682872"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245682872"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730515015"
Received: from htamura-mobl2.gar.corp.intel.com (HELO bard-pc.domain.name) ([10.252.185.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/5] soundwire: qcom: return error when pm_runtime_get_sync fails
Date:   Wed, 27 Apr 2022 07:56:19 +0800
Message-Id: <20220426235623.4253-2-yung-chuan.liao@linux.intel.com>
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

For some reason there's a missing error return in two places.

Fixes: 74e79da9fd46a ("soundwire: qcom: add runtime pm support")
Fixes: 04d46a7b38375 ("soundwire: qcom: add in-band wake up interrupt support")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index f5fc8c27012a..c40c25f2d264 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -516,6 +516,7 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
 				    "pm_runtime_get_sync failed in %s, ret %d\n",
 				    __func__, ret);
 		pm_runtime_put_noidle(swrm->dev);
+		return ret;
 	}
 
 	if (swrm->wake_irq > 0) {
@@ -1258,6 +1259,7 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
 				    "pm_runtime_get_sync failed in %s, ret %d\n",
 				    __func__, ret);
 		pm_runtime_put_noidle(swrm->dev);
+		return ret;
 	}
 
 	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
-- 
2.25.1

