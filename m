Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037D52FC8C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351572AbiEUNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbiEUNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:05:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F44C606C1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:05:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so9903846pju.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmqkmQcBrTMeraC/ViSTz7A8WYbcIZcg7RqKBqYcwVI=;
        b=XFQT2TEIaQV+QaQ6UzQPbUeI08EPjLJHkTIgWrOhr005wdKwgEcTf8eRgOvkhUpKUD
         VymVkHvrRHtgbab8NCwyMfGluZ1dAHVGB3xlQVd9VCggJ21WIYvzYmv4u9bc/e0lBCkT
         JgEu+JTREELrEPGOgcDvlZV/1FtY7UaBcbU4Sp9rr5lQ9RgQT4G0oMU04gXRSq5kL3FN
         nQPpnXuqcHsZWN5IDjkD7nak+x0+EbEpQ0f4mANUHukWyjxDIrFKskY0Qo0yP/GorCPB
         7xF9uQ2xofL+V5Q/IUVdZiR3IsZl8kSITYFhWsTW8bSXM/4laaLY2L1fYEym99uqHx32
         IeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmqkmQcBrTMeraC/ViSTz7A8WYbcIZcg7RqKBqYcwVI=;
        b=MXo3tA2ucu48DltSLA6Fu3H4/5+nnp1x/Rd8IwddKxp1+ZkDX4x5ewIZQ6t5AsCsvn
         f1q+JAKUs6pdNQOFrHBEugOkNr0uo8smACC2WYoxHwyNI16B2wolA2qt8sK42M44KlQu
         ejY5Imc3aes18GDnpN2kgrUuMUHbFcAdXU4RD0vffGZM8rXj+P8Yj2e84U1sQgt1kJ4q
         vg/sVlpaLCJKRArtQAz1QeVxHl3d2gSfQRMv9enCHwVObVKoCJ+hNhhg4zb+6m+wE4pG
         RWrdsZNMvMQ7v5UkGJfMZYC3RgnJI+JM7K6tSd+Vs7PdvZDzqTvNQYbjD1PW3YTqD0/w
         BN8g==
X-Gm-Message-State: AOAM532axshgqKkOQqTU+tJv39iz7c9B7qKPAP2sc7JqS4bIeD72t9+D
        khvgJO6HNicEXDJOF1Oi4PkGdA==
X-Google-Smtp-Source: ABdhPJxVSPIMhHoW4OmvtB18jmCsrf4MkYBdQmxGP4i4zWBovUWYEqsK/mZRODIH7/pUwyjQJ/R48g==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr4769002pjs.222.1653138308174;
        Sat, 21 May 2022 06:05:08 -0700 (PDT)
Received: from leo-build-box.lan (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0050dc7628160sm3724874pfm.58.2022.05.21.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:05:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Tor Jeremiassen <tor@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v6 2/2] perf scripts python: Support Arm CoreSight trace data disassembly
Date:   Sat, 21 May 2022 21:04:46 +0800
Message-Id: <20220521130446.4163597-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220521130446.4163597-1-leo.yan@linaro.org>
References: <20220521130446.4163597-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds python script to parse CoreSight tracing event and
print out source line and disassembly, it generates readable program
execution flow for easier humans inspecting.

The script receives CoreSight tracing packet with below format:

                +------------+------------+------------+
  packet(n):    |    addr    |    ip      |    cpu     |
                +------------+------------+------------+
  packet(n+1):  |    addr    |    ip      |    cpu     |
                +------------+------------+------------+

packet::addr presents the start address of the coming branch sample, and
packet::ip is the last address of the branch smple.  Therefore, a code
section between branches starts from packet(n)::addr and it stops at
packet(n+1)::ip.  As results we combines the two continuous packets to
generate the address range for instructions:

  [ sample(n)::addr .. sample(n+1)::ip ]

The script supports both objdump or llvm-objdump for disassembly with
specifying option '-d'.  If doesn't specify option '-d', the script
simply outputs source lines and symbols.

