Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148824E64CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbiCXOPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350758AbiCXOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:15:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA21FCD0;
        Thu, 24 Mar 2022 07:14:16 -0700 (PDT)
X-UUID: 0aa1160529f245fdb62e2fb6ad6abbe5-20220324
X-UUID: 0aa1160529f245fdb62e2fb6ad6abbe5-20220324
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1102049120; Thu, 24 Mar 2022 22:14:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 24 Mar 2022 22:14:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 22:14:08 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lecopzer.chen@mediatek.com>, <acme@kernel.org>,
        <akpm@linux-foundation.org>, <alexander.shishkin@linux.intel.com>,
        <catalin.marinas@arm.com>, <davem@davemloft.net>,
        <jolsa@redhat.com>, <jthierry@redhat.com>, <keescook@chromium.org>,
        <kernelfans@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <pmladek@suse.com>, <sparclinux@vger.kernel.org>,
        <sumit.garg@linaro.org>, <wangqing@vivo.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v3 0/5] Support hld delayed init based on Pseudo-NMI for arm64
Date:   Thu, 24 Mar 2022 22:14:00 +0800
Message-ID: <20220324141405.10835-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we already used hld internally for arm64 since 2020, there still
doesn't have a proper commit on the upstream and we badly need it.

This serise rework on 5.17 from [1] and the origin author is
Pingfan Liu <kernelfans@gmail.com>
Sumit Garg <sumit.garg@linaro.org>

Qoute from [1]:

> Hard lockup detector is helpful to diagnose unpaired irq enable/disable.
> But the current watchdog framework can not cope with arm64 hw perf event
> easily.

> On arm64, when lockup_detector_init()->watchdog_nmi_probe(), PMU is not
> ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
> integrated with the driver model and cpuhp. Hence it is hard to push the
> initialization of armv8_pmu_driver_init() before smp_init().

> But it is easy to take an opposite approach by enabling watchdog_hld to
> get the capability of PMU async. 
> The async model is achieved by expanding watchdog_nmi_probe() with
> -EBUSY, and a re-initializing work_struct which waits on a
> wait_queue_head.

Provide an API - retry_lockup_detector_init() for anyone who needs
to delayed init lockup detector.

The original assumption is: nobody should use delayed probe after
lockup_detector_check() (which has __init attribute).
That is, anyone uses this API must call between lockup_detector_init()
and lockup_detector_check(), and the caller must have __init attribute

The delayed init flow is:
1. lockup_detector_init() get -EBUSY from arch code, set
   allow_lockup_detector_init_retry=true

2. PMU arch code init done, call retry_lockup_detector_init().

3. retry_lockup_detector_init() queue the work only when
   allow_lockup_detector_init_retry=true which means nobody should call
   this before lockup_detector_init().

4. the work lockup_detector_delay_init() is doing without wait event.
   if probe success, set allow_lockup_detector_init_retry=false.

5. at late_initcall_sync(), lockup_detector_check() call flush_work() first
   to avoid previous retry_lockup_detector_init() is not scheduled.
   And then test whether allow_lockup_detector_init_retry is false, if it's
   true, means we have pending init un-finished, than forcely queue work
   again and flush_work to make sure the __init section won't be freed
   before the work done.

[1] https://lore.kernel.org/lkml/20211014024155.15253-1-kernelfans@gmail.com/

v3:
  1. Tweak commit message in patch 04 
	2. Remove wait event
  3. s/lockup_detector_pending_init/allow_lockup_detector_init_retry/
  4. provide api retry_lockup_detector_init()


v2:
  1. Tweak commit message in patch 01/02/04/05 
  2. Remove vobose WARN in patch 04 within watchdog core.
  3. Change from three states variable: detector_delay_init_state to
     two states variable: allow_lockup_detector_init_retry

     Thanks Petr Mladek <pmladek@suse.com> for the idea.
     > 1.  lockup_detector_work() called before lockup_detector_check().
     >     In this case, wait_event() will wait until lockup_detector_check()
     >     clears detector_delay_pending_init and calls wake_up().

     > 2. lockup_detector_check() called before lockup_detector_work().
     >    In this case, wait_even() will immediately continue because
     >    it will see cleared detector_delay_pending_init.
  4. Add comment in code in patch 04/05 for two states variable changing.
https://lore.kernel.org/lkml/20220307154729.13477-1-lecopzer.chen@mediatek.com/

Lecopzer Chen (4):
  kernel/watchdog: remove WATCHDOG_DEFAULT
  kernel/watchdog: change watchdog_nmi_enable() to void
  kernel/watchdog: Adapt the watchdog_hld interface for async model
  arm64: Enable perf events based hard lockup detector

Pingfan Liu (1):
  kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup
    detector event

 arch/arm64/Kconfig             |  2 +
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/perf_event.c | 12 +++++-
 arch/sparc/kernel/nmi.c        |  8 ++--
 drivers/perf/arm_pmu.c         |  5 +++
 include/linux/nmi.h            |  5 ++-
 include/linux/perf/arm_pmu.h   |  2 +
 kernel/watchdog.c              | 67 +++++++++++++++++++++++++++++++---
 kernel/watchdog_hld.c          |  8 +++-
 9 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.25.1

