Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1794510FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbiD0D4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350118AbiD0D4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:56:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778242A3E;
        Tue, 26 Apr 2022 20:53:28 -0700 (PDT)
X-UUID: 994b71eaf55d42cfbce11ee5a5df6835-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:d8919b75-7459-4d93-931d-ca7c04ea444d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:be129ec6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 994b71eaf55d42cfbce11ee5a5df6835-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2005499027; Wed, 27 Apr 2022 11:53:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 11:53:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 11:53:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 11:53:22 +0800
Message-ID: <68084aab064d3831d998dd1481b0dcef90591b26.camel@mediatek.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Wed, 27 Apr 2022 11:53:22 +0800
In-Reply-To: <20220426183041.2593d35f@canb.auug.org.au>
References: <20220426183041.2593d35f@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 2022-04-26 at 18:30 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x18): multiple definition of
> `adsp_clock_on'; sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+0x60): first defined here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function `.adsp_clock_on':
> mt8186-clk.c:(.text.adsp_clock_on+0x0): multiple definition of `.adsp_clock_on';
> sound/soc/sof/mediatek/mt8195/mt8195-clk.o:mt8195-clk.c:(.text.adsp_clock_on+0x0): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x30): multiple definition of
> `adsp_clock_off'; sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+0x78): first defined here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function `.adsp_clock_off':
> mt8186-clk.c:(.text.adsp_clock_off+0x0): multiple definition of `.adsp_clock_off';
> sound/soc/sof/mediatek/mt8195/mt8195-clk.o:mt8195-clk.c:(.text.adsp_clock_off+0x0): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o:(.opd+0x0): multiple definition of
> `sof_hifixdsp_boot_sequence'; sound/soc/sof/mediatek/mt8195/mt8195-loader.o:(.opd+0x0): first
> defined here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o: in function `.sof_hifixdsp_boot_sequence':
> mt8186-loader.c:(.text.sof_hifixdsp_boot_sequence+0x0): multiple definition of
> `.sof_hifixdsp_boot_sequence'; sound/soc/sof/mediatek/mt8195/mt8195-loader.o:mt8195-
> loader.c:(.text.sof_hifixdsp_boot_sequence+0x0): first defined here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o:(.opd+0x18): multiple definition of
> `sof_hifixdsp_shutdown'; sound/soc/sof/mediatek/mt8195/mt8195-loader.o:(.opd+0x18): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o: in function `.sof_hifixdsp_shutdown':
> mt8186-loader.c:(.text.sof_hifixdsp_shutdown+0x0): multiple definition of
> `.sof_hifixdsp_shutdown'; sound/soc/sof/mediatek/mt8195/mt8195-loader.o:mt8195-
> loader.c:(.text.sof_hifixdsp_shutdown+0x0): first defined here
> 
> Caused by commits
> 
>   570c14dc92d5 ("ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops")
>   210b3ab932f7 ("ASoC: SOF: mediatek: Add mt8186 dsp clock support")
> 
> I have reverted those commits and the following
> 
>   0e0b83cc7ec7 ("ASoC: SOF: mediatek: Add DSP system PM callback for mt8186")
> 
> for today.

I'm apologies for your inconvenience.

I've pushed a quick fix at
https://lore.kernel.org/alsa-devel/20220427034425.24294-1-tinghan.shen@mediatek.com/T/#u


Thanks & Regards
TingHan

> 

