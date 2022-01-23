Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437A3497462
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiAWSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbiAWSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:39:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E1C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:39:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d7so13466737plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rcyvME9NP0SbcE2gcLOE+VIy1txA6UyLEKtrd+SzH6g=;
        b=LhxN1cCZ2DcRQmONmp8s+xHtZBZE01nPCCUeldKjtqEJPqYTCRVxd0GJDzizWAxlts
         7xcfxlqiECbqB6VfZrEMPaN6lXIYfzI/51oeD5s6qK9ZxL9uZVFOy/Zj0WHSP2vXS3ZY
         Vw7reUqinISorbThc01iqs7Pbm5qzTEtuWSQHGzc7T+PD6zF8zR0nvTsjBisDy55Mi2O
         tcy4PuGUTcS/kG/ri5itMN+Keg5iJnWa8dJ2IK/y3aVAtiscoiKfz/VSDmLPrh4sog24
         nRSJgW5h9ncIjn2Jn5joC5dPRnf+yPjS8N8Bg97i4t7AWQZDqMqHrjUcGFYOoaGjTRj8
         d2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rcyvME9NP0SbcE2gcLOE+VIy1txA6UyLEKtrd+SzH6g=;
        b=yjSbOB68fehhbVIOd1MC15uciKZbXv80A6dMsDzbWOYspKtjf3n1IVFZYQ3zZ3dWBB
         APDdKo2cjWHO3MH2DZBfNk2Clsz1gjbwI91k2Kh75YN27x5Hrqi47ZmUKS5Dr4lH/Abv
         B5/9mA1XQTdV0505hdm4/3ZfGRo+UvfGl0S1+BDCFpmk5ZzRz8pCCA4wrxShYjbuWcK1
         P2auLFVPI0yXXoqhrbNzM3HZZLR8zGeewhNJjJIBwzSCW/DMS1l1fhpaGUc2CLJH/plx
         g/F0iFHY2fwP0XA2RoWEjE5nIqEI/HIWTltLXezJ/RWRLnY6W7ulPi5z/9587klKUKXx
         AK8g==
X-Gm-Message-State: AOAM532TBWqlxffJKQxFxFGcYgiUKkdtd93kyV+55i7Fei7zm/mi7IKm
        v3McEds4fIU2lmuZteeMrsI=
X-Google-Smtp-Source: ABdhPJxzkidVUoDp1okyc85snNtYC+JgyNA60CFHN7F6urt7Iu00O7o/niMV4kYd7wzYlSGiNaNLxQ==
X-Received: by 2002:a17:90b:ed6:: with SMTP id gz22mr6008091pjb.0.1642963188578;
        Sun, 23 Jan 2022 10:39:48 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id s23sm14499468pfg.144.2022.01.23.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:39:48 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/54] lib/bitmap: optimize bitmap_weight() usage 
Date:   Sun, 23 Jan 2022 10:38:31 -0800
Message-Id: <20220123183925.1052919-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases people use bitmap_weight()-based functions to compare
the result against a number of expression:

	if (cpumask_weight(mask) > 1)
		do_something();

This may take considerable amount of time on many-cpus machines because
cpumask_weight() will traverse every word of underlying cpumask
unconditionally.

We can significantly improve on it for many real cases if stop traversing
the mask as soon as we count cpus to any number greater than 1:

	if (cpumask_weight_gt(mask, 1))
		do_something();

The first part of series converts cpumask_weight() to cpumask_empty()
if the number to compare with is 0. Ditto for bitmap_weigth() and
nodes_weight().

In the 2nd part of the series bitmap_weight_cmp() is added together with
bitmap_weight_{eq,gt,ge,lt,le} wrappers on top of it. Corresponding
wrappers for cpumask and nodemask are added as well.

v1: https://lkml.org/lkml/2021/11/27/339
v2: https://lkml.org/lkml/2021/12/18/241
v3:
  - drop subseries for possible, present and active cpumasks. Will
    submit it separately if needed;
  - split patches per subsystems as requested by Greg and Michał;
  - trim the recipient list. Add drivers and arch maintainers to 
    corresponding patches only.

