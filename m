Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F758023B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiGYPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiGYPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175BDF66;
        Mon, 25 Jul 2022 08:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E4B612D3;
        Mon, 25 Jul 2022 15:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C507C341C6;
        Mon, 25 Jul 2022 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658764292;
        bh=D2wgVTwKzP8TBWzA6DR1j32Ce7EmDFIW2LmXj+GKvNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXK0FaoMHQ32sj98tTKH7oY94dnvER6p018jQ1LWKeXpJJbKDOuq1jQYj+5XhZOfi
         fC8hjB93sKZIhJlzvBplcInY/+qKq4HQXUdD47IfzTSpSPqWvb9F8EpE3aj4mlbcvT
         66vBWdXoHvNKouOeL6U0XQQjUK+CgpXXuXdkh+pTALylqcVfZT/otyLfy+Yq1qtyVA
         R0zassXG9RGgps57C/nhuCSAQPDgrYpM6ThzIJtz2hG8XkVUVCrUzOfJzOt4gL442Y
         pa5tn2CbpXbyVO3ER600g/2FqlTnuew1Nx2+98WGoEAzBTkffAN3iPhoa7IiTX+mkK
         PogEiHLzwFAhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 007D740374; Mon, 25 Jul 2022 12:51:29 -0300 (-03)
Date:   Mon, 25 Jul 2022 12:51:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Akemi Yagi <toracat@elrepo.org>, ElRepo <contact@elrepo.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
Message-ID: <Yt68AZA2VV9d02xZ@kernel.org>
References: <20220725104220.1106663-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725104220.1106663-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> The distro doesn't upgrade from python2 to python3, this causes the
> building error that the python script is not python2 compliant.
> 
> To fix the building failure, this patch changes from the python f-string
> format to traditional string format.

Thanks, applied.

- Arnaldo

 
> Reported-by: Akemi Yagi <toracat@elrepo.org>
> Fixes: 12fdd6c009da ("perf scripts python: Support Arm CoreSight trace data disassembly")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../scripts/python/arm-cs-trace-disasm.py     | 34 ++++++++++---------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 5f57d9829956..4339692a8d0b 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -61,7 +61,7 @@ def get_optional(perf_dict, field):
>  
>  def get_offset(perf_dict, field):
>  	if field in perf_dict:
> -		return f"+0x{perf_dict[field]:x}"
> +		return "+%#x" % perf_dict[field]
>  	return ""
>  
>  def get_dso_file_path(dso_name, dso_build_id):
> @@ -76,7 +76,7 @@ def get_dso_file_path(dso_name, dso_build_id):
>  	else:
>  		append = "/elf"
>  
> -	dso_path = f"{os.environ['PERF_BUILDID_DIR']}/{dso_name}/{dso_build_id}{append}"
> +	dso_path = os.environ['PERF_BUILDID_DIR'] + "/" + dso_name + "/" + dso_build_id + append;
>  	# Replace duplicate slash chars to single slash char
>  	dso_path = dso_path.replace('//', '/', 1)
>  	return dso_path
> @@ -94,8 +94,8 @@ def read_disam(dso_fname, dso_start, start_addr, stop_addr):
>  		start_addr = start_addr - dso_start;
>  		stop_addr = stop_addr - dso_start;
>  		disasm = [ options.objdump_name, "-d", "-z",
> -			   f"--start-address=0x{start_addr:x}",
> -			   f"--stop-address=0x{stop_addr:x}" ]
> +			   "--start-address="+format(start_addr,"#x"),
> +			   "--stop-address="+format(stop_addr,"#x") ]
>  		disasm += [ dso_fname ]
>  		disasm_output = check_output(disasm).decode('utf-8').split('\n')
>  		disasm_cache[addr_range] = disasm_output
> @@ -109,12 +109,14 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
>  			m = disasm_re.search(line)
>  			if m is None:
>  				continue
> -		print(f"\t{line}")
> +		print("\t" + line)
>  
>  def print_sample(sample):
> -	print(f"Sample = {{ cpu: {sample['cpu']:04} addr: 0x{sample['addr']:016x} " \
> -	      f"phys_addr: 0x{sample['phys_addr']:016x} ip: 0x{sample['ip']:016x} " \
> -	      f"pid: {sample['pid']} tid: {sample['tid']} period: {sample['period']} time: {sample['time']} }}")
> +	print("Sample = { cpu: %04d addr: 0x%016x phys_addr: 0x%016x ip: 0x%016x " \
> +	      "pid: %d tid: %d period: %d time: %d }" % \
> +	      (sample['cpu'], sample['addr'], sample['phys_addr'], \
> +	       sample['ip'], sample['pid'], sample['tid'], \
> +	       sample['period'], sample['time']))
>  
>  def trace_begin():
>  	print('ARM CoreSight Trace Data Assembler Dump')
> @@ -131,7 +133,7 @@ def common_start_str(comm, sample):
>  	cpu = sample["cpu"]
>  	pid = sample["pid"]
>  	tid = sample["tid"]
> -	return f"{comm:>16} {pid:>5}/{tid:<5} [{cpu:04}] {sec:9}.{ns:09}  "
> +	return "%16s %5u/%-5u [%04u] %9u.%09u  " % (comm, pid, tid, cpu, sec, ns)
>  
>  # This code is copied from intel-pt-events.py for printing source code
>  # line and symbols.
> @@ -171,7 +173,7 @@ def print_srccode(comm, param_dict, sample, symbol, dso):
>  	glb_line_number = line_number
>  	glb_source_file_name = source_file_name
>  
> -	print(f"{start_str}{src_str}")
> +	print(start_str, src_str)
>  
>  def process_event(param_dict):
>  	global cache_size
> @@ -188,7 +190,7 @@ def process_event(param_dict):
>  	symbol = get_optional(param_dict, "symbol")
>  
>  	if (options.verbose == True):
> -		print(f"Event type: {name}")
> +		print("Event type: %s" % name)
>  		print_sample(sample)
>  
>  	# If cannot find dso so cannot dump assembler, bail out
> @@ -197,7 +199,7 @@ def process_event(param_dict):
>  
>  	# Validate dso start and end addresses
>  	if ((dso_start == '[unknown]') or (dso_end == '[unknown]')):
> -		print(f"Failed to find valid dso map for dso {dso}")
> +		print("Failed to find valid dso map for dso %s" % dso)
>  		return
>  
>  	if (name[0:12] == "instructions"):
> @@ -244,15 +246,15 @@ def process_event(param_dict):
>  
>  	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>  	if (start_addr == 0 and stop_addr == 4):
> -		print(f"CPU{cpu}: CS_ETM_TRACE_ON packet is inserted")
> +		print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>  		return
>  
>  	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> -		print(f"Start address 0x{start_addr:x} is out of range [ 0x{dso_start:x} .. 0x{dso_end:x} ] for dso {dso}")
> +		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>  		return
>  
>  	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
> -		print(f"Stop address 0x{stop_addr:x} is out of range [ 0x{dso_start:x} .. 0x{dso_end:x} ] for dso {dso}")
> +		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>  		return
>  
>  	if (options.objdump_name != None):
> @@ -267,6 +269,6 @@ def process_event(param_dict):
>  		if path.exists(dso_fname):
>  			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>  		else:
> -			print(f"Failed to find dso {dso} for address range [ 0x{start_addr:x} .. 0x{stop_addr:x} ]")
> +			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
>  
>  	print_srccode(comm, param_dict, sample, symbol, dso)
> -- 
> 2.25.1

-- 

- Arnaldo
