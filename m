Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3099954EFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379816AbiFQEHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiFQEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:07:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AD96256;
        Thu, 16 Jun 2022 21:07:50 -0700 (PDT)
X-UUID: d95047c5bcf54f3b8ce8b90d8d68c77f-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:fd2ecd7c-a0a6-46a2-b04c-2d9ccea8ab66,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:201095f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d95047c5bcf54f3b8ce8b90d8d68c77f-20220617
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2062144128; Fri, 17 Jun 2022 12:07:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 17 Jun 2022 12:07:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 17 Jun 2022 12:07:40 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mark.rutland@arm.com>, <will@kernel.org>
CC:     <lecopzer.chen@mediatek.com>, <acme@kernel.org>,
        <akpm@linux-foundation.org>, <alexander.shishkin@linux.intel.com>,
        <catalin.marinas@arm.com>, <davem@davemloft.net>,
        <jolsa@redhat.com>, <jthierry@redhat.com>, <keescook@chromium.org>,
        <kernelfans@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <masahiroy@kernel.org>,
        <matthias.bgg@gmail.com>, <maz@kernel.org>, <mcgrof@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <nixiaoming@huawei.com>,
        <peterz@infradead.org>, <pmladek@suse.com>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <yj.chiang@mediatek.com>
Subject: RE: [PATCH v6 0/6] Support hld delayed init based on Pseudo-NMI for arm64
Date:   Fri, 17 Jun 2022 12:07:40 +0800
Message-ID: <20220617040740.25631-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614062835.7196-1-lecopzer.chen@mediatek.com>
References: <20220614062835.7196-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark


Could you help review arm parts of this patchset, please?

For the question mention in both [1] and [2],

> I'd still like Mark's Ack on this, as the approach you have taken doesn't
> really sit with what he was suggesting.
>
> I also don't understand how all the CPUs get initialised with your patch,
> since the PMU driver will be initialised after SMP is up and running.

The hardlock detector utilizes the softlockup_start_all() to start all
the cpu on watchdog_allowed_mask, which will do watchdog_nmi_enable()
that registers perf event on each CPUs.
Thus we simply need to retry lockup_detector_init() in a single cpu which
will reconfig and call to softlockup_start_all().

Also, the CONFIG_HARDLOCKUP_DETECTOR_PERF selects SOFTLOCKUP_DETECTOR,
IMO, this shows that hardlockup detector supports from softlockup.


> We should know whether pNMIs are possible once we've completed
> setup_arch() (and possibly init_IRQ()), long before SMP, so so I reckon
> we should have all the information available once we get to
> lockup_detector_init(), even if that requires some preparatory rework.

Hardlockup depends on PMU driver , I think the only way is moving
pmu driver at setup_arch() or any point which is earlier than
lockup_detector_init(), and I guess we have to reorganize the architecture
of arm PMU.

The retry function should benifit all the arch/ not only for arm64.
Any arch who needs to probe its pmu as module can use this without providing
a chance to mess up the setup order. 


Please let me know if you have any concern about this, thank you


[1] https://lore.kernel.org/all/CAFA6WYPPgUvHCpN5=EpJ2Us5h5uVWCbBA59C-YwYQX2ovyVeEw@mail.gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20210419170331.GB31045@willie-the-truck/


BRs,
Lecopzer
