Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D54F17AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378213AbiDDO5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiDDO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:57:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EF3117044;
        Mon,  4 Apr 2022 07:55:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C72D6E;
        Mon,  4 Apr 2022 07:55:44 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.8.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255133F5A1;
        Mon,  4 Apr 2022 07:55:43 -0700 (PDT)
Date:   Mon, 4 Apr 2022 15:55:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>
Subject: Re: Corrupted function tracer in 5.17.0-rc1
Message-ID: <YksG6LXUCwIZhK8k@FVFF77S0Q05N>
References: <20220404125212.tuby556kara5t56c@basti-XPS-13-9310>
 <20220404102607.5c9cb515@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20220404102607.5c9cb515@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 10:26:07AM -0400, Steven Rostedt wrote:
> 
> I added arm64 folks that maintain this code.
> 
> On Mon, 4 Apr 2022 14:52:12 +0200
> Sebastian Fricke <sebastian.fricke@collabora.com> wrote:
> 
> > Good day,
> > 
> > Maybe you can help me out with this, I am currently unsure if I cannot
> > use the function tracer due to some regression in the Kernel version I
> > am using or because I configured the kernel incorrectly.

From the title, this is v5.17-rc1, which is known broken due to the mcount sort
issue that was subsequently fixed in commit:

  4ed308c445a1e3ab ("ftrace: Have architectures opt-in for mcount build time sorting")

Is it possible to try with the final v5.17? Or at least try with that patch
cherry-picked?

I didn't think that led to this problem specifically, but in my testing the
problem was detected earlier, so maybe this is a secondary problem.

