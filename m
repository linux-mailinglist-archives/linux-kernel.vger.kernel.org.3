Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6C52763B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiEOHTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiEOHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:19:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183603DDFA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:19:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q76so11304640pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znkf0Iq37dQ1qnW05Lv4zpRAFEwrFQw23n/neRh4Crk=;
        b=QV9whAbMagaVov2W61oO2vkQRqYdCHgF1lAXpfUOvNALEgvf54ACJaHCIjsJhTIFnm
         DqyYJg5+aBBhc0m148hPMIQTt84jRMeJTIuH9+E/gfcwOJ5MYrwApjVbE41VGeAkXqh9
         B+66w9SQEMRrECwUA4+yje+ho3a5hY1u1T0rNnJTWVaPTU8VmCsAepCpsS1QetG8PVxs
         UBY/HRY4C0peFwurZXHnZAbqJRBcYYzfNR6CJpqbgV+mzKeoyNpA9uxLMq4wnmuC9EZJ
         EhoMHtO2tou6VxgeMS+Ywk1nol0s4EXoojC2TJ1k4mXGtd3yIkX/8P0OaVMxJqYpS78u
         vf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znkf0Iq37dQ1qnW05Lv4zpRAFEwrFQw23n/neRh4Crk=;
        b=u3fq6e3LA0mOITn/+2HSnEbRen71x6gxHdZWE+c7WpYYkeJzWCDRhRlCnJIhxRFyRk
         KXDMF5FylHm5z+V5H5H1V3Gken4rHs5mGFbQ8Jx6DChw/H2tKKEYmMjRIH0z8N3b+iUV
         qqrj4tjPqB44Gpv6DMd1XawPIEBnsTSRpCyl09r85ediGgXM3+eeVoic8qthRnwfGPM+
         R4mSPp4K3t/iR2jI301K8x2BfrvUCWtHkjxPaVXnItgKhsF8duQmy608kUgZ7D9oi98t
         mFnFe79NC2mfeliLJJp2EEeywf7nqyJJrrWecvx0GRkTAT8pz/CKRbNXSWg6sHjZzfNq
         dBOQ==
X-Gm-Message-State: AOAM532ymNtcILJEZ+5OzcR4pjWnyXyVaw1KwFBI3OpVYqLG9kz0+wjE
        XsBEVi6pXScQBbarUuN3KZ8Mhg==
X-Google-Smtp-Source: ABdhPJwneq5FeeAer7Y+Mv8o80Agcr+T4hweuThgD0mL73NUm2pB+PP5HIrnMgp3H0Qhlk8atUG/CA==
X-Received: by 2002:a63:69c7:0:b0:3c2:2b51:a4b6 with SMTP id e190-20020a6369c7000000b003c22b51a4b6mr10757393pgc.153.1652599165375;
        Sun, 15 May 2022 00:19:25 -0700 (PDT)
