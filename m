Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57194B18D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbiBJWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:52:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344212AbiBJWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:52:00 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8559B75
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:52:00 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id j24so6502918qkk.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Mk85loLOThbNQSOSUb3FqT3m+mzX4GZ/g9jCLAWa+E=;
        b=iivGpa8prXGA3rTzSN/P2mJPgq9t7ComsLYhdG0poK7tKY/TsriUXmbid+Yv039TYo
         OLNbQ4ACvyucdaoZMb4fvDnxw1+IFcvGTFXzXwri9ZpflpuV+aVEC1zbXHViKpxMkUAj
         bl4WvGM0xRKbvMgHLDs3gRUSzDSmKPLHISuaq7bkkiABtsdHIJzhUqR13FLweGZHDRZ5
         r3ohQlEJHT57ykfIZHb7T3TVdMGkdXAxPi11/Vw6HkN6OkmY0ukX64zOgmiUl73kawT3
         c3ImSbZa8A4KnDz9/4K/UXM/e+1HWjX0OwOCtLJhM2k/kmOWohqoC4K4SQqKJ8LxIh3B
         naGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Mk85loLOThbNQSOSUb3FqT3m+mzX4GZ/g9jCLAWa+E=;
        b=NQv5iO/tz67WdiiARAUlyyWCLBNrqftIrA04w17qGunLWNF5O0qT7as/NoucdroPhZ
         OR5KZ89KSEgbpOMJwphpx1ErQepvag5hxbAzEEnqBO9BnyC8//QkEmxpk1XFoQU4Oxzb
         AOdhNDwY5uX7gu7+Nom+fH/gYc5So/VL8Ql2Pq47gy576XisjgzwqRH7U9tKQUl+eFGg
         Lghvf+X8sCLezapKrla38gLtB/XQkDPntXIB2ltm1HsZprBiJAEoxRqmFd9Obv4Khaix
         FUNTPcdYkZUIFd/sjOfk/kaZg3p7yuh95Og3hEv7HJb1/kcNzz8JoWugFt1RVgDOAGtb
         xQtw==
X-Gm-Message-State: AOAM533g7xXsgo4vo2KM4+q5AmJ0FMOKgiA8exDgLJhoz2OmH70NET/h
        6AnSMZDjE2JecoXR7AadRCED11YwYHc=
X-Google-Smtp-Source: ABdhPJwni4hBc9oW5ikS54OdXNORPGNu27bEUaK6Q7h9OW5yK5s9fw04W/vf71CboIKRYUQFzV9A+Q==
X-Received: by 2002:ac8:7957:: with SMTP id r23mr6419981qtt.450.1644533509086;
        Thu, 10 Feb 2022 14:51:49 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id d22sm10799771qkn.112.2022.02.10.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:51:48 -0800 (PST)
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
Subject: [PATCH v4 00/49] bitmap: optimize bitmap_weight() usage
Date:   Thu, 10 Feb 2022 14:48:44 -0800
Message-Id: <20220210224933.379149-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

The first part of the series is a cleanup and rework where bitmap_weight
API is used wrongly.

Second part converts cpumask_weight() to cpumask_empty() if the number
to compare with is 0. Ditto for bitmap_weight() and nodes_weight().

In the 3nd part of the series bitmap_weight_cmp() is added together with
bitmap_weight_{eq,gt,ge,lt,le} wrappers on top of it. Corresponding
wrappers for cpumask and nodemask are added as well.

The rough numbers of new functions usage, as counted by grep:

	{bitmap,cpumask,nodes}_weight_eq	26
	{bitmap,cpumask,nodes}_weight_ge	25
	{bitmap,cpumask,nodes}_weight_gt	19
	{bitmap,cpumask,nodes}_weight_le	18
	{bitmap,cpumask,nodes}_weight_lt	14

