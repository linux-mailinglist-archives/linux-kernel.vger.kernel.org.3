Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570225AB33B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiIBOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbiIBOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:18:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A223715F8AE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662126228; x=1693662228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wbf36R8tPwDs/lN78MtL72HqGQOsM+BzFflTRh5/SCE=;
  b=SovRfZchk8ZNmqfTFJ0BMvXvq55Zi6fUlwq+TUB3wXW0wshens7jLcna
   gZIH7jjPoTrVttHY2GjdLR2my+eZ/uFQnLM/gSIrjo7Z+U8AfQptsu65f
   VZc/RdLGZo1+TyGiP6EDfC43TuUDEjoMbu8OO/k/f1uYvW1cLI5RGQPE/
   5TSLVJ5WDBCAgV7hv4cPfTDmcvR1cGz44ufyegCE2GHqDEZkmoAW+l3al
   tfio9+KgxvRRitQP3Y7b/QCJA5VvN2YVh7jhzpREToolTAS8iI/JInRWg
   TQe8KD+pzJob0yZuO+m+2U4bLfoB8F9fjrBlRhhmIRc528Oppkb9i0F98
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297264235"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="297264235"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674352589"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2022 06:23:17 -0700
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
Subject: [PATCH v5 2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
Date:   Fri,  2 Sep 2022 15:32:56 +0200
Message-Id: <20220902133256.789165-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902133256.789165-1-cezary.rojewski@intel.com>
References: <20220902133256.789165-1-cezary.rojewski@intel.com>
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

