Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99157282F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGLVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiGLVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:02:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD0CB454
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657659713; x=1689195713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f4KGXLrrWGWgegokfLH23YGfA5p33OTfV87tCgEjzfI=;
  b=Wnxz0gF50nrWbAUSBPK5iUoq2ex/2LXc0hVxu1PsldY5f/KQE2WQx6Zb
   fZdmbbvxLIFIz3Emw6Evd/p7HMJFOTnUgDLKavRTwR2KDRL0KrvUAvROE
   PSBobr+psI3PSxF8Sjhf++3ImERFZBxXdi3zhPpdiO/S6sgv7eKm2bReq
   AHiI2DFR5n5YxrAUMEOHVAjsyg9njdPfhV0f0ryrd9rdw4cVvM1Wmc2GA
   5jd8TTEGe4i4dV8qKLgbL7F0W+1yAcYtrPe+SRFEwUJhIiIwNyOAp5ysX
   NniiXP9AvZf1df8J5jGzAGkWFV3E7ugAZqVIxGWQuu3DjeULByXmFwB9r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286171754"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="286171754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 14:01:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="545577847"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 14:01:52 -0700
Date:   Tue, 12 Jul 2022 14:01:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: crash during machine check recovery testing
Message-ID: <Ys3hPyojZEAf3sru@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a puzzling trace. It looks as though there was a recoverable
machine check that used task_work_add() to request that kill_me_maybe()
be called before going back to user mode.

I'm guessing that the scheduler picked someone else to run, so this
didn't happen right away.

The stack trace looks like the task somehow did run without handling
that task_work ... and then the task called exit(2). This seems very
odd.

Things went downhill from there with do_exit() trying to clean up
by calling exit_task_work()->task_work_run() which called
kill_me_maybe() and tries to do something with an already dying process.


