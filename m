Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AD573A49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiGMPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiGMPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:35:21 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6C84E61A;
        Wed, 13 Jul 2022 08:35:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D54E5DE49;
        Wed, 13 Jul 2022 17:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1657726509; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=QJ5DmtNrlcXGr/uYeWc+eyH9iLfSIdYHMoFGbmyQMvI=;
        b=aO4gYxrQ7a3gEn5Mrounhd4hSjdcp9gsPYQswMcaR5zSpbGktz2dLkHaaU9YYBuOzgfzMb
        trkQLjhOfjLwFaVSiWWeTDj4yJwDC/LlW41lEOcCpW4+pn5gs49YvnapkjGVlD83nDzrz6
        nmveXmchm17dTtDC9+sARrlAM1YnZ5oRs/B+xSU1fG8KS6Lv+R4viQeidIHC47L+6xvj8b
        y8emKqWidloeMM5Wem+p/sw8J5xZav4/Qo/KtlxSu1pjsx04f5sXc6Eeh1+V7LIWrI52wW
        BO3LrKvagBEiuZAoDJKv2IOLDt1nyup3Ss4dGOWnyu+RQXyS+82dygJ4rYBzEw==
Date:   Wed, 13 Jul 2022 17:35:06 +0200
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
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.19.252-rt112
Message-ID: <165772237410.25508.13038617582392631958@beryllium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

I'm pleased to announce the 4.19.252-rt112 stable release. This is
just an update to the latest stable release.

