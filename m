Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B778D5004B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiDNDnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiDNDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:43:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB615A0E;
        Wed, 13 Apr 2022 20:40:44 -0700 (PDT)
X-UUID: c05a8078b41941aa8233f4154241fc9b-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:818fe170-59ba-46af-8fc6-e370c6b59fba,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:a40217a9-d103-4e36-82b9-b0e86991b3df,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: c05a8078b41941aa8233f4154241fc9b-20220414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906566215; Thu, 14 Apr 2022 11:40:39 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Apr 2022 11:40:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Apr
 2022 11:40:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 11:40:37 +0800
Message-ID: <fc1e157470d7ad68efd823f38fe4a360ba3dfbde.camel@mediatek.com>
Subject: Re: [PATCH V2 12/15] cpufreq: mediatek: Use maximum voltage in init
 stage
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 14 Apr 2022 11:40:37 +0800
In-Reply-To: <5f788a8f-7092-19ca-8499-d3626c4a386d@collabora.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-13-rex-bc.chen@mediatek.com>
         <5f788a8f-7092-19ca-8499-d3626c4a386d@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-08 at 15:37 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > Two or more clients may use the same regulator, and it could cause
> > the
> > issue of high-freqeuncy-low-voltage.
> > To prevent this, we use maximum voltage in
> > mtk_cpu_dvfs_info_init().
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Is this happening for proc-supply (proc_reg)?
> ...because it looks like it is, so you should send this commit
> separately
> and with an appropriate Fixes: tag.

Hello all,

If we use the value of max(booting voltage, target cpufreq voltage)
when cci is not ready, I think we don't need this patch to prevent high
frequenc low voltage issue.
(mentioned in [1])

I will drop this patch in next version.

Thanks.

[1]:https://patchwork.kernel.org/comment/24816091/

BRs,
Rex

