Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5157187E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiGLL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiGLL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:28:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715D55B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625319; x=1689161319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ESTrELnpPz3FhBNWbn7rulh5vFAk9pvEXmbrHBvvj0=;
  b=SfYXeAQQI1J5TtBW7tqMOegTCYYODxO/ERturRUoopgIT2dsJNsv+A5i
   yrqffLMu1Id/eJTHpib1c5hBndduhI7EjdzkPriAq0ufIXjn2Q4eC3alt
   g2KITKoZ7nFpf5J1U3W+6vTJDqfH+9E0SHzM10E4gDzUOM2A0xNAQrkbL
   u0D/KLqU3HRHdQdHDM96PLKiY2aqAtF1eXSiQgrI0j8I4sr+NcuFduOMH
   aUJJ4wOsHsEOac/9ojPqNcqeItQ86++O/1+lmaayOpft+8qHzUfoPqzvW
   T18TVDCX51vmz/MDxjh6R0idLKctR/oiKnosWOE8DnpwPAvChHPN+e7Yv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310523764"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="310523764"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:28:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="652870316"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:28:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf tests: Fix Track with sched_switch test for hybrid case
Date:   Tue, 12 Jul 2022 14:28:22 +0300
Message-Id: <20220712112824.28770-1-adrian.hunter@intel.com>
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

Here are a couple of fixes related to the Track with sched_switch test.


Adrian Hunter (2):
      perf parse-events: Fix segfault when event parser gets an error
      perf tests: Fix Track with sched_switch test for hybrid case

 tools/perf/tests/switch-tracking.c | 18 +++++++++++++-----
 tools/perf/util/parse-events.c     | 14 +++++++++++---
 2 files changed, 24 insertions(+), 8 deletions(-)


Regards
Adrian