v1: https://lkml.org/lkml/2021/11/27/339
v2: https://lkml.org/lkml/2021/12/18/241
v3: https://lkml.org/lkml/2022/1/27/913
v4: 
 - rebase on next-20220209;
 - exclude patches that already in next-20220209;
 - drop patches 41, 43, 47, 48 from v3 as they are not performance
   critical;
 - deeply rework iio_simple_dummy_trigger_h (patch #4) and
   qed_rdma_bmap_free (#10), instead of replacing bitmap_weight;
 - use more standard tags.

Yury Norov (49):
  net: dsa: don't use bitmap_weight() in b53_arl_read()
  net: systemport: don't use bitmap_weight() in bcm_sysport_rule_set()
  net: mellanox: fix open-coded for_each_set_bit()
  iio: fix opencoded for_each_set_bit()
  qed: rework qed_rdma_bmap_free()
  nds32: perf: replace bitmap_weight with bitmap_empty where appropriate
  KVM: x86: replace bitmap_weight with bitmap_empty where appropriate
  drm: replace bitmap_weight with bitmap_empty where appropriate
  ice: replace bitmap_weight with bitmap_empty for intel
  octeontx2-pf: replace bitmap_weight with bitmap_empty for Marvell
  qed: replace bitmap_weight with bitmap_empty in qed_roce_stop()
  perf/arm-cci: replace bitmap_weight with bitmap_empty where
    appropriate
  perf tools: replace bitmap_weight with bitmap_empty where appropriate
  arch/alpha: replace cpumask_weight with cpumask_empty where
    appropriate
  arch/ia64: replace cpumask_weight with cpumask_empty where appropriate
  arch/x86: replace cpumask_weight with cpumask_empty where appropriate
  cpufreq: replace cpumask_weight with cpumask_empty where appropriate
  gpu: drm: replace cpumask_weight with cpumask_empty where appropriate
  RDMA/hfi: replace cpumask_weight with cpumask_empty where appropriate
  irq: mips: replace cpumask_weight with cpumask_empty where appropriate
  genirq/affinity: replace cpumask_weight with cpumask_empty where
    appropriate
  sched: replace cpumask_weight with cpumask_empty where appropriate
  clocksource: replace cpumask_weight with cpumask_empty in
    clocksource.c
  mm/vmstat: replace cpumask_weight with cpumask_empty where appropriate
  arch/x86: replace nodes_weight with nodes_empty where appropriate
  bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions
  arch/x86: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le}
    where appropriate
  iio: replace bitmap_weight() with bitmap_weight_{eq,gt} where
    appropriate
  memstick: replace bitmap_weight with bitmap_weight_eq where
    appropriate
  ixgbe: replace bitmap_weight with bitmap_weight_eq for intel
  octeontx2-pf: replace bitmap_weight with bitmap_weight_{eq,gt} for
    OcteonTX2
  mlx4: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le} for
    mellanox
  perf: replace bitmap_weight with bitmap_weight_eq for ThunderX2
  media: tegra-video:: replace bitmap_weight with bitmap_weight_le
  cpumask: add cpumask_weight_{eq,gt,ge,lt,le}
  arch/ia64: replace cpumask_weight with cpumask_weight_eq in mm/tlb.c
  arch/mips: replace cpumask_weight with cpumask_weight_{eq, ...} where
    appropriate
  arch/powerpc: replace cpumask_weight with cpumask_weight_{eq, ...}
    where appropriate
  arch/s390: replace cpumask_weight with cpumask_weight_eq where
    appropriate
  firmware: pcsi: replace cpumask_weight with cpumask_weight_eq
  RDMA/hfi1: replace cpumask_weight with cpumask_weight_{eq, ...} where
    appropriate
  scsi: lpfc: replace cpumask_weight with cpumask_weight_gt
  soc/qman: replace cpumask_weight with cpumask_weight_lt
  nodemask: add nodemask_weight_{eq,gt,ge,lt,le}
  ACPI: replace nodes__weight with nodes_weight_ge for numa
  mm/mempolicy: replace nodes_weight with nodes_weight_eq
  nodemask: add num_node_state_eq()
  tools: bitmap: sync bitmap_weight
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
 drivers/iio/dummy/iio_simple_dummy_buffer.c   | 48 +++++-------
 drivers/iio/industrialio-trigger.c            |  2 +-
 drivers/infiniband/hw/hfi1/affinity.c         | 13 ++--
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
 drivers/net/ethernet/qlogic/qed/qed_rdma.c    | 45 ++++-------
 drivers/net/ethernet/qlogic/qed/qed_roce.c    |  2 +-
 drivers/perf/arm-cci.c                        |  2 +-
 drivers/perf/arm_pmu.c                        |  4 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  2 +-
 drivers/perf/thunderx2_pmu.c                  |  4 +-
 drivers/perf/xgene_pmu.c                      |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
 drivers/soc/fsl/qbman/qman_test_stash.c       |  2 +-
 drivers/staging/media/tegra-video/vi.c        |  2 +-
 include/linux/bitmap.h                        | 78 +++++++++++++++++++
 include/linux/cpumask.h                       | 50 ++++++++++++
 include/linux/nodemask.h                      | 40 ++++++++++
 kernel/irq/affinity.c                         |  2 +-
 kernel/sched/core.c                           |  2 +-
 kernel/sched/topology.c                       |  2 +-
 kernel/time/clocksource.c                     |  2 +-
 lib/bitmap.c                                  | 21 +++++
 mm/mempolicy.c                                |  2 +-
 mm/page_alloc.c                               |  2 +-
 mm/vmstat.c                                   |  4 +-
 tools/include/linux/bitmap.h                  | 44 +++++++++++
 tools/lib/bitmap.c                            | 20 +++++
 tools/perf/builtin-c2c.c                      |  4 +-
 tools/perf/util/pmu.c                         |  2 +-
 66 files changed, 384 insertions(+), 178 deletions(-)

-- 
2.32.0

