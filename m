Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D819E52010F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiEIP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiEIP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:28:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4802B09F1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652109849; x=1683645849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/sViUog6BCJi155DSkmrPcl4AzpSt9KMDE0A8R8Se/U=;
  b=Gq1Ad5V0ITZgAczgR9niGde8+Co/t1KejXfPDd56XcLiKEKj5/WjGk71
   J3fLHMd7g7GoNUuRJtvjof59veCSkenw+2gH6RA58jSt7cuxm6i0GRNSR
   ZFqamInSprbD7apV24cGnxzi0+KFdQ1fhDlpdehle5X4iHsJK+I4Ff2K6
   zxInLH2xsilzVpKegZSn9klpeQuWtybvTn1dTgh0AZotL+83Bdo3tBBBn
   xf/y5uwqW3uNTnDTe1SE9wvu4ZP+X/rVCxGYL2g0Hc0heuu1Ru0e6mC7a
   XzWejjet1oBkfJhBLwRP7J5Oo6cN6I4J8xhArPA5rIX0aJLjJ1CRwVtDt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294306875"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294306875"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592705512"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 08:24:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf scripts python: intel-pt-events.py: Print ptwrite value as a string if it is ASCII
Date:   Mon,  9 May 2022 18:24:00 +0300
Message-Id: <20220509152400.376613-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509152400.376613-1-adrian.hunter@intel.com>
References: <20220509152400.376613-1-adrian.hunter@intel.com>
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

It can be convenient to put a string value into a ptwrite payload as
a quick and easy way to identify what is being printed.

To make that useful, if the Intel ptwrite payload value contains only
printable ASCII characters padded with NULLs, then print it also as a
string.

Using the example program from the "Emulated PTWRITE" section of
tools/perf/Documentation/perf-intel-pt.txt:

 $ echo -n "Hello" | od -t x8
 0000000 0000006f6c6c6548
 0000005
 $ perf record -e intel_pt//u ./eg_ptw 0x0000006f6c6c6548
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.016 MB perf.data ]
 $ perf script --itrace=ew intel-pt-events.py
 Intel PT Branch Trace, Power Events, Event Trace and PTWRITE
      Switch In   38524/38524 [001]     24166.044995916     0/0
           eg_ptw 38524/38524 [001]     24166.045380004   ptwrite  jmp                   IP: 0 payload: 0x6f6c6c6548 Hello     56532c7ce196 perf_emulate_ptwrite+0x16 (/home/ahunter/git/work/eg_ptw)
 End

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 973bd12b7b40..9b7746b89381 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -104,7 +104,13 @@ def print_ptwrite(raw_buf):
 	flags = data[0]
 	payload = data[1]
 	exact_ip = flags & 1
-	print("IP: %u payload: %#x" % (exact_ip, payload), end=' ')
+	try:
+		s = payload.to_bytes(8, "little").decode("ascii").rstrip("\x00")
+		if not s.isprintable():
+			s = ""
+	except:
+		s = ""
+	print("IP: %u payload: %#x" % (exact_ip, payload), s, end=' ')
 
 def print_cbr(raw_buf):
 	data = struct.unpack_from("<BBBBII", raw_buf)
-- 
2.25.1

