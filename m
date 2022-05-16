Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F0527B51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 03:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiEPBQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 21:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiEPBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 21:16:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7410F1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:16:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z2so25860150ejj.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=98v1dVoCePH42vT3PcHkl80kc780pKR0G3Qhpjud5Cw=;
        b=Uc3N0rcsx21hFr3eNh8+4ZkfKsYCk5wo++AZLy2iKRno18PK3tu3bxA0yPwF7LjLKW
         dwz/60vLunORBcwdh1qi6maTZp0FmTDW75T1t+urFeFNs3a3ZLjeuKNZn5sAvg+PBYjm
         P/SYLea5UzEgLlPl5zvhlRZyYepHcQaNBBHAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=98v1dVoCePH42vT3PcHkl80kc780pKR0G3Qhpjud5Cw=;
        b=CvaeI+jcz8UgoVuUAKtoMRqht4ZPUZqCTsrG5rQIyJMyUqBp9SBKdjH38unnyu16om
         FXcu1F2bRGnGvCvNB75LpqrY9N5Tr3EnzrhsiZsqJy3LdkZND/wmDoIIedolZB9L/zCA
         BpBsUkvrcKwHPpuT+xMlFre7ITpNY6oWQb4uBhOlXBmMOONzfWv1Zc2bQpLty/ZIvGDX
         aHu2BbnnCWBqmRapJ7etPDwBQXdkNLZCDZuU58bn+DBikzxn9LuLjusTeexU/O29k+1g
         Ppk2Lc3E7w5mEHRkxdKje9McXIDNoEnu1JBnjp6lW2CkFP+GPGYhEJTtAfMnJg9yAQE+
         +2cg==
X-Gm-Message-State: AOAM531xEXKBhFbNR1WY2wnzORPK+S0qeQzIHY1kAGmNp1pw0HIpACxf
        WYdKakssQln63MUOM4d1dD9cnM9aHwuDFEVd
X-Google-Smtp-Source: ABdhPJxrkE4EI2U2NK+l6OCKSoeNHrZyv58p/9XEK5HLSUD0OkAKP322uGOFirVg7B97JqucDBFTag==
X-Received: by 2002:a17:907:2d22:b0:6f4:a36f:517d with SMTP id gs34-20020a1709072d2200b006f4a36f517dmr13512065ejc.686.1652663760018;
        Sun, 15 May 2022 18:16:00 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id d11-20020a50fe8b000000b0042ab0cac42asm963676edt.27.2022.05.15.18.15.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 18:15:59 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so10050958wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:15:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:394:836b:1552 with SMTP id
 l6-20020a05600c4f0600b00394836b1552mr24785197wmq.145.1652663758802; Sun, 15
 May 2022 18:15:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 May 2022 18:15:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2eVUN0a1E5UnBF1ziGaU1yrMJtnFPg4R78O=FcRDqnA@mail.gmail.com>
Message-ID: <CAHk-=wg2eVUN0a1E5UnBF1ziGaU1yrMJtnFPg4R78O=FcRDqnA@mail.gmail.com>
Subject: Linux 5.18-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So things continue to be fairly calm, and as such this is likely the
last rc before 5.18 unless something bad happens next week.

All the stats here look normal, with the bulk of it being random
driver updates (network drivers, gpu, usb, etc).

There's a few filesystem fixes, some core networking, and some code
kernel stuff. And some selftest updates.

