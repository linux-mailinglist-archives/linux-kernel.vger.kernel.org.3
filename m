Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6EB5A954A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiIALBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiIALBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:01:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB111B60E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030054; x=1693566054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nd+dFMrIYKlvpN9Bna4ZvCa7BtWRiwnW4U6nXtKLvO0=;
  b=I10jcfcw1buXj/IEvEekFTfyuQcMpcfe4JfF35ZXBajbFI4QLf9iSwNs
   RjVtgDjsZuFnTOaSFfW6kcvwkyZfcudhu7aVXs3VYfa2eJaI5xBiYAMjR
   3G6iqQsUp1KABcCqWYjBbhw/U/hwF57TX6/Y+oVzdJwrknbLQ9drH++yt
   be9b9VTQbWQKiCffYh1TFF3vDeo52ssI+lknC9ZPHGwP/4WZ7GUalJ4sx
   ty9jcXmOnBArrWTCpuktAU4283Dvthr55sjrcTbSCG76qIohpz7FNpwme
   aFnZLmUMC4geSofOZfzdRJR27pC9eIEUq4x10JHoBA5zy25Ewtxadejjn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294424820"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294424820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673799682"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf intel-pt: Improve object code read error message
Date:   Thu,  1 Sep 2022 14:00:31 +0300
Message-Id: <20220901110032.9226-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901110032.9226-1-adrian.hunter@intel.com>
References: <20220901110032.9226-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
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

The offset is more readable in hex instead of decimal.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d5e9fc8106dd..c01ff8001501 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -842,7 +842,8 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 						    offset, buf,
 						    INTEL_PT_INSN_BUF_SZ);
 			if (len <= 0) {
-				intel_pt_log("ERROR: failed to read at %" PRIu64 " ", offset);
+				intel_pt_log("ERROR: failed to read at offset %#" PRIx64 " ",
+					     offset);
 				if (intel_pt_enable_logging)
 					dso__fprintf(al.map->dso, intel_pt_log_fp());
 				return -EINVAL;
-- 
2.25.1

