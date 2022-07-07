Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6317B569E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiGGJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiGGJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:02:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02810286CE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657184579; x=1688720579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ceV8WWS1WuygJZNoiljZTPQwSaSd2stWwDoPG/Wi1F8=;
  b=JFOXceULp4FjITakNiHr/KISFtAZLJfgd8izrGMAOKwQaYN/Yu68J/1B
   aN2KZMcbfk+o91kaKZZCWQ8eUTx6N6KjlbtrQ6kvq36TYSwWPU1QNRFb7
   TjPr2Vkl89QujAsPODpeV58uRwyUcLfMUtN2nFLDJ35K7QE931TLm5sH+
   jEokPVXdiYRvKcEvqbsHw0/i9PyHjQRqDR++2ga460i7qMZIgZzvrOzhK
   ICmZrDe+pPOC6sizpeautuvgkMzeWtYG19FMymICqXax2EasIzhYlJz0U
   ZamJFHP15SYuN59Qa51/ObNMwUsAkTF4wtEunm9X0gJUyi6I623pVPtWE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285098962"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="285098962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 02:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="770361143"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2022 02:02:54 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     andy@kernel.org, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Date:   Thu,  7 Jul 2022 11:13:00 +0200
Message-Id: <20220707091301.1282291-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add strsplit_u32() and its __user variant to allow for splitting
specified string into array of u32 tokens.

Originally this functionality was added for the SOF sound driver. As
more users are on the horizon, relocate it so it becomes a common good.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/string_helpers.h    |  3 +
 lib/string_helpers.c              | 96 +++++++++++++++++++++++++++++++
 sound/soc/sof/sof-client-probes.c | 51 +---------------
 3 files changed, 100 insertions(+), 50 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4d72258d42fd..a4630ddfca27 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -126,4 +126,7 @@ static inline const char *str_enabled_disabled(bool v)
 	return v ? "enabled" : "disabled";
 }
 
+int strsplit_u32(const char *str, const char *delim, u32 **tkns, size_t *num_tkns);
+int strsplit_u32_user(const char __user *from, size_t count, loff_t *ppos, const char *delim,
+		      u32 **tkns, size_t *num_tkns);
 #endif
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5ed3beb066e6..bb24f0c62539 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -984,3 +984,99 @@ void fortify_panic(const char *name)
 }
 EXPORT_SYMBOL(fortify_panic);
 #endif /* CONFIG_FORTIFY_SOURCE */
+
+/**
+ * strsplit_u32 - Split string into sequence of u32 tokens
+ * @str:	The string to split into tokens.
+ * @delim:	The string containing delimiter characters.
+ * @tkns:	Returned u32 sequence pointer.
+ * @num_tkns:	Returned number of tokens obtained.
+ *
+ * On success @num_tkns and @tkns are assigned the number of tokens extracted
+ * and the array itself respectively.
+ * Caller takes responsibility for freeing @tkns when no longer needed.
+ */
+int strsplit_u32(const char *str, const char *delim, u32 **tkns, size_t *num_tkns)
+{
+	size_t max_count = 32;
+	size_t count = 0;
+	char *s, **p;
+	u32 *buf, *tmp;
+	int ret = 0;
+
+	p = (char **)&str;
+	*tkns = NULL;
+	*num_tkns = 0;
+
+	buf = kcalloc(max_count, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while ((s = strsep(p, delim)) != NULL) {
+		ret = kstrtouint(s, 0, buf + count);
+		if (ret)
+			goto free_buf;
+
+		if (++count > max_count) {
+			max_count *= 2;
+			tmp = krealloc(buf, max_count * sizeof(*buf), GFP_KERNEL);
+			if (!tmp) {
+				ret = -ENOMEM;
+				goto free_buf;
+			}
+			buf = tmp;
+		}
+	}
+
+	if (!count)
+		goto free_buf;
+	*tkns = kmemdup(buf, count * sizeof(*buf), GFP_KERNEL);
+	if (*tkns == NULL) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+	*num_tkns = count;
+
+free_buf:
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(strsplit_u32);
+
+/**
+ * strsplit_u32_user - Split string into sequence of u32 tokens
+ * @from:	The user space buffer to read from
+ * @ppos:	The current position in the buffer
+ * @count:	The maximum number of bytes to read
+ * @delim:	The string containing delimiter characters.
+ * @tkns:	Returned u32 sequence pointer.
+ * @num_tkns:	Returned number of tokens obtained.
+ *
+ * On success @num_tkns and @tkns are assigned the number of tokens extracted
+ * and the array itself respectively.
+ * Caller takes responsibility for freeing @tkns when no longer needed.
+ */
+int strsplit_u32_user(const char __user *from, size_t count, loff_t *ppos, const char *delim,
+		      u32 **tkns, size_t *num_tkns)
+{
+	char *buf;
+	int ret;
+
+	buf = kmalloc(count + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(buf, count, ppos, from, count);
+	if (ret != count) {
+		ret = (ret < 0) ? ret : -EIO;
+		goto free_buf;
+	}
+
+	buf[count] = '\0';
+	ret = strsplit_u32(buf, delim, tkns, num_tkns);
+
+free_buf:
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(strsplit_u32_user);
diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index 1f1ea93a7fbf..48ebbe58e2b9 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/string_helpers.h>
 #include <sound/soc.h>
 #include <sound/sof/header.h>
 #include "sof-client.h"
@@ -410,56 +411,6 @@ static const struct snd_compress_ops sof_probes_compressed_ops = {
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
 static int tokenize_input(const char __user *from, size_t count,
 			  loff_t *ppos, u32 **tkns, size_t *num_tkns)
 {
-- 
2.25.1

