Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F2550987
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiFSJqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFSJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:46:15 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B1AE68
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:46:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id s189-20020a6b2cc6000000b00669add3c306so4784626ios.21
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9UxLD+XkgKDBM6E3lsWDB/FVg9M9/OGsYFu9ysjqw5w=;
        b=BNbVZIsoAl76I7sUm+xz5WyzLuWAxRxWPsQGaXK7tnJ8iQANVUziTvWrSyU/7EzH2+
         75MQIzbvglFO7vBzmxv1Lf4d/yqPBAcvTGIhcQe3W1NJsNy6aEI0ACxPOxIsjy41rjaD
         FEWGYSswqGcLAAiayhcGFW5J1IdnBxpUfabaWbFPM3Y7LqjH/lDxaNvLygW4eBroPMi5
         UzTn6fjvgA3MA+9hZvnhf98eDJzcjLcA0aUAiBYlMsWh8Md7gZUkTgSynKvAj9m+DqFE
         HWkrWLTKBQ/XfAlbWdr/ClWPEweR3pcc+ZUaHWogZcAQ51k0P9QWq6AY7/1u1EXmH+Vi
         7MnQ==
X-Gm-Message-State: AJIora9cuajGaf0u4NreIl7BWmTr+ZW4L8KCpaNj2GS8Al42zNaZ9Mqr
        phUSSa4zgdnp31hglEG1SLm77DvJvpNQTWxpfD2GkpPMp1Bq
X-Google-Smtp-Source: AGRyM1tWF6Uy6x4vDkUgKmeK9SbJ7SGbnFkLGHmEVo8dYtSKUtJaVbNTDOAC221+aIlY2wxGOu1yGiFU/PL5u22BK7ODp7e1U4Hn
MIME-Version: 1.0
X-Received: by 2002:a02:3b52:0:b0:332:2a7e:2197 with SMTP id
 i18-20020a023b52000000b003322a7e2197mr10139624jaf.111.1655631973838; Sun, 19
 Jun 2022 02:46:13 -0700 (PDT)
