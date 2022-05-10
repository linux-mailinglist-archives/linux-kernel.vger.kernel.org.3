Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D39522056
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347145AbiEJQBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347233AbiEJPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD391838C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z126so13503210qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lf0sqMsn4LVEaqO+/Mf4ulUWX6BR8I9KEfQxFM/4vLM=;
        b=nhrJAj6iv3QwxvBUpUIwmUeMUAPBIx+S0N3/McdT4LHu1yx/BTzdrWjwvDvGmNVjIW
         nqJcoqPlJ9+U+5MVk95f7hGwRnh6giR+mZCRwI4QUmFghsCTMCtmO/Nt25ajv0VWAOaG
         LcCNkqJvp14ZFwdZaml2mCdJV7TiB57zggAOMnW8aqlpavQguQni/e3BzcaXBrOdXhtd
         7GjpzK8l+taK7daFK2ZapD6DmKoyu5nOAd/ReXIo75lKbZzVERnoHJSOXPFYry4vJBlw
         w6RVu1avd6DcGREID9d0R7xlB9vZwYpp2UOAdt3Ea9rnZx8kkIy28vc8Yy4TA7qi6Xr6
         nWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lf0sqMsn4LVEaqO+/Mf4ulUWX6BR8I9KEfQxFM/4vLM=;
        b=VelYSi+qnkqvjdkB9wHSk3SoCSYgCaXp9Gr21ba1tX6Qvurz7znwVTYBW9GEqCucG1
         Ya+ucfXhtIIL7lbIjuhihb2RXth1wBTXICL5wXBtXCKM4ocknaCQxggYJYQHw6U7U9Rv
         q8P1ycURy+z4miHWg5tNcr7RFNqFiseV66L+CgxEeGUr0DZUZhvLFppa3tK0pZ/dNSUl
         LalMgpFXJDsSmWr4CqUK0ETJ3n3jej1tfjGjwmxXp5n6r0thtPMOgWxA1KvXJhZDGS8U
         bPDwzR641XBi7A6v+nSqm2+JB3jDPlMkW6C2nwAyYb38b8jsWjgeRJQ/066tezOeNhHd
         ZcRw==
X-Gm-Message-State: AOAM533e+9a+NSClpOSqVM1X4ouGX6sZue/YoiApLo28rXoDBkPTY198
        4j2pvOPyPIqQzjjcmASUa5Y=
X-Google-Smtp-Source: ABdhPJy2XYghV8P8cUK1PQFS3/qFKu/G7Xlsa7dtAwRUGhoeETEpo+eK+nSokvA7Ncxx7GIqbwcWrg==
X-Received: by 2002:a05:620a:b43:b0:6a0:92b9:8199 with SMTP id x3-20020a05620a0b4300b006a092b98199mr7317034qkg.710.1652197673669;
        Tue, 10 May 2022 08:47:53 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id x9-20020ac84d49000000b002f39b99f677sm9647065qtv.17.2022.05.10.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:53 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 00/21] add coccinelle scripts for {bitmap,cpumask,nodes}_empty()
Date:   Tue, 10 May 2022 08:47:28 -0700
Message-Id: <20220510154750.212913-1-yury.norov@gmail.com>
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

In this series:
 - introduce bitmap.cocci, cpumask.cocci and nodemask.cocci;
 - add checks for cases where bitmap_weight() may be replaced with one of
   "empty, full, gt, lt, ge, le or eq" versions; and
 - address issued found with those scripts.

On top of next-2022-05-06.

Yury Norov (22):
  introduce bitmap.cocci
  introduce cpumask.cocci
  introduce nodemask.cocci
  ice: use bitmap_empty() in ice_vf_has_no_qs_ena()
  iio: replace bitmap_weight with bitmap_weitght_{eq,le} where
    appropriate
  octeontx2: use bitmap_empty() instead of bitmap_weight()
  risc-v: replace bitmap_weight with bitmap_empty in riscv_fill_hwcap()
  bitops: introduce MANY_BITS() macro
  qed: replace bitmap_weight() with MANY_BITS()
  net/mlx5e: simplify mlx5e_set_fecparam()
  KVM: x86: hyper-v: replace bitmap_weight() with hweight64()
  ia64: cleanup remove_siblinginfo()
  x86: smp: move cpumask_weight() out of for-loop in remove_siblinginfo
  x86: smp: use cpumask_weight_eq() in remove_siblinginfo
  net/mlx5: use cpumask_weight_gt() in irq_pool_request_irq()
  x86/tsc: use cpumask_weight_gt() in loop_timeout()
  sched/core: fix opencoded cpumask_any_but() in
    sched_core_cpu_{starting,deactivate}
  sched/core: remove unneeded cpumask_weight in
    sched_core_cpu_{starting,deactivate}
  sched/core: replace cpumask_weight() with cpumask_weight_eq() where
    appropriate
  sched/topology: replace cpumask_weight() with cpumask_weight_eq where
    appropriate
  cpufreq: use cpumask_weight_gt() in policy_is_shared()
  clockevents: use cpumask_weight_eq() in tick_cleanup_dead_cpu()

 MAINTAINERS                                   |   3 +
 arch/ia64/kernel/smpboot.c                    |   4 -
 arch/riscv/kernel/cpufeature.c                |   7 +-
 arch/x86/kernel/smpboot.c                     |   7 +-
 arch/x86/kernel/tsc_sync.c                    |   2 +-
 arch/x86/kvm/hyperv.c                         |   4 +-
 arch/xtensa/kernel/traps.c                    |   5 +-
 drivers/iio/adc/ad_sigma_delta.c              |   2 +-
 drivers/iio/industrialio-buffer.c             |   2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rpm.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   4 +-
 .../mellanox/mlx5/core/irq_affinity.c         |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c     |   3 +-
 include/linux/bitops.h                        |   3 +
 include/linux/cpufreq.h                       |   2 +-
 include/linux/log2.h                          |   2 +-
 kernel/sched/core.c                           |  47 +++-----
 kernel/sched/topology.c                       |   4 +-
 kernel/time/clockevents.c                     |   2 +-
 scripts/coccinelle/api/bitmap.cocci           | 104 ++++++++++++++++++
 scripts/coccinelle/api/cpumask.cocci          |  51 +++++++++
 scripts/coccinelle/api/nodemask.cocci         |  51 +++++++++
 24 files changed, 256 insertions(+), 67 deletions(-)
 create mode 100644 scripts/coccinelle/api/bitmap.cocci
 create mode 100644 scripts/coccinelle/api/cpumask.cocci
 create mode 100644 scripts/coccinelle/api/nodemask.cocci

-- 
2.32.0

