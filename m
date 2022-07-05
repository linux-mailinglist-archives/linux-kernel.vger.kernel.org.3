Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65B7566E9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiGEMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbiGEMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:45:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701C24094
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=TiBigXGxnG4jz95bnnzIvPwDJCWGHlezgBtGY8U3MtM=; b=mUa1/m/nzg0wcTSJT/DEzvSU4c
        buJrAjL8Dj5zo8n0ddo7S7dOYAZG8f7u5iyz6y8H66oeTZ09mNH+xkq3scp8F3bdqwDxhyt/nnJS0
        jyAvURL4sonvnC8gMcy06A86b0bsE8iWpBbZ2DtEYuUElLLtrpVraJLAOofiYVtS9H8fX63iHG0r7
        AjFeLN7ORTs0boaxAtb2UPAx+5P3ymKaouZ/Zzv2Rkq49mt/chkPOliy+RK8poflHM0h3NGdIPxPJ
        HCaWs4VlPRSTvC/1CKAP62vgWpFBL7RuZ6fNH3nbnE6SZ5aiShi9JDJ2bzKKFvgENyILF0aEGewhk
        ExBA03Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8hcy-000YoO-PF; Tue, 05 Jul 2022 12:26:04 +0000
Date:   Tue, 5 Jul 2022 13:26:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: next-20220616 - repeated crashes in  zap_pmd_range
Message-ID: <YsQt3IHbJnAhsSWl@casper.infradead.org>
References: <11765.1657004484@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11765.1657004484@turing-police>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 03:01:24AM -0400, Valdis Klētnieks wrote:
> I've had multiple crashes with the same kernel stack trace on my x86_64
> laptop.. There doesn't seem to be any matching reports in my linux-kernel mail
> folder or where Google can find them.

New to me.  BTW, the crash is in zap_pte_range() (the RIP line), not
zap_pmd_range().  It's tripping over:

        BUG_ON(is_migration_entry(entry) && !PageLocked(p));

It's not immediately clear to me which patch might be producing this
problem.

> I've hit it with different processes running:

You could hit it with any process doing anything.  What's happening is
that there's a migration entry, presumably inserted by kcompactd (since
this is a laptop, I assume it's not NUMA).  The page that it's referring
to isn't locked for some reason.

You seem to have hit it a few times; how easy is it to reproduce?  I
will say that 20220616 was almost three weeks ago; does it still happen
with 20220704?  I'd hate to spend time chasing a ghost.

