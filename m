Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7352ED0E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349779AbiETNYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241528AbiETNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:24:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F814E2C7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053066; x=1684589066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/5zgvFU2ybyvyyFUoqpvM63YLZE49DLKFEnrzYhU8o=;
  b=V3M0pSnl06wJolLg7UOC13DpX7oAQ33BiMo6OISsdZDvAFVCE+5q+hfR
   KLRNo0CZZAwq6/JNKobwiaL2okT2/4RLtdE/26plrYescXsz42yiggQxF
   7wZ6RlnoGItRa7XWZuHbCadmw8JryFnzZ0yTsCKEUH+2yg5VFXHlUjQ2O
   pzsL7SYQTDabW7C7A4XGUywih0vMnauVg6Jo2y9w/ZA2EhFPYOyTcZcua
   MDWG6OseszUTWMSdTdXdi5Bku/i2+UPKjuZWaoFijFI2wIsUCblPABHHz
   dcU4hyD95g1TlKqSoBSNU941b+i/bB9bg8dp8nns9sxMsX3dhk9tEYQA8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335661025"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335661025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715530821"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:24 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf data: Add has_kcore_dir()
Date:   Fri, 20 May 2022 16:24:03 +0300
Message-Id: <20220520132404.25853-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520132404.25853-1-adrian.hunter@intel.com>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function has_kcore_dir(), so that perf inject can determine if
it needs to keep the kcore_dir.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/data.c | 14 ++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index a5ace2bbc28d..caabeac24c69 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -479,6 +479,20 @@ int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz)
 	return mkdir(buf, S_IRWXU);
 }
 
+bool has_kcore_dir(const char *path)
+{
+	char *kcore_dir;
+	int ret;
+
+	if (asprintf(&kcore_dir, "%s/kcore_dir", path) < 0)
+		return false;
+
+	ret = access(kcore_dir, F_OK);
+
+	free(kcore_dir);
+	return !ret;
+}
+
 char *perf_data__kallsyms_name(struct perf_data *data)
 {
 	char *kallsyms_name;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 1402d9657ef2..7de53d6e2d7f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -99,6 +99,7 @@ void perf_data__close_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
 int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
+bool has_kcore_dir(const char *path);
 char *perf_data__kallsyms_name(struct perf_data *data);
 bool is_perf_data(const char *path);
 #endif /* __PERF_DATA_H */
-- 
2.25.1

