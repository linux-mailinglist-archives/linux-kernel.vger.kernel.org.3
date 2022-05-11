Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA01522BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiEKFbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbiEKFaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:30:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92110245C77;
        Tue, 10 May 2022 22:29:45 -0700 (PDT)
X-UUID: d2382189dd4b4fe8a38e3188572b15fa-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7505f239-8e5a-4c67-a443-71c57204b4ec,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:edcc60b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d2382189dd4b4fe8a38e3188572b15fa-20220511
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 857401825; Wed, 11 May 2022 13:29:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 11 May 2022 13:29:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 May 2022 13:29:39 +0800
Message-ID: <3dc832f47406c835ccdb0076edad58c180881134.camel@mediatek.com>
Subject: Re: [PATCH v3 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mka@chromium.org>, <wenst@chromium.org>,
        <jia-wei.chang@mediatek.com>, <andrew-sh.cheng@mediatek.com>,
        <hsinyi@chromium.org>, <saravanak@google.com>,
        <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
        <kyungmin.park@samsung.com>
Date:   Wed, 11 May 2022 13:29:38 +0800
In-Reply-To: <20220509120337.92472-1-cw00.choi@samsung.com>
References: <20220509120337.92472-1-cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-09 at 21:03 +0900, Chanwoo Choi wrote:
> The devfreq passive governor has already supported the devfreq parent
> device
> for coupling the frequency change if some hardware have the
> constraints
> such as power sharing and so on.
> 
> Add cpu based scaling support to passive governor with required-opp
> property.
> It uses the cpufreq notifier to catch the frequency change timing of
> cpufreq
> and get the next frequency according to new cpu frequency by using
> required-opp
> property. It is based on patch[1] and then just code clean-up by
> myself.
> 
> Make the common code for both passive_devfreq and passive_cpufreq
> parent type to remove the duplicate code.
> 
> [1] [RFC,v2] PM / devfreq: Add cpu based scaling support to
> passive_governor
> - https://lore.kernel.org/patchwork/patch/1101049/
> 
> Changes from v2:
> : 
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/__;!!CTRNKA9wMg0ARbw!x-hPdV1M41ovWuBCw3cVvayFBaqFZRCtLLqDHeX_iNnzvwmOKQYOVQeD9mBfi7n8okEj$
>  
> - Drop the following patch ("PM / devfreq: passive: Update frequency
> when start governor")
> - Move p_data->this initialization into
> cpufreq_passive_regiser_notifier()
> 
> Changes from v1:
> : 
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/__;!!CTRNKA9wMg0ARbw!x-hPdV1M41ovWuBCw3cVvayFBaqFZRCtLLqDHeX_iNnzvwmOKQYOVQeD9mBfiw3rUNcX$
>  
> - Rename cpu_data variable to parent_cpu_data to avoid build fail
> - Use for_each_possible_cpu macro when register cpufreq transition
> notifier
> - Add missing exception handling when
> cpufreq_passive_register_notifier is failed
> - Keep cpufreq_policy for posible cpus instead of NR_CPU in order to
> avoid
>   the memory waste when NR_CPU is too high.
> - Add reviewed-by tag of Matthias Kaehlcke for patch1
> 
> 
> Chanwoo Choi (3):
>   PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>   PM / devfreq: passive: Reduce duplicate code when passive_devfreq
> case
>   PM / devfreq: passive: Keep cpufreq_policy for possible cpus
> 
> Saravana Kannan (1):
>   PM / devfreq: Add cpu based scaling support to passive governor
> 
>  drivers/devfreq/devfreq.c          |  20 +-
>  drivers/devfreq/governor.h         |  27 ++
>  drivers/devfreq/governor_passive.c | 400 ++++++++++++++++++++++++---
> --
>  include/linux/devfreq.h            |  17 +-
>  4 files changed, 387 insertions(+), 77 deletions(-)
> 

For this serie:

Tested-by: Johnson Wang <johnson.wang@mediatek.com>


BRs,
Johnson Wang

