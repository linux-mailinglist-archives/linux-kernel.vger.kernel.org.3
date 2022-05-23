Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3AD5311F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiEWPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiEWPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:52:36 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943C26119
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:33 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id r25-20020adfb1d9000000b0020fc56e3f67so1299685wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=R7iSMDrHCjZU8l/ZZxQ47txPpE97XpwHqtaDcuYbgX0=;
        b=pXInn71KUKTiBBzGtLWoB//IMJMIJDpyymaOEBOLrB/SaivRePszcY5ccm190kE8YH
         NQH4V+QG0I5QpPutuvKdOjG3kQaCwOTXlViNKG6eClQo86g5ef0Y6UqLxmXEDlfSun31
         OUkQzFdgFeoNPOS4Z9BLYpi/9thQji05JEkYHr3zoG5IlzkaQT0nK3SBE6yHu3MWLu6v
         pOuzi0jnQZNCK2UBaTWCNRAr17uCfEboBneCXJa0DFXddnb0a5ruZcYnXWD3psdQdFlZ
         h9mRu+CT+fqYGdwgVjuVT4sD4YDLWYVBRBpCouDiF4tCs9XNXT3Y/psgRYiPCJZ6AhKm
         bY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=R7iSMDrHCjZU8l/ZZxQ47txPpE97XpwHqtaDcuYbgX0=;
        b=0THbajBimeuXcRw/IkFZF2PF3OObC+XF95OKHK82vFnPsyJJLllR6y8w0QbDe9FpEz
         /hV2qVe0d3LWETzpmAEPCc24GhPMpEn6XTBlSbAt0/U+cqGVhLBUG7QHI964SM5d3N69
         MwR+TAdu9fnCIsf/9fU5cRHC/Q3oKRzXlbGv++fQac6fvQaZfs1t5EYzNP1Hdmv8gzQ/
         kLX7K7aLa3dNcmbKVC+Cq6WiBuxn5BUUhRrYT+j8YYFxdCCGKkRcIsM3qbDmr5ZisP/c
         EEZ+7veUE8qAPlkdH5uZg4wNgP715tg8FppZKaWiUMWYNWDJRcbKqtlxiMAkTAkwRQCu
         tbvg==
X-Gm-Message-State: AOAM531TT1zxJHy7A3pb7dPSZzgMXhdU7N7+H4Y8AgFgcZPKWovmUwjQ
        3LoedC1jES5dJfmWTlnWPolmEAp2xS2yHtJS
X-Google-Smtp-Source: ABdhPJxwc7ufM1KRlXPFtj0gW6tN2HDdsY1Bc1DGX1BSV/730l2S2x3lF6ZD+5Hb4Hbyhe7UXbv4l0ix7URfwDm/
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with
 SMTP id h4-20020a05600016c400b0020fcd5d4797mr8686062wrf.193.1653321151498;
 Mon, 23 May 2022 08:52:31 -0700 (PDT)
Date:   Mon, 23 May 2022 16:51:33 +0100
Message-Id: <20220523155140.2878563-1-vdonnefort@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v9 0/7] feec() energy margin removal
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a new version of the patch-set to get rid of the energy margin in
feec(). Many thanks to all for the insightful comments I got.

find_energy_efficient() (feec()) will migrate a task to save energy only if
it saves at least 6% of the total energy consumed by the system. This
conservative approach is a problem on a system where a lot of small tasks
create a huge load on the overall: very few of them will be allowed to
migrate to a smaller CPU, wasting a lot of energy. Instead of trying to
determine yet another margin, let's try to remove it.

The first elements of this patch-set are various fixes and improvement that
stabilizes task_util and ensures energy comparison fairness across all CPUs
of the topology. Only once those fixed, we can completely remove the margin
and let feec() aggressively place task and save energy.

This has been validated by two different ways:

First using LISA's eas_behaviour test suite. This is composed of a set of
scenario and verify if the task placement is optimum. No failure have been
observed and it also improved some tests such as Ramp-Down (as the
placement is now more energy oriented) and *ThreeSmall (as no bouncing
between clusters happen anymore).

  * Hikey960: 100% PASSED
  * DB-845C:  100% PASSED
  * RB5:      100% PASSED

