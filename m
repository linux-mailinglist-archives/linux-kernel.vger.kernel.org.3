Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3519255328C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbiFUMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiFUMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:52:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA62872B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655815921; x=1687351921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/D5mciaX5QYYbf7vjhZDya04aE2F+rRnhiA6yYosjo=;
  b=dVRHL6GdnU8XO1vSz7wirKzDeri56QRcPIU4RpR/LZynBcT+C5VL9y/G
   0N9H7o1AGzkchvvFNDWM7byXrjqAaxkHNY7Fj2p7bpgHN1FVl1e9/8Y2+
   gyIzLpu/S+M9YQI8KF19LkLk2Fy7saWtGX3QogT++7mVn8kFhZea5o5w/
   Dz6uJ+fXEF4BTlLMYAqiAJnaTIBXMkrIaZE1V5FfnmcJEtKrCM5Ai6ZHu
   XL/CA0Q7idUdQLVDsJBGYnFv7XC8ezIYAdx4djzFlsMyFDSEbVlrQdY5o
   huavhOQnRDQ5A8vNV7WxiW5lzO6A9x1ccJVAHzfrXWtnqEEi+hpAlItPI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341793205"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341793205"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:52:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643611323"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:51:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf build-id: Fix caching files with a wrong build ID
Date:   Tue, 21 Jun 2022 15:51:44 +0300
Message-Id: <20220621125144.5623-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build ID events associate a file name with a build ID.  However, when
using perf inject, there is no guarantee that the file on the current
machine at the current time has that build ID. Fix by comparing the
build IDs and skip adding to the cache if they are different.

Example:

 $ echo "int main() {return 0;}" > prog.c
 $ gcc -o prog prog.c
 $ perf record --buildid-all ./prog
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.019 MB perf.data ]
 $ file-buildid() { file $1 | awk -F= '{print $2}' | awk -F, '{print $1}' ; }
 $ file-buildid prog
 444ad9be165d8058a48ce2ffb4e9f55854a3293e
 $ file-buildid ~/.debug/$(pwd)/prog/444ad9be165d8058a48ce2ffb4e9f55854a3293e/elf
 444ad9be165d8058a48ce2ffb4e9f55854a3293e
 $ echo "int main() {return 1;}" > prog.c
 $ gcc -o prog prog.c
 $ file-buildid prog
 885524d5aaa24008a3e2b06caa3ea95d013c0fc5

 Before:

 $ perf buildid-cache --purge $(pwd)/prog
 $ perf inject -i perf.data -o junk
 $ file-buildid ~/.debug/$(pwd)/prog/444ad9be165d8058a48ce2ffb4e9f55854a3293e/elf
 885524d5aaa24008a3e2b06caa3ea95d013c0fc5
 $

 After:

 $ perf buildid-cache --purge $(pwd)/prog
 $ perf inject -i perf.data -o junk
 $ file-buildid ~/.debug/$(pwd)/prog/444ad9be165d8058a48ce2ffb4e9f55854a3293e/elf

 $

Fixes: 454c407ec17a0c ("perf: add perf-inject builtin")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/build-id.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 82f3d46bea70..328668f38c69 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -872,6 +872,30 @@ int build_id_cache__remove_s(const char *sbuild_id)
 	return err;
 }
 
+static int filename__read_build_id_ns(const char *filename,
+				      struct build_id *bid,
+				      struct nsinfo *nsi)
+{
+	struct nscookie nsc;
+	int ret;
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	ret = filename__read_build_id(filename, bid);
+	nsinfo__mountns_exit(&nsc);
+
+	return ret;
+}
+
+static bool dso__build_id_mismatch(struct dso *dso, const char *name)
+{
+	struct build_id bid;
+
+	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) < 0)
+		return false;
+
+	return !dso__build_id_equal(dso, &bid);
+}
+
 static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 			       void *priv __maybe_unused)
 {
@@ -886,6 +910,10 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 		is_kallsyms = true;
 		name = machine->mmap_name;
 	}
+
+	if (!is_kallsyms && dso__build_id_mismatch(dso, name))
+		return 0;
+
 	return build_id_cache__add_b(&dso->bid, name, dso->nsinfo,
 				     is_kallsyms, is_vdso);
 }
-- 
2.25.1