The update to v4.19.249 stable release added the massive
drivers/arch/random.c rewrite from Jason A. Donenfeld. The upstream
version is RT friendly. Though the backport dropped the local locks
(stable v4.19 doesn't have this API) which I had to add back with the
v4.19-rt API.

Apart the mentioned random.c update, there are no further RT changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 55e923ec34618b1c2afde7b918e578cf1c0b5645

Or to build 4.19.252-rt112 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.252.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.252-rt112.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.246-rt110:
---

Adam Ford (1):
      ASoC: wm8962: Fix suspend while playing music

Adrian Hunter (1):
      mmc: block: Fix CQE recovery reset success

Akira Yokosawa (1):
      docs/conf.py: Cope with removal of language=None in Sphinx 5.0.0

Al Viro (1):
      9p: missing chunk of "fs/9p: Don't update file type when updating file attributes"

Aleksandr Loktionov (1):
      i40e: Fix call trace in setup_tx_descriptors

Alexander Aring (2):
      dlm: fix plock invalid read
      dlm: fix missing lkb refcount handling

Alexander Lobakin (1):
      modpost: fix removing numeric suffixes

Alexander Wetzel (1):
      rtl818x: Prevent using not initialized queues

Alexey Dobriyan (1):
      proc: fix dentry/inode overinstantiating under /proc/${pid}/net

Alexey Kardashevskiy (1):
      powerpc/mm: Switch obsolete dssall to .long

Amadeusz Sławiński (1):
      ALSA: jack: Access input_dev under mutex

Amelie Delaunay (1):
      dmaengine: stm32-mdma: remove GISR1 register

Amir Goldstein (2):
      inotify: show inotify mask flags in proc fdinfo
      fsnotify: fix wrong lockdep annotations

Ammar Faizi (1):
      x86/delay: Fix the wrong asm constraint in delay_loop()

Andre Przywara (1):
      clocksource/drivers/sp804: Avoid error on multiple instances

Andrew Donnellan (1):
      powerpc/rtas: Allow ibm,platform-dump RTAS call with null buffer address

Andy Lutomirski (8):
      random: Don't wake crng_init_wait when crng_init == 1
      random: Add a urandom_read_nowait() for random APIs that don't warn
      random: add GRND_INSECURE to return best-effort non-cryptographic bytes
      random: ignore GRND_RANDOM in getentropy(2)
      random: make /dev/random be almost like /dev/urandom
      random: remove the blocking pool
      random: delete code to pull data into pools
      random: remove kernel.random.read_wakeup_threshold

Ard Biesheuvel (1):
      random: avoid arch_get_random_seed_long() when collecting IRQ randomness

Baokun Li (2):
      jffs2: fix memory leak in jffs2_do_fill_super
      ext4: fix bug_on ext4_mb_use_inode_pa

Baruch Siach (1):
      iio: adc: vf610: fix conversion mode sysfs node name

Bjorn Helgaas (1):
      PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299

Björn Ardö (1):
      mailbox: forward the hrtimer if not queued and under a lock

Borislav Petkov (1):
      char/random: Add a newline at the end of the file

Brian Norris (2):
      PM / devfreq: rk3399_dmc: Disable edev on remove()
      drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX

Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 modem

Carlo Lobrano (2):
      USB: serial: option: add Telit LE910Cx 0x1250 composition
      net: usb: qmi_wwan: add Telit 0x1060 composition

Chao Yu (1):
      f2fs: fix deadloop in foreground GC

Charles Keepax (5):
      ASoC: tscs454: Add endianness flag in snd_soc_component_driver
      ASoC: cs42l52: Fix TLV scales for mixer controls
      ASoC: cs53l30: Correct number of volume levels on SX controls
      ASoC: cs42l52: Correct TLV for Bypass Volume
      ASoC: cs42l56: Correct typo in minimum level for SX volume controls

Chen Lin (1):
      net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface netdev[napi]_alloc_frag

Chengguang Xu (2):
      scsi: ipr: Fix missing/incorrect resource cleanup in error case
      scsi: pmcraid: Fix missing resource cleanup in error case

Chris Ye (1):
      nvdimm: Fix badblocks clear off-by-one error

Christian Borntraeger (1):
      s390/mm: use non-quiescing sske for KVM switch to keyed guest

Christoph Hellwig (1):
      drm: remove drm_fb_helper_modinit

Christophe JAILLET (1):
      net: bgmac: Fix an erroneous kfree() in bgmac_remove()

Christophe de Dinechin (1):
      nodemask.h: fix compilation error with GCC12

Chuck Lever (2):
      SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()
      SUNRPC: Fix READ_PLUS crasher

Cixi Geng (1):
      iio: adc: sc27xx: fix read big scale voltage not right

Claudiu Beznea (1):
      ARM: at91: pm: use proper compatible for sama5d2's rtc

Colin Ian King (1):
      xprtrdma: fix incorrect header size calculations

Corentin Labbe (1):
      crypto: marvell/cesa - ECB does not IV

Corey Minyard (1):
      ipmi:ssif: Check for NULL msg when handling events and messages

Cristian Marussi (1):
      firmware: arm_scmi: Fix list protocols enumeration in the base protocol

Dan Carpenter (6):
      ath9k_htc: fix potential out of bounds access with invalid rxstatus->rs_keyix
      drm/msm: return an error pointer in msm_gem_prime_get_sg_table()
      PCI: cadence: Fix find_first_zero_bit() limit
      PCI: rockchip: Fix find_first_zero_bit() limit
      net: ethernet: mtk_eth_soc: out of bounds read in mtk_hwlro_get_fdir_entry()
      gpio: winbond: Fix error code in winbond_gpio_get()

Daniel Vetter (1):
      fbcon: Consistently protect deferred_takeover with console_lock()

Daniel Wagner (5):
      Merge tag 'v4.19.249' into v4.19-rt
      random: Use local locks for crng context access
      Linux 4.19.249-rt111
      Merge tag 'v4.19.252' into v4.19-rt
      Linux 4.19.252-rt112

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit 0x1070 composition

Dave Airlie (1):
      drm/amdgpu/cs: make commands with 0 chunks illegal behaviour.

David Howells (5):
      rxrpc: Return an error to sendmsg if call failed
      rxrpc: Fix listen() setting the bar too high for the prealloc rings
      rxrpc: Don't try to resend the request if we're receiving the reply
      afs: Fix infinite loop found by xfstest generic/676
      afs: Fix dynamic root getattr

Demi Marie Obenour (1):
      xen/gntdev: Avoid blocking in unmap_grant_pages()

Dennis Dalessandro (1):
      RDMA/hfi1: Fix potential integer multiplication overflow errors

Diederik de Haas (1):
      net/sched: move NULL ptr check to qdisc_put() too

Dimitris Michailidis (1):
      selftests/net: pass ipv6_args to udpgso_bench's IPv6 TCP test

Ding Xiang (1):
      ext4: make variable "count" signed

Dinh Nguyen (1):
      dt-bindings: gpio: altera: correct interrupt-cells

Dmitry Baryshkov (1):
      drm/msm/dsi: fix error checks and return values for DSI xmit functions

Dmitry Osipenko (1):
      dmaengine: pl330: Fix lockdep warning about non-static key

Dmitry Rokosov (2):
      iio:chemical:ccs811: rearrange iio trigger get and register
      iio:accel:bma180: rearrange iio trigger get and register

Dominik Brodowski (7):
      random: fix crash on multiple early calls to add_bootloader_randomness()
      random: harmonize "crng init done" messages
      random: early initialization of ChaCha constants
      random: continually use hwgenerator randomness
      random: access primary_pool directly rather than through pointer
      random: only call crng_finalize_init() for primary_crng
      random: fix locking in crng_fast_load()

Dongliang Mu (1):
      rtlwifi: Use pr_warn instead of WARN_ONCE

Doug Berger (1):
      net: dsa: bcm_sf2: force pause link settings

Douglas Miller (2):
      RDMA/hfi1: Prevent panic when SDMA is disabled
      RDMA/hfi1: Prevent use of lock before it is initialized

Duoming Zhou (7):
      NFC: hci: fix sleep in atomic context bugs in nfc_hci_hcp_message_tx
      drivers: staging: rtl8192u: Fix deadlock in ieee80211_beacons_stop()
      drivers: staging: rtl8192e: Fix deadlock in rtllib_beacons_stop()
      drivers: tty: serial: Fix deadlock in sa1100_set_termios()
      drivers: usb: host: Fix deadlock in oxu_bus_suspend()
      net: rose: fix UAF bugs caused by timer handler
      net: rose: fix UAF bug caused by rose_t0timer_expiry

Edward Wu (1):
      ata: libata: add qc->flags in ata_qc_complete_template tracepoint

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix assert 1F04 upon reconfig

Eric Biggers (6):
      ext4: reject the 'commit' option on ext2 filesystems
      random: remove dead code left over from blocking pool
      crypto: blake2s - include <linux/bug.h> instead of <asm/bug.h>
      crypto: blake2s - adjust include guard naming
      random: initialize ChaCha20 constants with correct endianness
      random: remove use_input_pool parameter from crng_reseed()

Eric Dumazet (7):
      sctp: read sk->sk_bound_dev_if once in sctp_rcv()
      tcp: tcp_rtx_synack() can be called from process context
      bpf, arm64: Clear prog->jited_len along prog->jited
      tcp: fix tcp_mtup_probe_success vs wrong snd_cwnd
      tcp: add some entropy in __inet_hash_connect()
      erspan: do not assume transport header is always set
      net: bonding: fix possible NULL deref in rlb code

Eric Sandeen (1):
      xfs: remove incorrect ASSERT in xfs_rename

Eric W. Biederman (2):
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL

Evan Green (1):
      USB: hcd-pci: Fully suspend across freeze/thaw cycle

Evan Quan (1):
      drm/amd/pm: fix the compile warning

Fabio Estevam (1):
      net: phy: micrel: Allow probing without .driver_data

Felix Fietkau (1):
      mac80211: upgrade passive scan to active scan on DFS channels after beacon rx

Feras Daoud (1):
      net/mlx5: Rearm the FW tracer after each tracer event

Finn Thain (1):
      macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled

Gal Pressman (1):
      net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure

Gayatri Kammela (2):
      x86/cpu: Add Elkhart Lake to Intel family
      x86/cpu: Add another Alder Lake CPU to the Intel family

Geert Uytterhoeven (1):
      m68k: math-emu: Fix dependencies of math emulation support

George Spelvin (1):
      random: document get_random_int() family

Gong Yuanjun (2):
      mips: cpc: Fix refcount leak in mips_cpc_default_phys_base
      drm/radeon: fix a possible null pointer dereference

Greg Kroah-Hartman (7):
      Linux 4.19.247
      Linux 4.19.248
      Revert "hwmon: Make chip parameter for with_info API mandatory"
      Linux 4.19.249
      Linux 4.19.250
      Linux 4.19.251
      Linux 4.19.252

Greg Ungerer (2):
      m68knommu: set ZERO_PAGE() to the allocated zeroed page
      m68knommu: fix undefined reference to `_init_sp'

Grzegorz Szczurek (1):
      i40e: Fix adding ADQ filter to TC0

Guenter Roeck (2):
      hwmon: Make chip parameter for with_info API mandatory
      cpu/speculation: Add prototype for cpu_show_srbds()

Guilherme G. Piccoli (1):
      coresight: cpu-debug: Replace mutex with mutex_trylock on panic notifier

Guoqing Jiang (1):
      md: protect md_unregister_thread from reentrancy

Gustavo A. R. Silva (1):
      scsi: fcoe: Fix Wstringop-overflow warnings in fcoe_wwn_from_mac()

Haibo Chen (1):
      iio: accel: mma8452: ignore the return value of reset operation

Hangyu Hua (2):
      drm: msm: fix possible memory leak in mdp5_crtc_cursor_set()
      usb: usbip: fix a refcount leak in stub_probe()

Hans Verkuil (1):
      media: cec-adap.c: fix is_configuring state

Hans de Goede (1):
      iio: adc: axp288: Override TS pin bias current for some models

Hao Luo (1):
      kernfs: Separate kernfs_pr_cont_buf and rename_lock.

Haowen Bai (3):
      b43legacy: Fix assigning negative value to unsigned variable
      b43: Fix assigning negative value to unsigned variable
      ipw2x00: Fix potential NULL dereference in libipw_xmit()

He Ying (1):
      powerpc/kasan: Silence KASAN warnings in __get_wchan()

Heiko Carstens (1):
      s390/preempt: disable __preempt_count_add() optimization for PROFILE_ALL_BRANCHES

Heinz Mauelshagen (1):
      dm raid: fix accesses beyond end of raid member array

Helge Deller (1):
      fbcon: Disallow setting font bigger than screen size

Heming Zhao (1):
      md/bitmap: don't set sb values if can't pass sanity check

Herbert Xu (1):
      Revert "hwrng: core - Freeze khwrng thread during suspend"

Hoang Le (1):
      tipc: check attribute length for bearer name

Hsin-Yi Wang (3):
      fdt: add support for rng-seed
      fdt: Update CRC check for rng-seed
      video: of_display_timing.h: include errno.h

Huang Guobin (1):
      tty: Fix a possible resource leak in icom_probe

Ian Abbott (1):
      comedi: vmk80xx: fix expression for tx buffer size

Ilpo Järvinen (7):
      serial: 8250_fintek: Check SER_RS485_RTS_* only with RS485
      serial: digicolor-usart: Don't allow CS5-6
      serial: txx9: Don't allow CS5-6
      serial: sh-sci: Don't allow CS5-6
      serial: st-asc: Sanitize CSIZE and correct PARENB for CS7
      serial: stm32-usart: Correct CSIZE, bits, and parity
      serial: 8250: Store to lsr_save_flags after lsr read

Ilya Maximets (2):
      net: openvswitch: fix misuse of the cached connection on tuple changes
      net: openvswitch: fix leak of nested actions

Jakob Koschel (2):
      f2fs: fix dereference of stale list iterator after loop body
      staging: greybus: codecs: fix type confusion of list iterator variable

Jakub Kicinski (4):
      eth: tg3: silence the GCC 12 array-bounds warning
      net: tun: unlink NAPI from device on destruction
      net: tun: stop NAPI when detaching queues
      net: tun: avoid disabling NAPI twice

James Smart (1):
      scsi: lpfc: Fix port stuck in bypassed state after LIP in PT2PT topology

Jan Kara (2):
      ext4: verify dir block before splitting it
      ext4: avoid cycles in directory h-tree

Jan Kiszka (1):
      efi: Add missing prototype for efi_capsule_setup_info

Jan Varho (1):
      random: do not split fast init input in add_hwgenerator_randomness()

Jani Nikula (1):
      drm/edid: fix invalid EDID extension block filtering

Jann Horn (4):
      s390/crypto: fix scatterwalk_unmap() callers in AES-GCM
      random: don't reset crng_init_cnt on urandom_read()
      random: check for signal_pending() outside of need_resched() check
      mm/slub: add missing TID updates on slab deactivation

Janusz Krzysztofik (1):
      ARM: OMAP1: clock: Fix UART rate reporting algorithm

Jason A. Donenfeld (122):
      openrisc: start CPU timer early in boot
      crypto: blake2s - generic C library implementation and selftest
      lib/crypto: blake2s: move hmac construction into wireguard
      lib/crypto: sha1: re-roll loops to reduce code size
      MAINTAINERS: co-maintain random.c
      random: use BLAKE2s instead of SHA1 in extraction
      random: do not sign extend bytes for rotation when mixing
      random: do not re-init if crng_reseed completes before primary init
      random: mix bootloader randomness into pool
      random: use IS_ENABLED(CONFIG_NUMA) instead of ifdefs
      random: avoid superfluous call to RDRAND in CRNG extraction
      random: cleanup poolinfo abstraction
      random: cleanup integer types
      random: remove incomplete last_data logic
      random: remove unused extract_entropy() reserved argument
      random: rather than entropy_store abstraction, use global
      random: remove unused OUTPUT_POOL constants
      random: de-duplicate INPUT_POOL constants
      random: prepend remaining pool constants with POOL_
      random: cleanup fractional entropy shift constants
      random: access input_pool_data directly rather than through pointer
      random: simplify arithmetic function flow in account()
      random: use computational hash for entropy extraction
      random: simplify entropy debiting
      random: use linear min-entropy accumulation crediting
      random: always wake up entropy writers after extraction
      random: make credit_entropy_bits() always safe
      random: remove batched entropy locking
      random: use RDSEED instead of RDRAND in entropy extraction
      random: inline leaves of rand_initialize()
      random: ensure early RDSEED goes through mixer on init
      random: do not xor RDRAND when writing into /dev/random
      random: absorb fast pool into input pool after fast load
      random: use hash function for crng_slow_load()
      random: remove outdated INT_MAX >> 6 check in urandom_read()
      random: zero buffer after reading entropy from userspace
      random: tie batched entropy generation to base_crng generation
      random: remove ifdef'd out interrupt bench
      random: remove unused tracepoints
      random: add proper SPDX header
      random: deobfuscate irq u32/u64 contributions
      random: introduce drain_entropy() helper to declutter crng_reseed()
      random: remove useless header comment
      random: remove whitespace and reorder includes
      random: group initialization wait functions
      random: group entropy extraction functions
      random: group entropy collection functions
      random: group userspace read/write functions
      random: group sysctl functions
      random: rewrite header introductory comment
      random: defer fast pool mixing to worker
      random: do not take pool spinlock at boot
      random: unify early init crng load accounting
      random: check for crng_init == 0 in add_device_randomness()
      random: pull add_hwgenerator_randomness() declaration into random.h
      random: clear fast pool, crng, and batches in cpuhp bring up
      random: round-robin registers as ulong, not u32
      random: only wake up writers after zap if threshold was passed
      random: cleanup UUID handling
      random: unify cycles_t and jiffies usage and types
      random: do crng pre-init loading in worker rather than irq
      random: give sysctl_random_min_urandom_seed a more sensible value
      random: don't let 644 read-only sysctls be written to
      random: replace custom notifier chain with standard one
      random: use SipHash as interrupt entropy accumulator
      random: make consistent usage of crng_ready()
      random: reseed more often immediately after booting
      random: check for signal and try earlier when generating entropy
      random: skip fast_init if hwrng provides large chunk of entropy
      random: treat bootloader trust toggle the same way as cpu trust toggle
      random: re-add removed comment about get_random_{u32,u64} reseeding
      random: mix build-time latent entropy into pool at init
      random: do not allow user to keep crng key around on stack
      random: check for signals every PAGE_SIZE chunk of /dev/[u]random
      random: make random_get_entropy() return an unsigned long
      random: document crng_fast_key_erasure() destination possibility
      random: fix sysctl documentation nits
      init: call time_init() before rand_initialize()
      ia64: define get_cycles macro for arch-override
      s390: define get_cycles macro for arch-override
      parisc: define get_cycles macro for arch-override
      alpha: define get_cycles macro for arch-override
      powerpc: define get_cycles macro for arch-override
      timekeeping: Add raw clock fallback for random_get_entropy()
      m68k: use fallback for random_get_entropy() instead of zero
      mips: use fallback for random_get_entropy() instead of just c0 random
      arm: use fallback for random_get_entropy() instead of zero
      nios2: use fallback for random_get_entropy() instead of zero
      x86/tsc: Use fallback for random_get_entropy() instead of zero
      um: use fallback for random_get_entropy() instead of zero
      sparc: use fallback for random_get_entropy() instead of zero
      xtensa: use fallback for random_get_entropy() instead of zero
      random: insist on random_get_entropy() existing in order to simplify
      random: do not use batches when !crng_ready()
      random: do not pretend to handle premature next security model
      random: order timer entropy functions below interrupt functions
      random: do not use input pool from hard IRQs
      random: help compiler out with fast_mix() by using simpler arguments
      siphash: use one source of truth for siphash permutations
      random: use symbolic constants for crng_init states
      random: avoid initializing twice in credit race
      random: remove ratelimiting for in-kernel unseeded randomness
      random: use proper jiffies comparison macro
      random: handle latent entropy and command line from random_init()
      random: credit architectural init the exact amount
      random: use static branch for crng_ready()
      random: remove extern from functions in header
      random: use proper return types on get_random_{int,long}_wait()
      random: move initialization functions out of hot pages
      random: move randomize_page() into mm where it belongs
      random: check for signals after page of pool writes
      Revert "random: use static branch for crng_ready()"
      random: avoid checking crng_ready() twice in random_init()
      random: mark bootloader randomness code as __init
      random: account for arch randomness in bits
      random: credit cpu and bootloader seeds by default
      random: schedule mix_interrupt_randomness() less often
      random: quiet urandom warning ratelimit suppression message
      powerpc/powernv: wire up rng during setup_arch
      powerpc/pseries: wire up rng during setup_arch()
      s390/archrandom: simplify back to earlier design and initialize earlier
      powerpc/powernv: delay rng platform device creation until later in boot

Jason Wang (2):
      virtio-net: fix race between ndo_open() and virtio_device_ready()
      caif_virtio: fix race between virtio_device_ready() and ndo_open()

Jay Vosburgh (1):
      bonding: ARP monitor spams NETDEV_NOTIFY_PEERS notifiers

Jens Axboe (2):
      random: convert to using fops->write_iter()
      random: wire up fops->splice_{read,write}_iter()

Jessica Zhang (2):
      drm/msm/mdp5: Return error code in mdp5_pipe_release when deadlock is detected
      drm/msm/mdp5: Return error code in mdp5_mixer_release when deadlock is detected

Jia-Ju Bai (1):
      md: bcache: check the return value of kzalloc() in detached_dev_do_request()

Jimmy Assarsson (3):
      can: kvaser_usb: replace run-time checks with struct kvaser_usb_driver_info
      can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression
      can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits

Jiri Slaby (1):
      vt: drop old FONT ioctls

Joerg Roedel (1):
      iommu/amd: Increase timeout waiting for GA log enablement

Johan Hovold (4):
      PCI: qcom: Fix runtime PM imbalance on probe errors
      PCI: qcom: Fix unbalanced PHY init on probe errors
      phy: qcom-qmp: fix struct clk leak on probe errors
      phy: qcom-qmp: fix reset-controller leak on probe errors

Johannes Berg (3):
      nl80211: show SSID for P2P_GO interfaces
      wifi: mac80211: fix use-after-free in chanctx code
      um: chan_user: Fix winch_tramp() return value

John Ogness (2):
      serial: meson: acquire port->lock in startup()
      serial: msm_serial: disable interrupts in __msm_console_write()

Jonathan Teh (1):
      HID: hid-led: fix maximum brightness for Dream Cheeky

Jose Alonso (1):
      net: usb: ax88179_178a: Fix packet receiving

Josh Poimboeuf (4):
      x86/speculation: Add missing prototype for unpriv_ebpf_notify()
      scripts/faddr2line: Fix overlapping text section failures
      x86/speculation/mmio: Print SMT warning
      faddr2line: Fix overlapping text section failures, the sequel

Julien Grall (1):
      x86/xen: Remove undefined behavior in setup_features()

Jun Miao (1):
      tracing: Fix sleeping function called from invalid context on RT kernel

Junxiao Bi via Ocfs2-devel (1):
      ocfs2: dlmfs: fix error handling of user_dlm_destroy_lock

Kai-Heng Feng (1):
      igb: Make DMA faster when CPU is active on the PCIe link

Kajol Jain (1):
      powerpc/perf: Fix the threshold compare group constraint for power9

Kamal Heib (1):
      RDMA/qedr: Fix reporting QP timeout attribute

Kathiravan T (1):
      arm64: dts: qcom: ipq8074: fix the sleep clock frequency

Kees Cook (3):
      lkdtm/usercopy: Expand size of "out of frame" object
      nodemask: Fix return values to be unsigned
      random: move rand_initialize() earlier

Keita Suzuki (2):
      drm/amd/pm: fix double free in si_parse_power_table()
      tracing: Fix potential double free in create_var_ref()

Kinglong Mee (1):
      xprtrdma: treat all calls not a bcall when bc_serv is NULL

Kirill A. Shutemov (1):
      ACPICA: Avoid cache flush inside virtual machines

Kiwoong Kim (1):
      scsi: ufs: core: Exclude UECxx from SFR dump list

Krzysztof Kozlowski (8):
      ARM: dts: ox820: align interrupt controller node name with dtschema
      ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
      irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map() return value
      pinctrl: mvebu: Fix irq_of_parse_and_map() return value
      rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value
      rpmsg: qcom_smd: Fix returning 0 if irq_of_parse_and_map() fails
      clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
      nfc: nfcmrvl: Fix irq_of_parse_and_map() return value

Kuniyuki Iwashima (1):
      af_unix: Fix a data-race in unix_dgram_peer_wake_me().

Kwanghoon Son (1):
      media: exynos4-is: Fix compile warning

Leo Yan (2):
      perf c2c: Use stdio interface if slang is not supported
      perf c2c: Fix sorting in percent_rmt_hitm_cmp()

Liang He (3):
      xtensa: xtfpga: Fix refcount leak bug in setup
      xtensa: Fix refcount leak bug in time.c
      can: grcan: grcan_probe(): remove extra of_node_get()

Lin Ma (3):
      ASoC: rt5645: Fix errorenous cleanup order
      NFC: NULL out the dev->rfkill to prevent UAF
      USB: storage: karma: fix rio_karma_init return

Linus Torvalds (3):
      drm: fix EDID struct for old ARM OABI format
      drm: imx: fix compiler warning with gcc-12
      ida: don't use BUG_ON() for debugging

Liu Shixin (1):
      swiotlb: skip swiotlb_bounce when orig_addr is zero

Liu Zixian (1):
      drm/virtio: fix NULL pointer dereference in virtio_gpu_conn_get_modes

Luca Weiss (1):
      media: venus: hfi: avoid null dereference in deinit

Lucas Stach (2):
      drm/bridge: adv7511: clean up CEC adapter when probe fails
      ARM: dts: imx6qdl: correct PU regulator ramp delay

Lucas Tanure (1):
      i2c: cadence: Increase timeout per message if necessary

Lv Ruyi (3):
      scsi: megaraid: Fix error check return value of register_chrdev()
      powerpc/xics: fix refcount leak in icp_opal_init()
      mfd: ipaq-micro: Fix error check return value of platform_get_irq()

Maciej W. Rozycki (1):
      MIPS: IP27: Remove incorrect `cpu_has_fpu' override

Macpaul Lin (1):
      USB: serial: option: add Quectel RM500K module support

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled

Marek Szyprowski (1):
      usb: dwc2: gadget: don't reset gadget's driver->bus

Marian Postevca (1):
      usb: gadget: u_ether: fix regression in setting fixed MAC address

Marios Levogiannis (1):
      ALSA: hda/realtek - Fix microphone noise on ASUS TUF B550M-PLUS

Mark Brown (5):
      ASoC: dapm: Don't fold register value changes into notifications
      ASoC: rt5514: Fix event generation for "DSP Voice Wake Up" control
      random: document add_hwgenerator_randomness() with other input functions
      ASoC: es8328: Fix event generation for deemphasis control
      ASoC: wm_adsp: Fix event generation for wm_adsp_fw_put()

Mark Rutland (4):
      random: split primary/secondary crng init paths
      random: avoid warnings for !CONFIG_NUMA builds
      random: add arch_get_random_*long_early()
      arm64: ftrace: fix branch range checks

Mark-PK Tsai (1):
      tracing: Avoid adding tracer option before update_tracer_options

Martin Faltesek (2):
      nfc: st21nfca: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st21nfca: fix memory leaks in EVT_TRANSACTION handling

Masahiro Yamada (8):
      net: mdio: unexport __init-annotated mdio_bus_init()
      net: xfrm: unexport __init-annotated xfrm4_protocol_init()
      net: ipv6: unexport __init-annotated seg6_hmac_init()
      modpost: fix undefined behavior of is_arm_mapping_symbol()
      certs/blacklist_hashes.c: fix const confusion in certs blacklist
      modpost: fix section mismatch check for exported init/exit sections
      kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS (2nd attempt)
      xen: unexport __init-annotated xen_xlate_map_ballooned_pages()

Mathias Nyman (2):
      Input: bcm5974 - set missing URB_NO_TRANSFER_DMA_MAP urb flag
      xhci: turn off port power in shutdown

Matthieu Baerts (1):
      x86/pm: Fix false positive kmemleak report in msr_build_context()

Max Filippov (1):
      irqchip: irq-xtensa-mx: fix initial IRQ affinity

Maxim Mikityanskiy (1):
      net/mlx5e: Update netdev features after changing XDP state

Maxime Ripard (2):
      drm/vc4: txp: Don't set TXP_VSTART_AT_EOF
      drm/vc4: txp: Force alpha to be 0xff if it's disabled

Miaohe Lin (1):
      drivers/base/node.c: fix compaction sysfs file leak

Miaoqian Lin (31):
      ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
      ASoC: mediatek: Fix missing of_node_put in mt2701_wm8960_machine_probe
      spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout
      HID: elan: Fix potential double free in elan_input_configured
      ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
      regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
      media: st-delta: Fix PM disable depth imbalance in delta_probe
      media: exynos4-is: Change clk_disable to clk_disable_unprepare
      soc: qcom: smp2p: Fix missing of_node_put() in smp2p_parse_ipc
      soc: qcom: smsm: Fix missing of_node_put() in smsm_parse_ipc
      Input: sparcspkr - fix refcount leak in bbc_beep_probe
      powerpc/fsl_rio: Fix refcount leak in fsl_rio_setup
      video: fbdev: clcdfb: Fix refcount leak in clcdfb_of_vram_setup
      usb: musb: Fix missing of_node_put() in omap2430_probe
      soc: rockchip: Fix refcount leak in rockchip_grf_init
      firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle
      net: dsa: mv88e6xxx: Fix refcount leak in mv88e6xxx_mdios_register
      ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
      net: altera: Fix refcount leak in altera_tse_mdio_create
      misc: atmel-ssc: Fix IRQ check in ssc_probe
      irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
      irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
      usb: dwc2: Fix memory leak in dwc2_hcd_init
      usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe
      ARM: exynos: Fix refcount leak in exynos_map_pmu
      soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in brcmstb_pm_probe
      ARM: Fix refcount leak in axxia_boot_secondary
      ARM: cns3xxx: Fix refcount leak in cns3xxx_init
      ARM: meson: Fix refcount leak in meson_smp_prepare_cpus
      dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
      dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate

Michael Ellerman (1):
      powerpc/32: Fix overread/overwrite of thread_struct via ptrace

Michael Rodin (1):
      media: vsp1: Fix offset calculation for plane cropping

Michael Walle (3):
      i2c: at91: use dma safe buffers
      NFC: nxp-nci: Don't issue a zero length i2c_master_read()
      dmaengine: at_xdma: handle errors of at_xdmac_alloc_desc() correctly

Michal Kubecek (1):
      Revert "net: af_key: add check for pfkey_broadcast in function pfkey_process"

Mike Kravetz (1):
      hugetlb: fix huge_pmd_unshare address update

Mikulas Patocka (2):
      dma-debug: change allocation mode from GFP_NOWAIT to GFP_ATIOMIC
      dm raid: fix KASAN warning in raid5_add_disks

Miles Chen (1):
      drm/mediatek: Fix mtk_cec_mask()

Monish Kumar R (1):
      USB: new quirk for Dell Gen 2 devices

Muchun Song (1):
      dax: fix cache flush on PMD-mapped pages

Murilo Opsfelder Araujo (1):
      virtio-pci: Remove wrong address verification in vp_del_vqs()

Nathan Chancellor (1):
      i2c: at91: Initialize dma_buf in at91_twi_xfer()

Naveen N. Rao (2):
      powerpc: Enable execve syscall exit tracepoint
      kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]

