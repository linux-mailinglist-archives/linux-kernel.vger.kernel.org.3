Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709335ACCE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiIEHeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiIEHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:34:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9BCFD09
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363278; x=1693899278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rFeB9/OSr3GD/GXsmtQ3kQLgtYrMBz8kA/r9nXlUCj0=;
  b=KF2ynL3TW0kA/hPPZh1xkaU5Aw9/wt7itIKXsIuI4OSjeCHZexUdo/lb
   Z7XMQoFGpsQCorEqrJZ/un8TcbC9flTcikAPe1YxVdA/a1qizWaOuip1E
   3y+QmayA4nQ+ahDlWGRWQRIy0+IkTfDaXwhKaCPtogcNUkaLm5z2rtWJ3
   nCHq5bhUnyMULqZRGTNlgUViWGD6CMNB+owR5AqgC995VdhDUHPwPFG3O
   M50GTxUMxkB5ybP2VcxZspITLeUGflIoOYCrUG5LYuBYb8ZvigdgUHOBu
   bEcyyxV0aaKTeLO0d92zT/JS5XesmJQ3vKHPhrbChV4wx0arD0Y12RTuE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="360283454"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="360283454"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609595351"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] perf intel-pt: Support itrace option flag d+e to log on error
Date:   Mon,  5 Sep 2022 10:34:18 +0300
Message-Id: <20220905073424.3971-1-adrian.hunter@intel.com>
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


Changes in V2:

      perf intel-pt: Support itrace option flag d+e to log on error
	Ensure log_buf is defined before use

      perf intel-pt: Remove first line of log dumped on error
	Remove first line only if the buffer has wrapped


Adrian Hunter (6):
      perf tools: Add perf_config_scan()
      perf auxtrace: Add itrace option flag d+e to log on error
      perf intel-pt: Improve man page layout slightly
      perf intel-pt: Improve object code read error message
      perf intel-pt: Support itrace option flag d+e to log on error
      perf intel-pt: Remove first line of log dumped on error

 tools/perf/Documentation/itrace.txt             |   1 +
 tools/perf/Documentation/perf-config.txt        |   7 ++
 tools/perf/Documentation/perf-intel-pt.txt      |  13 ++-
 tools/perf/util/auxtrace.c                      |  13 +++
 tools/perf/util/auxtrace.h                      |   3 +
 tools/perf/util/config.c                        |  31 +++++++
 tools/perf/util/config.h                        |   1 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.c | 117 +++++++++++++++++++++++-
 tools/perf/util/intel-pt-decoder/intel-pt-log.h |   3 +-
 tools/perf/util/intel-pt.c                      |  23 ++++-
 10 files changed, 206 insertions(+), 6 deletions(-)


Regards
Adrian
