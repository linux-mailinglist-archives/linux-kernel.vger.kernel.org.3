Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AA58D520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiHIIHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiHIIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:07:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BB1AF3E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660032439; x=1691568439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PUcogZsmUXPArsatotSVjKay856CK85QtMa00eTlvBg=;
  b=QQxi6CvhEqXOOVjageA6SFsOwnrFjUR8FvDNDXkSubsc0o7X/XfnryjU
   l5Vh3zQQtoPkxs/vUbE0ZuiQVjETbKtnCOxve50qzCzHd5MvHj9KHLx/9
   3BoAt73ESjM8loGcVDh+/Nd848uYiegWOGWZNtLjgXis4i96q5PnmurRZ
   3od+/Q29BOfiXTxY2YraJK2qSqkBRN8pfgpMoh4YCdxgrsA86A92wKQY9
   bJ4DVRUIOwPSjn1fdq9/fr0lJ5Wsh6OfCSd+qdRd8T3lTDqGUivca0aVh
   EtGLIr7oT6wVb66aeynQpDGngYYGUZqYeX0ME9OIyrTtIpX6/DWdNfwmO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289537542"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="289537542"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:07:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633242844"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:07:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] perf tests: Fix Track with sched_switch test for hybrid case
Date:   Tue,  9 Aug 2022 11:06:59 +0300
Message-Id: <20220809080702.6921-1-adrian.hunter@intel.com>
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

Hi

Here are a couple of fixes (V2) related to the Track with sched_switch test,
and a subsequent tidy-up.


Changes in V2:

      perf parse-events: Fix segfault when event parser gets an error
	Amend commit message to refer to subsequent tidy-up patch

      perf tools: Do not pass NULL to parse_events()
	New patch


Adrian Hunter (3):
      perf parse-events: Fix segfault when event parser gets an error
      perf tests: Fix Track with sched_switch test for hybrid case
      perf tools: Do not pass NULL to parse_events()

 tools/perf/arch/arm/util/cs-etm.c       |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c    |  2 +-
 tools/perf/arch/x86/tests/intel-cqm.c   |  2 +-
 tools/perf/arch/x86/util/intel-bts.c    |  2 +-
 tools/perf/arch/x86/util/intel-pt.c     |  2 +-
 tools/perf/arch/x86/util/iostat.c       |  2 +-
 tools/perf/arch/x86/util/topdown.c      |  2 +-
 tools/perf/tests/code-reading.c         |  2 +-
 tools/perf/tests/event-times.c          |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c |  4 ++--
 tools/perf/tests/hists_cumulate.c       |  2 +-
 tools/perf/tests/hists_filter.c         |  4 ++--
 tools/perf/tests/hists_link.c           |  4 ++--
 tools/perf/tests/hists_output.c         |  2 +-
 tools/perf/tests/keep-tracking.c        |  4 ++--
 tools/perf/tests/perf-time-to-tsc.c     |  2 +-
 tools/perf/tests/switch-tracking.c      | 24 ++++++++++++++++--------
 tools/perf/util/bpf-loader.c            |  2 +-
 tools/perf/util/parse-events.c          | 22 ++++++++++++++++++----
 tools/perf/util/parse-events.h          |  4 ++++
 tools/perf/util/perf_api_probe.c        |  2 +-
 tools/perf/util/record.c                |  2 +-
 22 files changed, 61 insertions(+), 35 deletions(-)


Regards
Adrian