Nicolai Stange (4):
      crypto: drbg - prepare for more fine-grained tracking of seeding state
      crypto: drbg - track whether DRBG was seeded with !rng_is_initialized()
      crypto: drbg - move dynamic ->reseed_threshold adjustments to __drbg_seed()
      crypto: drbg - make reseeding from get_random_bytes() synchronous

Nicolas Dufresne (2):
      media: coda: Fix reported H264 profile
      media: coda: Add more H264 levels for CODA960

Niels Dossche (3):
      mwifiex: add mutex lock for call in mwifiex_dfs_chan_sw_work_queue
      ipv6: fix locking issues with loops over idev->addr_list
      usb: usbip: add missing device lock on tweak configuration cmd

Niklas Cassel (1):
      binfmt_flat: do not stop relocating GOT entries prematurely on riscv

Nikos Tsironis (1):
      dm era: commit metadata in postsuspend after worker stops

Nuno Sá (1):
      of: overlay: do not break notify on NOTIFY_{OK|STOP}

OGAWA Hirofumi (1):
      fat: add ratelimit to fat*_ent_bread()

Oleksandr Tyshchenko (1):
      xen/arm: Fix race in RB-tree based P2M accounting

Oliver Hartkopp (1):
      can: bcm: use call_rcu() instead of costly synchronize_rcu()

