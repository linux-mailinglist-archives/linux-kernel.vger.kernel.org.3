Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80D546599
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349272AbiFJLdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbiFJLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:33:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51B6D4E6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860816; x=1686396816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mNQZJduS5Qbm45AG8/qW2Xj9yJinjx1/z60P16hri4=;
  b=ijByJ1GKWmhw1yqlHPmav5q1OX94wSZWdHvAAjJY/ptI8/gtAtWXisJT
   LGRamJQ7BXhT283RQdIXDkVjYAHREt5R2TKqetf5CXWds+fHsdw5kH5AU
   p/GrXN//bZ9TR+7Ndk9Tn7RLnJwdTI8g5g2Mhh6M2F4voSsYIhfWmwoxw
   VNTXg2T3lFeX8CV6Nvty2St6sY8oM0vIjaWji8iFXAUSDKCluZVkhs60n
   H8W2okn8PhK/FxHHy449L9gT0nQKPuE5spqaHsCnYsbXU1aWGvAVw8GEP
   exRkhbm2+moXkOCYL4yd/VOpYvTM9RcVBMee2jdZyYofObgCXRKxnj8uF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275134330"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275134330"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616446311"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf record: Always get text_poke events with --kcore option
Date:   Fri, 10 Jun 2022 14:33:12 +0300
Message-Id: <20220610113316.6682-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610113316.6682-1-adrian.hunter@intel.com>
References: <20220610113316.6682-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcore provides a copy of the running kernel including any modified code.
A trace that benefits from that also benefits from text_poke events, so
enable them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9a71f0330137..3959a1b86afb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3805,6 +3805,9 @@ int cmd_record(int argc, const char **argv)
 		goto out_opts;
 	}
 
+	if (rec->opts.kcore)
+		rec->opts.text_poke = true;
+
 	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
-- 
2.25.1

