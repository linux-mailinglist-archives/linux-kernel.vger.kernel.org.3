Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACC470591
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbhLJQ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:49130 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241234AbhLJQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153403; x=1670689403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRM2w8bMnE0jw6PZpNA6fyrvQwnYgZALc1Kghx1MHoU=;
  b=XtccxDFqpCA5f/NhKOtdXfx4/lln5iejCcbk+81b4NLKxgD0ldpgD04r
   1nXp09qk0wJwyZ9KiYog9aPKKi5oo6vtLE9TT/pZYARVMwWWIWYvdlU9F
   16cH2J+AltJs9T6xYDaJUbXJ0zqzBzcY5/A7+4VoWjGH6ThxUQcx6Jl8P
   gDObMxwuxtf8ZSwB4AATkbPvqAg4FDJBMwWDWdaBGG8rLbVEU8J3vvWJT
   onWUU8zUa1ZFM5D3PKXr43K5tz+1ieAGTTfI6dIY8ak03bioZqh3cjqjr
   r5XB57wHOuROWMz8CAk45hmCjLa7/MeMvSwvIvnDHCygKaiko0xnU4Mhm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647124"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647124"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981866"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] perf intel-pt: Fix next 'err' value, walking trace
Date:   Fri, 10 Dec 2021 18:23:01 +0200
Message-Id: <20211210162303.2288710-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code after label 'next:' in intel_pt_walk_trace() assumes 'err' is zero,
but it may not be, if arrived at via a 'goto'. Ensure it is zero.

Fixes: 7c1b16ba0e26e6 ("perf intel-pt: Add support for decoding FUP/TIP only")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 845b0ca866a4..75b504aed7f4 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2942,6 +2942,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 		if (err)
 			return err;
 next:
+		err = 0;
 		if (decoder->cyc_threshold) {
 			if (decoder->sample_cyc && last_packet_type != INTEL_PT_CYC)
 				decoder->sample_cyc = false;
-- 
2.25.1

