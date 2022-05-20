Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47F52ED0F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiETNYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349809AbiETNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:24:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A216A259
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053067; x=1684589067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMnp/mUn9icKbmgubdGL7zBlHw8RhPKRnVLhR4Xj7z0=;
  b=heKWjdnw8xkNC4ErvX6YCMbVBTo7CRwpTkkJyJJrORcw9j6cHGS5ynAt
   j18ZagxwE31cxW6P7771rWhF5Kpy3/ZmcO989VaVqxHT9ndg0b/t+2ESy
   xB2F8P34JINDdLB4wFkxiYySZOTyXg6gCK4r+iXZKiM2zpdSjXmBWElbg
   niDh1BQ61s8CQnt/z5vb6fdwcsfQtIOeid9Im8UmivfGrZ26zkck0HmpG
   YxVEWmrZSWEWirrOJjtYmYgcxQTByxu0/QQI7r8lSEg9BRHY09nqZZW3Z
   z9IFyih9oh5EaFdsXH91ylYI42/gXXDWxbi2Fgvp6RJWvAyT+5NSW0qPq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335661033"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335661033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715530824"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf inject: Keep a copy of kcore_dir
Date:   Fri, 20 May 2022 16:24:04 +0300
Message-Id: <20220520132404.25853-6-adrian.hunter@intel.com>
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

If the input perf.data has a kcore_dir, copy it into the output, since
at least the kallsyms in the kcore_dir will be useful to the output.

Example:

 Before:

  $ ls -lR perf.data-from-desktop
  perf.data-from-desktop:
  total 916
  -rw------- 1 user user 931756 May 19 09:55 data
  drwx------ 2 user user   4096 May 19 09:55 kcore_dir

  perf.data-from-desktop/kcore_dir:
  total 42952
  -r-------- 1 user user  7582467 May 19 09:55 kallsyms
  -r-------- 1 user user 36388864 May 19 09:55 kcore
  -r-------- 1 user user     4828 May 19 09:55 modules

  $ perf inject -i perf.data-from-desktop -o injected-perf.data

  $ ls -lR injected-perf.data
  -rw------- 1 user user 931320 May 20 15:08 injected-perf.data

 After:

  $ perf inject -i perf.data-from-desktop -o injected-perf.data

  $ ls -lR injected-perf.data
  injected-perf.data:
  total 916
  -rw------- 1 user user 931320 May 20 15:21 data
  drwx------ 2 user user   4096 May 20 15:21 kcore_dir

  injected-perf.data/kcore_dir:
  total 42952
  -r-------- 1 user user  7582467 May 20 15:21 kallsyms
  -r-------- 1 user user 36388864 May 20 15:21 kcore
  -r-------- 1 user user     4828 May 20 15:21 modules

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 71b6eafe4c19..a75bf11585b5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -50,6 +50,7 @@ struct perf_inject {
 	bool			in_place_update;
 	bool			in_place_update_dry_run;
 	bool			is_pipe;
+	bool			copy_kcore_dir;
 	const char		*input_name;
 	struct perf_data	output;
 	u64			bytes_written;
@@ -880,6 +881,19 @@ static int feat_copy_cb(struct feat_copier *fc, int feat, struct feat_writer *fw
 	return 1; /* Feature section copied */
 }
 
+static int copy_kcore_dir(struct perf_inject *inject)
+{
+	char *cmd;
+	int ret;
+
+	ret = asprintf(&cmd, "cp -r -n %s/kcore_dir* %s >/dev/null 2>&1",
+		       inject->input_name, inject->output.path);
+	if (ret < 0)
+		return ret;
+	pr_debug("%s\n", cmd);
+	return system(cmd);
+}
+
 static int output_fd(struct perf_inject *inject)
 {
 	return inject->in_place_update ? -1 : perf_data__fd(&inject->output);
@@ -995,6 +1009,12 @@ static int __cmd_inject(struct perf_inject *inject)
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
 		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc);
+
+		if (inject->copy_kcore_dir) {
+			ret = copy_kcore_dir(inject);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -1131,9 +1151,16 @@ int cmd_inject(int argc, const char **argv)
 		}
 		if (!inject.in_place_update_dry_run)
 			data.in_place_update = true;
-	} else if (perf_data__open(&inject.output)) {
-		perror("failed to create output file");
-		return -1;
+	} else {
+		if (strcmp(inject.output.path, "-") && !inject.strip &&
+		    has_kcore_dir(inject.input_name)) {
+			inject.output.is_dir = true;
+			inject.copy_kcore_dir = true;
+		}
+		if (perf_data__open(&inject.output)) {
+			perror("failed to create output file");
+			return -1;
+		}
 	}
 
 	data.path = inject.input_name;
-- 
2.25.1