Below shows usages with llvm-objdump or objdump to output disassembly.

  # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d llvm-objdump-11 -k ./vmlinux
  ARM CoreSight Trace Data Assembler Dump
  	ffff800008eb3198 <etm4_enable_hw>:
  	ffff800008eb3310: c0 38 00 35  	cbnz	w0, 0xffff800008eb3a28 <etm4_enable_hw+0x890>
  	ffff800008eb3314: 9f 3f 03 d5  	dsb	sy
  	ffff800008eb3318: df 3f 03 d5  	isb
  	ffff800008eb331c: f5 5b 42 a9  	ldp	x21, x22, [sp, #32]
  	ffff800008eb3320: fb 73 45 a9  	ldp	x27, x28, [sp, #80]
  	ffff800008eb3324: e0 82 40 39  	ldrb	w0, [x23, #32]
  	ffff800008eb3328: 60 00 00 34  	cbz	w0, 0xffff800008eb3334 <etm4_enable_hw+0x19c>
  	ffff800008eb332c: e0 03 19 aa  	mov	x0, x25
  	ffff800008eb3330: 8c fe ff 97  	bl	0xffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>
              main  6728/6728  [0004]         0.000000000  etm4_enable_hw+0x198                    [kernel.kallsyms]
  	ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>:
  	ffff800008eb2d60: 1f 20 03 d5  	nop
  	ffff800008eb2d64: 1f 20 03 d5  	nop
  	ffff800008eb2d68: 3f 23 03 d5  	hint	#25
  	ffff800008eb2d6c: 00 00 40 f9  	ldr	x0, [x0]
  	ffff800008eb2d70: 9f 3f 03 d5  	dsb	sy
  	ffff800008eb2d74: 00 c0 3e 91  	add	x0, x0, #4016
  	ffff800008eb2d78: 1f 00 00 b9  	str	wzr, [x0]
  	ffff800008eb2d7c: bf 23 03 d5  	hint	#29
  	ffff800008eb2d80: c0 03 5f d6  	ret
              main  6728/6728  [0004]         0.000000000  etm4_cs_lock.isra.0.part.0+0x20

  # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d objdump -k ./vmlinux
  ARM CoreSight Trace Data Assembler Dump
  	ffff800008eb3310 <etm4_enable_hw+0x178>:
  	ffff800008eb3310:	350038c0 	cbnz	w0, ffff800008eb3a28 <etm4_enable_hw+0x890>
  	ffff800008eb3314:	d5033f9f 	dsb	sy
  	ffff800008eb3318:	d5033fdf 	isb
  	ffff800008eb331c:	a9425bf5 	ldp	x21, x22, [sp, #32]
  	ffff800008eb3320:	a94573fb 	ldp	x27, x28, [sp, #80]
  	ffff800008eb3324:	394082e0 	ldrb	w0, [x23, #32]
  	ffff800008eb3328:	34000060 	cbz	w0, ffff800008eb3334 <etm4_enable_hw+0x19c>
  	ffff800008eb332c:	aa1903e0 	mov	x0, x25
  	ffff800008eb3330:	97fffe8c 	bl	ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>
              main  6728/6728  [0004]         0.000000000  etm4_enable_hw+0x198                    [kernel.kallsyms]
  	ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>:
  	ffff800008eb2d60:	d503201f 	nop
  	ffff800008eb2d64:	d503201f 	nop
  	ffff800008eb2d68:	d503233f 	paciasp
  	ffff800008eb2d6c:	f9400000 	ldr	x0, [x0]
  	ffff800008eb2d70:	d5033f9f 	dsb	sy
  	ffff800008eb2d74:	913ec000 	add	x0, x0, #0xfb0
  	ffff800008eb2d78:	b900001f 	str	wzr, [x0]
  	ffff800008eb2d7c:	d50323bf 	autiasp
  	ffff800008eb2d80:	d65f03c0 	ret
              main  6728/6728  [0004]         0.000000000  etm4_cs_lock.isra.0.part.0+0x20

Co-authored-by: Tor Jeremiassen <tor@ti.com>
Co-authored-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Co-authored-by: Al Grant <al.grant@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 272 ++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
new file mode 100755
index 000000000000..5f57d9829956
--- /dev/null
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -0,0 +1,272 @@
+# SPDX-License-Identifier: GPL-2.0
+# arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember
+#
+# Author: Tor Jeremiassen <tor@ti.com>
+#         Mathieu Poirier <mathieu.poirier@linaro.org>
+#         Leo Yan <leo.yan@linaro.org>
+#         Al Grant <Al.Grant@arm.com>
+
+from __future__ import print_function
+import os
+from os import path
+import sys
+import re
+from subprocess import *
+from optparse import OptionParser, make_option
+
+from perf_trace_context import perf_set_itrace_options, \
+	perf_sample_insn, perf_sample_srccode
+
+# Below are some example commands for using this script.
+#
+# Output disassembly with objdump:
+#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#		-- -d objdump -k path/to/vmlinux
+# Output disassembly with llvm-objdump:
+#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#		-- -d llvm-objdump-11 -k path/to/vmlinux
+# Output only source line and symbols:
+#  perf script -s scripts/python/arm-cs-trace-disasm.py
+
+# Command line parsing.
+option_list = [
+	# formatting options for the bottom entry of the stack
+	make_option("-k", "--vmlinux", dest="vmlinux_name",
+		    help="Set path to vmlinux file"),
+	make_option("-d", "--objdump", dest="objdump_name",
+		    help="Set path to objdump executable file"),
+	make_option("-v", "--verbose", dest="verbose",
+		    action="store_true", default=False,
+		    help="Enable debugging log")
+]
+
+parser = OptionParser(option_list=option_list)
+(options, args) = parser.parse_args()
+
+# Initialize global dicts and regular expression
+disasm_cache = dict()
+cpu_data = dict()
+disasm_re = re.compile("^\s*([0-9a-fA-F]+):")
+disasm_func_re = re.compile("^\s*([0-9a-fA-F]+)\s.*:")
+cache_size = 64*1024
+
+glb_source_file_name	= None
+glb_line_number		= None
+glb_dso			= None
+
+def get_optional(perf_dict, field):
+       if field in perf_dict:
+               return perf_dict[field]
+       return "[unknown]"
+
+def get_offset(perf_dict, field):
+	if field in perf_dict:
+		return f"+0x{perf_dict[field]:x}"
+	return ""
+
+def get_dso_file_path(dso_name, dso_build_id):
+	if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
+		if (options.vmlinux_name):
+			return options.vmlinux_name;
+		else:
+			return dso_name
+
+	if (dso_name == "[vdso]") :
+		append = "/vdso"
+	else:
+		append = "/elf"
+
+	dso_path = f"{os.environ['PERF_BUILDID_DIR']}/{dso_name}/{dso_build_id}{append}"
+	# Replace duplicate slash chars to single slash char
+	dso_path = dso_path.replace('//', '/', 1)
+	return dso_path
+
+def read_disam(dso_fname, dso_start, start_addr, stop_addr):
+	addr_range = str(start_addr) + ":" + str(stop_addr) + ":" + dso_fname
+
+	# Don't let the cache get too big, clear it when it hits max size
+	if (len(disasm_cache) > cache_size):
+		disasm_cache.clear();
+
+	if addr_range in disasm_cache:
+		disasm_output = disasm_cache[addr_range];
+	else:
+		start_addr = start_addr - dso_start;
+		stop_addr = stop_addr - dso_start;
+		disasm = [ options.objdump_name, "-d", "-z",
+			   f"--start-address=0x{start_addr:x}",
+			   f"--stop-address=0x{stop_addr:x}" ]
+		disasm += [ dso_fname ]
+		disasm_output = check_output(disasm).decode('utf-8').split('\n')
+		disasm_cache[addr_range] = disasm_output
+
+	return disasm_output
+
+def print_disam(dso_fname, dso_start, start_addr, stop_addr):
+	for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
+		m = disasm_func_re.search(line)
+		if m is None:
+			m = disasm_re.search(line)
+			if m is None:
+				continue
+		print(f"\t{line}")
+
+def print_sample(sample):
+	print(f"Sample = {{ cpu: {sample['cpu']:04} addr: 0x{sample['addr']:016x} " \
+	      f"phys_addr: 0x{sample['phys_addr']:016x} ip: 0x{sample['ip']:016x} " \
+	      f"pid: {sample['pid']} tid: {sample['tid']} period: {sample['period']} time: {sample['time']} }}")
+
+def trace_begin():
+	print('ARM CoreSight Trace Data Assembler Dump')
+
+def trace_end():
+	print('End')
+
+def trace_unhandled(event_name, context, event_fields_dict):
+	print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
+
+def common_start_str(comm, sample):
+	sec = int(sample["time"] / 1000000000)
+	ns = sample["time"] % 1000000000
+	cpu = sample["cpu"]
+	pid = sample["pid"]
+	tid = sample["tid"]
+	return f"{comm:>16} {pid:>5}/{tid:<5} [{cpu:04}] {sec:9}.{ns:09}  "
+
+# This code is copied from intel-pt-events.py for printing source code
+# line and symbols.
+def print_srccode(comm, param_dict, sample, symbol, dso):
+	ip = sample["ip"]
+	if symbol == "[unknown]":
+		start_str = common_start_str(comm, sample) + ("%x" % ip).rjust(16).ljust(40)
+	else:
+		offs = get_offset(param_dict, "symoff")
+		start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
+
+	global glb_source_file_name
+	global glb_line_number
+	global glb_dso
+
+	source_file_name, line_number, source_line = perf_sample_srccode(perf_script_context)
+	if source_file_name:
+		if glb_line_number == line_number and glb_source_file_name == source_file_name:
+			src_str = ""
+		else:
+			if len(source_file_name) > 40:
+				src_file = ("..." + source_file_name[-37:]) + " "
+			else:
+				src_file = source_file_name.ljust(41)
+
+			if source_line is None:
+				src_str = src_file + str(line_number).rjust(4) + " <source not found>"
+			else:
+				src_str = src_file + str(line_number).rjust(4) + " " + source_line
+		glb_dso = None
+	elif dso == glb_dso:
+		src_str = ""
+	else:
+		src_str = dso
+		glb_dso = dso
+
+	glb_line_number = line_number
+	glb_source_file_name = source_file_name
+
+	print(f"{start_str}{src_str}")
+
+def process_event(param_dict):
+	global cache_size
+	global options
+
+	sample = param_dict["sample"]
+	comm = param_dict["comm"]
+
+	name = param_dict["ev_name"]
+	dso = get_optional(param_dict, "dso")
+	dso_bid = get_optional(param_dict, "dso_bid")
+	dso_start = get_optional(param_dict, "dso_map_start")
+	dso_end = get_optional(param_dict, "dso_map_end")
+	symbol = get_optional(param_dict, "symbol")
+
+	if (options.verbose == True):
+		print(f"Event type: {name}")
+		print_sample(sample)
+
+	# If cannot find dso so cannot dump assembler, bail out
+	if (dso == '[unknown]'):
+		return
+
+	# Validate dso start and end addresses
+	if ((dso_start == '[unknown]') or (dso_end == '[unknown]')):
+		print(f"Failed to find valid dso map for dso {dso}")
+		return
+
+	if (name[0:12] == "instructions"):
+		print_srccode(comm, param_dict, sample, symbol, dso)
+		return
+
+	# Don't proceed if this event is not a branch sample, .
+	if (name[0:8] != "branches"):
+		return
+
+	cpu = sample["cpu"]
+	ip = sample["ip"]
+	addr = sample["addr"]
+
+	# Initialize CPU data if it's empty, and directly return back
+	# if this is the first tracing event for this CPU.
+	if (cpu_data.get(str(cpu) + 'addr') == None):
+		cpu_data[str(cpu) + 'addr'] = addr
+		return
+
+	# The format for packet is:
+	#
+	#		  +------------+------------+------------+
+	#  sample_prev:   |    addr    |    ip	    |	 cpu	 |
+	#		  +------------+------------+------------+
+	#  sample_next:   |    addr    |    ip	    |	 cpu	 |
+	#		  +------------+------------+------------+
+	#
+	# We need to combine the two continuous packets to get the instruction
+	# range for sample_prev::cpu:
+	#
+	#     [ sample_prev::addr .. sample_next::ip ]
+	#
+	# For this purose, sample_prev::addr is stored into cpu_data structure
+	# and read back for 'start_addr' when the new packet comes, and we need
+	# to use sample_next::ip to calculate 'stop_addr', plusing extra 4 for
+	# 'stop_addr' is for the sake of objdump so the final assembler dump can
+	# include last instruction for sample_next::ip.
+	start_addr = cpu_data[str(cpu) + 'addr']
+	stop_addr  = ip + 4
+
+	# Record for previous sample packet
+	cpu_data[str(cpu) + 'addr'] = addr
+
+	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
+	if (start_addr == 0 and stop_addr == 4):
+		print(f"CPU{cpu}: CS_ETM_TRACE_ON packet is inserted")
+		return
+
+	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
+		print(f"Start address 0x{start_addr:x} is out of range [ 0x{dso_start:x} .. 0x{dso_end:x} ] for dso {dso}")
+		return
+
+	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
+		print(f"Stop address 0x{stop_addr:x} is out of range [ 0x{dso_start:x} .. 0x{dso_end:x} ] for dso {dso}")
+		return
+
+	if (options.objdump_name != None):
+		# It doesn't need to decrease virtual memory offset for disassembly
+		# for kernel dso, so in this case we set vm_start to zero.
+		if (dso == "[kernel.kallsyms]"):
+			dso_vm_start = 0
+		else:
+			dso_vm_start = int(dso_start)
+
+		dso_fname = get_dso_file_path(dso, dso_bid)
+		if path.exists(dso_fname):
+			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+		else:
+			print(f"Failed to find dso {dso} for address range [ 0x{start_addr:x} .. 0x{stop_addr:x} ]")
+
+	print_srccode(comm, param_dict, sample, symbol, dso)
-- 
2.25.1