Oliver Neukum (2):
      usbnet: fix memory allocation in helpers
      usbnet: fix memory leak in error case

Olivier Matz (2):
      ixgbe: fix bcast packets Rx on VF after promisc removal
      ixgbe: fix unexpected VLAN Rx in promisc mode on VF

Pablo Neira Ayuso (2):
      netfilter: nf_tables: disallow non-stateful expression in sets earlier
      netfilter: nft_dynset: restore set element counter when failing to update

Pali Rohár (1):
      irqchip/armada-370-xp: Do not touch Performance Counter Overflow on A375, A38x, A39x

Pascal Hambourg (1):
      md/raid0: Ignore RAID0 layout if the second zone has only one device

Pavel Skripkin (1):
      media: pvrusb2: fix array-index-out-of-bounds in pvr2_i2c_core_init

Pawan Gupta (10):
      Documentation: Add documentation for Processor MMIO Stale Data
      x86/speculation/mmio: Enumerate Processor MMIO Stale Data bug
      x86/speculation: Add a common function for MD_CLEAR mitigation update
      x86/speculation/mmio: Add mitigation for Processor MMIO Stale Data
      x86/bugs: Group MDS, TAA & Processor MMIO Stale Data mitigations
      x86/speculation/mmio: Enable CPU Fill buffer clearing on idle
      x86/speculation/mmio: Add sysfs reporting for Processor MMIO Stale Data
      x86/speculation/srbds: Update SRBDS mitigation selection
      x86/speculation/mmio: Reuse SRBDS mitigation for SBDS
      KVM: x86/speculation: Disable Fill buffer clear within guests

