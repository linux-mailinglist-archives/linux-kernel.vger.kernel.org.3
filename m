Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DB4979FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiAXIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:06:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:57796 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233770AbiAXIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643011616; x=1674547616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NdWJpfgYvdi4FpcIp+TSu8AsTwOqqArWaWI2Neenkoc=;
  b=lac+LAYWaDIULtiJvBcyPNrKwZkap/nwQ0OH9Nj1HbPf0d5Nm8y+okWw
   HWGwsZQ7X1HOcqNr4KIHlMCWtGpxjXVbkpocc1L41nzgM+g8O+707Uupb
   cT2kk9GktGXxSYnpZQaT/GLovG7jNrQ47wwugLZ0TitKXKRIke6qGRoCg
   yDKefQFf+7omBeNI2MJ9WRteVpp0PW/XFCqchIUi9C4eO1xIy0rhrkxx/
   Ks2AYg8OeIyZPoIVxYAy6EnyHFqHGdqKbvhsCp+9tho77fg8rquxlZFcY
   7kloJnYSVniIsSYWeOb59qCjHFk3m1f54uUfNP7pgZBOuA9/4z4SRTCfL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306707268"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306707268"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="478981191"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 00:06:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: [PATCH 0/2] perf/x86/intel/pt: Add support for event tracing and TNT disabling
Date:   Mon, 24 Jan 2022 10:06:49 +0200
Message-Id: <20220124080651.2699107-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As of Intel SDM (https://www.intel.com/sdm) version 076, there are 2 new
Intel PT features called Event Trace and TNT-Disable.

Event Trace exposes details about asynchronous events such as interrupts
and VM-Entry/Exit.

TNT-Disable disables TNT packets to reduce the tracing overhead, but with
the result that exact control flow information is lost.

Tools patches are being sent in a separate patch set, but can be found
here:

	https://github.com/ahunter6/linux/tree/event-trace


Alexander Shishkin (2):
      perf/x86/intel/pt: Add a capability and config bit for event tracing
      perf/x86/intel/pt: Add a capability and config bit for disabling TNTs

 arch/x86/events/intel/pt.c       | 16 ++++++++++++++++
 arch/x86/include/asm/intel_pt.h  |  2 ++
 arch/x86/include/asm/msr-index.h |  2 ++
 3 files changed, 20 insertions(+)


Regards
Adrian 
