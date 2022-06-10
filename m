Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048054659A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiFJLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiFJLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:33:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8B6D4E6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860814; x=1686396814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LW6LmcGDJTFBaX5yGRnwzECDDr+FEtnXQcNFueBGtqg=;
  b=CCAHfOJxTE8QoljSAG3VoX2hsGgM6vQLDw7X0z4MXgGX89RYUKmG4asx
   F89lfG3fW2XSLCQeeGywqaK1YEyVywwB8N3WLYnbmjZbxo7//XatpbTul
   xdkyy2VyH1Se2iOUv6etD2zNuSkSZjQDxXGuRGXqK2W53dwubGrZ5P5qb
   WbJhqK2LqHOUFrEg5Aw7Dib7YP7QQiQGcp1BTmzPqZFW//gJKlXMxi5FQ
   tjz4oVfGffWp34qGhL+/b6x4AZ2V389cMVKmFU+hyqRf/c9qwbLVwmjid
   KJw3mczh/EE+ERcW07o7iwz3luPlaeW/YujDEFfBlGkmVbqsupzjYVajt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275134321"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275134321"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616446306"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf record: Preparation for sideband injection
Date:   Fri, 10 Jun 2022 14:33:11 +0300
Message-Id: <20220610113316.6682-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some small patches in preparation for "sideband injection".

I hope to run perf record in a virtual machine to capture sideband events
while simulataneously running perf record with Intel PT on the host, and
then subsequently inject the sideband events from the guest perf.data file
into the host perf.data file, so that decoding can decode the Intel PT
trace for the periods when the guest is running user space (kernel space
is already decodable).

The patches are changes I have found so far that will be needed.


Adrian Hunter (5):
      perf record: Always get text_poke events with --kcore option
      perf record: Always record id index
      perf record: Add new option to sample identifier
      perf record: Add finished init event
      perf script: Add some missing event dumps

 tools/lib/perf/include/perf/event.h      |  1 +
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/builtin-inject.c              |  1 +
 tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++++++-----
 tools/perf/builtin-script.c              |  6 +++++
 tools/perf/util/event.c                  |  1 +
 tools/perf/util/header.c                 |  3 +++
 tools/perf/util/record.c                 |  2 +-
 tools/perf/util/record.h                 |  1 +
 tools/perf/util/session.c                |  4 +++
 tools/perf/util/synthetic-events.c       |  7 +++--
 tools/perf/util/tool.h                   |  3 ++-
 12 files changed, 65 insertions(+), 11 deletions(-)


Regards
Adrian
