Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A950D95D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiDYGY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiDYGYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:24:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2C13AA63;
        Sun, 24 Apr 2022 23:20:52 -0700 (PDT)
X-UUID: 7d7dd1a2c46c45448383c19f538b1ff3-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:55a30fbe-1aa7-41b0-9a24-5ac3f53f736c,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:53
X-CID-INFO: VERSION:1.1.4,REQID:55a30fbe-1aa7-41b0-9a24-5ac3f53f736c,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:53
X-CID-META: VersionHash:faefae9,CLOUDID:000ffdef-06b0-4305-bfbf-554bfc9d151a,C
        OID:5c2a2e49368b,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 7d7dd1a2c46c45448383c19f538b1ff3-20220425
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1765017538; Mon, 25 Apr 2022 14:20:48 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Apr 2022 14:20:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 14:20:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 14:20:46 +0800
Message-ID: <88b2103944768732ab813c294bce88097321f501.camel@mediatek.com>
Subject: Re: [PATCH V4 00/14] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 25 Apr 2022 14:20:46 +0800
In-Reply-To: <af95f353-c91d-844e-3bc1-e052f7d16e54@linaro.org>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <af95f353-c91d-844e-3bc1-e052f7d16e54@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-22 at 19:23 +0200, Krzysztof Kozlowski wrote:
> On 22/04/2022 09:52, Rex-BC Chen wrote:
> > 
> > Reference series:
> > [1]: V1 of this series is present by Jia-Wei Chang.
> >      message-id:20220307122151.11666-1-jia-wei.chang@mediatek.com
> > 
> > [2]: The MediaTek CCI devfreq driver is introduced in another
> > series.
> >      message-id:20220408052150.22536-1-johnson.wang@mediatek.com
> > 
> > [3]: The MediaTek SVS driver is introduced in another series.
> >      message-id:20220221063939.14969-1-roger.lu@mediatek.com
> 
> These are not proper links. Please use lore references.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

I will use lore references in next version.
Thanks.

BRs,
Rex

