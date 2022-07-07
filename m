Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56756AE00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiGGVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGGVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:55:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76277237C8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:55:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BB05220A2;
        Thu,  7 Jul 2022 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657230936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MThMNZncGPBuW1szQObbzqTQ4yKEJ0cAqvi3hxv2R4=;
        b=lzS8QzqcZThsma8f1kM5UJLURJH8srjKMY9LmLmkNhn6rFjYmwMwXzevuOqTRBw1oD8AId
        T7LhZspeT+EOEoS2Ais+82aLhbjtX5vD7sm1OzGw+1pUP4cfEFs6T5zpHhyP7RZyfZyRJD
        V3hpREXmc9KlDboFvZYh4jnYjDk9Y4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657230936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MThMNZncGPBuW1szQObbzqTQ4yKEJ0cAqvi3hxv2R4=;
        b=kThp6YxdFd+JxohQg+0M1mvtrlJ2akoAHme/zl7ZJ7tYGkpwL1vCNvQ2IF1u+E7ryhOcjm
        /Ai40mr+Mc/nDKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05B7413461;
        Thu,  7 Jul 2022 21:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GRfHAFhWx2IaWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Jul 2022 21:55:36 +0000
Message-ID: <1d3a26ac-89b3-0211-f8f2-5165ffa732fd@suse.cz>
Date:   Thu, 7 Jul 2022 23:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [mm/page_alloc] 2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 15:51, Oliver Sang wrote:
> Hi Andrew Morton,
> 
> On Sun, Jul 03, 2022 at 01:22:09PM -0700, Andrew Morton wrote:
>> On Sun, 3 Jul 2022 17:44:30 +0800 kernel test robot <oliver.sang@intel.com> wrote:
>> 
>> > FYI, we noticed the following commit (built with gcc-11):
>> > 
>> > commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
>> > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
>> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
>> > patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net
>> > 
>> 
>> Did this test include the followup patch
>> mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch?
> 
> no, we just fetched original patch set and test upon it.

It appears you fetched v4, not v5. I noticed it from the threading of your
report that was threaded in the v4 thread, and also the github url: above.
In v4, pcpu_spin_trylock_irqsave() was missing an unpin, and indeed it's
missing in the github branch you were testing:

https://github.com/intel-lab-lkp/linux/commit/2bd8eec68f740608db5ea58ecff06965228764cb#diff-cef95765dfd76e5f9c9f0faebfa683edf904d0c3de71547ae8c3ea14418c1e38R187

v5 should be fine:

https://lore.kernel.org/lkml/20220624125423.6126-1-mgorman@techsingularity.net/

