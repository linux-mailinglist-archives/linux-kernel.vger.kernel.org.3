Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBC497A72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiAXImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242213AbiAXImF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013724; x=1674549724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=00H2+rRNCICoB/WIoPaJixOCO2+VgOT4jsWhhO74k1c=;
  b=F9Z9gi7TRyCPArMhQU/8wwzYswVBuqfWuRnt3lsqfHquA7r9ZapaohQJ
   ySNIsB89SomLenVXOXHCJVpSsuhX9XKgyG55DCeX8UM98xZoIwIfHtqlm
   IGTqgGuwvg2YfPKKDFqJZjwnALkVkJoaWBkpaCqmMwXpIhmIB/DZKqM/x
   uSKIRHwLuXv2ko3ZmIwHLFkg24Yr30vqq7JPFIf/uq+HNE3hZF5s+ZO0Q
   AUFxkpMJONjMRbwWxKK5B1+FsjFA9K8hX2YX46/DBpqFN6Rll/jvCfBb0
   0iKHLYNNSqz0TGCZw6mQYXBafSVwOGhrGfNDFsj32bFpdOdpkt5R3FqN0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778313"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627416929"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:02 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] perf intel-pt: Add support for Event Trace and TNT disable
Date:   Mon, 24 Jan 2022 10:41:36 +0200
Message-Id: <20220124084201.2699795-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Brief documentation is in the last patch with more technical details in
Intel SDM (https://www.intel.com/sdm) version 076.

The patches touch mostly Intel PT and auxtrace code, with a few supporting
changes to perf script.

I am not aware of any hardware that has the new capabilities yet.

Patches can also be found here:

	https://github.com/ahunter6/linux/tree/event-trace


Adrian Hunter (25):
      perf intel-pt: pkt-decoder-test: Fix scope of test_data
      perf intel-pt: pkt-decoder: Remove misplaced linebreak
      perf intel-pt: pkt-decoder: Add CFE and EVD packets
      perf intel-pt: pkt-decoder: Add MODE.Exec IFLAG bit
      perf intel-pt: decoder: Add config bit definitions
      perf intel-pt: decoder: Factor out clearing of FUP event variables
      perf intel-pt: decoder: Add CFE and EVD processing
      perf intel-pt: decoder: Add MODE.Exec IFLAG processing
      perf tools: Define Intel PT CFE / EVD event
      perf tools: Define Intel PT iflag synthesized event
      perf tools: Define new D and t flags
      perf auxtrace: Add itrace option "I"
      perf intel-pt: Record Event Trace capability flag
      perf intel-pt: Synthesize CFE / EVD event
      perf intel-pt: Synthesize iflag event
      perf intel-pt: Synthesize new D and t flags
      perf intel-pt: Force 'quick' mode when TNT is disabled
      perf script: Display Intel PT CFE / EVD synthesized event
      perf script: Display Intel PT iflag synthesized event
      perf script: Display new D and t flags
      perf scripts python: intel-pt-events.py: Add Event Trace
      perf scripting python: Add all sample flags to DB export
      perf scripts python: export-to-sqlite.py: Export all sample flags
      perf scripts python: export-to-postgresql.py: Export all sample flags
      perf intel-pt: Add documentation for Event Trace and TNT disable

 tools/perf/Documentation/itrace.txt                |   2 +
 tools/perf/Documentation/perf-intel-pt.txt         | 104 ++++++++-
 tools/perf/Documentation/perf-script.txt           |  13 +-
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |  17 +-
 tools/perf/arch/x86/util/intel-pt.c                |   7 +
 tools/perf/builtin-script.c                        |  78 ++++++-
 tools/perf/scripts/python/export-to-postgresql.py  |  17 +-
 tools/perf/scripts/python/export-to-sqlite.py      |  19 +-
 tools/perf/scripts/python/intel-pt-events.py       |  55 ++++-
 tools/perf/util/auxtrace.c                         |   4 +
 tools/perf/util/auxtrace.h                         |   4 +
 tools/perf/util/event.h                            |  45 +++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 245 +++++++++++++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  21 ++
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  47 +++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   3 +
 tools/perf/util/intel-pt.c                         | 164 +++++++++++++-
 .../util/scripting-engines/trace-event-python.c    |   3 +-
 18 files changed, 779 insertions(+), 69 deletions(-)


Regards
Adrian
