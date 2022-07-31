Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFF586192
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiGaVn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 17:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 17:43:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0045E6301
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:43:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gk3so5017123ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=NDYQ4DbinmXluuY6wqBBmgRDLqMkQZCsq7SAzwRumPA=;
        b=gDCR/QeD5wA6a0unWoPYAiYjsA23CGpgkJ4ilOwvIknbJGkhbT4NjfPjZ51PX3VXfp
         tbxsi9ZyHz4hL1KdFOTRNjfXhzVUYbWrteJhtKv7liLgn12WAycTluljRFy3LxDafM5O
         NwQpQi5WA2kxtF9JHdlHKLtPhBG75A9F62YoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=NDYQ4DbinmXluuY6wqBBmgRDLqMkQZCsq7SAzwRumPA=;
        b=Q/CW/uiZBYL7QbkGOyUaZmMY47arEyCdYFLQSoTxkr4d4rX9JWw4MqlxCpFffTXpY7
         OcLhK0yJZFEsIDUg89sYxVcTdpC3L15lM7lH7xhbUTOCh6hYv1aQc9iNPfko6RwRbbHv
         weLgo2z3joY18QvLshbiLIUCiv0Nnc0RyyHQ/bSoAAenTvbvvJCQinYdslUgksUXdF23
         xK9fTJVHKzRJxt26IYjKu0rjb3h1OpS640bZVAGcCN+/JeAsfl3oSCnzXtCfUG083/vO
         lEXDtyBct6QCe4ckjHLN+FbqgNF/OxF1At5gNTX2Vo2XKpFX9DEWmTtA+Sp/QD51YorB
         szgA==
X-Gm-Message-State: ACgBeo1b8QxETGeDxN15SM0rjU5xuLz89yYP5FhIUCLd+PWPHUE2iZdm
        1Oui7y4wug7YA/CyWw+4563WwMwpa8lZNGAXU1w=
X-Google-Smtp-Source: AA6agR4/hK2YXZoDrMHku1hNA0FNg6ZRlN3lYreXuI+hja/gkLiwaSnG7pe4A+EtviS9+ZGvRZkCJg==
X-Received: by 2002:a17:907:2d0c:b0:730:86ec:d536 with SMTP id gs12-20020a1709072d0c00b0073086ecd536mr1255786ejc.391.1659303800251;
        Sun, 31 Jul 2022 14:43:20 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b0043ca6fb7e7dsm5726755edx.68.2022.07.31.14.43.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 14:43:19 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id b6so4931827wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:43:19 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr9211421wmf.38.1659303799250; Sun, 31 Jul
 2022 14:43:19 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 14:43:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Message-ID: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Subject: Linux 5.19
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, one week late, and 5.19 is tagged and pushed out.

The full shortlog (just from rc8, obviously not all of 5.19) is below,
but I can happily report that there is nothing really interesting in
there. A lot of random small stuff.

In the diffstat, the loongarch updates stand out, as does another
batch of the networking sysctl READ_ONCE() annotations to make some of
the data race checker code happy.

Other than that it's really just a mixed bag of various odds and ends.

On a personal note, the most interesting part here is that I did the
release (and am writing this) on an arm64 laptop. It's something I've
been waiting for for a _loong_ time, and it's finally reality, thanks
to the Asahi team. We've had arm64 hardware around running Linux for a
long time, but none of it has really been usable as a development
platform until now.

It's the third time I'm using Apple hardware for Linux development - I
did it many years ago for powerpc development on a ppc970 machine.
And then a decade+ ago when the Macbook Air was the only real
thin-and-lite around. And now as an arm64 platform.

Not that I've used it for any real work, I literally have only been
doing test builds and boots and now the actual release tagging. But
I'm trying to make sure that the next time I travel, I can travel with
this as a laptop and finally dogfooding the arm64 side too.

Anyway, regardless of all that, this obviously means that the merge
window (*) will open tomorrow. But please give this a good test run
before you get all excited about a new development kernel.

              Linus

(*) I'll likely call it 6.0 since I'm starting to worry about getting
confused by big numbers again.

---

Abhishek Pandit-Subedi (1):
      Bluetooth: Always set event mask on suspend

Alejandro Lucero (1):
      sfc: disable softirqs for ptp TX

Alistair Popple (1):
      nouveau/svm: Fix to migrate all requested pages

Andrei Vagin (1):
      fs: sendfile handles O_NONBLOCK of out_fd

Anirudh Venkataramanan (1):
      ice: Fix VSIs unable to share unicast MAC

Arnaldo Carvalho de Melo (1):
      tools headers cpufeatures: Sync with the kernel sources

Baolin Wang (1):
      mailmap: update Baolin Wang's email

Bart Van Assche (1):
      scsi: ufs: core: Fix a race condition related to device management

Benjamin Poirier (1):
      bridge: Do not send empty IFLA_AF_SPEC attribute

Bibo Mao (2):
      LoongArch: Remove clock setting during cpu hotplug stage
      LoongArch: Remove unused variables

Borislav Petkov (1):
      Revert "x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV"

ChenXiaoSong (1):
      ntfs: fix use-after-free in ntfs_ucsncmp()

