Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6B5ACD27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiIEHrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIEHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:47:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F73A4B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364065; x=1693900065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MxKaFoJUBiibjQngRYpH9q0dUJkS052ByEu905h3Hws=;
  b=XtbSbO0D63jYNUz22oiOZ936ltSHE8h0yZJ1kIIZKPa4thG50fuumWgq
   TK/hbhgqan5wBioZapg32B3sxmZvoeTt0hJFhiemYHXpzvfxyg4dawo23
   uvQkPlUGTI0nxixzqT/ZF3OJkGNH4c4XgwyrUbIAOkhWlC9HZ2IJH4zq5
   S8OCBWcDprlEEIuN8HhtfIhh1b05bm+3GkGp1v9QTITZAnW0YWQ9puAxL
   94gxPN7RKQ+P5pwS9KyGIdU03xfW4wqdNawwJjal7C1w7MS7TWFchlSKe
   74i2AEI0tW+EdYdh9SgHfQdwI7jG5gvnNPX/314Y2V6x9Zw8OCheEwPKB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297118890"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="297118890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:47:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609599032"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:47:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] perf dlfilter: dlfilter-show-cycles: Fix types for print format
Date:   Mon,  5 Sep 2022 10:47:35 +0300
Message-Id: <20220905074735.4513-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid compiler warning about format %llu that expects long long unsigned
int but argument has type __u64.

Fixes: c3afd6e50fce ("perf dlfilter: Add dlfilter-show-cycles")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Add fixes tag


 tools/perf/dlfilters/dlfilter-show-cycles.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/dlfilters/dlfilter-show-cycles.c b/tools/perf/dlfilters/dlfilter-show-cycles.c
index 9eccc97bff82..6d47298ebe9f 100644
--- a/tools/perf/dlfilters/dlfilter-show-cycles.c
+++ b/tools/perf/dlfilters/dlfilter-show-cycles.c
@@ -98,9 +98,9 @@ int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, vo
 static void print_vals(__u64 cycles, __u64 delta)
 {
 	if (delta)
-		printf("%10llu %10llu ", cycles, delta);
+		printf("%10llu %10llu ", (unsigned long long)cycles, (unsigned long long)delta);
 	else
-		printf("%10llu %10s ", cycles, "");
+		printf("%10llu %10s ", (unsigned long long)cycles, "");
 }
 
 int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
-- 
2.25.1

