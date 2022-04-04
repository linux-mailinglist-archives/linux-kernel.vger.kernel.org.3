Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92C54F16EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377171AbiDDO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377120AbiDDO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256983ED37;
        Mon,  4 Apr 2022 07:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5C86B8167E;
        Mon,  4 Apr 2022 14:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD94C34110;
        Mon,  4 Apr 2022 14:26:08 +0000 (UTC)
Date:   Mon, 4 Apr 2022 10:26:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>
Subject: Re: Corrupted function tracer in 5.17.0-rc1
Message-ID: <20220404102607.5c9cb515@gandalf.local.home>
In-Reply-To: <20220404125212.tuby556kara5t56c@basti-XPS-13-9310>
References: <20220404125212.tuby556kara5t56c@basti-XPS-13-9310>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I added arm64 folks that maintain this code.

On Mon, 4 Apr 2022 14:52:12 +0200
Sebastian Fricke <sebastian.fricke@collabora.com> wrote:

> Good day,
> 
> Maybe you can help me out with this, I am currently unsure if I cannot
> use the function tracer due to some regression in the Kernel version I
> am using or because I configured the kernel incorrectly.
> 
> I have added the configuration as attachment.
> 
> Here is what I try to do:
> ```
> # cd /sys/kernel/tracing/
> # ls
> available_events            per_cpu                 stack_trace
> available_filter_functions  printk_formats          stack_trace_filter
> available_tracers           README                  timestamp_mode
> buffer_percent              recursed_functions      trace
> buffer_size_kb              saved_cmdlines          trace_clock
> buffer_total_size_kb        saved_cmdlines_size     trace_marker
> current_tracer              saved_tgids             trace_marker_raw
> dyn_ftrace_total_info       set_event               trace_options
> dynamic_events              set_event_notrace_pid   trace_pipe
> enabled_functions           set_event_pid           trace_stat
> error_log                   set_ftrace_filter       tracing_cpumask
> events                      set_ftrace_notrace      tracing_on
> free_buffer                 set_ftrace_notrace_pid  tracing_thresh
> function_profile_enabled    set_ftrace_pid          uprobe_events
> instances                   set_graph_function      uprobe_profile
> max_graph_depth             set_graph_notrace       
> options                     stack_max_size          
> # echo function > current_tracer

So you enabled function tracing first before setting the filter. That means
all functions that ftrace knows about will be modified.

> # echo do_page_fault > set_ftrace_filter 
> -ash: can't create set_ftrace_filter: No such device

Looks like the setting of all functions faulted, and that would disable
ftrace and give the above error messag. So the filter never took place. I
wonder if you had set the filter first, and then tried to update if it
would have worked. This would let us know if it is all function updates
that's the problem or just a specific few.

> ```
> 
> In the kernel log I can see that a ftrace bug is reported:
> ```
> [  173.064893] ------------[ ftrace bug ]------------
> [  173.064918] ftrace faulted on modifying 

The above shows that ftrace faulted when it tried to modify a function. 

> [  173.064923] [<ffff8000096003dc>] set_reset_devices+0x4/0x20

The above is what it tried to update. I'm guessing you will see
"set_reset_devices" in the list of functions in
"available_filter_functions".

> [  173.064957] Setting ftrace call site to call ftrace function
> [  173.064962] ftrace record flags: 80000001

The above is that a trampoline is in use (as shown below) with one user.


Mark, et.al. Any changes that would cause ftrace not to be able to update
the code.

Sebastian, can you reply with the .config you used.

Thanks,

-- Steve


> [  173.064968]  (1)  
>                  expected tramp: ffff80000802a96c
> [  173.065004] ------------[ cut here ]------------
> [  173.065009] WARNING: CPU: 1 PID: 592 at kernel/trace/ftrace.c:2068 ftrace_bug+0x218/0x250
> [  173.065032] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache netfs iptable_nat nf_nat iptable_mangle bpfilter iptable_filter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables nfnetlink hantro_vpu(C) rockchip_vdec(C) btsdio hci_uart v4l2_vp9 rockchip_rga snd_soc_simple_card snd_soc_audio_graph_card brcmfmac snd_soc_es8316 v4l2_h264 snd_soc_hdmi_codec btqca snd_soc_spdif_tx snd_soc_rockchip_i2s videobuf2_dma_contig snd_soc_simple_card_utils btrtl brcmutil v4l2_mem2mem videobuf2_dma_sg snd_soc_core btbcm videobuf2_memops cfg80211 btintel videobuf2_v4l2 snd_pcm_dmaengine snd_pcm videobuf2_common bluetooth videodev snd_timer mc snd rfkill dw_hdmi_i2s_audio dw_hdmi_cec soundcore cpufreq_dt sunrpc ip_tables x_tables autofs4 cls_cgroup panfrost drm_shmem_helper gpu_sched rockchipdrm drm_cma_helper dw_hdmi dw_mipi_dsi analogix_dp drm_kms_helper cec rc_core drm
> [  173.065467]  drm_panel_orientation_quirks realtek(E)
> [  173.065487] CPU: 1 PID: 592 Comm: ash Tainted: G         C  E     5.17.0-rc1-rockpidebug2 #70
> [  173.065501] Hardware name: Radxa ROCK Pi 4B (DT)
> [  173.065508] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  173.065521] pc : ftrace_bug+0x218/0x250
> [  173.065533] lr : ftrace_bug+0x218/0x250
> [  173.065545] sp : ffff80000b433b30
> [  173.065550] x29: ffff80000b433b30 x28: ffff000006ae0000 x27: 0000000000000000
> [  173.065571] x26: 0000000000000000 x25: 0000000000000000 x24: ffff800009eb1f58
> [  173.065591] x23: 00000000fffffff2 x22: ffff8000093e1ba0 x21: ffff8000093e1a70
> [  173.065611] x20: ffff8000096003dc x19: ffff000000480030 x18: 0000000000000020
> [  173.065631] x17: 0000000000000000 x16: 0000000000000009 x15: ffff000006ae04a0
> [  173.065651] x14: 0000000000000000 x13: 6336396132303830 x12: 3030303866666666
> [  173.065671] x11: ffff800009c7f1b0 x10: ffff800009c67170 x9 : ffff800008116dc8
> [  173.065691] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
> [  173.065711] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000027
> [  173.065730] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
> [  173.065749] Call trace:
> [  173.065755]  ftrace_bug+0x218/0x250
> [  173.065767]  ftrace_replace_code+0x94/0xa0
> [  173.065783]  ftrace_modify_all_code+0xb8/0x150
> [  173.065796]  arch_ftrace_update_code+0x14/0x20
> [  173.065808]  ftrace_run_update_code+0x24/0x78
> [  173.065820]  ftrace_startup_enable+0x44/0x58
> [  173.065832]  ftrace_startup+0xcc/0x160
> [  173.065846]  register_ftrace_function+0x38/0x90
> [  173.065859]  function_trace_init+0x7c/0xd0
> [  173.065873]  tracing_set_tracer+0xe8/0x170
> [  173.065883]  tracing_set_trace_write+0x10c/0x178
> [  173.065894]  vfs_write+0xc8/0x378
> [  173.065909]  ksys_write+0x74/0x108
> [  173.065921]  __arm64_sys_write+0x24/0x30
> [  173.065934]  invoke_syscall+0x4c/0x110
> [  173.065948]  el0_svc_common.constprop.0+0x4c/0xf8
> [  173.065962]  do_el0_svc+0x2c/0x90
> [  173.065974]  el0_svc+0x20/0x60
> [  173.065988]  el0t_64_sync_handler+0xb0/0xb8
> [  173.065998]  el0t_64_sync+0x1a0/0x1a4
> [  173.066010] ---[ end trace 0000000000000000 ]---
> ```
> (full kernel log here: https://paste.debian.net/1236750/)
> 
> Thanks in advance for any help!
> 
> Greetings,
> Sebastian