> now we applied the patch you pointed to us upon 2bd8eec68f and found the issue
> still exist.
> (attached dmesg FYI)
> 
> [  204.416449][T27283] BUG: sleeping function called from invalid context at mm/gup.c:1170
> [  204.416455][T27283] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 27283, name: compaction_test
> [  204.416457][T27283] preempt_count: 1, expected: 0
> [  204.416460][T27283] 1 lock held by compaction_test/27283:
> [  204.416462][T27283]  #0: ffff88918df83928 (&mm->mmap_lock#2){++++}-{3:3}, at: __mm_populate+0x1d0/0x300
> [  204.416477][T27283] CPU: 76 PID: 27283 Comm: compaction_test Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  204.416481][T27283] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  204.416483][T27283] Call Trace:
> [  204.416485][T27283]  <TASK>
> [  204.416489][T27283]  dump_stack_lvl+0x45/0x59
> [  204.416497][T27283]  __might_resched.cold+0x15e/0x190
> [  204.416508][T27283]  __get_user_pages+0x274/0x6c0
> [  204.416522][T27283]  ? get_gate_page+0x640/0x640
> [  204.416538][T27283]  ? rwsem_down_read_slowpath+0xb80/0xb80
> [  204.416548][T27283]  populate_vma_page_range+0xd7/0x140
> [  204.416554][T27283]  __mm_populate+0x178/0x300
> [  204.416560][T27283]  ? faultin_vma_page_range+0x100/0x100
> [  204.416566][T27283]  ? __up_write+0x13a/0x480
> [  204.416575][T27283]  vm_mmap_pgoff+0x1a7/0x240
> [  204.416584][T27283]  ? randomize_page+0x80/0x80
> [  204.416586][T27283]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  204.416595][T27283]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  204.416600][T27283]  ? syscall_enter_from_user_mode+0x21/0x80
> [  204.416609][T27283]  do_syscall_64+0x59/0x80
> [  204.416617][T27283]  ? irqentry_exit_to_user_mode+0xa/0x40
> [  204.416624][T27283]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  204.416629][T27283]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  204.416633][T27283] RIP: 0033:0x7f10e01e2b62
> [  204.416637][T27283] Code: e4 e8 b2 4b 01 00 66 90 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 8b 05 f9 52 0c 00 64
> [  204.416639][T27283] RSP: 002b:00007ffd771efe48 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> [  204.416642][T27283] RAX: ffffffffffffffda RBX: 0000000000002022 RCX: 00007f10e01e2b62
> [  204.416645][T27283] RDX: 0000000000000003 RSI: 0000000006400000 RDI: 0000000000000000
> [  204.416646][T27283] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> [  204.416648][T27283] R10: 0000000000002022 R11: 0000000000000246 R12: 0000000000401170
> [  204.416649][T27283] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  204.416666][T27283]  </TASK>
> [  204.690617][T27283] BUG: scheduling while atomic: compaction_test/27283/0x00000004
> [  204.690624][T27283] no locks held by compaction_test/27283.
> [  204.690625][T27283] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  204.690688][T27283] CPU: 76 PID: 27283 Comm: compaction_test Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  204.690691][T27283] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  204.690694][T27283] Call Trace:
> [  204.690695][T27283]  <TASK>
> [  204.690700][T27283]  dump_stack_lvl+0x45/0x59
> [  204.690707][T27283]  __schedule_bug.cold+0xcf/0xe0
> [  204.690714][T27283]  schedule_debug+0x274/0x300
> [  204.690724][T27283]  __schedule+0xf5/0x1740
> [  204.690733][T27283]  ? io_schedule_timeout+0x180/0x180
> [  204.690737][T27283]  ? vm_mmap_pgoff+0x1a7/0x240
> [  204.690748][T27283]  schedule+0xea/0x240
> [  204.690753][T27283]  exit_to_user_mode_loop+0x79/0x140
> [  204.690759][T27283]  exit_to_user_mode_prepare+0xfc/0x180
> [  204.690762][T27283]  syscall_exit_to_user_mode+0x19/0x80
> [  204.690768][T27283]  do_syscall_64+0x69/0x80
> [  204.690773][T27283]  ? __local_bh_enable+0x7a/0xc0
> [  204.690777][T27283]  ? __do_softirq+0x52c/0x865
> [  204.690786][T27283]  ? irqentry_exit_to_user_mode+0xa/0x40
> [  204.690792][T27283]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  204.690798][T27283]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  204.690802][T27283] RIP: 0033:0x7f10e01e2b62
> [  204.690806][T27283] Code: e4 e8 b2 4b 01 00 66 90 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 8b 05 f9 52 0c 00 64
> [  204.690808][T27283] RSP: 002b:00007ffd771efe48 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> [  204.690811][T27283] RAX: 00007f022d8e7000 RBX: 0000000000002022 RCX: 00007f10e01e2b62
> [  204.690813][T27283] RDX: 0000000000000003 RSI: 0000000006400000 RDI: 0000000000000000
> [  204.690814][T27283] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> [  204.690815][T27283] R10: 0000000000002022 R11: 0000000000000246 R12: 0000000000401170
> [  204.690817][T27283] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  204.690830][T27283]  </TASK>
> [  216.734914][ T1147]
> [  230.207563][ T1147]
> [  244.124530][ T1147]
> [  257.808775][ T1147]
> [  271.803313][ T1147]
> [  272.181098][  T563] BUG: sleeping function called from invalid context at mm/migrate.c:1380
> [  272.181104][  T563] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 563, name: kcompactd0
> [  272.181107][  T563] preempt_count: 1, expected: 0
> [  272.181109][  T563] no locks held by kcompactd0/563.
> [  272.181112][  T563] CPU: 63 PID: 563 Comm: kcompactd0 Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  272.181115][  T563] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  272.181117][  T563] Call Trace:
> [  272.181119][  T563]  <TASK>
> [  272.181124][  T563]  dump_stack_lvl+0x45/0x59
> [  272.181133][  T563]  __might_resched.cold+0x15e/0x190
> [  272.181143][  T563]  migrate_pages+0x2b1/0x1200
> [  272.181152][  T563]  ? isolate_freepages+0x880/0x880
> [  272.181158][  T563]  ? split_map_pages+0x4c0/0x4c0
> [  272.181167][  T563]  ? buffer_migrate_page_norefs+0x40/0x40
> [  272.181172][  T563]  ? isolate_migratepages+0x300/0x6c0
> [  272.181183][  T563]  compact_zone+0xa3f/0x1640
> [  272.181200][  T563]  ? compaction_suitable+0x200/0x200
> [  272.181205][  T563]  ? lock_acquire+0x194/0x500
> [  272.181211][  T563]  ? finish_wait+0xc5/0x280
> [  272.181220][  T563]  proactive_compact_node+0xeb/0x180
> [  272.181224][  T563]  ? compact_store+0xc0/0xc0
> [  272.181239][  T563]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  272.181242][  T563]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.181252][  T563]  kcompactd+0x500/0xc80
> [  272.181262][  T563]  ? kcompactd_do_work+0x540/0x540
> [  272.181268][  T563]  ? prepare_to_swait_exclusive+0x240/0x240
> [  272.181275][  T563]  ? __kthread_parkme+0xd9/0x200
> [  272.181278][  T563]  ? schedule+0xfe/0x240
> [  272.181282][  T563]  ? kcompactd_do_work+0x540/0x540
> [  272.181288][  T563]  kthread+0x28f/0x340
> [  272.181290][  T563]  ? kthread_complete_and_exit+0x40/0x40
> [  272.181295][  T563]  ret_from_fork+0x1f/0x30
> [  272.181313][  T563]  </TASK>
> [  272.295259][ T2111] meminfo[2111]: segfault at 7ffc6e0e55e8 ip 00007fbdf6db8580 sp 00007ffc6e0e55f0 error 7 in libc-2.31.so[7fbdf6d12000+14b000]
> [  272.295314][ T2111] Code: 00 00 48 8b 15 11 29 0f 00 f7 d8 41 bd ff ff ff ff 64 89 02 66 0f 1f 44 00 00 85 ed 0f 85 80 00 00 00 44 89 e6 bf 02 00 00
> 00 <e8> 3b 9c fb ff 44 89 e8 5d 41 5c 41 5d c3 66 90 e8 eb 8a fb ff e8
> [  272.296053][ T2111] BUG: scheduling while atomic: meminfo/2111/0x00000002
> [  272.296056][ T2111] no locks held by meminfo/2111.
> [  272.296058][ T2111] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  272.296121][ T2111] CPU: 20 PID: 2111 Comm: meminfo Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  272.296125][ T2111] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  272.296127][ T2111] Call Trace:
> [  272.296128][ T2111]  <TASK>
> [  272.296132][ T2111]  dump_stack_lvl+0x45/0x59
> [  272.296141][ T2111]  __schedule_bug.cold+0xcf/0xe0
> [  272.296150][ T2111]  schedule_debug+0x274/0x300
> [  272.296160][ T2111]  __schedule+0xf5/0x1740
> [  272.296169][ T2111]  ? rwlock_bug+0xc0/0xc0
> [  272.296176][ T2111]  ? io_schedule_timeout+0x180/0x180
> [  272.296181][ T2111]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  272.296185][ T2111]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.296194][ T2111]  do_task_dead+0xda/0x140
> [  272.296200][ T2111]  do_exit+0x6a7/0xac0
> [  272.296210][ T2111]  do_group_exit+0xb7/0x2c0
> [  272.296216][ T2111]  get_signal+0x1b13/0x1cc0
> [  272.296226][ T2111]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.296230][ T2111]  ? force_sig_info_to_task+0x30d/0x500
> [  272.296234][ T2111]  ? ptrace_signal+0x700/0x700
> [  272.296245][ T2111]  arch_do_signal_or_restart+0x77/0x300
> [  272.296252][ T2111]  ? get_sigframe_size+0x40/0x40
> [  272.296257][ T2111]  ? show_opcodes.cold+0x1c/0x21
> [  272.296270][ T2111]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  272.296277][ T2111]  exit_to_user_mode_loop+0xac/0x140
> [  272.296282][ T2111]  exit_to_user_mode_prepare+0xfc/0x180
> [  272.296286][ T2111]  irqentry_exit_to_user_mode+0x5/0x40
> [  272.296291][ T2111]  asm_exc_page_fault+0x27/0x30
> [  272.296293][ T2111] RIP: 0033:0x7fbdf6db8580
> [  272.296297][ T2111] Code: Unable to access opcode bytes at RIP 0x7fbdf6db8556.
> [  272.296299][ T2111] RSP: 002b:00007ffc6e0e55f0 EFLAGS: 00010246
> [  272.296301][ T2111] RAX: 0000000000006bb3 RBX: 00007ffc6e0e56d0 RCX: 00007fbdf6db84bb
> [  272.296303][ T2111] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
> [  272.296305][ T2111] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fbdf6cea740
> [  272.296306][ T2111] R10: 00007fbdf6ceaa10 R11: 0000000000000246 R12: 0000000000000000
> [  272.296308][ T2111] R13: 0000000000006bb3 R14: 00005563332b3908 R15: 00007ffc6e0e56b0
> [  272.296323][ T2111]  </TASK>
> [  272.296514][ T2150] gzip-meminfo[2150]: segfault at 7fd637199670 ip 00007fd637199670 sp 00007fffd9088698 error 14 in libc-2.31.so[7fd6370f3000+14b000
> ]
> [  272.296560][ T2150] Code: Unable to access opcode bytes at RIP 0x7fd637199646.
> [  272.297682][ T2150] BUG: scheduling while atomic: gzip-meminfo/2150/0x00000002
> [  272.297686][ T2150] no locks held by gzip-meminfo/2150.
> [  272.297687][ T2150] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  272.297746][ T2150] CPU: 45 PID: 2150 Comm: gzip-meminfo Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  272.297749][ T2150] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  272.297751][ T2150] Call Trace:
> [  272.297752][ T2150]  <TASK>
> [  272.297756][ T2150]  dump_stack_lvl+0x45/0x59
> [  272.297762][ T2150]  __schedule_bug.cold+0xcf/0xe0
> [  272.297768][ T2150]  schedule_debug+0x274/0x300
> [  272.297775][ T2150]  __schedule+0xf5/0x1740
> [  272.297783][ T2150]  ? rwlock_bug+0xc0/0xc0
> [  272.297788][ T2150]  ? io_schedule_timeout+0x180/0x180
> [  272.297794][ T2150]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  272.297797][ T2150]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.297806][ T2150]  do_task_dead+0xda/0x140
> [  272.297811][ T2150]  do_exit+0x6a7/0xac0
> [  272.297819][ T2150]  do_group_exit+0xb7/0x2c0
> [  272.297825][ T2150]  get_signal+0x1b13/0x1cc0
> [  272.297833][ T2150]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.297838][ T2150]  ? force_sig_info_to_task+0x30d/0x500
> [  272.297842][ T2150]  ? ptrace_signal+0x700/0x700
> [  272.297854][ T2150]  arch_do_signal_or_restart+0x77/0x300
> [  272.297859][ T2150]  ? get_sigframe_size+0x40/0x40
> [  272.297864][ T2150]  ? show_opcodes+0x97/0xc0
> [  272.297876][ T2150]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  272.297883][ T2150]  exit_to_user_mode_loop+0xac/0x140
> [  272.297887][ T2150]  exit_to_user_mode_prepare+0xfc/0x180
> [  272.297890][ T2150]  irqentry_exit_to_user_mode+0x5/0x40
> [  272.297894][ T2150]  asm_exc_page_fault+0x27/0x30
> [  272.297897][ T2150] RIP: 0033:0x7fd637199670
> [  272.297900][ T2150] Code: Unable to access opcode bytes at RIP 0x7fd637199646.
> [  272.297901][ T2150] RSP: 002b:00007fffd9088698 EFLAGS: 00010246
> [  272.297904][ T2150] RAX: 0000000000000000 RBX: 00007fd63728e610 RCX: 0000000000000000
> [  272.297905][ T2150] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  272.297906][ T2150] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000001
> [  272.297908][ T2150] R10: fffffffffffff287 R11: 00007fd63710c660 R12: 00007fd63728e610
> [  272.297909][ T2150] R13: 0000000000000001 R14: 00007fd63728eae8 R15: 0000000000000000
> [  272.297923][ T2150]  </TASK>
> [  272.340352][  T563] BUG: scheduling while atomic: kcompactd0/563/0x0000004d
> [  272.340356][  T563] no locks held by kcompactd0/563.
> [  272.340357][  T563] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  272.340433][  T563] CPU: 63 PID: 563 Comm: kcompactd0 Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  272.340437][  T563] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  272.340438][  T563] Call Trace:
> [  272.340440][  T563]  <TASK>
> [  272.340444][  T563]  dump_stack_lvl+0x45/0x59
> [  272.340451][  T563]  __schedule_bug.cold+0xcf/0xe0
> [  272.340459][  T563]  schedule_debug+0x274/0x300
> [  272.340467][  T563]  __schedule+0xf5/0x1740
> [  272.340477][  T563]  ? io_schedule_timeout+0x180/0x180
> [  272.340481][  T563]  ? find_held_lock+0x2c/0x140
> [  272.340486][  T563]  ? prepare_to_wait_event+0xcd/0x6c0
> [  272.340496][  T563]  schedule+0xea/0x240
> [  272.340501][  T563]  schedule_timeout+0x11b/0x240
> [  272.340507][  T563]  ? usleep_range_state+0x180/0x180
> [  272.340512][  T563]  ? timer_migration_handler+0xc0/0xc0
> [  272.340520][  T563]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.340525][  T563]  ? prepare_to_wait_event+0xcd/0x6c0
> [  272.340540][  T563]  kcompactd+0x870/0xc80
> [  272.340554][  T563]  ? kcompactd_do_work+0x540/0x540
> [  272.340560][  T563]  ? prepare_to_swait_exclusive+0x240/0x240
> [  272.340567][  T563]  ? __kthread_parkme+0xd9/0x200
> [  272.340571][  T563]  ? schedule+0xfe/0x240
> [  272.340574][  T563]  ? kcompactd_do_work+0x540/0x540
> [  272.340579][  T563]  kthread+0x28f/0x340
> [  272.340582][  T563]  ? kthread_complete_and_exit+0x40/0x40
> [  272.340588][  T563]  ret_from_fork+0x1f/0x30
> [  272.340605][  T563]  </TASK>
> [  272.799216][  T564] BUG: scheduling while atomic: kcompactd1/564/0x00000027
> [  272.799222][  T564] no locks held by kcompactd1/564.
> [  272.799224][  T564] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  272.799283][  T564] CPU: 80 PID: 564 Comm: kcompactd1 Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  272.799287][  T564] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  272.799289][  T564] Call Trace:
> [  272.799292][  T564]  <TASK>
> [  272.799299][  T564]  dump_stack_lvl+0x45/0x59
> [  272.799309][  T564]  __schedule_bug.cold+0xcf/0xe0
> [  272.799318][  T564]  schedule_debug+0x274/0x300
> [  272.799329][  T564]  __schedule+0xf5/0x1740
> [  272.799341][  T564]  ? io_schedule_timeout+0x180/0x180
> [  272.799345][  T564]  ? find_held_lock+0x2c/0x140
> [  272.799352][  T564]  ? prepare_to_wait_event+0xcd/0x6c0
> [  272.799362][  T564]  schedule+0xea/0x240
> [  272.799368][  T564]  schedule_timeout+0x11b/0x240
> [  272.799374][  T564]  ? usleep_range_state+0x180/0x180
> [  272.799379][  T564]  ? timer_migration_handler+0xc0/0xc0
> [  272.799389][  T564]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  272.799394][  T564]  ? prepare_to_wait_event+0xcd/0x6c0
> [  272.799402][  T564]  kcompactd+0x870/0xc80
> [  272.799416][  T564]  ? kcompactd_do_work+0x540/0x540
> [  272.799422][  T564]  ? prepare_to_swait_exclusive+0x240/0x240
> [  272.799429][  T564]  ? __kthread_parkme+0xd9/0x200
> [  272.799433][  T564]  ? schedule+0xfe/0x240
> [  272.799436][  T564]  ? kcompactd_do_work+0x540/0x540
> [  272.799442][  T564]  kthread+0x28f/0x340
> [  272.799445][  T564]  ? kthread_complete_and_exit+0x40/0x40
> [  272.799451][  T564]  ret_from_fork+0x1f/0x30
> [  272.799469][  T564]  </TASK>
> [  273.033327][  T563] BUG: scheduling while atomic: kcompactd0/563/0x00000003
> [  273.033331][  T563] no locks held by kcompactd0/563.
> [  273.033333][  T563] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  273.033428][  T563] CPU: 63 PID: 563 Comm: kcompactd0 Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  273.033432][  T563] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  273.033434][  T563] Call Trace:
> [  273.033436][  T563]  <TASK>
> [  273.033440][  T563]  dump_stack_lvl+0x45/0x59
> [  273.033449][  T563]  __schedule_bug.cold+0xcf/0xe0
> [  273.033457][  T563]  schedule_debug+0x274/0x300
> [  273.033467][  T563]  __schedule+0xf5/0x1740
> [  273.033477][  T563]  ? io_schedule_timeout+0x180/0x180
> [  273.033481][  T563]  ? find_held_lock+0x2c/0x140
> [  273.033487][  T563]  ? prepare_to_wait_event+0xcd/0x6c0
> [  273.033498][  T563]  schedule+0xea/0x240
> [  273.033503][  T563]  schedule_timeout+0x11b/0x240
> [  273.033509][  T563]  ? usleep_range_state+0x180/0x180
> [  273.033521][  T563]  ? timer_migration_handler+0xc0/0xc0
> [  273.033530][  T563]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  273.033535][  T563]  ? prepare_to_wait_event+0xcd/0x6c0
> [  273.033543][  T563]  kcompactd+0x870/0xc80
> [  273.033557][  T563]  ? kcompactd_do_work+0x540/0x540
> [  273.033563][  T563]  ? prepare_to_swait_exclusive+0x240/0x240
> [  273.033570][  T563]  ? __kthread_parkme+0xd9/0x200
> [  273.033574][  T563]  ? schedule+0xfe/0x240
> [  273.033577][  T563]  ? kcompactd_do_work+0x540/0x540
> [  273.033582][  T563]  kthread+0x28f/0x340
> [  273.033585][  T563]  ? kthread_complete_and_exit+0x40/0x40
> [  273.033590][  T563]  ret_from_fork+0x1f/0x30
> [  273.033608][  T563]  </TASK>
> [  273.319687][  T564] BUG: sleeping function called from invalid context at mm/migrate.c:1380
> [  273.319692][  T564] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 564, name: kcompactd1
> [  273.319694][  T564] preempt_count: 1, expected: 0
> [  273.319696][  T564] no locks held by kcompactd1/564.
> [  273.319699][  T564] CPU: 80 PID: 564 Comm: kcompactd1 Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  273.319702][  T564] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  273.319704][  T564] Call Trace:
> [  273.319707][  T564]  <TASK>
> [  273.319713][  T564]  dump_stack_lvl+0x45/0x59
> [  273.319723][  T564]  __might_resched.cold+0x15e/0x190
> [  273.319734][  T564]  migrate_pages+0x2b1/0x1200
> [  273.319744][  T564]  ? isolate_freepages+0x880/0x880
> [  273.319752][  T564]  ? split_map_pages+0x4c0/0x4c0
> [  273.319762][  T564]  ? buffer_migrate_page_norefs+0x40/0x40
> [  273.319767][  T564]  ? isolate_migratepages+0x300/0x6c0
> [  273.319778][  T564]  compact_zone+0xa3f/0x1640
> [  273.319795][  T564]  ? compaction_suitable+0x200/0x200
> [  273.319800][  T564]  ? lock_acquire+0x194/0x500
> [  273.319807][  T564]  ? finish_wait+0xc5/0x280
> [  273.319816][  T564]  proactive_compact_node+0xeb/0x180
> [  273.319820][  T564]  ? compact_store+0xc0/0xc0
> [  273.319835][  T564]  ? lockdep_hardirqs_on_prepare+0x19a/0x380
> [  273.319839][  T564]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  273.319850][  T564]  kcompactd+0x500/0xc80
> [  273.319860][  T564]  ? kcompactd_do_work+0x540/0x540
> [  273.319866][  T564]  ? prepare_to_swait_exclusive+0x240/0x240
> [  273.319873][  T564]  ? __kthread_parkme+0xd9/0x200
> [  273.319877][  T564]  ? schedule+0xfe/0x240
> [  273.319882][  T564]  ? kcompactd_do_work+0x540/0x540
> [  273.319888][  T564]  kthread+0x28f/0x340
> [  273.319891][  T564]  ? kthread_complete_and_exit+0x40/0x40
> [  273.319896][  T564]  ret_from_fork+0x1f/0x30
> [  273.319914][  T564]  </TASK>
> [  273.637490][  T564] BUG: scheduling while atomic: kcompactd1/564/0x00000041
> [  273.637496][  T564] no locks held by kcompactd1/564.
> [  273.637498][  T564] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common sk
> x_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate btrfs blake2b_g
> eneric xor raid6_pq zstd_compress libcrc32c crc32c_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg ast drm_vram_helper drm_ttm_helper
>  ipmi_ssif ttm drm_kms_helper ahci syscopyarea libahci sysfillrect mei_me intel_uncore acpi_ipmi i2c_i801 sysimgblt ioatdma ipmi_si mei libata joydev fb
> _sys_fops i2c_smbus lpc_ich intel_pch_thermal dca wmi ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse ip_tables
> [  273.637556][  T564] CPU: 80 PID: 564 Comm: kcompactd1 Tainted: G S      W         5.19.0-rc2-00008-g292baeb4c714 #1
> [  273.637560][  T564] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
> [  273.637562][  T564] Call Trace:
> [  273.637565][  T564]  <TASK>
> [  273.637571][  T564]  dump_stack_lvl+0x45/0x59
> [  273.637580][  T564]  __schedule_bug.cold+0xcf/0xe0
> [  273.637589][  T564]  schedule_debug+0x274/0x300
> [  273.637600][  T564]  __schedule+0xf5/0x1740
> [  273.637612][  T564]  ? io_schedule_timeout+0x180/0x180
> [  273.637616][  T564]  ? find_held_lock+0x2c/0x140
> [  273.637622][  T564]  ? prepare_to_wait_event+0xcd/0x6c0
> [  273.637633][  T564]  schedule+0xea/0x240
> [  273.637638][  T564]  schedule_timeout+0x11b/0x240
> [  273.637645][  T564]  ? usleep_range_state+0x180/0x180
> [  273.637650][  T564]  ? timer_migration_handler+0xc0/0xc0
> [  273.637659][  T564]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  273.637664][  T564]  ? prepare_to_wait_event+0xcd/0x6c0
> [  273.637671][  T564]  kcompactd+0x870/0xc80
> [  273.637687][  T564]  ? kcompactd_do_work+0x540/0x540
> [  273.637692][  T564]  ? prepare_to_swait_exclusive+0x240/0x240
> [  273.637700][  T564]  ? __kthread_parkme+0xd9/0x200
> [  273.637704][  T564]  ? schedule+0xfe/0x240
> [  273.637707][  T564]  ? kcompactd_do_work+0x540/0x540
> [  273.637713][  T564]  kthread+0x28f/0x340
> [  273.637716][  T564]  ? kthread_complete_and_exit+0x40/0x40
> [  273.637722][  T564]  ret_from_fork+0x1f/0x30
> [  273.637740][  T564]  </TASK>
> [  285.377624][ T1147]
> 
> 
> 
>> 
>> 
>> From: Mel Gorman <mgorman@techsingularity.net>
>> Subject: mm/page_alloc: replace local_lock with normal spinlock -fix
>> Date: Mon, 27 Jun 2022 09:46:45 +0100
>> 
>> As noted by Yu Zhao, use pcp_spin_trylock_irqsave instead of
>> pcpu_spin_trylock_irqsave.  This is a fix to the mm-unstable patch
>> mm-page_alloc-replace-local_lock-with-normal-spinlock.patch
>> 
>> Link: https://lkml.kernel.org/r/20220627084645.GA27531@techsingularity.net
>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> Reported-by: Yu Zhao <yuzhao@google.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> 
>>  mm/page_alloc.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> --- a/mm/page_alloc.c~mm-page_alloc-replace-local_lock-with-normal-spinlock-fix
>> +++ a/mm/page_alloc.c
>> @@ -3497,7 +3497,7 @@ void free_unref_page(struct page *page,
>>  
>>  	zone = page_zone(page);
>>  	pcp_trylock_prepare(UP_flags);
>> -	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
>> +	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
>>  	if (pcp) {
>>  		free_unref_page_commit(zone, pcp, page, migratetype, order);
>>  		pcp_spin_unlock_irqrestore(pcp, flags);
>> _
>> 

