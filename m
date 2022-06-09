Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB9544FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbiFIOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbiFIOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:52:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC521D51BE;
        Thu,  9 Jun 2022 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654786363; x=1686322363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L3j3KLTjGzl6L8doNicMHi1urVgpP9e31Lf5zLVOHXs=;
  b=ak5Cm/zWU1Q2gNxHWl/hk+wxrL7G9QlnQsSWO11/onghzivsLcKoSDPt
   v8gO5fdMsuN7DtKSAE7/ayZs1HH/pge155chTLm7aXrWx5y/jxxywk4qa
   rA6ZJgsLDt4D/nvR6S06umDVCSzUq0WLi6bOwUPCmIBB1ej5PI652Eoiu
   thxfKxfaDXyVAP19oehLEgisskAuaV4TrirSURVAxA/LgUXCbU5n4Y+Jo
   jxLAXhZLdGIf2OD/zRbmiR4rumZppGklfziikdOhBv+liYinGqIjAe91N
   m7eSEgQ7Q7V70dAfgRYb4Sg1RtH/+qJDOEOQHS3Xbr22eF53LSuAsViH/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257132165"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257132165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 07:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="827633469"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2022 07:52:40 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH v2 0/5] Add perf stat default events for hybrid machines
Date:   Thu,  9 Jun 2022 22:53:09 +0800
Message-Id: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 tools/perf/arch/x86/util/topdown.c | 52 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  1 +
 tools/perf/builtin-stat.c          | 50 ++++-------------------
 tools/perf/util/evlist.c           | 11 +++--
 tools/perf/util/evlist.h           |  9 ++++-
 tools/perf/util/evsel.c            |  7 +++-
 tools/perf/util/evsel.h            |  1 +
 tools/perf/util/stat-display.c     |  2 +-
 tools/perf/util/topdown.c          |  7 ++++
 tools/perf/util/topdown.h          |  3 +-
 12 files changed, 167 insertions(+), 60 deletions(-)

-- 
2.25.1