Peilin Ye (1):
      net/sched: sch_netem: Fix arithmetic in netem_dump() for 32-bit platforms

Peng Wu (2):
      ARM: versatile: Add missing of_node_put in dcscb_init
      ARM: hisi: Add missing of_node_put after of_find_compatible_node

Petr Machata (2):
      mlxsw: spectrum_dcb: Do not warn about priority changes
      mlxsw: spectrum_cnt: Reorder counter pools

Phil Elwell (1):
      ARM: dts: bcm2835-rpi-zero-w: Fix GPIO line name for Wifi/BT

Qi Zheng (1):
      tty: fix deadlock caused by calling printk() under tty_port->lock

Qu Wenruo (2):
      btrfs: add "0x" prefix for unsupported optional features
      btrfs: repair super block num_devices automatically

Randy Dunlap (7):
      x86: Fix return value of __setup handlers
      x86/mm: Cleanup the control_va_addr_alignment() __setup handler
      powerpc/8xx: export 'cpm_setbrg' for modules
      powerpc/idle: Fix return value of __setup() handler
      powerpc/4xx/cpm: Fix return value of __setup() handler
      pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards
      RISC-V: fix barrier() use in <vdso/processor.h>

Rasmus Villemoes (3):
      drivers/char/random.c: constify poolinfo_table
      drivers/char/random.c: remove unused stuct poolinfo::poolbits
      drivers/char/random.c: make primary_crng static