Yury Norov (54):
  net/dsa: don't use bitmap_weight() in b53_arl_read()
  net/ethernet: don't use bitmap_weight() in bcm_sysport_rule_set()
  thermal/intel: don't use bitmap_weight() in end_power_clamp()
  net: mellanox: fix open-coded for_each_set_bit()
  nds32: perf: replace bitmap_weight with bitmap_empty where appropriate
  x86/kvm: replace bitmap_weight with bitmap_empty where appropriate
  gpu: drm: replace bitmap_weight with bitmap_empty where appropriate
  net: ethernet: replace bitmap_weight with bitmap_empty for intel
  net: ethernet: replace bitmap_weight with bitmap_empty for Marvell
  net: ethernet: replace bitmap_weight with bitmap_empty for qlogic
  perf: replace bitmap_weight with bitmap_empty where appropriate
  tools/perf: replace bitmap_weight with bitmap_empty where appropriate
  arch/alpha: replace cpumask_weight with cpumask_empty where
    appropriate
  arch/ia64: replace cpumask_weight with cpumask_empty where appropriate
  arch/x86: replace cpumask_weight with cpumask_empty where appropriate
  cpufreq: replace cpumask_weight with cpumask_empty where appropriate
  gpu: drm: replace cpumask_weight with cpumask_empty where appropriate
  drivers/infiniband: replace cpumask_weight with cpumask_empty where
    appropriate
  drivers/irqchip: replace cpumask_weight with cpumask_empty where
    appropriate
  kernel/irq: replace cpumask_weight with cpumask_empty where
    appropriate
  kernel: replace cpumask_weight with cpumask_empty in padata.c
  rcu: replace cpumask_weight with cpumask_empty where appropriate
  sched: replace cpumask_weight with cpumask_empty where appropriate
  time: replace cpumask_weight with cpumask_empty in clocksource.c
  mm/vmstat: replace cpumask_weight with cpumask_empty where appropriate
  arch/x86: replace nodes_weight with nodes_empty where appropriate
  lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions
  arch/x86: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le}
    where appropriate
  drivers/iio: replace bitmap_weight() with bitmap_weight_{eq,gt} where
    appropriate
  drivers/memstick: replace bitmap_weight with bitmap_weight_eq where
    appropriate
  net: ethernet: replace bitmap_weight with bitmap_weight_eq for intel
  net: ethernet: replace bitmap_weight with bitmap_weight_{eq,gt} for
    OcteonTX2
  net: ethernet: replace bitmap_weight with
    bitmap_weight_{eq,gt,ge,lt,le} for mellanox
  perf: replace bitmap_weight with bitmap_weight_eq for ThunderX2
  drivers/staging: replace bitmap_weight with bitmap_weight_le for
    tegra-video
  lib/cpumask: add cpumask_weight_{eq,gt,ge,lt,le}
  arch/ia64: replace cpumask_weight with cpumask_weight_eq in mm/tlb.c
  arch/mips: replace cpumask_weight with cpumask_weight_{eq, ...} where
    appropriate
  arch/powerpc: replace cpumask_weight with cpumask_weight_{eq, ...}
    where appropriate
  arch/s390: replace cpumask_weight with cpumask_weight_eq where
    appropriate
  arch/x86: replace cpumask_weight with cpumask_weight_eq where
    appropriate
  firmware: pcsi: replace cpumask_weight with cpumask_weight_eq
  drivers/hv: replace cpumask_weight with cpumask_weight_eq
  infiniband: replace cpumask_weight with cpumask_weight_{eq, ...} where
    appropriate
  scsi: replace cpumask_weight with cpumask_weight_gt
  soc: replace cpumask_weight with cpumask_weight_lt
  sched: replace cpumask_weight with cpumask_weight_eq where appropriate
  kernel/time: replace cpumask_weight with cpumask_weight_eq where
    appropriate
  lib/nodemask: add nodemask_weight_{eq,gt,ge,lt,le}
  acpi: replace nodes__weight with nodes_weight_ge for numa
  mm: replace nodes_weight with nodes_weight_eq in mempolicy
  lib/nodemask: add num_node_state_eq()
  tools/bitmap: sync bitmap_weight
  MAINTAINERS: add cpumask and nodemask files to BITMAP_API

 MAINTAINERS                                   |  4 +
 arch/alpha/kernel/process.c                   |  2 +-
 arch/ia64/kernel/setup.c                      |  2 +-
 arch/ia64/mm/tlb.c                            |  2 +-
 arch/mips/cavium-octeon/octeon-irq.c          |  4 +-
 arch/mips/kernel/crash.c                      |  2 +-
 arch/nds32/kernel/perf_event_cpu.c            |  2 +-
 arch/powerpc/kernel/smp.c                     |  2 +-
 arch/powerpc/kernel/watchdog.c                |  2 +-
 arch/powerpc/xmon/xmon.c                      |  4 +-
 arch/s390/kernel/perf_cpum_cf.c               |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 16 ++--
 arch/x86/kernel/smpboot.c                     |  4 +-
 arch/x86/kvm/hyperv.c                         |  8 +-
 arch/x86/mm/amdtopology.c                     |  2 +-
 arch/x86/mm/mmio-mod.c                        |  2 +-
 arch/x86/mm/numa_emulation.c                  |  4 +-
 arch/x86/platform/uv/uv_nmi.c                 |  2 +-
 drivers/acpi/numa/srat.c                      |  2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c             |  2 +-
 drivers/cpufreq/scmi-cpufreq.c                |  2 +-
 drivers/firmware/psci/psci_checker.c          |  2 +-
 drivers/gpu/drm/i915/i915_pmu.c               |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c      |  2 +-
 drivers/hv/channel_mgmt.c                     |  4 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c   |  4 +-
 drivers/iio/industrialio-trigger.c            |  2 +-
 drivers/infiniband/hw/hfi1/affinity.c         | 13 ++-
 drivers/infiniband/hw/qib/qib_file_ops.c      |  2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c       |  2 +-
 drivers/irqchip/irq-bcm6345-l1.c              |  2 +-
 drivers/memstick/core/ms_block.c              |  4 +-
 drivers/net/dsa/b53/b53_common.c              |  6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c    |  6 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  4 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  2 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  2 +-
 .../marvell/octeontx2/nic/otx2_flows.c        |  8 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c      | 33 +++-----
 drivers/net/ethernet/mellanox/mlx4/eq.c       |  4 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c       |  4 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c    |  4 +-
 drivers/net/ethernet/qlogic/qed/qed_roce.c    |  2 +-
 drivers/perf/arm-cci.c                        |  2 +-
 drivers/perf/arm_pmu.c                        |  4 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  2 +-
 drivers/perf/thunderx2_pmu.c                  |  4 +-
 drivers/perf/xgene_pmu.c                      |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
 drivers/soc/fsl/qbman/qman_test_stash.c       |  2 +-
 drivers/staging/media/tegra-video/vi.c        |  2 +-
 drivers/thermal/intel/intel_powerclamp.c      |  9 +--
 include/linux/bitmap.h                        | 80 +++++++++++++++++++
 include/linux/cpumask.h                       | 50 ++++++++++++
 include/linux/nodemask.h                      | 40 ++++++++++
 kernel/irq/affinity.c                         |  2 +-
 kernel/padata.c                               |  2 +-
 kernel/rcu/tree_nocb.h                        |  4 +-
 kernel/rcu/tree_plugin.h                      |  2 +-
 kernel/sched/core.c                           | 10 +--
 kernel/sched/topology.c                       |  4 +-
 kernel/time/clockevents.c                     |  2 +-
 kernel/time/clocksource.c                     |  2 +-
 lib/bitmap.c                                  | 21 +++++
 mm/mempolicy.c                                |  2 +-
 mm/page_alloc.c                               |  2 +-
 mm/vmstat.c                                   |  4 +-
 tools/include/linux/bitmap.h                  | 44 ++++++++++
 tools/lib/bitmap.c                            | 20 +++++
 tools/perf/builtin-c2c.c                      |  4 +-
 tools/perf/util/pmu.c                         |  2 +-
 73 files changed, 374 insertions(+), 142 deletions(-)

-- 
2.30.2