> > I have added the configuration as attachment.
> > 
> > Here is what I try to do:
> > ```
> > # cd /sys/kernel/tracing/
> > # ls
> > available_events            per_cpu                 stack_trace
> > available_filter_functions  printk_formats          stack_trace_filter
> > available_tracers           README                  timestamp_mode
> > buffer_percent              recursed_functions      trace
> > buffer_size_kb              saved_cmdlines          trace_clock
> > buffer_total_size_kb        saved_cmdlines_size     trace_marker
> > current_tracer              saved_tgids             trace_marker_raw
> > dyn_ftrace_total_info       set_event               trace_options
> > dynamic_events              set_event_notrace_pid   trace_pipe
> > enabled_functions           set_event_pid           trace_stat
> > error_log                   set_ftrace_filter       tracing_cpumask
> > events                      set_ftrace_notrace      tracing_on
> > free_buffer                 set_ftrace_notrace_pid  tracing_thresh
> > function_profile_enabled    set_ftrace_pid          uprobe_events
> > instances                   set_graph_function      uprobe_profile
> > max_graph_depth             set_graph_notrace       
> > options                     stack_max_size          
> > # echo function > current_tracer
> 
> So you enabled function tracing first before setting the filter. That means
> all functions that ftrace knows about will be modified.
> 
> > # echo do_page_fault > set_ftrace_filter 
> > -ash: can't create set_ftrace_filter: No such device
> 
> Looks like the setting of all functions faulted, and that would disable
> ftrace and give the above error messag. So the filter never took place. I
> wonder if you had set the filter first, and then tried to update if it
> would have worked. This would let us know if it is all function updates
> that's the problem or just a specific few.

Could that be caused by what I suggested above, with the ftrace locations not
being sorted?

> > ```
> > 
> > In the kernel log I can see that a ftrace bug is reported:
> > ```
> > [  173.064893] ------------[ ftrace bug ]------------
> > [  173.064918] ftrace faulted on modifying 
> 
> The above shows that ftrace faulted when it tried to modify a function. 
> 
> > [  173.064923] [<ffff8000096003dc>] set_reset_devices+0x4/0x20
> 
> The above is what it tried to update. I'm guessing you will see
> "set_reset_devices" in the list of functions in
> "available_filter_functions".
> 
> > [  173.064957] Setting ftrace call site to call ftrace function
> > [  173.064962] ftrace record flags: 80000001
> 
> The above is that a trampoline is in use (as shown below) with one user.
> 
> 
> Mark, et.al. Any changes that would cause ftrace not to be able to update
> the code.

Only as above. If we rule that out I can have a go investigating this locally.

Thanks,
Mark.

> 
> Sebastian, can you reply with the .config you used.
> 
> Thanks,
> 
> -- Steve
> 
> 
> > [  173.064968]  (1)  
> >                  expected tramp: ffff80000802a96c
> > [  173.065004] ------------[ cut here ]------------
> > [  173.065009] WARNING: CPU: 1 PID: 592 at kernel/trace/ftrace.c:2068 ftrace_bug+0x218/0x250
> > [  173.065032] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache netfs iptable_nat nf_nat iptable_mangle bpfilter iptable_filter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables nfnetlink hantro_vpu(C) rockchip_vdec(C) btsdio hci_uart v4l2_vp9 rockchip_rga snd_soc_simple_card snd_soc_audio_graph_card brcmfmac snd_soc_es8316 v4l2_h264 snd_soc_hdmi_codec btqca snd_soc_spdif_tx snd_soc_rockchip_i2s videobuf2_dma_contig snd_soc_simple_card_utils btrtl brcmutil v4l2_mem2mem videobuf2_dma_sg snd_soc_core btbcm videobuf2_memops cfg80211 btintel videobuf2_v4l2 snd_pcm_dmaengine snd_pcm videobuf2_common bluetooth videodev snd_timer mc snd rfkill dw_hdmi_i2s_audio dw_hdmi_cec soundcore cpufreq_dt sunrpc ip_tables x_tables autofs4 cls_cgroup panfrost drm_shmem_helper gpu_sched rockchipdrm drm_cma_helper dw_hdmi dw_mipi_dsi analogix_dp drm_kms_helper cec rc_cor
>  e drm
> > [  173.065467]  drm_panel_orientation_quirks realtek(E)
> > [  173.065487] CPU: 1 PID: 592 Comm: ash Tainted: G         C  E     5.17.0-rc1-rockpidebug2 #70
> > [  173.065501] Hardware name: Radxa ROCK Pi 4B (DT)
> > [  173.065508] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  173.065521] pc : ftrace_bug+0x218/0x250
> > [  173.065533] lr : ftrace_bug+0x218/0x250
> > [  173.065545] sp : ffff80000b433b30
> > [  173.065550] x29: ffff80000b433b30 x28: ffff000006ae0000 x27: 0000000000000000
> > [  173.065571] x26: 0000000000000000 x25: 0000000000000000 x24: ffff800009eb1f58
> > [  173.065591] x23: 00000000fffffff2 x22: ffff8000093e1ba0 x21: ffff8000093e1a70
> > [  173.065611] x20: ffff8000096003dc x19: ffff000000480030 x18: 0000000000000020
> > [  173.065631] x17: 0000000000000000 x16: 0000000000000009 x15: ffff000006ae04a0
> > [  173.065651] x14: 0000000000000000 x13: 6336396132303830 x12: 3030303866666666
> > [  173.065671] x11: ffff800009c7f1b0 x10: ffff800009c67170 x9 : ffff800008116dc8
> > [  173.065691] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
> > [  173.065711] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000027
> > [  173.065730] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
> > [  173.065749] Call trace:
> > [  173.065755]  ftrace_bug+0x218/0x250
> > [  173.065767]  ftrace_replace_code+0x94/0xa0
> > [  173.065783]  ftrace_modify_all_code+0xb8/0x150
> > [  173.065796]  arch_ftrace_update_code+0x14/0x20
> > [  173.065808]  ftrace_run_update_code+0x24/0x78
> > [  173.065820]  ftrace_startup_enable+0x44/0x58
> > [  173.065832]  ftrace_startup+0xcc/0x160
> > [  173.065846]  register_ftrace_function+0x38/0x90
> > [  173.065859]  function_trace_init+0x7c/0xd0
> > [  173.065873]  tracing_set_tracer+0xe8/0x170
> > [  173.065883]  tracing_set_trace_write+0x10c/0x178
> > [  173.065894]  vfs_write+0xc8/0x378
> > [  173.065909]  ksys_write+0x74/0x108
> > [  173.065921]  __arm64_sys_write+0x24/0x30
> > [  173.065934]  invoke_syscall+0x4c/0x110
> > [  173.065948]  el0_svc_common.constprop.0+0x4c/0xf8
> > [  173.065962]  do_el0_svc+0x2c/0x90
> > [  173.065974]  el0_svc+0x20/0x60
> > [  173.065988]  el0t_64_sync_handler+0xb0/0xb8
> > [  173.065998]  el0t_64_sync+0x1a0/0x1a4
> > [  173.066010] ---[ end trace 0000000000000000 ]---
> > ```
> > (full kernel log here: https://paste.debian.net/1236750/)
> > 
> > Thanks in advance for any help!
> > 
> > Greetings,
> > Sebastian
> 
