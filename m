Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89B45AAE3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiIBMVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiIBMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:21:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88215A01
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662121199; x=1693657199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wbf36R8tPwDs/lN78MtL72HqGQOsM+BzFflTRh5/SCE=;
  b=jaFSVVGqOasowkq+/QU8K1NLh8oik+2N9aDdliLF4a0DRPT81Txw82pt
   SkKx2jqOoZ4xD2BmXiylylBLXiVY4atz5vFHk0B4okZtobfPrIlELxQZN
   uNK6ZVvprrqUIKwW4KMJeFRDn8VAUCAHAGApcqioQAaAe6AGjp1n8nrhA
   +5K2Hfks1cq/1j9nk24Z6VPuoeivlijGxE6oG1u54pi/+Pu7oz8nq0iYy
   gGWQE1w5ckUZnNuMLXgBooOiZG0hfKIjstoJ0nv3y1BwajMfH6lRlTUNx
   rf1Hc/AGuziihB7ZUh9XbhQJpDBsU9UIN+tS1dOy3VjJyqIqB5JQxBty7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275712455"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="275712455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563947000"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Sep 2022 05:19:54 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, andy@kernel.org,
        intel-poland@eclists.intel.com, andy.shevchenko@gmail.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v4 2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
Date:   Fri,  2 Sep 2022 14:29:28 +0200
Message-Id: <20220902122928.632602-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902122928.632602-1-cezary.rojewski@intel.com>
References: <20220902122928.632602-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of global integer-array parsing helper instead of the internal
one as both serve same purpose. With that, both strsplit_u32() and
tokenize_input() become unused so remove them.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/sof/sof-client-probes.c | 104 ++++++------------------------
 1 file changed, 18 insertions(+), 86 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index eb246b823461..aad7fdc665d7 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -12,6 +12,8 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/string_helpers.h>
+
 #include <sound/soc.h>
 #include <sound/sof/header.h>
 #include "sof-client.h"
@@ -410,79 +412,6 @@ static const struct snd_compress_ops sof_probes_compressed_ops = {
 	.copy = sof_probes_compr_copy,
 };
 
-/**
- * strsplit_u32 - Split string into sequence of u32 tokens
- * @buf:	String to split into tokens.
- * @delim:	String containing delimiter characters.
- * @tkns:	Returned u32 sequence pointer.
- * @num_tkns:	Returned number of tokens obtained.
- */
-static int strsplit_u32(char *buf, const char *delim, u32 **tkns, size_t *num_tkns)
-{
-	char *s;
-	u32 *data, *tmp;
-	size_t count = 0;
-	size_t cap = 32;
-	int ret = 0;
-
-	*tkns = NULL;
-	*num_tkns = 0;
-	data = kcalloc(cap, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	while ((s = strsep(&buf, delim)) != NULL) {
-		ret = kstrtouint(s, 0, data + count);
-		if (ret)
-			goto exit;
-		if (++count >= cap) {
-			cap *= 2;
-			tmp = krealloc(data, cap * sizeof(*data), GFP_KERNEL);
-			if (!tmp) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-			data = tmp;
-		}
-	}
-
-	if (!count)
-		goto exit;
-	*tkns = kmemdup(data, count * sizeof(*data), GFP_KERNEL);
-	if (!(*tkns)) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-	*num_tkns = count;
-
-exit:
-	kfree(data);
-	return ret;
-}
-
-static int tokenize_input(const char __user *from, size_t count,
-			  loff_t *ppos, u32 **tkns, size_t *num_tkns)
-{
-	char *buf;
-	int ret;
-
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = simple_write_to_buffer(buf, count, ppos, from, count);
-	if (ret != count) {
-		ret = ret >= 0 ? -EIO : ret;
-		goto exit;
-	}
-
-	buf[count] = '\0';
-	ret = strsplit_u32(buf, ",", tkns, num_tkns);
-exit:
-	kfree(buf);
-	return ret;
-}
-
 static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 					  size_t count, loff_t *ppos)
 {
@@ -548,8 +477,8 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
 	struct sof_probe_point_desc *desc;
-	size_t num_tkns, bytes;
-	u32 *tkns;
+	u32 num_elems, *array;
+	size_t bytes;
 	int ret, err;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -557,16 +486,18 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = parse_int_array_user(from, count, (int **)&array);
 	if (ret < 0)
 		return ret;
-	bytes = sizeof(*tkns) * num_tkns;
-	if (!num_tkns || (bytes % sizeof(*desc))) {
+
+	num_elems = *array;
+	bytes = sizeof(*array) * num_elems;
+	if (!num_elems || (bytes % sizeof(*desc))) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	desc = (struct sof_probe_point_desc *)tkns;
+	desc = (struct sof_probe_point_desc *)&array[1];
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
@@ -583,7 +514,7 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 	if (err < 0)
 		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
 exit:
-	kfree(tkns);
+	kfree(array);
 	return ret;
 }
 
@@ -603,8 +534,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 	struct sof_client_dev *cdev = file->private_data;
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
-	size_t num_tkns;
-	u32 *tkns;
+	u32 num_elems, *array;
 	int ret, err;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -612,10 +542,12 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = parse_int_array_user(from, count, (int **)&array);
 	if (ret < 0)
 		return ret;
-	if (!num_tkns) {
+
+	num_elems = *array;
+	if (!num_elems) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -626,7 +558,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		goto exit;
 	}
 
-	ret = sof_probes_points_remove(cdev, tkns, num_tkns);
+	ret = sof_probes_points_remove(cdev, &array[1], num_elems);
 	if (!ret)
 		ret = count;
 
@@ -635,7 +567,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 	if (err < 0)
 		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
 exit:
-	kfree(tkns);
+	kfree(array);
 	return ret;
 }
 
-- 
2.25.1