Ravi Bangoria (1):
      perf/amd/ibs: Use interrupt regs ip for stack unwinding

Rhett Aultman (1):
      can: gs_usb: gs_usb_open/close(): fix memory leak

Richard Henderson (7):
      x86: Remove arch_has_random, arch_has_random_seed
      powerpc: Remove arch_has_random, arch_has_random_seed
      s390: Remove arch_has_random, arch_has_random_seed
      linux/random.h: Remove arch_has_random, arch_has_random_seed
      linux/random.h: Use false with bool
      linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
      powerpc: Use bool in archrandom.h

Rick Lindsley (1):
      ibmvnic: Properly dispose of all skbs during a failover.

Robert Eckelmann (1):
      USB: serial: io_ti: add Agilent E5805A support

Roger Pau Monne (4):
      xen/blkfront: fix leaking data in shared pages
      xen/netfront: fix leaking data in shared pages
      xen/netfront: force data bouncing when backend is untrusted
      xen/blkfront: force data bouncing when backend is untrusted

Sabrina Dubroca (1):
      esp: limit skb_page_frag_refill use to a single page

Samuel Holland (2):
      clocksource/drivers/riscv: Events are stopped during CPU suspend
      pinctrl: sunxi: a83t: Fix NAND function name for some pins

Satish Nagireddy (1):
      i2c: cadence: Unregister the clk notifier in error path