Sortlog appended, nothing really stands out (the most exciting thing
last week was literally that Andrew has started using git, which will
make my life easier, but that doesn't affect the *code*)

Please give it one last week of testing, so that we'll have a nice
solid 5.18 release.

                 Linus

---

Adrian-Ken Rueegsegger (1):
      x86/mm: Fix marking of unused sub-pmd ranges

Alex Deucher (2):
      Revert "drm/amd/pm: keep the BACO feature enabled for suspend"
      drm/amdgpu/ctx: only reset stable pstate if the user changed it (v2)

Alexander Graf (1):
      KVM: PPC: Book3S PR: Enable MSR_DR for switch_mmu_context()

Alexandra Winter (3):
      s390/ctcm: fix variable dereferenced before check
      s390/ctcm: fix potential memory leak
      s390/lcs: fix variable dereferenced before check

Amir Goldstein (1):
      fanotify: do not allow setting dirent events in mask of non-dir

Amit Cohen (1):
      mlxsw: Avoid warning during ip6gre device removal

Anatolii Gerasymenko (1):
      ice: clear stale Tx queue settings before configuring

Andreas Gruenbacher (7):
      gfs2: Fix filesystem block deallocation for short writes
      gfs2: Variable rename
      gfs2: Clean up use of fault_in_iov_iter_{read,write}able
      gfs2: Pull return value test out of should_fault_in_pages
      gfs2: Align read and write chunks to the page cache
      gfs2: buffered write prefaulting
      gfs2: Stop using glock holder auto-demotion for now

AngeloGioacchino Del Regno (3):
      serial: 8250_mtk: Fix UART_EFR register address
      serial: 8250_mtk: Make sure to select the right FEATURE_SEL
      serial: 8250_mtk: Fix register address for XON/XOFF character

Arnaldo Carvalho de Melo (1):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources

Brian Bunker (1):
      scsi: scsi_dh_alua: Properly handle the ALUA transitioning state

Camel Guo (1):
      hwmon: (tmp401) Add OF device ID table

Catalin Marinas (1):
      Documentation/process: Update ARM contact for embargoed hardware issu=
es

Charan Teja Reddy (1):
      dma-buf: call dma_buf_stats_setup after dmabuf is in valid list

ChiYuan Huang (1):
      usb: typec: tcpci_mt6360: Update for BMC PHY setting

Christophe JAILLET (1):
      drm/nouveau: Fix a potential theorical leak in
nouveau_get_backlight_name()

Chunfeng Yun (2):
      usb: xhci-mtk: fix fs isoc's transfer error
      usb: xhci-mtk: remove bandwidth budget table

Dan Aloni (1):
      nfs: fix broken handling of the softreval mount option

Dan Vacura (1):
      usb: gadget: uvc: allow for application to cleanly shutdown

Daniel Starke (3):
      tty: n_gsm: fix buffer over-read in gsm_dlci_data()
      tty: n_gsm: fix mux activation issues in gsm_config()
      tty: n_gsm: fix invalid gsmtty_write_room() result

Daniel Vetter (1):
      fbdev: Prevent possible use-after-free in fb_release()

Darren Hart (2):
      Documentation/process: Make groups alphabetical and use tabs consiste=
ntly
      Documentation/process: Add embargoed HW contact for Ampere Computing

Delyan Kratunov (1):
      sched/tracing: Append prev_state to tp args instead

Eric Dumazet (1):
      netlink: do not reset transport header in netlink_recvmsg()

Eric Yang (1):
      drm/amd/display: undo clearing of z10 related function pointers

Ethan Yang (1):
      USB: serial: qcserial: add support for Sierra Wireless EM7590

Fabio Estevam (2):
      net: phy: micrel: Do not use kszphy_suspend/resume for KSZ8061
      net: phy: micrel: Pass .probe for KS8737

Felix Fietkau (1):
      mac80211: fix rx reordering with non explicit / psmp ack policy

Florian Fainelli (2):
      net: bcmgenet: Check for Wake-on-LAN interrupt probe deferral
      net: dsa: bcm_sf2: Fix Wake-on-LAN with mac_link_down()

Francesco Dolcini (1):
      net: phy: Fix race condition on link status change

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix missed DMA unmap for aborted commands

Gleb Fotengauer-Malinovskiy (1):
      rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE ioctl request definition

Grant Grundler (4):
      net: atlantic: fix "frag[0] not initialized"
      net: atlantic: reduce scope of is_rsc_complete
      net: atlantic: add check for MAX_SKB_FRAGS
      net: atlantic: verify hw_head_ lies within TX buffer ring

Gregory Greenman (1):
      MAINTAINERS: update iwlwifi driver maintainer

Guangguan Wang (1):
      net/smc: non blocking recvmsg() return -EAGAIN when no data and
signal_pending

Guenter Roeck (1):
      iwlwifi: iwl-dbg: Use del_timer_sync() before freeing

Hui Tang (1):
      drm/vc4: hdmi: Fix build error for implicit function declaration

Hyeonggon Yoo (1):
      mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool

Ian Rogers (1):
      perf bench: Fix two numa NDEBUG warnings

Indan Zupancic (1):
      fsl_lpuart: Don't enable interrupts too early

Itay Iellin (1):
      Bluetooth: Fix the creation of hdev->name

Ivan Vecera (1):
      ice: Fix race during aux device (un)plugging

James Smart (2):
      scsi: lpfc: Fix split code for FLOGI on FCoE
      scsi: lpfc: Correct BDE DMA address assignment for GEN_REQ_WQE

Jan Kara (1):
      udf: Avoid using stale lengthOfImpUse

Javier Martinez Canillas (5):
      Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregist=
ered"
      fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
      fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
      fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove
      fbdev: efifb: Fix a use-after-free due early fb_info cleanup

Jeff Layton (1):
      ceph: fix setting of xattrs on async created inodes

Jeremy Linton (1):
      perf tests: Fix coresight `perf test` failure.

Jesse Brandeburg (1):
      dim: initialize all struct fields

Jing Xia (1):
      writeback: Avoid skipping inode writeback

Joel Savitz (1):
      selftests: vm: Makefile: rename TARGETS to VMTARGETS

Joey Gouly (1):
      arm64: vdso: fix makefile dependency on vdso.so

Johannes Berg (3):
      mac80211_hwsim: fix RCU protected chanctx access
      mac80211_hwsim: call ieee80211_tx_prepare_skb under RCU protection
      nl80211: fix locking in nl80211_set_tx_bitrate_mask()

Jonathan Lemon (1):
      ptp: ocp: Use DIV64_U64_ROUND_UP for rounding.

Jonathan Toppins (1):
      MAINTAINERS: add missing files for bonding definition

Kalesh Singh (1):
      procfs: prevent unprivileged processes accessing fdinfo dir

Kalle Valo (1):
      mailmap: update Kalle Valo's email

Karol Herbst (1):
      drm/i915: Fix race in __i915_vma_remove_closed

Kees Cook (2):
      net: chelsio: cxgb4: Avoid potential negative array offset
      decnet: Use container_of() for struct dn_neigh casts

Kieran Frewen (2):
      nl80211: validate S1G channel width
      cfg80211: retrieve S1G operating channel number

Kristina Martsenko (1):
      arm64: cpufeature: remove duplicate ID_AA64ISAR2_EL1 entry

Lina Wang (2):
      net: fix wrong network header length
      selftests net: add UDP GRO fraglist + bpf self-tests

Linus Torvalds (1):
      Linux 5.18-rc7

Lokesh Dhoundiyal (1):
      ipv4: drop dst in multicast routing path

Lukas Wunner (1):
      genirq: Remove WARN_ON_ONCE() in generic_handle_domain_irq()

Manikanta Pubbisetty (1):
      mac80211: Reset MBSSID parameters upon connection

Manuel Ullmann (1):
      net: atlantic: always deep reset on pm op, fixing up my null
deref regression

Mario Limonciello (2):
      platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
      platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a
number of laptops

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Correct dual fan probe

Martyna Szapar-Mudlaw (1):
      mailmap: add entry for martyna.szapar-mudlaw@intel.com

Mathieu Poirier (1):
      MAINTAINERS: Add James and Mike as Arm64 performance events reviewers

Maxim Mikityanskiy (1):
      tls: Fix context leak on tls_device_down

Maximilian Luz (2):
      platform/surface: gpe: Add support for Surface Pro 8
      platform/surface: aggregator: Fix initialization order when
compiling as builtin module

Miaoqian Lin (1):
      slimbus: qcom: Fix IRQ check in qcom_slim_probe

Michal Michalik (1):
      ice: fix PTP stale Tx timestamps cleanup

Mike Rapoport (1):
      arm[64]/memremap: don't abuse pfn_valid() to ensure presence of linea=
r map

Naoya Horiguchi (1):
      mm/hwpoison: use pr_err() instead of dump_page() in get_any_page()

Nicolas Dichtel (2):
      ping: fix address binding wrt vrf
      selftests: add ping test with ping_group_range tuned

Niels Dossche (1):
      mm: mremap: fix sign for EFAULT error return value

Paolo Abeni (1):
      net/sched: act_pedit: really ensure the skb is writable

Prarit Bhargava (1):
      platform/x86/intel: Fix 'rmmod pmt_telemetry' panic

Randy Dunlap (1):
      hwmon: (ltq-cputemp) restrict it to SOC_XWAY

Richard Gong (1):
      drm/amdgpu: vi: disable ASPM on Intel Alder Lake based systems

Robin Murphy (1):
      drm/nouveau/tegra: Stop using iommu_present()

Schspa Shi (1):
      usb: gadget: fix race when gadget driver register via ioctl

Scott Chen (1):
      USB: serial: pl2303: add device id for HP LM930 Display

SeongJae Park (1):
      MAINTAINERS: add a mailing list for DAMON development

Sergey Ryazanov (1):
      usb: cdc-wdm: fix reading stuck on device close

Shreyas K K (1):
      arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs

Shunsuke Mie (1):
      virtio: fix virtio transitional ids

Stephen Boyd (1):
      interconnect: Restore sync state by ignoring ipa-virt in provider cou=
nt

Sven Eckelmann (1):
      batman-adv: Don't skb_split skbuffs with frag_list

Sven Schwermer (2):
      USB: serial: option: add Fibocom L610 modem
      USB: serial: option: add Fibocom MA510 modem

Taehee Yoo (2):
      net: sfc: fix memory leak due to ptp channel
      net: sfc: ef10: fix memory leak in efx_ef10_mtd_probe()

Tariq Toukan (1):
      net: Fix features skip in for_each_netdev_feature()

Tetsuo Handa (1):
      net: rds: use maybe_get_net() when acquiring refcount on TCP sockets

Thi=C3=A9baud Weksteen (1):
      firmware_loader: use kernel credentials when reading firmware

Trond Myklebust (2):
      Revert "SUNRPC: Ensure gss-proxy connects on setup"
      SUNRPC: Ensure that the gssproxy client can start in a connected stat=
e

Uwe Kleine-K=C3=B6nig (1):
      usb: typec: tcpci: Don't skip cleanup in .remove() on error

Vladimir Oltean (6):
      net: mscc: ocelot: mark traps with a bool instead of keeping
them in a list
      net: mscc: ocelot: fix last VCAP IS1/IS2 filter persisting in
hardware when deleted
      net: mscc: ocelot: fix VCAP IS2 filters matching on both lookups
      net: mscc: ocelot: restrict tc-trap actions to VCAP IS2 lookup 0
      net: mscc: ocelot: avoid corrupting hardware counters when
moving VCAP filters
      net: dsa: flush switchdev workqueue on bridge join error path

Waiman Long (1):
      cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in cpuset_init_=
smp()

Wan Jiabing (1):
      net: phy: micrel: Fix incorrect variable type in micrel

Wen Gong (1):
      ath11k: reduce the wait time of 11d scan and hw scan while add interf=
ace

Xiaomeng Tong (1):
      i40e: i40e_main: fix a missing check on list iterator

Xiubo Li (1):
      ceph: check folio PG_private bit instead of folio->private

Xu Yu (2):
      Revert "mm/memory-failure.c: skip huge_zero_page in memory_failure()"
      mm/huge_memory: do not overkill when splitting huge_zero_page

Yang Yingliang (5):
      tty/serial: digicolor: fix possible null-ptr-deref in
digicolor_uart_probe()
      ionic: fix missing pci_release_regions() on error in ionic_probe()
      ethernet: tulip: fix missing pci_disable_device() on error in
tulip_init_one()
      net: stmmac: fix missing pci_disable_device() on error in
stmmac_pci_probe()
      net: ethernet: mediatek: ppe: fix wrong size passed to memset()

Zack Rusin (3):
      drm/vmwgfx: Fix fencing on SVGAv3
      drm/vmwgfx: Initialize drm_mode_fb_cmd2
      drm/vmwgfx: Disable command buffers on svga3 without gbobjects
