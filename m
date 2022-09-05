Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A75ACCD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiIEHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiIEHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:34:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74110FD7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363288; x=1693899288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5+cFdZuhJFU58XSt+XWu8IhXjGVt378HIsUWt4m88gg=;
  b=QovO8eKqoEB4fi6dKneCY7r8XVM6JI0zz4OVgobFoU0cOpQtMyLRI7kK
   nBEZXGFt2AnI0O+2VAbea/+s0M641CRYoBrAOvRk1hD3KUt4gp15b4UZu
   0fnAmXoa/3vU7Nr+TeSaFzJouc1VsfR1oThTrwVEGXe6xysYEjk/EaSju
   Qxra5mQOWXszWx75D99hMX8mMkENqlo9wRZS/JTF/yQ69efSFf+fNnBBJ
   vy8evHEWEFx6FiEU6j+pMiZNXU7zHdBXTDkELZIjFzWZLxMglJuI0BSGL
   s95ICnW6kG3yAHWHhcd/ky03oUmWWmdLaJoxuhnMAr84qkipGTx+vhhxT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="296332700"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="296332700"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609595386"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/6] perf intel-pt: Improve object code read error message
Date:   Mon,  5 Sep 2022 10:34:22 +0300
Message-Id: <20220905073424.3971-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905073424.3971-1-adrian.hunter@intel.com>
References: <20220905073424.3971-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset is more readable in hex instead of decimal.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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