> [142037.910871][T92126] ------------[ cut here ]------------
> [142037.990897][T92126] kernel BUG at include/linux/swapops.h:378!
> [142038.070921][T92126] invalid opcode: 0000 [#1] PREEMPT SMP
> [142038.150973][T92126] CPU: 0 PID: 92126 Comm: gnome-mahjongg Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
> [142038.311018][T92126] RIP: 0010:zap_pte_range+0xb71/0xba0
> [142038.391046][T92126] Code: ff e9 74 fb ff ff 48 8d 49 ff e9 4c fb ff ff 49 8b 56 10 49 8b 76 08 e8 ad dc 04 00 e9 6d
> fc ff ff 4c 8d 41 ff e9 6c fb ff ff <0f> 0b 48 8d 49 ff e9 f3 fa ff ff e8 af 37 d4 00 48 83 e2 f7 e9 20
> [142038.471068][T92126] RSP: 0018:ffffaeca836d3a70 EFLAGS: 00010246
> [142038.631101][T92126] RAX: 0000000000000000 RBX: 0000563818dc4000 RCX: 0000000000000000
> [142038.711121][T92126] RDX: efffffffdca33600 RSI: efffffffdca33600 RDI: ffffe37b046b9900
> [142038.791142][T92126] RBP: ffffaeca836d3b00 R08: ffffe37b046b9900 R09: 000000003b13b0a2
> [142038.871162][T92126] R10: 000000009127bdcc R11: 0000000000000000 R12: ffffaeca836d3c18
> [142038.951182][T92126] R13: ffff88914584be18 R14: eff0000000000600 R15: ffffaeca836d3ce0
> [142039.031202][T92126] FS:  00007f2b5492b200(0000) GS:ffff889276a00000(0000) knlGS:0000000000000000
> [142039.111223][T92126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [142039.191243][T92126] CR2: 0000563818de0000 CR3: 0000000110dfa000 CR4: 00000000001006f0
> [142039.271263][T92126] Call Trace:
> [142039.351283][T92126]  <TASK>
> [142039.431309][T92126]  zap_pmd_range.isra.0+0x136/0x320
> [142039.511337][T92126]  unmap_page_range+0x18a/0x2f0
> [142039.591362][T92126]  ? debug_smp_processor_id+0x1b/0x20
> [142039.671389][T92126]  unmap_single_vma+0x5c/0x100
> [142039.751499][T92126]  ? __this_cpu_preempt_check+0x17/0x20
> [142039.831525][T92126]  unmap_vmas+0x147/0x1e0
> [142039.911548][T92126]  ? unmap_vmas+0x4/0x1e0
> [142039.991579][T92126]  unmap_region+0x10e/0x170
> [142040.071610][T92126]  do_brk_munmap+0x2b8/0x370
> [142040.151641][T92126]  __do_sys_brk+0x2ec/0x3a0
> [142040.231670][T92126]  __x64_sys_brk+0x11/0x20
> [142040.311693][T92126]  do_syscall_64+0x3e/0x90
> [142040.391718][T92126]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [142040.471740][T92126] RIP: 0033:0x7f2b5592450b
> [142040.551764][T92126] Code: ff ff 0f 1f 44 00 00 64 83 3b 0d 75 07 64 c7 03 01 00 00 00 5b b8 ff ff ff ff 5d 41 5c c3
> 90 f3 0f 1e fa b8 0c 00 00 00 0f 05 <48> 8b 15 3e 19 0d 00 48 89 02 48 39 f8 72 06 31 c0 c3 0f 1f 00 48
> [142040.631785][T92126] RSP: 002b:00007ffe9ae558a8 EFLAGS: 00000206 ORIG_RAX: 000000000000000c
> [142040.791817][T92126] RAX: ffffffffffffffda RBX: fffffffffffbb000 RCX: 00007f2b5592450b
> [142040.871837][T92126] RDX: fffffffffffff000 RSI: 00007f2b559f6ce0 RDI: 0000563818dbd000
> [142040.951856][T92126] RBP: 0000563818e02000 R08: 00007f2b559f74a0 R09: 00007f2b559f74a0
> [142041.031876][T92126] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f2b559fe358
> [142041.111895][T92126] R13: 0000000000000000 R14: 0000563818de1f50 R15: 00000000000200b0
> [142041.191922][T92126]  </TASK>
> [142041.271941][T92126] Modules linked in: snd_hrtimer tls bnep ts_bm nft_limit xt_string xt_LOG nf_log_syslog nft_compa
> t nf_tables sunrpc binfmt_misc ath3k btusb btrtl btbcm btintel bluetooth vfat fat ecdh_generic ecc intel_rapl_msr rtsx_p
> ci_sdmmc intel_rapl_common intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp crct10dif_pclmul crc32_pclmul crc32
> c_intel polyval_generic ghash_clmulni_intel uas joydev cryptd ath9k serio_raw ath9k_common ath9k_hw rtsx_pci ath snd_hda
> _codec_realtek snd_hda_codec_hdmi mei_txe toshiba_acpi fan industrialio toshiba_bluetooth rfkill_gpio pwm_lpss_platform
> pwm_lpss bfq fuse
> [142045.672581][T92126] Unloaded tainted modules: polyval_clmulni():1 polyval_clmulni():1 pcc_cpufreq():1 pcc_cpufreq():
> 1 pcc_cpufreq():1 pcc_cpufreq():1
> 
