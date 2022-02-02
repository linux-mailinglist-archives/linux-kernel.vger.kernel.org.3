Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F124A6CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiBBIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:23:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:19622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232819AbiBBIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643790228; x=1675326228;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wdy7MoOCFGG4FgfFGa+kkUzBPB0aW3lGeiiXICIgLq4=;
  b=VXTl7aHO+dr6VL71w3cLzWTM90cyTp1Ytzxiv15icrdmlPnUxBwP0Qn5
   FtJF64rIG9hLTQx11yaEc+9iijjadyDgMaWkE4fM1LZX4Yynz6MGoO0rz
   sobCTGCikBmdgjo9U3ZJr6DCrv5jMQuOKJOBgjn+Vq5yPFrlBKV+r013N
   UYYFiVXikb0kevgaOEUlELRlJcT3WD3lqzGlVdYOXIVY3zlc6i7U0PNBw
   LgrsDF0LGHbYFN17iAlpMJt/Dfz2FYWUXdReA5iBJ57LEqMvTuNLHyMHX
   hy5D7iTq0Q3K3QoO0gAHxndsRBegyFN2dnq4aM+odh6hF401kIQVotQvl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246701362"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="246701362"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="538159615"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 02 Feb 2022 00:23:42 -0800
Subject: Re: [PATCH] perf/x86/intel/pt: Fix crash with stop filters in
 single-range mode
To:     Tristan Hume <tristan@thume.ca>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
References: <20220127220806.73664-1-tristan@thume.ca>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <015e9e04-444f-959d-c003-3d8a9535e738@intel.com>
Date:   Wed, 2 Feb 2022 10:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220127220806.73664-1-tristan@thume.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 00:08, Tristan Hume wrote:
> Add a check for !buf->single before calling pt_buffer_region_size in a
> place where a missing check can cause a kernel crash.
> 
> Fixes a bug introduced by 670638477aede0d7a355ced04b569214aa3feacd,
> which added a support for PT single-range output mode. Since that commit
> if a PT stop filter range is hit while tracing, the kernel will crash
> because of a null pointer dereference in pt_handle_status due to calling
> pt_buffer_region_size without a ToPA configured.
> 
> The commit which introduced single-range mode guarded almost all uses of
> the ToPA buffer variables with checks of the buf->single variable, but
> missed the case where tracing was stopped by the PT hardware, which
> happens when execution hits a configured stop filter.

Please add to the commit message:

Example:

 # perf record -S -e intel_pt// --filter tracestop __schedule sleep 1