Schspa Shi (1):
      random: fix typo in comments

Sebastian Andrzej Siewior (1):
      random: remove unused irq_flags argument from add_interrupt_randomness()

Sergey Senozhatsky (1):
      char/random: silence a lockdep splat with printk()

Sergey Shtylyov (2):
      ata: libata-transport: fix {dma|pio|xfer}_mode sysfs files
      ata: libata-core: fix NULL pointer deref in ata_host_alloc_pinfo()

Shuah Khan (4):
      misc: rtsx: set NULL intfdata when probe fails
      misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
      misc: rtsx_usb: use separate command and response buffers
      misc: rtsx_usb: set return value in rsp_buf alloc err path

Shyam Prasad N (1):
      cifs: return errors during session setup during reconnects

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV31 with new baseline

Smith, Kyle Miller (Nimble Kernel) (1):
      nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags

Stefan Wahren (1):
      ARM: dts: bcm2835-rpi-b: Fix GPIO line names

Stephan Gerhold (1):
      virtio_net: fix xdp_rxq_info bug after suspend/resume

Stephan Mueller (1):
      crypto: drbg - add FIPS 140-2 CTRNG for noise source

Stephan Müller (2):
      crypto: drbg - always seeded with SP800-90B compliant noise source
      crypto: drbg - always try to free Jitter RNG instance

Stephen Boyd (2):
      random: Support freezable kthreads in add_hwgenerator_randomness()
      random: Use wait_event_freezable() in add_hwgenerator_randomness()

Steven Price (1):
      drm/plane: Move range check for format_count earlier

Takashi Iwai (2):
      ALSA: hda/via: Fix missing beep setup
      ALSA: hda/conexant: Fix missing beep setup

Tejun Heo (1):
      blk-iolatency: Fix inflight count imbalances and IO hangs on offline

Theodore Ts'o (2):
      random: only read from /dev/random after its pool has received 128 bits
      random: fix soft lockup when trying to read from an uninitialized blocking pool

Thibaut VARÈNE (1):
      ath9k: fix QCA9561 PA bias level

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo PD70PNT

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Move and rename chip_check/chip_ready/chip_good_for_write
      mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N

Tony Lindgren (1):
      bus: ti-sysc: Fix warnings for unbind for serial

Tony Luck (1):
      x86/cpu: Add Lakefield, Alder Lake and Rocket Lake models to the to Intel CPU family

Trond Myklebust (3):
      NFSv4/pNFS: Do not fail I/O when we fail to allocate the pNFS layout
      NFSv4: Don't hold the layoutget locks across multiple RPC calls
      pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVAILABLE

Uwe Kleine-König (1):
      pwm: lp3943: Fix duty calculation in case period was clamped