Received: from localhost.localdomain ([104.245.96.71])
        by smtp.gmail.com with ESMTPSA id t19-20020a63dd13000000b003c2698d199bsm4461943pgg.25.2022.05.15.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:19:25 -0700 (PDT)
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
Subject: [PATCH v5 2/2] perf scripts python: Support Arm CoreSight trace data disassembly
Date:   Sun, 15 May 2022 15:18:38 +0800
Message-Id: <20220515071838.3077178-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515071838.3077178-1-leo.yan@linaro.org>
References: <20220515071838.3077178-1-leo.yan@linaro.org>
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
        ffff800008eb3310: c0 38 00 35   cbnz    w0, 0xffff800008eb3a28 <etm4_enable_hw+0x890>
        ffff800008eb3314: 9f 3f 03 d5   dsb     sy
        ffff800008eb3318: df 3f 03 d5   isb
        ffff800008eb331c: f5 5b 42 a9   ldp     x21, x22, [sp, #32]
        ffff800008eb3320: fb 73 45 a9   ldp     x27, x28, [sp, #80]
        ffff800008eb3324: e0 82 40 39   ldrb    w0, [x23, #32]
        ffff800008eb3328: 60 00 00 34   cbz     w0, 0xffff800008eb3334 <etm4_enable_hw+0x19c>
        ffff800008eb332c: e0 03 19 aa   mov     x0, x25
        ffff800008eb3330: 8c fe ff 97   bl      0xffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>
            main  6055/6055  [004]         0.000000000  etm4_enable_hw+0x198                     [kernel.kallsyms]
        ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>:
        ffff800008eb2d60: 1f 20 03 d5   nop
        ffff800008eb2d64: 1f 20 03 d5   nop
        ffff800008eb2d68: 3f 23 03 d5   hint    #25
        ffff800008eb2d6c: 00 00 40 f9   ldr     x0, [x0]
        ffff800008eb2d70: 9f 3f 03 d5   dsb     sy
        ffff800008eb2d74: 00 c0 3e 91   add     x0, x0, #4016
        ffff800008eb2d78: 1f 00 00 b9   str     wzr, [x0]
        ffff800008eb2d7c: bf 23 03 d5   hint    #29
        ffff800008eb2d80: c0 03 5f d6   ret
            main  6055/6055  [004]         0.000000000  etm4_cs_lock.isra.0.part.0+0x20

  # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d objdump -k ./vmlinux
  ARM CoreSight Trace Data Assembler Dump
        ffff800008eb3310 <etm4_enable_hw+0x178>:
        ffff800008eb3310:       350038c0        cbnz    w0, ffff800008eb3a28 <etm4_enable_hw+0x890>
        ffff800008eb3314:       d5033f9f        dsb     sy
        ffff800008eb3318:       d5033fdf        isb
        ffff800008eb331c:       a9425bf5        ldp     x21, x22, [sp, #32]
        ffff800008eb3320:       a94573fb        ldp     x27, x28, [sp, #80]
        ffff800008eb3324:       394082e0        ldrb    w0, [x23, #32]
        ffff800008eb3328:       34000060        cbz     w0, ffff800008eb3334 <etm4_enable_hw+0x19c>
        ffff800008eb332c:       aa1903e0        mov     x0, x25
        ffff800008eb3330:       97fffe8c        bl      ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>
            main  6055/6055  [004]         0.000000000  etm4_enable_hw+0x198                     [kernel.kallsyms]
        ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>:
        ffff800008eb2d60:       d503201f        nop
        ffff800008eb2d64:       d503201f        nop
        ffff800008eb2d68:       d503233f        paciasp
        ffff800008eb2d6c:       f9400000        ldr     x0, [x0]
        ffff800008eb2d70:       d5033f9f        dsb     sy
        ffff800008eb2d74:       913ec000        add     x0, x0, #0xfb0
        ffff800008eb2d78:       b900001f        str     wzr, [x0]
        ffff800008eb2d7c:       d50323bf        autiasp
        ffff800008eb2d80:       d65f03c0        ret
            main  6055/6055  [004]         0.000000000  etm4_cs_lock.isra.0.part.0+0x20

Co-authored-by: Tor Jeremiassen <tor@ti.com>
Co-authored-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Co-authored-by: Al Grant <al.grant@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 275 ++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
new file mode 100755
index 000000000000..164c1f5e6930
--- /dev/null
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -0,0 +1,275 @@
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
+		return "+%#x" % perf_dict[field]
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
+	dso_path = os.environ['PERF_BUILDID_DIR'] + "/" + dso_name + "/" + dso_build_id + append;
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
+	try:
+		disasm_output = disasm_cache[addr_range];
+	except:
+		start_addr = start_addr - dso_start;
+		stop_addr = stop_addr - dso_start;
+		disasm = [ options.objdump_name, "-d", "-z",
+			   "--start-address="+format(start_addr,"#x"),
+			   "--stop-address="+format(stop_addr,"#x") ]
+		disasm += [ dso_fname ]
+		disasm_output = check_output(disasm).split('\n')
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
+		print("\t" + line)
+
+def print_sample(sample):
+	print("Sample = { cpu: 0x%d addr: 0x%x phys_addr: 0x%x ip: 0x%x " \
+	      "pid: %d tid: %d period: %d time: %d }" % \
+	      (sample['cpu'], sample['addr'], sample['phys_addr'], \
+	       sample['ip'], sample['pid'], sample['tid'], \
+	       sample['period'], sample['time']))
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
+	ts = sample["time"]
+	cpu = sample["cpu"]
+	pid = sample["pid"]
+	tid = sample["tid"]
+	return "%16s %5u/%-5u [%03u] %9u.%09u  " % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000)
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
+			src_str = src_file + str(line_number).rjust(4)
+
+			if source_line is None:
+				src_str = src_file + " <source not found>"
+			else:
+				src_str = src_file + " " + source_line
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
+	print(start_str, src_str)
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
+		print("Event type: %s" % name)
+		print_sample(sample)
+
+	# If cannot find dso so cannot dump assembler, bail out
+	if (dso == '[unknown]'):
+		return
+
+	# Validate dso start and end addresses
+	if ((dso_start == '[unknown]') or (dso_end == '[unknown]')):
+		print("Failed to find valid dso map for dso %s"	% (dso))
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
+		print("CPU%s: CS_ETM_TRACE_ON packet is inserted" % cpu)
+		return
+
+	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
+		print("Start address 0x%x is out of range for dso %s [ 0x%x .. 0x%x ]" % (start_addr, dso, int(dso_start), int(dso_end)))
+		return
+
+	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
+		print("Stop address 0x%x is out of range for dso %s [ 0x%x .. 0x%x ]" % (stop_addr, dso, int(dso_start), int(dso_end)))
+		return
+
+	if (options.objdump_name != None):
+		# It doesn't need to reduce virtual memory offset for disassembly
+		# if it's a kernel dso, so in this case set vm_start to zero.
+		if (dso == "[kernel.kallsyms]"):
+			dso_vm_start = 0
+		else:
+			dso_vm_start = int(dso_start)
+
+		dso_fname = get_dso_file_path(dso, dso_bid)
+		if path.exists(dso_fname):
+			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+		else:
+			print("Failed to find dso file %s s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
+
+	print_srccode(comm, param_dict, sample, symbol, dso)
-- 
2.25.1