[38682.429683] BUG: kernel NULL pointer dereference, address: 0000000000000090
[38682.437571] #PF: supervisor write access in kernel mode
[38682.443479] #PF: error_code(0x0002) - not-present page
[38682.449282] PGD 0
[38682.451604] Oops: 0002 [#1] SMP NOPTI
[38682.455773] CPU: 62 PID: 3851780 Comm: movdir64b_mem_s Tainted: G   M               5.15.0-spr.bkc.pc.8.8.5.x86_64 #1
[38682.467708] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.86B.0082.D01.2206061329 06/06/2022
[38682.479534] RIP: 0010:down_read+0xa/0x90
[38682.484016] Code: f0 ff ff 19 c0 f7 d0 83 e0 fc c3 65 48 8b 04 25 c0 6d 01 00 48 89 47 08 31 c0 c3 0f 1f 44 00 00 0f 1f 44 00 00 be 00 01 00 00 <f0> 48 0f c1 37 48 81 c6 00 01 00 00 78 2b 48 b8 07 00 00 00 00 00
[38682.505037] RSP: 0018:ff81f92d7f4d7dc8 EFLAGS: 00010246
[38682.510955] RAX: 0000000000000000 RBX: ff3cfa798b5e0000 RCX: 0000000000000000
[38682.518998] RDX: 0000000000000002 RSI: 0000000000000100 RDI: 0000000000000090
[38682.527046] RBP: 00000000001d0b6a R08: 0000000000000000 R09: c0000001003c4637
[38682.535072] R10: ff81f92d7f4d7c60 R11: ff81f92d7f4d7c58 R12: 0000000000000002
[38682.543137] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
[38682.551179] FS:  0000000000000000(0000) GS:ff3cfb75f9980000(0000) knlGS:0000000000000000
[38682.560281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[38682.566775] CR2: 0000000000000090 CR3: 0000006ecb20c006 CR4: 0000000001f71ee0
[38682.574827] DR0: ffffffffa2b9879b DR1: 0000000000000000 DR2: 0000000000000000
[38682.582887] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[38682.590947] PKRU: 55555554
[38682.594052] PKRS: 0x55555554
[38682.597366] Call Trace:
[38682.600188]  kill_accessing_process+0x63/0x138
[38682.605240]  memory_failure.cold.54+0xd7/0xde
[38682.610203]  kill_me_maybe+0x3d/0xa5
[38682.614287]  task_work_run+0x6a/0xa0
[38682.618383]  do_exit+0x345/0xb40
[38682.622078]  __x64_sys_exit+0x17/0x20
[38682.626256]  do_syscall_64+0x3f/0x90
[38682.630325]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[38682.636030] RIP: 0033:0x7fed33d4b28e
[38682.640110] Code: Unable to access opcode bytes at RIP 0x7fed33d4b264.
[38682.647481] RSP: 002b:00007fec5fffed40 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
[38682.656031] RAX: ffffffffffffffda RBX: 00007fec5f7ff000 RCX: 00007fed33d4b28e
[38682.664074] RDX: 000000000000003c RSI: 00000000007fb000 RDI: 0000000000000000
[38682.672112] RBP: 0000000000000000 R08: 0000000000000000 R09: 00003f72fbf65c35
[38682.680145] R10: 00000000000000e7 R11: 0000000000000246 R12: 00007ffdc87d6cae
[38682.688191] R13: 00007ffdc87d6caf R14: 00007fec5ffff700 R15: 00007fec5fffee00
[38682.696242] Modules linked in: einj veth xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink br_netfilter bridge stp llc overlay sunrpc iax_crypto idxd_mdev vfio_pci_core vfio_virqfd intel_rapl_msr intel_rapl_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp ofpart spi_nor pmt_crashlog pmt_telemetry mtd pmt_class kvm_intel intel_sdsi joydev kvm irqbypass isst_if_mbox_pci snd_pcm isst_if_mmio isst_if_common idxd i2c_i801 spi_intel_pci intel_vsec snd_timer spi_intel i2c_smbus mei_me mei i2c_ismt wmi acpi_power_meter acpi_pad pfr_update pfr_telemetry ip_tables crc32c_intel igb ast igc drm_vram_helper dca drm_ttm_helper pinctrl_emmitsburg pinctrl_intel fuse
[38682.775007] CR2: 0000000000000090
[38682.778807] ---[ end trace 8a3c9a1881a94be4 ]---
[38683.503336] RIP: 0010:down_read+0xa/0x90
[38683.507819] Code: f0 ff ff 19 c0 f7 d0 83 e0 fc c3 65 48 8b 04 25 c0 6d 01 00 48 89 47 08 31 c0 c3 0f 1f 44 00 00 0f 1f 44 00 00 be 00 01 00 00 <f0> 48 0f c1 37 48 81 c6 00 01 00 00 78 2b 48 b8 07 00 00 00 00 00
[38683.528877] RSP: 0018:ff81f92d7f4d7dc8 EFLAGS: 00010246
[38683.534807] RAX: 0000000000000000 RBX: ff3cfa798b5e0000 RCX: 0000000000000000
[38683.542866] RDX: 0000000000000002 RSI: 0000000000000100 RDI: 0000000000000090
[38683.550909] RBP: 00000000001d0b6a R08: 0000000000000000 R09: c0000001003c4637
[38683.558958] R10: ff81f92d7f4d7c60 R11: ff81f92d7f4d7c58 R12: 0000000000000002
[38683.566995] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
[38683.575045] FS:  0000000000000000(0000) GS:ff3cfb75f9980000(0000) knlGS:0000000000000000
[38683.584155] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[38683.590656] CR2: 0000000000000090 CR3: 0000006ecb20c006 CR4: 0000000001f71ee0
[38683.598713] DR0: ffffffffa2b9879b DR1: 0000000000000000 DR2: 0000000000000000
[38683.606749] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[38683.614808] PKRU: 55555554
[38683.617915] PKRS: 0x55555554
[38683.621216] Fixing recursive fault but reboot is needed!
