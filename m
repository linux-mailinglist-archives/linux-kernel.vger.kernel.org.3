Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E153F360
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiFGBdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFGBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:33:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67863BDC;
        Mon,  6 Jun 2022 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654565609; x=1686101609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzQeFX68gnIklr+bbjNE8aiCC5EqbVdttq1LHlkCJME=;
  b=RXj9Hs5cNLyOD6Nup9lq8uywIs+YPWzNF01Ie++KywMmWyCRZh+00vNQ
   OXIHHNVMwtjcksNDXp96mSdACoWntWmfDDrM+fFr0D0sSen8TYSllHurA
   H9gxHFJcclmV0pU6rmvfh4HZ0/VGf87huU12xuRtA6AO61b4f90KEVt6N
   ydTlw3RYAYDC2hWy9XKlraACscTUsxZzqIfE3WoVUfHPdumHwVRF6hXQA
   6eSV03SVQkEvOaLF5Ez4EKIf9nYmPY0lvjJ0Kk3fWBZOdBwtRZE20/Zb7
   VbfLjG1oUdktyfdcgqCcHdC63hByLm0qTpPFM5JiUszeIXzYp3vwM1tKh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274239067"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="274239067"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="669760103"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 18:33:24 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 0/5] Add perf stat default events for hybrid machines
Date:   Tue,  7 Jun 2022 09:33:10 +0800
Message-Id: <20220607013315.1956301-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The patch series is to clean up the existing perf stat default and support
the perf metrics Topdown for the p-core PMU in the perf stat default. The
first 4 patches are the clean-up patch and fixing the "--detailed" issue.
The last patch adds support for the perf metrics Topdown, the perf metrics
Topdown support for e-core PMU will be implemented later separately.

Kan Liang (4):
  perf stat: Revert "perf stat: Add default hybrid events"
  perf evsel: Add arch_evsel__hw_name()
  perf evlist: Always use arch_evlist__add_default_attrs()
  perf x86 evlist: Add default hybrid events for perf stat

Zhengjun Xing (1):
  perf stat: Add topdown metrics in the default perf stat on the hybrid
    machine

 tools/perf/arch/x86/util/evlist.c  | 64 +++++++++++++++++++++++++-----
 tools/perf/arch/x86/util/evsel.c   | 20 ++++++++++
 tools/perf/arch/x86/util/topdown.c | 51 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  1 +
 tools/perf/builtin-stat.c          | 50 ++++-------------------
 tools/perf/util/evlist.c           | 11 +++--
 tools/perf/util/evlist.h           |  9 ++++-
 tools/perf/util/evsel.c            |  7 +++-
 tools/perf/util/evsel.h            |  1 +
 tools/perf/util/stat-display.c     |  2 +-
 tools/perf/util/topdown.c          |  7 ++++
 tools/perf/util/topdown.h          |  3 +-
 12 files changed, 166 insertions(+), 60 deletions(-)

-- 
2.25.1

