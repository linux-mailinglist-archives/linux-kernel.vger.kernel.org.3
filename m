Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACDF510CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356268AbiD0AAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356263AbiDZX7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:59:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE749C9C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017402; x=1682553402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8buaCP5WAQdOwNeI5o7LDn1PP+ytMuRXjlhLzBrLdD8=;
  b=QPlfMCj91+C0geqGSHxzZ5hjalrMvDyUPzCAM5/qVMoU1Z8LX3rgDM0y
   8tVH8iO+6ThMjoBRwNhuWMi3xCixmuM7kKVzCS8lC8vLlRXRdjkkAFxLo
   vGnAjBASM9M2WJmi7yzndC7ZWGf9Y03mlYYPhzdqUqu/dfihgNk0UrYsO
   YeCiKbJsREBUr7QSybQjH0wW+wwQocytTiyQOmyvBm9OWr88xILKaoann
   cz4ZZw5fTzrSn80LNIAzuQcj6+8Ci+GLZKjOvlIEPq0tf+/5rLRlwvCkl
   XYucM/oRV7EFfzLjLcPW9opKClz4PgNGJvEthk1xYCKnNC1mwv2cPQxgP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245682893"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245682893"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730515051"
Received: from htamura-mobl2.gar.corp.intel.com (HELO bard-pc.domain.name) ([10.252.185.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:40 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 5/5] soundwire: qcom: use pm_runtime_resume_and_get()
Date:   Wed, 27 Apr 2022 07:56:23 +0800
Message-Id: <20220426235623.4253-6-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/qcom.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c40c25f2d264..c244d31805cc 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -510,12 +510,11 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
 	struct qcom_swrm_ctrl *swrm = dev_id;
 	int ret;
 
-	ret = pm_runtime_get_sync(swrm->dev);
+	ret = pm_runtime_resume_and_get(swrm->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(swrm->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(swrm->dev);
 		return ret;
 	}
 
@@ -1059,12 +1058,11 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai;
 	int ret, i;
 
-	ret = pm_runtime_get_sync(ctrl->dev);
+	ret = pm_runtime_resume_and_get(ctrl->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(ctrl->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(ctrl->dev);
 		return ret;
 	}
 
@@ -1253,12 +1251,11 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
 	struct qcom_swrm_ctrl *swrm = s_file->private;
 	int reg, reg_val, ret;
 
-	ret = pm_runtime_get_sync(swrm->dev);
+	ret = pm_runtime_resume_and_get(swrm->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(swrm->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(swrm->dev);
 		return ret;
 	}
 
-- 
2.25.1

