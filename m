Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D7E4EE0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiCaSrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiCaSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:47:02 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548862A1E;
        Thu, 31 Mar 2022 11:45:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B0B65D57A;
        Thu, 31 Mar 2022 20:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1648752308; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=q2IxgHfjFcRg4uaBh/2whAztcwa+26Kd4szRz7UpcBA=;
        b=t/xgEiVUaqBMZK017n0ygLbW6yO+ZGIJtSP84TOtWK1wgvnN8Zf/8hzfp87CcuEiIp7zZ0
        oA35VkySUIWzSr0AJvdO1YBe/kwiNCWKjlrY8ta0UK82Xd977/cEbA0T5fWd92kxYWXzIu
        6KTzaphce5R52cElko9dKWs1wGSNkk04vSYcaCldUFiaL9oR1wE5DzMCEeqtYe9gWhET20
        h+FmRPP+SOH7DwxRwDzR+fPnOnyEUMYtc/i0gmas/5Q/XBMLscXOWBJmvdhyaOXwmbLCEC
        JdHpP6koqaOshHAKZmbYCENuKBIUujEaEml90HLiLwqVXJPwd64gAnXvWa6xwA==
Date:   Thu, 31 Mar 2022 20:45:04 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [ANNOUNCE] 4.19.237-rt107
Message-ID: <164875194487.15351.7634869661022863588@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.237-rt107 stable release.
This is just an update to the latest stable release. No RT specific
changes.

A cyclicdeadline run on arm64 triggered a BUG_ON in the deadline
schedule:

 kernel BUG at kernel/sched/deadline.c:1495!
 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
 Modules linked in:
 Process cyclicdeadline (pid: 2923, stack limit = 0x00000000fe0206e8)
 CPU: 0 PID: 2923 Comm: cyclicdeadline Not tainted 4.19.237-rt107-00591-gefaee3f0115e #12
 Hardware name: Raspberry Pi 3 Model B+ (DT)
 pstate: 40000085 (nZcv daIf -PAN -UAO)
 pc : enqueue_task_dl+0x88/0x864
 lr : rt_mutex_setprio+0x128/0x490
 sp : ffff00000f013570
 x29: ffff00000f013570 x28: 0000000000000001
 x27: ffff80002f4e0ec0 x26: ffff000008de88e8
 x25: 000000000000002e x24: 00000000ffffffff
 x23: ffff80003dfcc9c0 x22: ffff80002fba5a78
 x21: ffff80002efb0ec0 x20: 000000000000002e
 x19: ffff80002fba5880 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000000 x14: 0000000000000000
 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000000 x8 : 0000000000000002
 x7 : 0000000000003a75 x6 : ffff8000369b0e00
 x5 : ffff80002fba5880 x4 : 00000000ffffffe2
 x3 : ffff000008102b30 x2 : ffff80002efb0ec0
 x1 : 0000000000000002 x0 : 0000000000000078
 Call trace:
  enqueue_task_dl+0x88/0x864
  rt_mutex_setprio+0x128/0x490
  rt_mutex_adjust_prio_chain+0x4f4/0x5e0
  task_blocks_on_rt_mutex+0x19c/0x2bc
  rt_spin_lock_slowlock_locked+0xb4/0x280
  rt_spin_lock_slowlock+0x68/0xa0
  rt_spin_lock+0x78/0x84
  get_page_from_freelist+0x9e8/0x175c
  __alloc_pages_nodemask+0x138/0xe80
  alloc_pages_current+0x90/0x100
  allocate_slab+0x48c/0x5c0
  ___slab_alloc+0x5b4/0x6d0
  __slab_alloc.constprop.0+0x88/0x114
  kmem_cache_alloc+0x2cc/0x300
  taskstats_exit+0x260/0x380
  do_exit+0x1a8/0x9a0
  __arm64_sys_exit+0x28/0x30
  el0_svc_common+0x84/0x1a0
  el0_svc_handler+0x3c/0x80
  el0_svc+0x8/0x700
 Code: 37f800a0 d503201f a9046bf9 a90573fb (d4210000)

After discussion with Juri, we figured this might be solved by
2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple
scheduling classes"). First, I am trying to reproduce this but it looks
like it is not easy to trigger.

Anyway, this is not a rergression but as Clark mentioned this bug is
present also on newer -rt versions.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: efaee3f0115e910419fe389bc4fa1d3983a4f259

Or to build 4.19.237-rt107 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.237.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.237-rt107.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.235-rt106:
---

Alan Stern (1):
      usb: gadget: Fix use-after-free bug by not setting udc->dev.driver

Alexander Lobakin (1):
      MIPS: smp: fill in sibling and core maps earlier

Anshuman Khandual (1):
      arm64: Add Cortex-X2 CPU part definition

Arnd Bergmann (1):
      nds32: fix access_ok() checks in get/put_user

Brian Masney (1):
      crypto: qcom-rng - ensure buffer for generate is completely filled

Chengming Zhou (1):
      kselftest/vm: fix tests build with old libc

Chuansheng Liu (1):
      thermal: int340x: fix memory leak in int3400_notify()

Corentin Labbe (1):
      ARM: dts: rockchip: fix a typo on rk3288 crypto-controller

Dan Carpenter (1):
      usb: gadget: rndis: prevent integer overflow in rndis_set_response()

Daniel Wagner (2):
      Merge tag 'v4.19.237' into v4.19-rt
      Linux 4.19.237-rt107

Dietmar Eggemann (1):
      sched/topology: Fix sched_domain_topology_level alloc in sched_init_numa()