Vasily Averin (1):
      tracing: incorrect isolate_mote_t cast in mm_vmscan_lru_isolate

Vasily Gorbik (1):
      latent_entropy: avoid build error when plugin cflags are not set

Venky Shankar (1):
      ceph: allow ceph.dir.rctime xattr to be updatable

Vincent Whitchurch (3):
      um: Fix out-of-bounds read in LDT setup
      tty: goldfish: Fix free_irq() on remove
      iio: trigger: sysfs: fix use-after-free on remove

Vinod Polimera (1):
      drm/msm/disp/dpu1: set vbif hw config to NULL to avoid use after memory free during pm runtime resume

Vladimir Oltean (4):
      net: mscc: ocelot: allow unregistered IP multicast flooding
      selftests: forwarding: fix flood_unicast_test when h2 supports IFF_UNICAST_FLT
      selftests: forwarding: fix learning_test when h1 supports IFF_UNICAST_FLT
      selftests: forwarding: fix error message in learning_test

Wang Cheng (1):
      staging: rtl8712: fix uninit-value in r871xu_drv_init()

Wang Weiyang (1):
      tty: goldfish: Use tty_port_destroy() to destroy port

Wang Yufen (1):
      ipv6: Fix signed integer overflow in l2tp_ip6_sendmsg

Wenli Looi (1):
      ath9k: fix ar9003_get_eepmisc

Wentao Wang (1):
      scsi: vmw_pvscsi: Expand vcpuHint to 16 bits

Willem de Bruijn (1):
      ip_gre: test csum_start instead of transport header

Willy Tarreau (5):
      tcp: use different parts of the port_offset for index and offset
      tcp: add small random increments to the source port
      tcp: dynamically allocate the perturb table used by source ports
      tcp: increase source port perturb table to 2^16
      tcp: drop the hash_32() part from the index calculation

Xiao Yang (1):
      RDMA/rxe: Generate a completion for unsupported/invalid opcode

Xiaohui Zhang (1):
      nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred

Xiaoke Wang (1):
      iio: dummy: iio_simple_dummy: check the return value of kstrdup()

Xiaomeng Tong (8):
      media: uvcvideo: Fix missing check to determine if element is found in list
      scsi: dc395x: Fix a missing check on list iterator
      drm/nouveau/clk: Fix an incorrect NULL check on list iterator
      md: fix an incorrect NULL check in does_sb_need_changing
      md: fix an incorrect NULL check in md_reload_sb
      iommu/msm: Fix an incorrect NULL check on list iterator
      carl9170: tx: fix an incorrect use of list iterator
      gma500: fix an incorrect NULL check on list iterator

Xie Yongji (1):
      vringh: Fix loop descriptors check in the indirect cases

Xu Yang (1):
      usb: chipidea: udc: check request status before setting device address

Yang Yingliang (6):
      drm/msm/hdmi: check return value after calling platform_get_resource_byname()
      drm/rockchip: vop: fix possible null-ptr-deref in vop_bind()
      ASoC: wm2000: fix missing clk_disable_unprepare() on error in wm2000_anc_transition()
      rtc: mt6397: check return value after calling platform_get_resource()
      video: fbdev: pxa3xx-gcu: release the resources correctly in pxa3xx_gcu_probe/remove()
      hwmon: (ibmaem) don't call platform_device_del() if platform_device_add() fails

Yangtao Li (5):
      random: remove unnecessary unlikely()
      random: convert to ENTROPY_BITS for better code readability
      random: Add and use pr_fmt()
      random: fix typo in add_timer_randomness()
      random: remove some dead code of poolinfo

Ye Bin (2):
      ext4: fix use-after-free in ext4_rename_dir_prepare
      ext4: fix bug_on in ext4_writepages

Yevhen Orlov (1):
      net: bonding: fix use-after-free after 802.3ad slave unbind

Yian Chen (1):
      iommu/vt-d: Fix PCI bus rescan device hot add

Yicong Yang (1):
      PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()

Ying Hsu (1):
      Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout

Yong Wu (1):
      iommu/mediatek: Add list_del in mtk_iommu_remove

Yonglin Tan (1):
      USB: serial: option: add Quectel EM05-G modem

Yu Kuai (3):
      nbd: call genl_unregister_family() first in nbd_cleanup()
      nbd: fix race between nbd_alloc_config() and module removal
      nbd: fix io hung while disconnecting device

Yu Xiao (1):
      nfp: only report pause frame configuration for physical device

YueHaibing (1):
      net: ipv6: unexport __init-annotated seg6_hmac_net_init()

Zhang Rui (1):
      x86/cpu: Add Jasper Lake to Intel family

Zhang Yi (1):
      ext4: add reserved GDT blocks check

Zhen Ni (1):
      USB: host: isp116x: check return value after calling platform_get_resource()

Zheng Yongjun (2):
      spi: img-spfi: Fix pm_runtime_get_sync() error checking
      usb: dwc3: pci: Fix pm_runtime_get_sync() error checking

Zhengjun Xing (1):
      perf jevents: Fix event syntax error caused by ExtSel

Zheyu Ma (4):
      media: pci: cx23885: Fix the error handling in cx23885_initdev()
      media: cx25821: Fix the warning when removing the module
      tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()
      iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()

Zhihao Cheng (2):
      fs-writeback: writeback_sb_inodes：Recalculate 'wrote' according skipped pages
      ubi: ubi_create_volume: Fix use-after-free when volume creation failed

Zixuan Fu (1):
      fs: jfs: fix possible NULL pointer dereference in dbFree()

bumwoo lee (1):
      extcon: Modify extcon device to be created after driver data is set

chengkaitao (1):
      virtio-mmio: fix missing put_device() when vm_cmdline_parent registration failed

huangwenhui (1):
      ALSA: hda/conexant - Fix loopback issue with CX20632

huhai (1):
      MIPS: Remove repetitive increase irq_err_count

jianghaoran (1):
      ipv6: Don't send rs packets to the interface of ARPHRD_TUNNEL

katrinzhou (1):
      ipv6/sit: fix ipip6_tunnel_get_prl return value

kernel test robot (1):
      sit: use min
