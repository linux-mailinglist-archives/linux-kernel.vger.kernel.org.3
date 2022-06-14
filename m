Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3E54A971
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351900AbiFNG3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351199AbiFNG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:28:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DF1A070;
        Mon, 13 Jun 2022 23:28:46 -0700 (PDT)
X-UUID: 6f66c7e9231b4720ab41533455a9f34c-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:a91390f5-3f84-4e34-8af8-3caf468a4b1d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:75c68407-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 6f66c7e9231b4720ab41533455a9f34c-20220614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 313948037; Tue, 14 Jun 2022 14:28:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 14:28:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jun 2022 14:28:36 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <pmladek@suse.com>, <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <lecopzer.chen@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: [PATCH v6 0/6] Support hld delayed init based on Pseudo-NMI for
Date:   Tue, 14 Jun 2022 14:28:29 +0800
Message-ID: <20220614062835.7196-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
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

> Hard lockup detector is helpful to diagnose unpaired irq
> enable/disable.
> But the current watchdog framework can not cope with arm64 hw perf
> event
> easily.

> On arm64, when lockup_detector_init()->watchdog_nmi_probe(), PMU is
> not
> ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
> integrated with the driver model and cpuhp. Hence it is hard to push
> the
> initialization of armv8_pmu_driver_init() before smp_init().

> But it is easy to take an opposite approach by enabling watchdog_hld
> to
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
1. lockup_detector_init() -> watchdog_nmi_probe() get non-zero retun,
   then set allow_lockup_detector_init_retry to true which means it's
   able to do delayed probe later.

2. PMU arch code init done, call retry_lockup_detector_init().

3. retry_lockup_detector_init() queue the work only when
   allow_lockup_detector_init_retry is true which means nobody should
call
   this before lockup_detector_init().

4. the work lockup_detector_delay_init() is doing without wait event.
   if probe success, set allow_lockup_detector_init_retry to false.

5. at late_initcall_sync(), lockup_detector_check() set
   allow_lockup_detector_init_retry to false first to avoid any later
retry,
   and then flush_work() to make sure the __init section won't be freed
   before the work done.

[1]
https://lore.kernel.org/lkml/20211014024155.15253-1-kernelfans@gmail.com/

v6:
  fix build failed reported by kernel test robot <lkp@intel.com>

v5:
  1. rebase on v5.19-rc2
  2. change to proper schedule api
  3. return value checking before retry_lockup_detector_init()
https://lore.kernel.org/lkml/20220613135956.15711-1-lecopzer.chen@mediatek.com/

v4:
  1. remove -EBUSY protocal, let all the non-zero value from
     watchdog_nmi_probe() be able to retry.
  2. separate arm64 part patch into hw_nmi_get_sample_period and retry
     delayed init
  3. tweak commit msg that we don't have to limit to -EBUSY  
  4. rebase on v5.18-rc4
https://lore.kernel.org/lkml/20220427161340.8518-1-lecopzer.chen@mediatek.com/

v3:
  1. Tweak commit message in patch 04 
	2. Remove wait event
  3. s/lockup_detector_pending_init/allow_lockup_detector_init_retry/
  4. provide api retry_lockup_detector_init() 
https://lore.kernel.org/lkml/20220324141405.10835-1-lecopzer.chen@mediatek.com/ 

v2:
  1. Tweak commit message in patch 01/02/04/05 
  2. Remove vobose WARN in patch 04 within watchdog core.
  3. Change from three states variable: detector_delay_init_state to
     two states variable: allow_lockup_detector_init_retry

     Thanks Petr Mladek <pmladek@suse.com> for the idea.
     > 1.  lockup_detector_work() called before lockup_detector_check().
     >     In this case, wait_event() will wait until
     >     lockup_detector_check()
     >     clears detector_delay_pending_init and calls wake_up().

     > 2. lockup_detector_check() called before lockup_detector_work().
     >    In this case, wait_even() will immediately continue because
     >    it will see cleared detector_delay_pending_init.
  4. Add comment in code in patch 04/05 for two states variable
changing.
https://lore.kernel.org/lkml/20220307154729.13477-1-lecopzer.chen@mediatek.com/


Lecopzer Chen (5):
  kernel/watchdog: remove WATCHDOG_DEFAULT
  kernel/watchdog: change watchdog_nmi_enable() to void
  kernel/watchdog: Adapt the watchdog_hld interface for async model
  arm64: add hw_nmi_get_sample_period for preparation of lockup detector
  arm64: Enable perf events based hard lockup detector

Pingfan Liu (1):
  kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup
    detector event

 arch/arm64/Kconfig               |  2 +
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/perf_event.c   | 12 +++++-
 arch/arm64/kernel/watchdog_hld.c | 39 +++++++++++++++++
 arch/sparc/kernel/nmi.c          |  8 ++--
 drivers/perf/arm_pmu.c           |  5 +++
 include/linux/nmi.h              |  4 +-
 include/linux/perf/arm_pmu.h     |  2 +
 kernel/watchdog.c                | 72 +++++++++++++++++++++++++++++---
 kernel/watchdog_hld.c            |  8 +++-
 10 files changed, 139 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.25.1