Eric Dumazet (4):
      tcp: make tcp_read_sock() more robust
      net/packet: fix slab-out-of-bounds access in packet_recvmsg()
      llc: fix netdevice reference leaks in llc_ui_bind()
      llc: only change llc->dev when bind() succeeds

Giacomo Guiduzzi (1):
      ALSA: pci: fix reading of swapped values from pcmreg in AC97 codec

Giovanni Cabiddu (1):
      crypto: qat - disable registration of algorithms

Greg Kroah-Hartman (2):
      Linux 4.19.236
      Linux 4.19.237

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity

James Morse (18):
      arm64: entry.S: Add ventry overflow sanity checks
      arm64: entry: Make the trampoline cleanup optional
      arm64: entry: Free up another register on kpti's tramp_exit path
      arm64: entry: Move the trampoline data page before the text page
      arm64: entry: Allow tramp_alias to access symbols after the 4K boundary
      arm64: entry: Don't assume tramp_vectors is the start of the vectors
      arm64: entry: Move trampoline macros out of ifdef'd section
      arm64: entry: Make the kpti trampoline's kpti sequence optional
      arm64: entry: Allow the trampoline text to occupy multiple pages
      arm64: entry: Add non-kpti __bp_harden_el1_vectors for mitigations
      arm64: entry: Add vectors that have the bhb mitigation sequences
      arm64: entry: Add macro for reading symbol addresses from the trampoline
      arm64: Add percpu vectors for EL1
      arm64: proton-pack: Report Spectre-BHB vulnerabilities as part of Spectre-v2
      KVM: arm64: Add templates for BHB mitigation sequences
      arm64: Mitigate spectre style branch history side channels
      KVM: arm64: Allow SMCCC_ARCH_WORKAROUND_3 to be discovered and migrated
      arm64: Use the clearbhb instruction in mitigations

Jia-Ju Bai (1):
      atm: firestream: check the return value of ioremap() in fs_init()

Jiasheng Jiang (2):
      atm: eni: Add check for dma_map_single
      hv_netvsc: Add check for kvmalloc_array

Joey Gouly (1):
      arm64: add ID_AA64ISAR2_EL1 sys register

Jonathan Teh (1):
      ALSA: cmipci: Restore aux vol on suspend/resume

Jordy Zomer (1):
      nfc: st21nfca: Fix potential buffer overflows in EVT_TRANSACTION

Joseph Qi (1):
      ocfs2: fix crash when initialize filecheck kobj fails

Julian Braha (1):
      ARM: 9178/1: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE

Kai Lueke (1):
      Revert "xfrm: state and policy should fail if XFRMA_IF_ID 0"

Lad Prabhakar (1):
      can: rcar_canfd: rcar_canfd_channel_probe(): register the CAN device when fully ready

Lars-Peter Clausen (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on RODE NT-USB

Linus Lüssing (1):
      mac80211: fix potential double free on mesh join

Lucas Wei (1):
      fs: sysfs_emit: Remove PAGE_SIZE alignment check

Marek Vasut (1):
      drm/panel: simple: Fix Innolux G070Y2-L01 BPP settings

Mark Cilissen (1):
      ACPI / x86: Work around broken XSDT on Advantech DAC-BJ01 board

Maximilian Luz (1):
      ACPI: battery: Add device HID and quirk for Microsoft Surface Go 3

Miaoqian Lin (1):
      net: dsa: Add missing of_node_put() in dsa_port_parse_of

Michael Petlan (1):
      perf symbols: Fix symbol size calculation condition

Nicolas Dichtel (1):
      net: handle ARPHRD_PIMREG in dev_is_mac_header_xmit()

Niels Dossche (1):
      sfc: extend the locking on mcdi->seqno

Oliver Graute (1):
      staging: fbtft: fb_st7789v: reset display before initialization

Pablo Neira Ayuso (1):
      netfilter: nf_tables: initialize registers in nft_do_chain()

Pavel Skripkin (1):
      Input: aiptek - properly check endpoint type

Randy Dunlap (1):
      efi: fix return value of __setup handlers

Rob Herring (1):
      arm64: Add part number for Arm Cortex-A77

Sascha Hauer (1):
      arm64: dts: rockchip: reorder rk3399 hdmi clocks

Sreeramya Soratkal (1):
      nl80211: Update bss channel on channel switch for P2P_CLIENT

Steffen Klassert (1):
      esp: Fix possible buffer overflow in ESP transformation

Stephane Graber (1):
      drivers: net: xgene: Fix regression in CRC stripping

Suzuki K Poulose (1):
      arm64: Add Neoverse-N2, Cortex-A710 CPU part definition

Tadeusz Struk (1):
      net: ipv6: fix skb_over_panic in __ip6_append_data

Takashi Iwai (3):
      ASoC: sti: Fix deadlock via snd_pcm_stop_xrun() call
      ALSA: oss: Fix PCM OSS buffer allocation overflow
      ALSA: pcm: Add stream lock during PCM reset ioctl operations

Valentin Schneider (2):
      sched/topology: Make sched_init_numa() use a set for the deduplicating sort
      ia64: ensure proper NUMA distance and possible map initialization

Werner Sembach (1):
      ACPI: video: Force backlight native for Clevo NL5xRU and NL5xNU

Xin Long (2):
      sctp: fix the processing for INIT chunk
      sctp: fix the processing for INIT_ACK chunk

Yan Yan (2):
      xfrm: Check if_id in xfrm_migrate
      xfrm: Fix xfrm migrate issues when address family changes

Zhang Qiao (1):
      cpuset: Fix unsafe lock order between cpuset lock and cpuslock

liqiong (1):
      mm: fix dereference a null pointer in migrate[_huge]_page_move_mapping()