Second, using an Android benchmark: PCMark2 on a Pixel4, with a lot of
backports to have a scheduler as close as we can from mainline.

  +------------+-----------------+-----------------+
  |    Test    |      Perf       |    Energy [1]   |
  +------------+-----------------+-----------------+
  | Web2       | -0.3% pval 0.03 | -1.8% pval 0.00 |
  | Video2     | -0.3% pval 0.13 | -5.6% pval 0.00 |
  | Photo2 [2] | -3.8% pval 0.00 | -1%   pval 0.00 |
  | Writing2   |  0%   pval 0.13 | -1%   pval 0.00 |
  | Data2      |  0%   pval 0.8  | -0.43 pval 0.00 |
  +------------+-----------------+-----------------+

The margin removal let the kernel make the best use of the Energy Model,
tasks are more likely to be placed where they fit and this saves a
substantial amount of energy, while having a limited impact on
performances.

[1]=C2=A0This is an energy estimation based on the CPU activity and the Ene=
rgy
Model for this device. "All models are wrong but some are useful"; yes,
this is an imperfect estimation that doesn't take into account some idle
states and shared power rails. Nonetheless this is based on the information
the kernel has during runtime and it proves the scheduler can take better
decisions based solely on those data.

[2] This is the only performance impact observed. The debugging of this
test showed no issue with task placement. The better score was solely due
to some critical threads held on better performing CPUs. If a thread needs
a higher capacity CPU, the placement must result from a user input (with
e.g. uclamp min) instead of being artificially held on less efficient CPUs
by feec().  Notice also, the experiment didn't use the Android only
latency_sensitive feature which would hide this problem on a real-life
device.

v8 -> v9:
  - PELT migration decay: Fix barriers to prevent overestimation. (Vincent
    G.)
  - PELT migration decay: Fix CONFIG_GROUP_SCHED=3Dn build.
  - Various readbility improvements. (Dietmar)
  - Collect Reviewed-by tags.

v7 -> v8:
  - PELT migration decay: Refine estimation computation. (vincent G.)
  - PELT migration decay: Do not apply estimation if load_avg is decayed
    (Tao)
  - PELT migration decay: throttled_pelt_idle update ordering for the
    update_blocked_load case. (vincent G.)

v6 -> v7:
  - PELT migration decay: Add missing clock_pelt_idle updates.
  - PELT migration decay: Fix PELT scaling delta for CONFIG_CFS_BANDWIDTH.

v4 -> v5:
  - PELT migration decay: timestamp only at idle time (Vincent G.)
  - PELT migration decay: split timestamp values (enter_idle /
    clock_pelt_idle) (Vincent G.)

v3 -> v4:
  - Minor cosmetic changes (Dietmar)

v2 -> v3:
  - feec(): introduce energy_env struct (Dietmar)
  - PELT migration decay: Only apply when src CPU is idle (Vincent G.)
  - PELT migration decay: Do not apply when cfs_rq is throttled
  - PELT migration decay: Snapshot the lag at cfs_rq's level

v1 -> v2:
  - Fix PELT migration last_update_time (previously root cfs_rq's).
  - Add Dietmar's patches to refactor feec()'s CPU loop.
  - feec(): renaming busy time functions get_{pd,tsk}_busy_time()
  - feec(): pd_cap computation in the first for_each_cpu loop.
  - feec(): create get_pd_max_util() function (previously within
    compute_energy())
  - feec(): rename base_energy_pd to base_energy.

Dietmar Eggemann (3):
  sched, drivers: Remove max param from
    effective_cpu_util()/sched_cpu_util()
  sched/fair: Rename select_idle_mask to select_rq_mask
  sched/fair: Use the same cpumask per-PD throughout
    find_energy_efficient_cpu()

Vincent Donnefort (4):
  sched/fair: Provide u64 read for 32-bits arch helper
  sched/fair: Decay task PELT values during wakeup migration
  sched/fair: Remove task_util from effective utilization in feec()
  sched/fair: Remove the energy margin in feec()

 drivers/powercap/dtpm_cpu.c       |  33 +--
 drivers/thermal/cpufreq_cooling.c |   6 +-
 include/linux/sched.h             |   2 +-
 kernel/sched/core.c               |  15 +-
 kernel/sched/cpufreq_schedutil.c  |   5 +-
 kernel/sched/fair.c               | 465 +++++++++++++++++++-----------
 kernel/sched/pelt.h               |  40 ++-
 kernel/sched/sched.h              |  53 +++-
 8 files changed, 395 insertions(+), 224 deletions(-)

--=20
2.36.1.124.g0e6072fb45-goog

