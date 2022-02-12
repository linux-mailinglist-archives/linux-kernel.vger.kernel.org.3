Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF934B344E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiBLKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:44:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiBLKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:44:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A52656E;
        Sat, 12 Feb 2022 02:43:56 -0800 (PST)
X-UUID: fb20e02e584d43b5b10b84467f310f71-20220212
X-UUID: fb20e02e584d43b5b10b84467f310f71-20220212
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 690852364; Sat, 12 Feb 2022 18:43:52 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 12 Feb 2022 18:43:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 12 Feb
 2022 18:43:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Feb 2022 18:43:50 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <sumit.garg@linaro.org>,
        <kernelfans@gmail.com>, <lecopzer.chen@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH 0/5] Support hld based on Pseudo-NMI for arm64
Date:   Sat, 12 Feb 2022 18:43:44 +0800
Message-ID: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we already used hld internally for arm64 since 2020, there still
doesn't have a proper commit on the upstream and we badly need it.

This serise rebase on 5.17-rc3 from [1] and the origin author is
Pingfan Liu <kernelfans@gmail.com>
Sumit Garg <sumit.garg@linaro.org>

[1] wasn't reviewed for its patch v3, I'll take over the further development
for this.


Qoute from [1]:

Hard lockup detector is helpful to diagnose unpaired irq enable/disable.
But the current watchdog framework can not cope with arm64 hw perf event
easily.

On arm64, when lockup_detector_init()->watchdog_nmi_probe(), PMU is not
ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
integrated with the driver model and cpuhp. Hence it is hard to push the
initialization of armv8_pmu_driver_init() before smp_init().

But it is easy to take an opposite approach by enabling watchdog_hld to
get the capability of PMU async. 
The async model is achieved by expanding watchdog_nmi_probe() with
-EBUSY, and a re-initializing work_struct which waits on a
wait_queue_head.

[1] https://lore.kernel.org/lkml/20211014024155.15253-1-kernelfans@gmail.com/


Lecopzer Chen (2):
  kernel/watchdog: remove WATCHDOG_DEFAULT
  kernel/watchdog: change watchdog_nmi_enable() to void

Pingfan Liu (2):
  kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup
    detector event
  kernel/watchdog: Adapt the watchdog_hld interface for async model

Sumit Garg (1):
  arm64: Enable perf events based hard lockup detector

 arch/arm64/Kconfig               |  2 ++
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/perf_event.c   | 11 ++++--
 arch/arm64/kernel/watchdog_hld.c | 36 +++++++++++++++++++
 arch/sparc/kernel/nmi.c          |  8 ++---
 drivers/perf/arm_pmu.c           |  5 +++
 include/linux/nmi.h              | 11 +++++-
 include/linux/perf/arm_pmu.h     |  2 ++
 kernel/watchdog.c                | 61 ++++++++++++++++++++++++++++----
 kernel/watchdog_hld.c            |  8 ++++-
 10 files changed, 131 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.25.1

