Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE36565045
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiGDJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiGDJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:03:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7319DF;
        Mon,  4 Jul 2022 02:03:18 -0700 (PDT)
X-UUID: 181d3082a46649a9a35ab648b48b4b0f-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:6ee8ed7b-a37c-43d2-a8f7-c779c099fe12,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.7,REQID:6ee8ed7b-a37c-43d2-a8f7-c779c099fe12,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:87442a2,CLOUDID:a8478cd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:f9056e83bc0f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 181d3082a46649a9a35ab648b48b4b0f-20220704
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1495964430; Mon, 04 Jul 2022 17:03:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 4 Jul 2022 17:03:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 4 Jul 2022 17:03:12 +0800
Message-ID: <cff17eda03125c7b144f934ebc633458b09d4d40.camel@mediatek.com>
Subject: Re: [PATCH v2 1/1] remoteproc: mediatek: enable cache for mt8186 SCP
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 4 Jul 2022 17:03:12 +0800
In-Reply-To: <20220701121229.22756-2-allen-kh.cheng@mediatek.com>
References: <20220701121229.22756-1-allen-kh.cheng@mediatek.com>
         <20220701121229.22756-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-01 at 20:12 +0800, Allen-KH Cheng wrote:
> This patch is for enableing cache in SCP. There is not enough space
> on the SRAM of SCP. We need to run programs in DRAM. The DRAM power
> and latency is much larger than SRAM, so cache is used to mitigate
> the negative effects for performance. we set SCP registers for cache
> size before loading SCP FW. (8KB+8KB) and also adjust ipi_buf_offset
> in SRAM from 0x7bdb0 to 0x3BDB0 for enableing cache.
> 
> This patch was tested on MediaTek mt8186.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> 

Test scp boot and scp ipc ok.

Tested-by: TingHan Shen <tinghan.shen@mediatek.com>