[ 6148.371226] BUG: unable to handle page fault for address: fffffffffffff028
[ 6148.371236] #PF: supervisor read access in kernel mode
[ 6148.371240] #PF: error_code(0x0000) - not-present page
[ 6148.371244] PGD 6410067 P4D 6410067 PUD 6412067 PMD 0 
[ 6148.371253] Oops: 0000 [#1] PREEMPT SMP PTI
[ 6148.371258] CPU: 0 PID: 7279 Comm: perf Not tainted 5.16.0+ #24
[ 6148.371264] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, BIOS BECFL357.86A.0089.2021.0621.1343 06/21/2021
[ 6148.371268] RIP: 0010:pt_handle_status+0x94/0x270
[ 6148.371278] Code: 26 01 00 00 8b 4b 28 4c 8b 43 20 48 8b 73 30 48 89 ca 49 8d b8 28 f0 ff ff 48 8d 0c cf 83 fa ff 75 08 49 63 50 20 48 8d 0c d7 <0f> b7 09 ba 01 00 00 00 66 c1 e9 06 83 e1 0f 83 c1 0c d3 e2 48 63
[ 6148.371283] RSP: 0018:ffffc9000308fad0 EFLAGS: 00010013
[ 6148.371288] RAX: 0000000000000002 RBX: ffff8881d62ed500 RCX: fffffffffffff028
[ 6148.371292] RDX: 0000000000000000 RSI: 0000000000000510 RDI: fffffffffffff028
[ 6148.371296] RBP: ffffc9000308fae8 R08: 0000000000000000 R09: 0000000000000000
[ 6148.371299] R10: 0000000000000000 R11: 0000000000000000 R12: 0000051000000002
[ 6148.371302] R13: ffff88846dc1e020 R14: 0000000000000004 R15: ffff88846dc36208
[ 6148.371306] FS:  00007f1f8630b3c0(0000) GS:ffff88846dc00000(0000) knlGS:0000000000000000
[ 6148.371311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6148.371315] CR2: fffffffffffff028 CR3: 0000000124ea6001 CR4: 00000000003706f0
[ 6148.371318] Call Trace:
[ 6148.371321]  <TASK>
[ 6148.371325]  pt_event_stop+0x8a/0xd0
[ 6148.371333]  pt_event_del+0x13/0x20
[ 6148.371338]  event_sched_out.isra.0+0x7a/0x1c0
[ 6148.371345]  group_sched_out.part.0+0x43/0x90
[ 6148.371350]  __perf_event_disable+0x105/0x1f0
[ 6148.371355]  event_function+0xab/0xf0
[ 6148.371362]  ? perf_duration_warn+0x30/0x30
[ 6148.371369]  remote_function+0x51/0x60
[ 6148.371375]  generic_exec_single+0x66/0xa0
[ 6148.371381]  smp_call_function_single+0xb9/0x170
[ 6148.371386]  ? perf_duration_warn+0x30/0x30
[ 6148.371393]  ? preempt_count_add+0x74/0xc0
[ 6148.371399]  event_function_call+0x114/0x120
[ 6148.371405]  ? group_sched_out.part.0+0x90/0x90
[ 6148.371409]  ? cpu_clock_event_read+0x30/0x30
[ 6148.371415]  _perf_event_disable+0x48/0x60
[ 6148.371421]  ? event_function_call+0x120/0x120
[ 6148.371427]  perf_event_for_each_child+0x3f/0x90
[ 6148.371432]  ? event_function_call+0x120/0x120
[ 6148.371438]  _perf_ioctl+0x20c/0x910
[ 6148.371443]  ? force_compatible_cpus_allowed_ptr+0x1d0/0x1d0
[ 6148.371451]  ? affine_move_task+0x419/0x610
[ 6148.371459]  ? __this_cpu_preempt_check+0x13/0x20
[ 6148.371468]  ? xfd_validate_state+0x23/0x80
[ 6148.371475]  perf_ioctl+0x48/0x70
[ 6148.371481]  __x64_sys_ioctl+0x91/0xc0
[ 6148.371490]  do_syscall_64+0x43/0xc0
[ 6148.371495]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 6148.371504] RIP: 0033:0x7f1f86d8050b
[ 6148.371509] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
[ 6148.371513] RSP: 002b:00007fffd59a86c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 6148.371519] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1f86d8050b
[ 6148.371522] RDX: 0000000000000000 RSI: 0000000000002401 RDI: 0000000000000005
[ 6148.371525] RBP: 00007fffd59a8700 R08: 0000000000000000 R09: 00007f1f86e54cc0
[ 6148.371528] R10: 0000562bd7bad010 R11: 0000000000000246 R12: 0000000000000000
[ 6148.371531] R13: 0000562bd7bc8f20 R14: 0000562bd7bb1e10 R15: 0000562bd7bc8f20
[ 6148.371537]  </TASK>
[ 6148.371539] Modules linked in:
[ 6148.371544] CR2: fffffffffffff028
[ 6148.371547] ---[ end trace 542919a16ee8853b ]---

> 
> Tested that hitting a stop filter while PT recording successfully
> records a trace with this patch but crashes without this patch.
> 
> Signed-off-by: Tristan Hume <tristan@thume.ca>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>

Fixes: 670638477aede0 ("perf/x86/intel/pt: Opportunistically use single range output mode")
Cc: stable@vger.kernel.org
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  arch/x86/events/intel/pt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 7f406c14715f..2d33bba9a144 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -897,8 +897,9 @@ static void pt_handle_status(struct pt *pt)
>  		 * means we are already losing data; need to let the decoder
>  		 * know.
>  		 */
> -		if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
> -		    buf->output_off == pt_buffer_region_size(buf)) {
> +		if (!buf->single &&
> +		    (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
> +		     buf->output_off == pt_buffer_region_size(buf))) {
>  			perf_aux_output_flag(&pt->handle,
>  			                     PERF_AUX_FLAG_TRUNCATED);
>  			advance++;
> 