Christophe JAILLET (1):
      caif: Fix bitmap data type in "struct caifsock"

Dan Carpenter (2):
      Bluetooth: mgmt: Fix double free on error path
      stmmac: dwmac-mediatek: fix resource leak in probe

David Howells (1):
      watch_queue: Fix missing rcu annotation

David Jeffery (1):
      scsi: mpt3sas: Stop fw fault watchdog work item during system shutdown

Dimitris Michailidis (1):
      net/funeth: Fix fun_xdp_tx() and XDP packet reclaim

Duoming Zhou (1):
      sctp: fix sleep in atomic context bug in timer handlers

Eiichi Tsukata (1):
      docs/kernel-parameters: Update descriptions for "mitigations="
param with retbleed

Emil Renner Berthing (1):
      riscv: compat: vdso: Fix vdso_install target

Eric Dumazet (1):
      tcp: md5: fix IPv4-mapped support

Florian Fainelli (2):
      tools: Fixed MIPS builds due to struct flock re-definition
      ARM: 9216/1: Fix MAX_DMA_ADDRESS overflow

Florian Westphal (3):
      netfilter: nf_queue: do not allow packet truncation below
transport header offset
      netfilter: nf_tables: add rescheduling points during loop detection walks
      netfilter: nft_queue: only allow supported familes and hooks

Gao Xiang (1):
      mailmap: update Gao Xiang's email addresses

Harald Freudenberger (1):
      s390/archrandom: prevent CPACF trng invocations in interrupt context

Huacai Chen (2):
      LoongArch: Disable executable stack by default
      LoongArch: Fix shared cache size calculation

Ian Rogers (1):
      perf bpf: Remove undefined behavior from bpf_perf_object__next()

Jaewon Kim (1):
      page_alloc: fix invalid watermark check on a negative value

Jason Wang (1):
      virtio-net: fix the race between refill work and close

Jason Yan (1):
      scsi: core: Fix warning in scsi_alloc_sgtables()

Jernej Skrabec (1):
      clk: sunxi-ng: Fix H6 RTC clock definition

Jianglei Nie (1):
      net: macsec: fix potential resource leak in macsec_add_rxsa()
and macsec_add_txsa()

Jonathan Lemon (1):
      ptp: ocp: Select CRC16 in the Kconfig.

Josef Bacik (1):
      mm: fix page leak with multiple threads mapping the same page

Jun Yi (1):
      LoongArch: Remove useless header compiler.h

Junxiao Bi (1):
      Revert "ocfs2: mount shared volume without ha stack"

Kuniyuki Iwashima (23):
      tcp: Fix data-races around sysctl_tcp_dsack.
      tcp: Fix a data-race around sysctl_tcp_app_win.
      tcp: Fix a data-race around sysctl_tcp_adv_win_scale.
      tcp: Fix a data-race around sysctl_tcp_frto.
      tcp: Fix a data-race around sysctl_tcp_nometrics_save.
      tcp: Fix data-races around sysctl_tcp_no_ssthresh_metrics_save.
      tcp: Fix data-races around sysctl_tcp_moderate_rcvbuf.
      tcp: Fix data-races around sysctl_tcp_workaround_signed_windows.
      tcp: Fix a data-race around sysctl_tcp_limit_output_bytes.
      tcp: Fix a data-race around sysctl_tcp_challenge_ack_limit.
      tcp: Fix a data-race around sysctl_tcp_min_tso_segs.
      tcp: Fix a data-race around sysctl_tcp_tso_rtt_log.
      tcp: Fix a data-race around sysctl_tcp_min_rtt_wlen.
      tcp: Fix a data-race around sysctl_tcp_autocorking.
      tcp: Fix a data-race around sysctl_tcp_invalid_ratelimit.
      tcp: Fix data-races around sk_pacing_rate.
      net: Fix data-races around sysctl_[rw]mem(_offset)?.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_delay_ns.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_slack_ns.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_nr.
      tcp: Fix data-races around sysctl_tcp_reflect_tos.
      ipv4: Fix data-races around sysctl_fib_notify_on_flag_change.
      net: ping6: Fix memleak in ipv6_renew_options().

Lai Jiangshan (1):
      workqueue: Avoid a false warning in unbind_workers()

Leo Yan (3):
      perf scripts python: Let script to be python2 compliant
      perf symbol: Correct address for bss symbols
      perf symbol: Skip symbols if SHF_ALLOC flag is not set

Liang He (2):
      net: sungem_phy: Add of_node_put() for reference returned by
of_get_parent()
      scsi: ufs: host: Hold reference returned by of_parse_phandle()

Linus Torvalds (2):
      watch_queue: Fix missing locking in add_watch_to_object()
      Linux 5.19

Linus Walleij (1):
      ARM: pxa2xx: Fix GPIO descriptor tables

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put

Lukas Bulwahn (2):
      asm-generic: remove a broken and needless ifdef conditional
      x86/configs: Update configs in x86_debug.config

Maciej Fijalkowski (2):
      ice: check (DD | EOF) bits on Rx descriptor rather than (EOP | RS)
      ice: do not setup vlan for loopback VSI

