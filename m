Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287AE554959
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357708AbiFVLUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357484AbiFVLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D53FD3DA77
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655896727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0sIsnfMpe4FJBTS0h3l7SV9v1TTfsWpjwvuPTBuEppw=;
        b=KJUcuMCVKLPqzSs6nmHEGpLlHe6cYItDNUMLpEFho3YUxl1tlSO2TKKvQPlWDa6bKp06IU
        nL5YncfTNB+kqNO4XqA0+qqXg2Jt27T8slikWPfN+2P2KGFHLlNu8YEAaLM4unqlo48cAm
        r1M90xec0CrKrJYMO3BS/OV8xQCH0s8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-MFN3ONSFMUuoINxGAeGjBw-1; Wed, 22 Jun 2022 07:18:44 -0400
X-MC-Unique: MFN3ONSFMUuoINxGAeGjBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D44383395C;
        Wed, 22 Jun 2022 11:18:44 +0000 (UTC)
Received: from [10.43.17.54] (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E91840334F;
        Wed, 22 Jun 2022 11:18:43 +0000 (UTC)
Message-ID: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
Date:   Wed, 22 Jun 2022 13:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk
From:   Zdenek Kabelac <zkabelac@redhat.com>
Subject: i915: crash with 5.19-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

While somewhat oldish hw (T61, 4G, C2D) - I've now witnessed new crash with Xorg:

(happened while reopening iconified Firefox window  - running 'standard' 
rawhide -nodebug kernel 5.19.0-0.rc2.21.fc37.x86_64)

  page:00000000577758b3 refcount:0 mapcount:0 mapping:0000000000000000 
index:0x1 pfn:0x1192cc
  flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
  raw: 0017ffffc0000000 ffffe683c47171c8 ffff8fa3f79377a8 0000000000000000
  raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
  ------------[ cut here ]------------
  kernel BUG at mm/shmem.c:708!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 42896 Comm: Xorg Not tainted 5.19.0-0.rc2.21.fc37.x86_64 #1
  Hardware name: LENOVO 6464CTO/6464CTO, BIOS 7LETC9WW (2.29 ) 03/18/2011
  RIP: 0010:shmem_add_to_page_cache+0x48e/0x500
  Code: 01 0f 84 0a fc ff ff 48 8d 4a ff 31 d2 48 39 cb 0f 85 ff fb ff ff e9 
f6 fb ff ff 48 c7 c6 70 01 64 bb 48 89 df e8 f2 99 01 00 <0f> 0b 48 c7 c6 a0 
1b 64 bb 48 89 df e8 e1 99 01 00 0f 0b 48 8b 13
  RSP: 0018:ffff9ce7c047f6b0 EFLAGS: 00010286
  RAX: 000000000000003f RBX: ffffe683c464b300 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: ffffffffbb67b8e8 RDI: 00000000ffffffff
  RBP: 0000000000023f97 R08: ffffffffbca122a0 R09: 64656b636f6c5f74
  R10: 747365745f6f696c R11: 6f6621284f494c4f R12: 00000000001120d4
  R13: ffff8fa2c6ae7890 R14: ffffe683c464b300 R15: 0000000000000001
  FS:  00007fc1cea31380(0000) GS:ffff8fa3f7900000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f6972e228c8 CR3: 0000000104ba8000 CR4: 00000000000006e0
  Call Trace:
  <TASK>
  shmem_swapin_folio+0x274/0x980
  shmem_getpage_gfp+0x234/0x990
  shmem_read_mapping_page_gfp+0x36/0xf0
  shmem_sg_alloc_table+0x11b/0x250 [i915]
  shmem_get_pages+0xaa/0x310 [i915]
  __i915_gem_object_get_pages+0x31/0x40 [i915]
  i915_vma_pin_ww+0x69d/0x920 [i915]
  eb_validate_vmas+0x17d/0x7a0 [i915]
  ? eb_pin_engine+0x262/0x2d0 [i915]
  i915_gem_do_execbuffer+0xd43/0x2c00 [i915]
  ? refill_obj_stock+0x102/0x1a0
  ? unix_stream_read_generic+0x1ea/0xa60
  ? unix_stream_read_generic+0x1ea/0xa60
  ? _raw_spin_lock_irqsave+0x23/0x50
  ? _atomic_dec_and_lock_irqsave+0x38/0x60
  ? __active_retire+0xb7/0x100 [i915]
  ? _raw_spin_unlock_irqrestore+0x23/0x40
  ? dma_fence_signal+0x39/0x50
  ? dma_resv_iter_walk_unlocked.part.0+0x164/0x170
  i915_gem_execbuffer2_ioctl+0x115/0x270 [i915]
  ? i915_gem_do_execbuffer+0x2c00/0x2c00 [i915]
  drm_ioctl_kernel+0x9b/0x140
  ? __check_object_size+0x47/0x260
  drm_ioctl+0x21c/0x410
  ? i915_gem_do_execbuffer+0x2c00/0x2c00 [i915]
  ? exit_to_user_mode_prepare+0x17d/0x1f0
  __x64_sys_ioctl+0x8a/0xc0
  do_syscall_64+0x58/0x80
  ? syscall_exit_to_user_mode+0x17/0x40
  ? do_syscall_64+0x67/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
  RIP: 0033:0x7fc1cf28da9f
  Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 
24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff 
ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
  RSP: 002b:00007ffe5f52e1c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007ffe5f52e250 RCX: 00007fc1cf28da9f
  RDX: 00007ffe5f52e250 RSI: 0000000040406469 RDI: 000000000000000d
  RBP: 000000000000000d R08: 00007fc1ce938410 R09: 00007fc1cf2fa4c0
  R10: 0000000000000000 R11: 0000000000000246 R12: 000055e2dde0d340
  R13: 0000000000000114 R14: 00007ffe5f52e250 R15: 00007fc1cdc49000
  </TASK>
  Modules linked in: tls rfcomm snd_seq_dummy snd_hrtimer xt_CHECKSUM 
xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 ip6table_mangle 
ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables bridge stp 
llc bnep binfmt_misc btusb btrtl btbcm btintel btmtk bluetooth ecdh_generic 
snd_hda_codec_analog snd_hda_codec_generic iwl3945 iwlegacy coretemp kvm_intel 
mac80211 snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 kvm 
iTCO_wdt snd_hda_codec intel_pmc_bxt iTCO_vendor_support snd_hda_core 
snd_hwdep snd_seq snd_seq_device cfg80211 irqbypass snd_pcm thinkpad_acpi 
pcspkr joydev i2c_i801 snd_timer i2c_smbus ledtrig_audio wmi_bmof r592 
platform_profile snd memstick rfkill lpc_ich soundcore acpi_cpufreq nfsd 
auth_rpcgss nfs_acl lockd grace sunrpc fuse zram i915 sdhci_pci cqhci sdhci 
drm_buddy drm_display_helper e1000e mmc_core cec serio_raw yenta_socket ttm 
wmi video ata_generic pata_acpi
  scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:shmem_add_to_page_cache+0x48e/0x500
  Code: 01 0f 84 0a fc ff ff 48 8d 4a ff 31 d2 48 39 cb 0f 85 ff fb ff ff e9 
f6 fb ff ff 48 c7 c6 70 01 64 bb 48 89 df e8 f2 99 01 00 <0f> 0b 48 c7 c6 a0 
1b 64 bb 48 89 df e8 e1 99 01 00 0f 0b 48 8b 13
  RSP: 0018:ffff9ce7c047f6b0 EFLAGS: 00010286
  RAX: 000000000000003f RBX: ffffe683c464b300 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: ffffffffbb67b8e8 RDI: 00000000ffffffff
  RBP: 0000000000023f97 R08: ffffffffbca122a0 R09: 64656b636f6c5f74
  R10: 747365745f6f696c R11: 6f6621284f494c4f R12: 00000000001120d4
  R13: ffff8fa2c6ae7890 R14: ffffe683c464b300 R15: 0000000000000001
  FS:  00007fc1cea31380(0000) GS:ffff8fa3f7900000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f6972e228c8 CR3: 0000000104ba8000 CR4: 00000000000006e0


Regards


Zdenek

