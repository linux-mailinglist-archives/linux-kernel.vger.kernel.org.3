Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F3520118
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbiEIP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiEIP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:27:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D02AF616
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652109843; x=1683645843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACJiDCUdpywNLMrApEeAJ5BBg2+25UYq+EsolncC7Ao=;
  b=kWt5rmlpwmh/QrvsY44OxIHtilNi+nF0H4pfnNe+L0UkF8F4gTiBdjBO
   Gqacsx0QKWdv9haa8A8SmK9xTmZreoateP98XsjCKWCnOPFAZQN9CI/gU
   5bwPVNZmW74qm2tRopRf6KELKgPN1kx1daLvGUWcnl5cXV/kxlrK5QuZG
   PgQPK8beZgnsWscY6tCypgDNZuK6fXj0MkI7CA17i//XkYu6X0+RfbJLE
   XCFO/rKWaCUkopOi5NfE8cKDWBMlEK+SJtbkEP1fYdk0P6X7fYErn9nCf
   yaNsCjQQdg5QZMArk2SJ1gmtfP529R8d6fBdWSQa45juOr2XvHjK13232
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294306852"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294306852"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592705186"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 08:24:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf intel-pt: Add support for emulated ptwrite
Date:   Mon,  9 May 2022 18:23:57 +0300
Message-Id: <20220509152400.376613-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 3 patches (on top of "perf intel-pt: Add link to the perf wiki's
Intel PT page") to add support for decoding emulated ptwrite i.e. for
hardware that does not have the ptwrite instruction.


Adrian Hunter (3):
      perf intel-pt: Add support for emulated ptwrite
      perf script: Print Intel ptwrite value as a string if it is ASCII
      perf scripts python: intel-pt-events.py: Print ptwrite value as a string if it is ASCII

 tools/perf/Documentation/perf-intel-pt.txt         | 88 +++++++++++++++++++
 tools/perf/builtin-script.c                        | 32 ++++++-
 tools/perf/scripts/python/intel-pt-events.py       |  8 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 99 +++++++++++++++++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |  1 +
 tools/perf/util/intel-pt.c                         | 37 +++++++-
 8 files changed, 261 insertions(+), 6 deletions(-)


Regards
Adrian
