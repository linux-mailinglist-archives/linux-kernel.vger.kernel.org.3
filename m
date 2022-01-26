Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3208E49C7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiAZKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:48:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:10953 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240212AbiAZKsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643194100; x=1674730100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vv57DJifcsENs5tGulRi3mJmeUn2LUXarXjXGXywB80=;
  b=DOqdc+Dtdgj8kNLuIhvBV4jdSreiKc4gko7RLaAnol3wfV5GVGOxizTD
   ACSpl3IgcCl/Br0pfU1W5BYEGt7fqU52WGN1EELUuq8WvihRnmOn0XdXe
   v7qz0IK/mfiZJ0YiOobLxoSM5UjDZJm/iLdpzXzBnHkkkNRTKzgV4BZ/J
   kAo2FYWvgwlwhp9FxuxHIGExux3Ed+EcOsLLoT/5b2Cf1yQOdvPhcPdmY
   JuDFgFLnR8VbSG6dDI772vspMpNJkuEEGOwpedEKlMOyNnYyjDHHCvMb/
   bITCyl9RVqPU0CmmmXZf7QmzLkNnVC12OX6OsBCg0LZr/oR7sFOR0oAOp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332878453"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="332878453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 02:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="674323258"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2022 02:48:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing and TNT disabling
Date:   Wed, 26 Jan 2022 12:48:13 +0200
Message-Id: <20220126104815.2807416-1-adrian.hunter@intel.com>
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


Changes in V2:

	Add my SOB


Alexander Shishkin (2):
      perf/x86/intel/pt: Add a capability and config bit for event tracing
      perf/x86/intel/pt: Add a capability and config bit for disabling TNTs

 arch/x86/events/intel/pt.c       | 16 ++++++++++++++++
 arch/x86/include/asm/intel_pt.h  |  2 ++
 arch/x86/include/asm/msr-index.h |  2 ++
 3 files changed, 20 insertions(+)


Regards
Adrian 
