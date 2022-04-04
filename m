Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D234F0DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377018AbiDDDnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352591AbiDDDns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770239805
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D5646111D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82258C2BBE4;
        Mon,  4 Apr 2022 03:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649043711;
        bh=HuBthyv0jlhrroQ/LbSxvCBXHiEnHO5N2vwpPIkoOMY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZzJqhWSbkVqK6dP9xY2JerJ2vjOlAaYARla7uHaDDxi6G0zFPTY0GDAcSYsIDF5du
         +D84dDA1gZ2zFlC9uwS5Xn529dpLK1n60rcw5APR+AZ4v/5lQsF46eigjd79nx3OJZ
         Jb/ZrTJWiyfVORCCv+VMkTPbWCaPelpE1eVklMhD7QAePq3yZToKcSy+KSnodGF747
         iGbSy6llmS9hEOaaggKUP++KD+2o1fWjE01NSu4HIEpkcyAXsR/BCiefam9YtevesS
         +ewFnmpteAjhdsahNKi4BBZSEVSCkfAe4Kbq9kJ05TbEYI0V1BUh1kwLQaoXwBpQCU
         WxGv2foSPGQVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B4BB5C08B7; Sun,  3 Apr 2022 20:41:51 -0700 (PDT)
Date:   Sun, 3 Apr 2022 20:41:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a
 136/158] WARNING: modpost: vmlinux.o(.text+0x28d3a): Section mismatch in
 reference from the function cpu_in_idle() to the variable .init.text:.LVL79
Message-ID: <20220404034151.GS4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202204040803.eMjcdkZh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204040803.eMjcdkZh-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 08:18:59AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
> head:   d9f3e7d671416fdf5b61f094765754269b652db0
> commit: 4a8d065a72d07894b2d9f976ffa9ee4ab1f8abb4 [136/158] refscale: Allow refscale without RCU Tasks
> config: riscv-randconfig-r002-20220403 (https://download.01.org/0day-ci/archive/20220404/202204040803.eMjcdkZh-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/4a8d065a72d07894b2d9f976ffa9ee4ab1f8abb4
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
>         git checkout 4a8d065a72d07894b2d9f976ffa9ee4ab1f8abb4
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text+0x28d3a): Section mismatch in reference from the function cpu_in_idle() to the variable .init.text:.LVL79
> The function cpu_in_idle() references
> the variable __init .LVL79.
> This is often because cpu_in_idle lacks a __init
> annotation or the annotation of .LVL79 is wrong.

This added information is much nicer, thank you!

But I cannot make cpu_in_idle()  as __init because it is invoked at
runtime by nmi_cpu_backtrace().

Also, I do not see any .LVL79.  Might this be a compiler temporary?

And I cannot see how this patch could have affected cpu_in_idle().

Might this instead be a false positive caused by the fact that
cpu_in_idle() references __cpuidle_text_start and __cpuidle_text_end,
both of which are defined in vmlinux.lds.h?

							Thanx, Paul

> --
> >> WARNING: modpost: vmlinux.o(.text+0x81fe66): Section mismatch in reference from the function pccard_sysfs_remove_socket() to the variable .init.text:.LVL163
> The function pccard_sysfs_remove_socket() references
> the variable __init .LVL163.
> This is often because pccard_sysfs_remove_socket lacks a __init
> annotation or the annotation of .LVL163 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0x967e84): Section mismatch in reference from the function rproc_report_crash() to the variable .init.text:.L0
> The function rproc_report_crash() references
> the variable __init .L0 .
> This is often because rproc_report_crash lacks a __init
> annotation or the annotation of .L0 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0x97395c): Section mismatch in reference from the function sdw_debugfs_exit() to the variable .init.text:.L0
> The function sdw_debugfs_exit() references
> the variable __init .L0 .
> This is often because sdw_debugfs_exit lacks a __init
> annotation or the annotation of .L0 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0xa3373a): Section mismatch in reference from the function snd_pcm_period_elapsed() to the variable .init.text:.L0
> The function snd_pcm_period_elapsed() references
> the variable __init .L0 .
> This is often because snd_pcm_period_elapsed lacks a __init
> annotation or the annotation of .L0 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0xb54e76): Section mismatch in reference from the function br_vlan_tunnel_info() to the variable .init.text:.L0
> The function br_vlan_tunnel_info() references
> the variable __init .L0 .
> This is often because br_vlan_tunnel_info lacks a __init
> annotation or the annotation of .L0 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0xbd1d50): Section mismatch in reference from the function batadv_v_mesh_free() to the variable .init.text:.L0
> The function batadv_v_mesh_free() references
> the variable __init .L0 .
> This is often because batadv_v_mesh_free lacks a __init
> annotation or the annotation of .L0 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0xd24c8): Section mismatch in reference from the function wb_wakeup_delayed() to the variable .exit.text:.L0
> The function wb_wakeup_delayed() references a variable in an exit section.
> Often the variable .L0 has valid usage outside the exit section
> and the fix is to remove the __exit annotation of .L0 .
> --
> >> WARNING: modpost: vmlinux.o(.text+0x378a4a): Section mismatch in reference from the function drm_mode_equal() to the variable .init.text:.LBB506
> The function drm_mode_equal() references
> the variable __init .LBB506.
> This is often because drm_mode_equal lacks a __init
> annotation or the annotation of .LBB506 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0x378a54): Section mismatch in reference from the function drm_mode_equal_no_clocks() to the variable .init.text:.LBB506
> The function drm_mode_equal_no_clocks() references
> the variable __init .LBB506.
> This is often because drm_mode_equal_no_clocks lacks a __init
> annotation or the annotation of .LBB506 is wrong.
> 
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> << WARNING: modpost: vmlinux.o(.text+0x17f74): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x2ad3a): Section mismatch in reference from the function calc_load_nohz_stop() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x1816f8): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x26987c): Section mismatch in reference from the function zstd_find_frame_compressed_size() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x477170): Section mismatch in reference from the function radeon_audio_init() to the variable .init.text:.LVL153
> << WARNING: modpost: vmlinux.o(.text+0x6a44d4): Section mismatch in reference from the function gf100_gr_wait_idle() to the variable .init.text:.LBB317
> << WARNING: modpost: vmlinux.o(.text+0x96a4ee): Section mismatch in reference from the function rpmsg_create_channel() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0x96a502): Section mismatch in reference from the function rpmsg_release_channel() to the variable .init.text:.L6
> << WARNING: modpost: vmlinux.o(.text+0x96a51a): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L13
> << WARNING: modpost: vmlinux.o(.text+0x96a660): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L25
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
