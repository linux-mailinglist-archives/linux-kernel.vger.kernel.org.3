Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405945AAF6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiIBMh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiIBMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:37:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A662DF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662121194; x=1693657194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iito/a+ymZLPMsxae6Mq4cZS1ef+cun+eIfLQGc3m4I=;
  b=XHnE2BlyUKK7kyvmzMDwujYhOQOXV+XXBz7r7j1pLW1fBZFgDC1wDHhd
   TsZ3tyllsOq0skKf4sSQGAAVzkd30L2EvNUgLDCbHAB1luHKfKjkp6H56
   WGJ+a5WeM1sYD+jU9QTSjkx/SrcXhUrHmKAglqpGNvQaDZmooOZYZ2KQw
   /0Ewb/8oM5Y9Pw/N+BSfkD0SFQocfXDL9MIp9JV1aeAiV2geHornaCg1O
   fl1P4zH0tPt69sWwqHvxlavBabSO2q+H+aKc/DcPPQE8bqqBRT1aFxmdO
   wjgDo5im+JDbfXzaGIqia/7Do6b74PXSuuIPpoNVQSK6/E1zkCIsACRNs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275712444"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="275712444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563946995"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Sep 2022 05:19:49 -0700
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
Subject: [PATCH v4 1/2] lib/string_helpers: Introduce parse_int_array_user()
Date:   Fri,  2 Sep 2022 14:29:27 +0200
Message-Id: <20220902122928.632602-2-cezary.rojewski@intel.com>
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

Add new helper function to allow for splitting specified user string
into a sequence of integers. Internally it makes use of get_options() so
the returned sequence contains the integers extracted plus an additional
element that begins the sequence and specifies the integers count.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4d72258d42fd..dc2e726fd820 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -21,6 +21,8 @@ enum string_size_units {
 void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
 		     char *buf, int len);
 
+int parse_int_array_user(const char __user *from, size_t count, int **array);
+
 #define UNESCAPE_SPACE		BIT(0)
 #define UNESCAPE_OCTAL		BIT(1)
 #define UNESCAPE_HEX		BIT(2)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5ed3beb066e6..d0c8f6ecf84c 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -131,6 +131,51 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 }
 EXPORT_SYMBOL(string_get_size);
 
+/**
+ * parse_int_array_user - Split string into a sequence of integers
+ * @from:	The user space buffer to read from
+ * @ppos:	The current position in the buffer
+ * @count:	The maximum number of bytes to read
+ * @tkns:	Returned pointer to sequence of integers
+ *
+ * On success @tkns is allocated and initialized with a sequence of
+ * integers extracted from the @from plus an additional element that
+ * begins the sequence and specifies the integers count.
+ *
+ * Caller takes responsibility for freeing @tkns when it is no longer
+ * needed.
+ */
+int parse_int_array_user(const char __user *from, size_t count, int **array)
+{
+	int *ints, nints;
+	char *buf;
+	int ret = 0;
+
+	buf = memdup_user_nul(from, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	get_options(buf, 0, &nints);
+	if (!nints) {
+		ret = -ENOENT;
+		goto free_buf;
+	}
+
+	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
+	if (!ints) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	get_options(buf, nints + 1, ints);
+	*array = ints;
+
+free_buf:
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(parse_int_array_user);
+
 static bool unescape_space(char **src, char **dst)
 {
 	char *p = *dst, *q = *src;
-- 
2.25.1

