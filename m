Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C92497A87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiAXInd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:62621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242283AbiAXInO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013794; x=1674549794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2h9bHGDewdmOF/SyS/9WfylitAc0QQW5ESIvmQkmic=;
  b=E+SXK7VRSqIMlNB1gkQSQWjZQ0+5ZRDtIbgpzkr/zlE035TVCHTe+A8h
   UMdBvhJhwrEE+UirByJs3rGNYZ09p+qxYek6eQXggAbU8VYgaHoDa8h6w
   Los5ke07vWsStYzz7Vju2BoNHKwPvxCNjhetMieyIThuNN5tZhIdTBYHk
   6FxE2gVz7KArnKBvqJNU0WCAvYVVUSrbNOqtnnG2WerzcenciUO5x6Z9g
   /kFYbcptxUh9/SUaGnzq9SFRV+lbVGYcBcx7mVpwxDlMK8GAI9Kz6HBDB
   JchxSLas6ckxJLAPoB9bIKpUJOEaiePOnk+1ozaKHesuIFsa1eMvFwCYW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778488"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778488"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417257"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:49 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] perf scripts python: intel-pt-events.py: Add Event Trace
Date:   Mon, 24 Jan 2022 10:41:57 +0200
Message-Id: <20220124084201.2699795-22-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Event Trace to the intel-pt-events.py script. This shows how to unpack
the raw data from the new sample events in a Python script.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 55 ++++++++++++++++++--
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 66452a8ec358..973bd12b7b40 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -76,16 +76,16 @@ def trace_begin():
 	glb_args = ap.parse_args()
 	if glb_args.insn_trace:
 		print("Intel PT Instruction Trace")
-		itrace = "i0nsepwx"
+		itrace = "i0nsepwxI"
 		glb_insn = True
 	elif glb_args.src_trace:
 		print("Intel PT Source Trace")
-		itrace = "i0nsepwx"
+		itrace = "i0nsepwxI"
 		glb_insn = True
 		glb_src = True
 	else:
-		print("Intel PT Branch Trace, Power Events and PTWRITE")
-		itrace = "bepwx"
+		print("Intel PT Branch Trace, Power Events, Event Trace and PTWRITE")
+		itrace = "bepwxI"
 	global glb_disassembler
 	try:
 		glb_disassembler = LibXED()
@@ -149,6 +149,43 @@ def print_psb(raw_buf):
 	offset = data[1]
 	print("offset: %#x" % (offset), end=' ')
 
+glb_cfe = ["", "INTR", "IRET", "SMI", "RSM", "SIPI", "INIT", "VMENTRY", "VMEXIT",
+		"VMEXIT_INTR", "SHUTDOWN", "", "UINT", "UIRET"] + [""] * 18
+glb_evd = ["", "PFA", "VMXQ", "VMXR"] + [""] * 60
+
+def print_evt(raw_buf):
+	data = struct.unpack_from("<BBH", raw_buf)
+	typ = data[0] & 0x1f
+	ip_flag = (data[0] & 0x80) >> 7
+	vector = data[1]
+	evd_cnt = data[2]
+	s = glb_cfe[typ]
+	if s:
+		print(" cfe: %s IP: %u vector: %u" % (s, ip_flag, vector), end=' ')
+	else:
+		print(" cfe: %u IP: %u vector: %u" % (typ, ip_flag, vector), end=' ')
+	pos = 4
+	for i in range(evd_cnt):
+		data = struct.unpack_from("<QQ", raw_buf)
+		et = data[0] & 0x3f
+		s = glb_evd[et]
+		if s:
+			print("%s: %#x" % (s, data[1]), end=' ')
+		else:
+			print("EVD_%u: %#x" % (et, data[1]), end=' ')
+
+def print_iflag(raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	iflag = data[0] & 1
+	old_iflag = iflag ^ 1
+	via_branch = data[0] & 2
+	branch_ip = data[1]
+	if via_branch:
+		s = "via"
+	else:
+		s = "non"
+	print("IFLAG: %u->%u %s branch" % (old_iflag, iflag, s), end=' ')
+
 def common_start_str(comm, sample):
 	ts = sample["time"]
 	cpu = sample["cpu"]
@@ -164,7 +201,7 @@ def print_common_start(comm, sample, name):
 	# weight      = sample["weight"]
 	# transaction = sample["transaction"]
 	# cpumode     = get_optional_zero(sample, "cpumode")
-	print(common_start_str(comm, sample) + "%7s  %19s" % (name, flags_disp), end=' ')
+	print(common_start_str(comm, sample) + "%8s  %21s" % (name, flags_disp), end=' ')
 
 def print_instructions_start(comm, sample):
 	if "x" in get_optional_null(sample, "flags"):
@@ -315,6 +352,14 @@ def do_process_event(param_dict):
 		print_common_start(comm, sample, name)
 		print_psb(raw_buf)
 		print_common_ip(param_dict, sample, symbol, dso)
+	elif name == "evt":
+		print_common_start(comm, sample, name)
+		print_evt(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
+	elif name == "iflag":
+		print_common_start(comm, sample, name)
+		print_iflag(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	else:
 		print_common_start(comm, sample, name)
 		print_common_ip(param_dict, sample, symbol, dso)
-- 
2.25.1

