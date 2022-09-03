Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924355ABE0A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiICJfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 05:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiICJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 05:34:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67421260;
        Sat,  3 Sep 2022 02:34:37 -0700 (PDT)
X-UUID: 8f5aa7cec44e4bf88f5fbc40a7def764-20220903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=85nido2etOpg9jJYQFbRVZv19oAO9gLaQLHV39+tA4A=;
        b=j0rdHukpRWvpqeCt8hUsYqHVEetSP5RR1GNE9uoN4CNyXiGBmusScEWlGArFomwOYG2zIzDN8Vl/FxOPRVGsAaDCSNBtuBjKHM2v4onZwJbI/SWgHrw196pNLxDL3XO0Q942hnZPhxC1qRuUnahpUgiMm93FGu3OUdP6DCGVvrA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:ef36b599-93fc-4bca-a97b-ead363518b4c,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:ef36b599-93fc-4bca-a97b-ead363518b4c,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:d46f0521-1c20-48a5-82a0-25f9c331906d,C
        OID:e6d5d1283953,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8f5aa7cec44e4bf88f5fbc40a7def764-20220903
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 5461367; Sat, 03 Sep 2022 17:34:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Sep 2022 17:34:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 3 Sep 2022 17:34:16 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <lecopzer.chen@mediatek.com>, <acme@kernel.org>,
        <akpm@linux-foundation.org>, <alexander.shishkin@linux.intel.com>,
        <catalin.marinas@arm.com>, <davem@davemloft.net>,
        <jolsa@redhat.com>, <jthierry@redhat.com>, <keescook@chromium.org>,
        <kernelfans@gmail.com>, <masahiroy@kernel.org>,
        <matthias.bgg@gmail.com>, <maz@kernel.org>, <mcgrof@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <nixiaoming@huawei.com>,
        <peterz@infradead.org>, <pmladek@suse.com>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <yj.chiang@mediatek.com>
Subject: [PATCH v7 0/6] Support hld delayed init based on Pseudo-NMI for
Date:   Sat, 3 Sep 2022 17:34:09 +0800
Message-ID: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
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

v7:
  rebase on v6.0-rc3

v6:
  fix build failed reported by kernel test robot <lkp@intel.com>
https://lore.kernel.org/lkml/20220614062835.7196-1-lecopzer.chen@mediatek.com/

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

