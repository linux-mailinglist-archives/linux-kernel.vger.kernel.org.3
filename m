Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AF55160C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiFTKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiFTKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:39:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D31400F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721562; x=1687257562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Twk46FsDuF77SRth9P1/m8cJs6aDI8dgjNxONIBlVI=;
  b=cdIdtZiA84xDHhDkPoqXMLDtsQm5E+nnfB0PZF0BlXhckSOplLwfKjOV
   pjyDo7wdqr4CXxMjfA0etNoEYCkiYaNE3PA52SYFAdqdzfGCO0FrEuCga
   4fgvDDLMK9t8Ufpyp6wXV+4oTmfoM9hvAit84HXUWQRgP/xaBHLAaNMUp
   9CVTji4rBe8easnZD0mHSfShOvi1qiCI703WPrp9eLLMigkeq5Op5T4rb
   y7I5MIqLrhOUPcmScz4nW91gFIfTroo9Db5tsn+yxxIIcw4VMMGb02sJP
   ByoB/H5czQg3JrilYKDatXzCTU1lPCICCX95Qodb1wRuX61q1mALemQ5a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262896713"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262896713"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:39:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643056788"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.58.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:39:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject: Fix missing free in copy_kcore_dir()
Date:   Mon, 20 Jun 2022 13:39:04 +0300
Message-Id: <20220620103904.7960-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free string allocated by asprintf().

Fixes: d8fc08550929bb ("perf inject: Keep a copy of kcore_dir")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 42e2918fd1cc..fee9da14afc6 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -891,7 +891,9 @@ static int copy_kcore_dir(struct perf_inject *inject)
 	if (ret < 0)
 		return ret;
 	pr_debug("%s\n", cmd);
-	return system(cmd);
+	ret = system(cmd);
+	free(cmd);
+	return ret;
 }
 
 static int output_fd(struct perf_inject *inject)
-- 
2.25.1

