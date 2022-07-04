Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A8556587C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiGDOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiGDOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:19:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAAEFFC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9A64B80F03
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C77C3411E;
        Mon,  4 Jul 2022 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656944391;
        bh=7vo3mqe9Qcsda9vM7KMrdZX6HLtI93fHFj//LQvLa1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyxgDDmspKLKZARO6/0mzW5SyZmrYTpHMagY6ROaJRWlOhs1AHvKsyP4PRLGGO/sT
         xUAP5m5gCDulzdWfXJYocg1lFFzf/ujfTFCClQ1iw+gPd1kDRnka5akEXlOGKIGt8O
         KEM+SpeYUseM6xTZbNEQhfdD4nQlHHYyelhtgC77K6MMnIs1ojTpIaEe2k7MHVU3QN
         Vq0aFOptRokK+nRvx3TK91Qs1IM5t9bQaZ3/dpGaGR1NqkeTqtBEoB82rnYrNeRX/s
         n6xN05qpqIZAIUMGMhGWbEV8TliWRIME0b7b2zVbO0AvS7jreQT0CPdT9pSjQYvmXh
         F3yXEXunoL8WQ==
Date:   Mon, 4 Jul 2022 15:19:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LTP List <ltp@lists.linux.it>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, brauner@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: 5.19.0-rc5 : Raspberry Pi 4 : Unable to handle kernel paging
 request at virtual address
Message-ID: <20220704141945.GD31684@willie-the-truck>
References: <CA+G9fYtu1G4oGtKZQ_g5VJbQoET8c7hN_Ds-O1-1HD3PwV4wkQ@mail.gmail.com>
 <20220704112605.GB31553@willie-the-truck>
 <aa641b98-98ca-14d3-2a28-2c0aef96ed0d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa641b98-98ca-14d3-2a28-2c0aef96ed0d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 02:37:52PM +0100, Robin Murphy wrote:
> On 2022-07-04 12:26, Will Deacon wrote:
> > On Mon, Jul 04, 2022 at 01:28:30PM +0530, Naresh Kamboju wrote:
> > > While running LTP controllers tests on arm64 Raspberry Pi 4 Model B
> > > the following kernel crash noticed.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > metadata:
> > >    git_ref: master
> > >    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> > >    git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
> > >    kernel_version: 5.19.0-rc5
> > >    kernel-config: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/config
> > >    build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/579007773
> > >    artifact-location: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh
> > >    vmlinux.xz: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/vmlinux.xz
> > >    System.map: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/System.map
> > >    toolchain: gcc-11
> > > 
> > > Steps to reproduce:
> > > -------------------
> > > ./runltp -p -q -f controllers
> > > 
> > > Test log:
> > > ----------
> > > cgroup_fj_stress_blkio_4_4_each 1 TPASS: All done!
> > > cgroup_fj_stress_blkio_4_4_each 2 TINFO: Removing all ltp subgroups...
> > > cgroup_fj_stress_blkio_2_9_each 1 TINFO: Subsystem blkio is mounted at
> > > /sys/fs/cgroup/blkio
> > > cgroup_fj_stress_blkio_2_9_each 1 TINFO: Creating subgroups ...
> > > [ 2414.973441] Unable to handle kernel paging request at virtual
> > > address 00620000090336a0
> > > [ 2414.981581] Mem abort info:
> > > [ 2414.984480]   ESR = 0x0000000086000004
> > > [ 2414.988323]   EC = 0x21: IABT (current EL), IL = 32 bits
> > > [ 2414.993765]   SET = 0, FnV = 0
> > > [ 2414.996905]   EA = 0, S1PTW = 0
> > > [ 2415.000124]   FSC = 0x04: level 0 translation fault
> > > [ 2415.005118] [00620000090336a0] address between user and kernel address ranges
> > > [ 2415.012393] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > > [ 2415.018048] Modules linked in: btrfs blake2b_generic libcrc32c
> > > raid6_pq zstd_compress xhci_pci snd_soc_hdmi_codec xhci_pci_renesas
> > > raspberrypi_cpufreq hci_uart btqca brcmfmac brcmutil btbcm vc4
> > > bluetooth cfg80211 cec drm_display_helper drm_cma_helper rfkill
> > > clk_raspberrypi reset_raspberrypi drm_kms_helper crct10dif_ce
> > > raspberrypi_hwmon drm i2c_bcm2835 iproc_rng200 rng_core pwm_bcm2835
> > > bcm2711_thermal pcie_brcmstb fuse
> > > [ 2415.055725] CPU: 0 PID: 11626 Comm: cgroup_fj_stres Not taintedlinu#1
> > > [ 2415.062965] Hardware name: Raspberry Pi 4 Model B (DT)
> > > [ 2415.068175] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [ 2415.075238] pc : 0x620000090336a0
> > > [ 2415.078600] lr : ktime_get+0x50/0xac
> > > [ 2415.082228] sp : ffff80000dfdbb90
> > > [ 2415.085585] x29: ffff80000dfdbb90 x28: 00000000ffffffff x27: ffff00006405e580
> > > [ 2415.092832] x26: ffff00006405e748 x25: 0000000001200000 x24: ffff00006405e180
> > > [ 2415.100076] x23: ffff80000dfdbd68 x22: 0000000000000000 x21: 000002321545f201
> > > [ 2415.107320] x20: 000000000012017e x19: ffff80000ae3b440 x18: ffff000000000000
> > > [ 2415.114564] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000000dc
> > > [ 2415.121809] x14: 0000000001200011 x13: 0000000060000000 x12: 0000ffffa7b6c1e8
> > > [ 2415.129052] x11: 0000000000000040 x10: ffff80000a96c5c0 x9 : ffff8000080990d4
> > > [ 2415.136295] x8 : 0000000000000000 x7 : 0000000000a9c84a x6 : 4480001ec1769752
> > > [ 2415.143538] x5 : 00ffbffeffffffff x4 : 0000000900000000 x3 : 0000000000000000
> > > [ 2415.150781] x2 : ffff80000a94e000 x1 : ffff8000090336a0 x0 : ffff80000ad102f0
> > > [ 2415.158025] Call trace:
> > > [ 2415.160498]  0x620000090336a0
> > > [ 2415.163505]  copy_process+0xe34/0x1534
> > 
> > Do you have the disassembly (and source:line infor) around
> > copy_process+0xe34/0x1534? The faulting PC is like a messed up copy of x1
> > where the upper bits have been corrupted somehow.
> 
> Even better, according to the vmlinux that LR value points right after a
> "blr x1". From the shape of it, looks like it's probably the tk_clock_read()
> call.

System.map has:

ffff8000090336a0 t arch_counter_read

so yes, it looks like we want to call that via:

	clock->read(clock);

but the indirect branch goes wrong :/

Naresh -- do you see this repeatably and on more than just one board?

Will
