Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B55ABE3F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiICJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiICJpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 05:45:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B824B0C4;
        Sat,  3 Sep 2022 02:45:31 -0700 (PDT)
X-UUID: 16d58f0892984158981941aca84ff6b6-20220903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C7v8EPLTEZmZ1anSY1oDPlwBHyvM0IIQ7mwyVrAfIGI=;
        b=VcqMn0TJV8maJJiYiReo3rWuElI1R/9vAJigezoDh4G7lXdBjSX1FV50lIJ9HYEOLlC1XhHlQ3u4KnqqAzWNaNIumuaFEV16RaLmvEYvfrvVr8GmAGFG3Akhua0bHAOg4svigEWnuW3Z6vPG+BhqOcpsHx8GxCgyP41cj5YztoI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:306089ba-8c64-48b9-81b5-4ecc718f1e25,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:40
X-CID-INFO: VERSION:1.1.10,REQID:306089ba-8c64-48b9-81b5-4ecc718f1e25,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:40
X-CID-META: VersionHash:84eae18,CLOUDID:246786d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:fb7138c31022,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 16d58f0892984158981941aca84ff6b6-20220903
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1090876215; Sat, 03 Sep 2022 17:45:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Sep 2022 17:45:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 3 Sep 2022 17:45:24 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mark.rutland@arm.com>, <will@kernel.org>
CC:     <lecopzer.chen@mediatek.com>, <acme@kernel.org>,
        <akpm@linux-foundation.org>, <alexander.shishkin@linux.intel.com>,
        <catalin.marinas@arm.com>, <davem@davemloft.net>,
        <jolsa@redhat.com>, <jthierry@redhat.com>, <keescook@chromium.org>,
        <kernelfans@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <pmladek@suse.com>, <sparclinux@vger.kernel.org>,
        <sumit.garg@linaro.org>, <wangqing@vivo.com>,
        <yj.chiang@mediatek.com>
Subject: RE: [PATCH v7 0/6] Support hld delayed init based on Pseudo-NMI for arm64
Date:   Sat, 3 Sep 2022 17:45:23 +0800
Message-ID: <20220903094523.16002-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
References: <20220903093415.15850-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark
 
Sorry for bothering you, this need to be reviewed by ARM Perf maintainer,

could you please help review this pathset or comment about it?




Thanks a lot.

 
> Hi Will, Mark
>
> Could you help review arm parts of this patchset, please?
> 
> For the question mention in both [1] and [2],
> 
> > I'd still like Mark's Ack on this, as the approach you have taken doesn't
> > really sit with what he was suggesting.
> >
> > I also don't understand how all the CPUs get initialised with your patch,
> > since the PMU driver will be initialised after SMP is up and running.
> 
> The hardlock detector utilizes the softlockup_start_all() to start all
> the cpu on watchdog_allowed_mask, which will do watchdog_nmi_enable()
> that registers perf event on each CPUs.
> Thus we simply need to retry lockup_detector_init() in a single cpu which
> will reconfig and call to softlockup_start_all().
> 
> Also, the CONFIG_HARDLOCKUP_DETECTOR_PERF selects SOFTLOCKUP_DETECTOR,
> IMO, this shows that hardlockup detector supports from softlockup.
> 
> 
> > We should know whether pNMIs are possible once we've completed
> > setup_arch() (and possibly init_IRQ()), long before SMP, so so I reckon
> > we should have all the information available once we get to
> > lockup_detector_init(), even if that requires some preparatory rework.
> 
> Hardlockup depends on PMU driver , I think the only way is moving
> pmu driver at setup_arch() or any point which is earlier than
> lockup_detector_init(), and I guess we have to reorganize the architecture
> of arm PMU.
> 
> The retry function should benifit all the arch/ not only for arm64.
> Any arch who needs to probe its pmu as module can use this without providing
> a chance to mess up the setup order. 
> 
> 
> Please let me know if you have any concern about this, thank you
> 
> 
> [1] https://lore.kernel.org/all/CAFA6WYPPgUvHCpN5=EpJ2Us5h5uVWCbBA59C-YwYQX2ovyVeEw@mail.gmail.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20210419170331.GB31045@willie-the-truck/
> 
> 
