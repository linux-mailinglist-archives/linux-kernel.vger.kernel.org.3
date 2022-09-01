Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F35A9547
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiIALBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiIALAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:00:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDB17E1F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030046; x=1693566046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zy4CSrpaJAYBla5BDSC7jJY6v5GCwWmwkq2T0G0SkeQ=;
  b=nQIRTicsNrnNDZBvLn++YJUEeTeREoDH/JmzzrC+YTwGrzi/9s9SoMBK
   LRV/LDNO+1vrbVl1IuiMUfkmjx/XZwQ4NYabgl3yJtkv96SsWQ65IpLxU
   /BlPKVGTVCOf7rk3K48ICpCdQZ0JW2ed4TZbrKllu80WpUEmJqQ9OaZvm
   ZvF2TQ2VNjCjkZmjRInabywFN8NIsM91FkotNCjgCC/xkuwuBmDffaPvk
   JTTmvodeKNC7we4FND+jbqAkxr8QSkpsy3DjGIJV+kjsWSoNaQVbnN+Ue
   ggRx7jQT/tMcErImzw4BT83sLVmnJ2pqL8QVszssAM5qiioHuT02nLpuX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294424780"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294424780"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673799598"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf intel-pt: Support itrace option flag d+e to log on error
Date:   Thu,  1 Sep 2022 14:00:27 +0300
Message-Id: <20220901110032.9226-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
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

Hi

Here are a few patches to add the ability to output the decoding debug log
only when there are decoding errors.

This is motivated by the fact that a full log can be very large, so just
getting interesting bits is useful for analyzing errors.

If necessary, the size of output on error is configurable via perf config,
and perf_config_scan() was added in the 1st patch to make that simpler.

The 2nd patch adds the new option flag to auxtrace.

There are a couple of very minor and essentially unrelated changes in
patches 3 and 4.

The main Intel PT change is in patch 5 and there is a small example in the
commit message.


Adrian Hunter (5):
      perf tools: Add perf_config_scan()
      perf auxtrace: Add itrace option flag d+e to log on error
      perf intel-pt: Improve man page layout slightly
      perf intel-pt: Improve object code read error message
      perf intel-pt: Support itrace option flag d+e to log on error

 tools/perf/Documentation/itrace.txt             |  1 +
 tools/perf/Documentation/perf-config.txt        |  7 ++
 tools/perf/Documentation/perf-intel-pt.txt      | 13 +++-
 tools/perf/util/auxtrace.c                      | 13 ++++
 tools/perf/util/auxtrace.h                      |  3 +
 tools/perf/util/config.c                        | 31 ++++++++
 tools/perf/util/config.h                        |  1 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.c | 94 ++++++++++++++++++++++++-
 tools/perf/util/intel-pt-decoder/intel-pt-log.h |  3 +-
 tools/perf/util/intel-pt.c                      | 23 +++++-
 10 files changed, 183 insertions(+), 6 deletions(-)


Regards
Adrian