Date:   Sun, 19 Jun 2022 02:46:13 -0700
In-Reply-To: <20220619074222.197-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adf67c05e1c9db6d@google.com>
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
From:   syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   10.844767][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   10.847514][    T1] NET: Registered PF_PHONET protocol family
[   10.849852][    T1] 8021q: 802.1Q VLAN Support v1.8
[   10.862031][    T1] DCCP: Activated CCID 2 (TCP-like)
[   10.864153][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   10.868606][    T1] sctp: Hash tables configured (bind 32/56)
[   10.872191][    T1] NET: Registered PF_RDS protocol family
[   10.874827][    T1] Registered RDS/infiniband transport
[   10.877896][    T1] Registered RDS/tcp transport
[   10.878582][    T1] tipc: Activated (version 2.0.0)
[   10.880662][    T1] NET: Registered PF_TIPC protocol family
[   10.883066][    T1] tipc: Started in single node mode
[   10.885611][    T1] NET: Registered PF_SMC protocol family
[   10.887512][    T1] 9pnet: Installing 9P2000 support
[   10.889041][    T1] NET: Registered PF_CAIF protocol family
[   10.896316][    T1] NET: Registered PF_IEEE802154 protocol family
[   10.898744][    T1] Key type dns_resolver registered
[   10.900069][    T1] Key type ceph registered
[   10.902352][    T1] libceph: loaded (mon/osd proto 15/24)
[   10.906546][    T1] batman_adv: B.A.T.M.A.N. advanced 2021.3 (compatibility version 15) loaded
[   10.908905][    T1] openvswitch: Open vSwitch switching datapath
[   10.914955][    T1] NET: Registered PF_VSOCK protocol family
[   10.916734][    T1] mpls_gso: MPLS GSO support
[   10.925815][    T1] IPI shorthand broadcast: enabled
[   10.927901][    T1] AVX2 version of gcm_enc/dec engaged.
[   10.929353][    T1] AES CTR mode by8 optimization enabled
[   10.935460][    T1] sched_clock: Marking stable (10918945287, 16319670)->(10947484662, -12219705)
[   10.939476][    T1] registered taskstats version 1
[   10.949666][    T1] Loading compiled-in X.509 certificates
[   10.954893][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   10.960358][    T1] zswap: loaded using pool lzo/zbud
[   10.964105][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   12.891476][    T1] Key type ._fscrypt registered
[   12.892493][    T1] Key type .fscrypt registered
[   12.893303][    T1] Key type fscrypt-provisioning registered
[   12.900821][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   12.902540][    T1] FS-Cache: Netfs 'afs' registered for caching
[   12.914757][    T1] Btrfs loaded, crc32c=crc32c-intel, assert=on, zoned=yes, fsverity=yes
[   12.924293][    T1] Key type big_key registered
[   12.932517][    T1] Key type encrypted registered
[   12.937808][    T1] ima: No TPM chip found, activating TPM-bypass!
[   12.944279][    T1] Loading compiled-in module X.509 certificates
[   12.951349][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   12.962289][    T1] ima: Allocated hash algorithm: sha256
[   12.969019][    T1] ima: No architecture policies found
[   12.974890][    T1] evm: Initialising EVM extended attributes:
[   12.980993][    T1] evm: security.selinux (disabled)
[   12.986193][    T1] evm: security.SMACK64
[   12.990330][    T1] evm: security.SMACK64EXEC
[   12.994944][    T1] evm: security.SMACK64TRANSMUTE
[   13.000146][    T1] evm: security.SMACK64MMAP
[   13.004847][    T1] evm: security.apparmor (disabled)
[   13.010050][    T1] evm: security.ima
[   13.013907][    T1] evm: security.capability
[   13.018318][    T1] evm: HMAC attrs: 0x1
[   13.107165][    T1] PM:   Magic number: 10:960:626
[   13.112264][    T1] net nr2: hash matches
[   13.119666][    T1] printk: console [netcon0] enabled
[   13.124977][    T1] netconsole: network logging started
[   13.130961][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   13.139959][    T1] rdma_rxe: loaded
[   13.144854][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.156087][    T1] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.165077][  T136] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.175748][  T136] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   13.175818][    T1] ALSA device list:
[   13.188315][    T1]   #0: Dummy 1
[   13.192038][    T1]   #1: Loopback 1
[   13.196005][    T1]   #2: Virtual MIDI Card 1
[   13.203471][    T1] md: Waiting for all devices to be available before autodetect
[   13.211120][    T1] md: If you don't use raid, use raid=noautodetect
[   13.217788][    T1] md: Autodetecting RAID arrays.
[   13.222873][    T1] md: autorun ...
[   13.226613][    T1] md: ... autorun DONE.
[   13.273639][    T1] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[   13.284816][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   13.305610][    T1] devtmpfs: mounted
[   13.366871][    T1] Freeing unused kernel image (initmem) memory: 3820K
[   13.373890][    T1] Write protecting the kernel read-only data: 169984k
[   13.385399][    T1] Freeing unused kernel image (text/rodata gap) memory: 2012K
[   13.395571][    T1] Freeing unused kernel image (rodata/data gap) memory: 1648K
[   13.407818][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   13.417565][    T1] Run /sbin/init as init process
[   13.799387][ T2938] mount (2938) used greatest stack depth: 23616 bytes left
[   13.829633][ T2939] EXT4-fs (sda1): re-mounted. Opts: (null). Quota mode: none.
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or directory
mount: mounting mqueue on /dev/mqueue failed: No such file or di[   13.908724][ T2941] mount (2941) used greatest stack depth: 21664 bytes left
rectory
mount: mounting hugetlbfs on /dev/hugepages failed: No such file or directory
mount: mounting fuse.lxcfs on /var/lib/lxcfs failed: No such file or directory
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: [   14.384860][ T2968] logger (2968) used greatest stack depth: 21264 bytes left
OK
Populating /dev using udev: [   14.629834][ T2970] udevd[2970]: starting version 3.2.10
[   14.766437][ T2971] udevd[2971]: starting eudev-3.2.10
[   14.771664][ T2970] udevd (2970) used greatest stack depth: 20744 bytes left
[   17.677808][ T2975] ================================================================================
[   17.751683][ T2975] UBSAN: null-ptr-deref in ./include/linux/pagemap.h:1088:17
[   17.763463][ T2975] member access within null pointer of type 'struct folio'
[   17.777402][ T2975] CPU: 1 PID: 2975 Comm: udevd Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   17.787589][ T2975] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   17.797942][ T2975] Call Trace:
[   17.801236][ T2975]  <TASK>
[   17.804175][ T2975]  dump_stack_lvl+0x1e3/0x2cb
[   17.808898][ T2975]  ? bfq_pos_tree_add_move+0x451/0x451
[   17.814536][ T2975]  ? panic+0x7e3/0x7e3
[   17.818626][ T2975]  ? mpage_readahead+0x6a0/0x6a0
[   17.823578][ T2975]  ubsan_type_mismatch_common+0x280/0x390
[   17.829899][ T2975]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   17.836081][ T2975]  mpage_readahead+0x588/0x6a0
[   17.840878][ T2975]  ? dio_await_one+0x250/0x250
[   17.845677][ T2975]  ? blkdev_fallocate+0x330/0x330
[   17.850847][ T2975]  ? put_page+0x90/0x90
[   17.855021][ T2975]  ? __alloc_pages+0x2fd/0x5f0
[   17.859813][ T2975]  ? blk_start_plug_nr_ios+0xaa/0x210
[   17.865212][ T2975]  read_pages+0x162/0x520
[   17.869658][ T2975]  ? page_cache_ra_unbounded+0x840/0x840
[   17.875316][ T2975]  ? filemap_add_folio+0x1ab/0x220
[   17.880461][ T2975]  ? add_to_page_cache_locked+0x90/0x90
[   17.886040][ T2975]  ? folio_alloc+0x47/0x50
[   17.890480][ T2975]  ? filemap_alloc_folio+0x1a9/0x1c0
[   17.895793][ T2975]  page_cache_ra_unbounded+0x6c1/0x840
[   17.901294][ T2975]  ? read_cache_pages_invalidate_pages+0xa0/0xa0
[   17.907660][ T2975]  ? do_page_cache_ra+0xde/0x100
[   17.912625][ T2975]  force_page_cache_ra+0x288/0x2e0
[   17.917802][ T2975]  filemap_read+0x809/0x23d0
[   17.922443][ T2975]  ? find_get_pages_range_tag+0x570/0x570
[   17.928182][ T2975]  ? memset+0x1f/0x40
[   17.932287][ T2975]  ? generic_file_read_iter+0x9e/0x4a0
[   17.937847][ T2975]  ? memset+0x1f/0x40
[   17.941845][ T2975]  ? init_sync_kiocb+0x303/0x4b0
[   17.946919][ T2975]  vfs_read+0x5cd/0x760
[   17.951205][ T2975]  ? kernel_read+0x1f0/0x1f0
[   17.955917][ T2975]  ? __fget_light+0xcc/0x170
[   17.963827][ T2975]  ksys_read+0x19f/0x2d0
[   17.968364][ T2975]  ? vfs_write+0x720/0x720
[   17.972798][ T2975]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   17.978800][ T2975]  ? lockdep_hardirqs_on+0x95/0x140
[   17.984015][ T2975]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   17.990020][ T2975]  do_syscall_64+0x44/0xa0
[   17.994540][ T2975]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   18.000620][ T2975] RIP: 0033:0x7f0caea3f8fe
[   18.005044][ T2975] Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[   18.024669][ T2975] RSP: 002b:00007fffae3113b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   18.033187][ T2975] RAX: ffffffffffffffda RBX: 000000007fff0000 RCX: 00007f0caea3f8fe
[   18.041256][ T2975] RDX: 0000000000000040 RSI: 000056006c2e6e18 RDI: 0000000000000009
[   18.049238][ T2975] RBP: 0000000000000040 R08: 000056006c2e6df0 R09: 00007f0caeb0fa60
[   18.057255][ T2975] R10: 0000000000000040 R11: 0000000000000246 R12: 000056006c2e6df0
[   18.065331][ T2975] R13: 000056006c2e6e08 R14: 000056006c2df7f0 R15: 000056006c2df7a0
[   18.073720][ T2975]  </TASK>
[   18.461046][ T2975] ================================================================================
[   18.536749][ T2975] Kernel panic - not syncing: panic_on_warn set ...
[   18.543407][ T2975] CPU: 1 PID: 2975 Comm: udevd Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   18.554051][ T2975] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   18.564115][ T2975] Call Trace:
[   18.567414][ T2975]  <TASK>
[   18.570355][ T2975]  dump_stack_lvl+0x1e3/0x2cb
[   18.575072][ T2975]  ? bfq_pos_tree_add_move+0x451/0x451
[   18.580648][ T2975]  ? panic+0x7e3/0x7e3
[   18.584755][ T2975]  panic+0x2f1/0x7e3
[   18.588776][ T2975]  ? ubsan_type_mismatch_common+0x2a4/0x390
[   18.594909][ T2975]  ? fb_is_primary_device+0xcc/0xcc
[   18.600137][ T2975]  ? panic+0x7e3/0x7e3
[   18.604237][ T2975]  ? mpage_readahead+0x6a0/0x6a0
[   18.609209][ T2975]  ubsan_type_mismatch_common+0x38c/0x390
[   18.615075][ T2975]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   18.621078][ T2975]  mpage_readahead+0x588/0x6a0
[   18.625976][ T2975]  ? dio_await_one+0x250/0x250
[   18.630804][ T2975]  ? blkdev_fallocate+0x330/0x330
[   18.635852][ T2975]  ? put_page+0x90/0x90
[   18.640023][ T2975]  ? __alloc_pages+0x2fd/0x5f0
[   18.645245][ T2975]  ? blk_start_plug_nr_ios+0xaa/0x210
[   18.648343][ T2987] ================================================================================
[   18.650637][ T2975]  read_pages+0x162/0x520
[   18.660328][ T2987] UBSAN: object-size-mismatch in net/unix/af_unix.c:977:14
[   18.664635][ T2975]  ? page_cache_ra_unbounded+0x840/0x840
[   18.664666][ T2975]  ? filemap_add_folio+0x1ab/0x220
[   18.664688][ T2975]  ? add_to_page_cache_locked+0x90/0x90
[   18.664707][ T2975]  ? folio_alloc+0x47/0x50
[   18.672435][ T2987] member access within address ffff88802187eccc with insufficient space
[   18.677546][ T2975]  ? filemap_alloc_folio+0x1a9/0x1c0
[   18.677578][ T2975]  page_cache_ra_unbounded+0x6c1/0x840
[   18.677613][ T2975]  ? read_cache_pages_invalidate_pages+0xa0/0xa0
[   18.682698][ T2987] for an object of type 'struct sockaddr_un'
[   18.688235][ T2975]  ? do_page_cache_ra+0xde/0x100
[   18.688259][ T2975]  force_page_cache_ra+0x288/0x2e0
[   18.688281][ T2975]  filemap_read+0x809/0x23d0
[   18.739227][ T2975]  ? find_get_pages_range_tag+0x570/0x570
[   18.744946][ T2975]  ? memset+0x1f/0x40
[   18.748928][ T2975]  ? generic_file_read_iter+0x9e/0x4a0
[   18.754388][ T2975]  ? memset+0x1f/0x40
[   18.758368][ T2975]  ? init_sync_kiocb+0x303/0x4b0
[   18.763401][ T2975]  vfs_read+0x5cd/0x760
[   18.767635][ T2975]  ? kernel_read+0x1f0/0x1f0
[   18.772314][ T2975]  ? __fget_light+0xcc/0x170
[   18.776898][ T2975]  ksys_read+0x19f/0x2d0
[   18.781138][ T2975]  ? vfs_write+0x720/0x720
[   18.785977][ T2975]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   18.791948][ T2975]  ? lockdep_hardirqs_on+0x95/0x140
[   18.797309][ T2975]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   18.803366][ T2975]  do_syscall_64+0x44/0xa0
[   18.808050][ T2975]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   18.814121][ T2975] RIP: 0033:0x7f0caea3f8fe
[   18.818562][ T2975] Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[   18.838256][ T2975] RSP: 002b:00007fffae3113b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   18.846694][ T2975] RAX: ffffffffffffffda RBX: 000000007fff0000 RCX: 00007f0caea3f8fe
[   18.854746][ T2975] RDX: 0000000000000040 RSI: 000056006c2e6e18 RDI: 0000000000000009
[   18.862707][ T2975] RBP: 0000000000000040 R08: 000056006c2e6df0 R09: 00007f0caeb0fa60
[   18.870866][ T2975] R10: 0000000000000040 R11: 0000000000000246 R12: 000056006c2e6df0
[   18.878953][ T2975] R13: 000056006c2e6e08 R14: 000056006c2df7f0 R15: 000056006c2df7a0
[   18.886929][ T2975]  </TASK>
[   18.890138][ T2987] CPU: 0 PID: 2987 Comm: udevadm Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
[   18.900576][ T2987] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   18.910642][ T2987] Call Trace:
[   18.913918][ T2987]  <TASK>
[   18.917027][ T2987]  dump_stack_lvl+0x1e3/0x2cb
[   18.921732][ T2987]  ? bfq_pos_tree_add_move+0x451/0x451
[   18.927368][ T2987]  ? panic+0x7e3/0x7e3
[   18.931463][ T2987]  ubsan_type_mismatch_common+0x1e6/0x390
[   18.937297][ T2987]  __ubsan_handle_type_mismatch_v1+0x4a/0x60
[   18.943302][ T2987]  unix_autobind+0x129/0x4d0
[   18.947996][ T2987]  ? tomoyo_socket_connect_permission+0x1dc/0x300
[   18.954645][ T2987]  unix_stream_connect+0x896/0x1010
[   18.960057][ T2987]  ? unix_bind+0x9a0/0x9a0
[   18.964571][ T2987]  ? bpf_lsm_socket_connect+0x5/0x10
[   18.970033][ T2987]  ? __sys_connect_file+0xbd/0x170
[   18.975243][ T2987]  ? __x64_sys_connect+0x148/0x1e0
[   18.980464][ T2987]  __x64_sys_connect+0x15b/0x1e0
[   18.985402][ T2987]  ? __sys_connect+0x170/0x170
[   18.990272][ T2987]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   18.996341][ T2987]  ? lockdep_hardirqs_on+0x95/0x140
[   19.001536][ T2987]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[   19.007520][ T2987]  do_syscall_64+0x44/0xa0
[   19.011934][ T2987]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   19.017822][ T2987] RIP: 0033:0x7f536a0dcd23
[   19.022232][ T2987] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 18 89 54 24 0c 48
[   19.042137][ T2987] RSP: 002b:00007ffeaf475368 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
[   19.050735][ T2987] RAX: ffffffffffffffda RBX: 0000560b72990930 RCX: 00007f536a0dcd23
[   19.058955][ T2987] RDX: 0000000000000013 RSI: 0000560b72990948 RDI: 0000000000000003
[   19.066935][ T2987] RBP: 000000000000001e R08: 000000000000001e R09: 0030312e322e332d
[   19.074919][ T2987] R10: 00007ffeaf4754b4 R11: 0000000000000246 R12: 00007ffeaf475380
[   19.083318][ T2987] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
[   19.091592][ T2987]  </TASK>
[   19.094678][ T2975] Kernel Offset: disabled
[   19.099196][ T2975] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=11480d28080000


Tested on:

commit:         c741e491 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=308b87e56290f642
dashboard link: https://syzkaller.appspot.com/bug?extid=3cc1054e15babd5f4cd2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1630cfe8080000