Mat Martineau (1):
      mptcp: Do not return EINPROGRESS when subflow creation succeeds

Maxim Mikityanskiy (1):
      net/tls: Remove the context from the list in tls_device_down

Miaohe Lin (1):
      hugetlb: fix memoryleak in hugetlb_mcopy_atomic_pte

Michael Ellerman (2):
      powerpc/64s: Disable stack variable initialisation for prom_init
      drm/amdgpu: Re-enable DCN for 64-bit powerpc

Michael Walle (1):
      ARM: dts: lan966x: fix sys_clk frequency

Michal Maloszewski (1):
      i40e: Fix interface init with MSI interrupts (no MSI-X)

Mike Rapoport (1):
      secretmem: fix unhandled fault in truncate

Muchun Song (1):
      mm: fix missing wake-up event for FSDAX pages

Nadav Amit (1):
      userfaultfd: provide properly masked address for huge-pages

Naoya Horiguchi (1):
      mm/hugetlb: separate path for hwpoison entry in copy_hugetlb_page_range()

Nathan Chancellor (1):
      drm/simpledrm: Fix return type of
simpledrm_simple_display_pipe_mode_valid()

Przemyslaw Patynowski (2):
      ice: Fix max VLANs available for VF
      ice: Fix tunnel checksum offload with fragmented traffic

Qi Hu (1):
      LoongArch: Fix missing fcsr in ptrace's fpr_set

Qi Zheng (1):
      mm: fix NULL pointer dereference in wp_page_reuse()

Ralph Campbell (1):
      mm/hmm: fault non-owner device private entries

Rob Herring (2):
      dt-bindings: net: ethernet-controller: Rework 'fixed-link' schema
      dt-bindings: net: fsl,fec: Add missing types to phy-reset-* properties

Russell King (Oracle) (1):
      ARM: findbit: fix overflowing offset

Sabrina Dubroca (4):
      macsec: fix NULL deref in macsec_add_rxsa
      macsec: fix error message in macsec_add_rxsa and _txsa
      macsec: limit replay window size with XPN
      macsec: always read MACSEC_SA_ATTR_PN as a u64

Seth Forshee (1):
      mailmap: update Seth Forshee's email address

Sherry Sun (2):
      EDAC/synopsys: Use the correct register to disable the error
interrupt on v3 hw
      EDAC/synopsys: Re-enable the error interrupts on v3 hw

Slark Xiao (3):
      nfp: bpf: Fix typo 'the the' in comment
      net: ipa: Fix typo 'the the' in comment
      s390/qeth: Fix typo 'the the' in comment

Subbaraya Sundeep (1):
      octeontx2-pf: Fix UDP/TCP src and dst port tc filters

Sunil Goutham (1):
      octeontx2-pf: cn10k: Fix egress ratelimit configuration

Taehee Yoo (1):
      net: mld: fix reference count leak in mld_{query | report}_work()

Tetsuo Handa (1):
      wifi: mac80211: do not abuse fq.lock in ieee80211_do_stop()

Thadeu Lima de Souza Cascardo (1):
      x86/bugs: Do not enable IBPB at firmware entry when IBPB is not available

Tiezhu Yang (1):
      LoongArch: Fix wrong "ROM Size" of boardinfo

Tobias Gruetzmacher (1):
      nvme-pci: Crucial P2 has bogus namespace ids

Toshi Kani (1):
      EDAC/ghes: Set the DIMM label unconditionally

Umesh Nerlige Ramappa (1):
      drm/i915/reset: Add additional steps for Wa_22011802037 for
execlist backend

Vladimir Oltean (2):
      net: pcs: xpcs: propagate xpcs_read error to xpcs_get_state_c37_sgmii
      net: dsa: fix reference counting for LAG FDBs

WANG Xuerui (8):
      LoongArch: Use ABI names of registers where appropriate
      LoongArch: Use the "jr" pseudo-instruction where applicable
      LoongArch: Use the "move" pseudo-instruction where applicable
      LoongArch: Simplify "BEQ/BNE foo, zero" with BEQZ/BNEZ
      LoongArch: Simplify "BLT foo, zero" with BLTZ
      LoongArch: Simplify "BGT foo, zero" with BGTZ
      LoongArch: Re-tab the assembly files
      LoongArch: Remove several syntactic sugar macros for branches

Waiman Long (2):
      intel_idle: Fix false positive RCU splats due to incorrect hardirqs state
      locking/rwsem: Allow slowpath writer to ignore handoff bit if
not set by first waiter

Wei Wang (1):
      Revert "tcp: change pingpong threshold to 3"

Xin Long (2):
      Documentation: fix sctp_wmem in ip-sysctl.rst
      sctp: leave the err path free in sctp_stream_init to sctp_stream_free

Yee Lee (1):
      mm: kfence: apply kmemleak_ignore_phys on early allocated pool

ZhaoLong Wang (1):
      tmpfs: fix the issue that the mount and remount results are inconsistent.

Ziyang Xuan (1):
      ipv6/addrconf: fix a null-ptr-deref bug for ip6_ptr
