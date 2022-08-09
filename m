Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519D58D91D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiHINIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:08:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D34AE40
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660050510; x=1691586510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6nuA7BFojAvV82yY2QTMxNPJYI65JNZT/10bCDJ4Gt4=;
  b=FqJ7yBKNzgxwWvlUD9PA9OHEoPf8CcFbIS99+cxMpwuInSgtEXsK8c8q
   rnVkb67b78JgxQZu77bZlTSnDUPEFtP+o6kXVP2ErhwMRjoW23ItlvUA2
   dzKyaBiNd9PwOQj2f/KpvHyJn+Kj6oG180J07gPkRccYzKTkPVTKu6X/i
   Ga7LIRdfeyTFUyKV1GnCh8rYZYCHscLTZYChHWgsnaFyZxaAXoRu/JY7r
   o8Pf+KVIRKdUCMoobeGRwLQ0ok2fNMs2iGdH5TSkhL6gHQUtB3CR1Ithw
   3WNL3siWAo0frXLRj11ujv/qG+YwBpRD7LmIYQ4e7iUvrr9kp8Eju0IZH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270603110"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="270603110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 06:08:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633318732"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 06:08:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix missing free of machine->kallsyms_filename
Date:   Tue,  9 Aug 2022 16:07:58 +0300
Message-Id: <20220809130758.12800-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing free of machine->kallsyms_filename to machine__exit().

Fixes: a5367ecb5353 ("perf tools: Automatically use guest kcore_dir if present")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index facc13fbf16e..2a16cae28407 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -236,6 +236,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->root_dir);
 	zfree(&machine->mmap_name);
 	zfree(&machine->current_tid);
+	zfree(&machine->kallsyms_filename);
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
-- 
2.25.1

