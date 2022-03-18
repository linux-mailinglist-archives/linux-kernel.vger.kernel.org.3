Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891924DD64B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiCRIkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiCRIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:40:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC7172E26;
        Fri, 18 Mar 2022 01:38:56 -0700 (PDT)
X-UUID: a5aae80ff55748a886439f9cafa3bc6f-20220318
X-UUID: a5aae80ff55748a886439f9cafa3bc6f-20220318
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 792840434; Fri, 18 Mar 2022 16:38:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Mar 2022 16:38:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Mar
 2022 16:38:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 16:38:44 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <moudy.ho@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <acourbot@chromium.org>, <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>, <daoyuan.huang@mediatek.com>,
        <devicetree@vger.kernel.org>, <drinkcat@chromium.org>,
        <geert+renesas@glider.be>, <hsinyi@google.com>,
        <hverkuil-cisco@xs4all.nl>, <jason-jh.lin@mediatek.com>,
        <jernej.skrabec@siol.net>, <laurent.pinchart@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <maoguang.meng@mediatek.com>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>,
        <menghui.lin@mediatek.com>, <miles.chen@mediatek.com>,
        <pihsun@chromium.org>, <ping-hsun.wu@mediatek.com>,
        <randy.wu@mediatek.com>, <river.cheng@mediatek.com>,
        <rob@landley.net>, <robh+dt@kernel.org>, <roy-cw.yeh@mediatek.com>,
        <sj.huang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <tfiga@chromium.org>
Subject: Re: [PATCH v14 6/6] soc: mediatek: mutex: add functions that operate registers by CMDQ
Date:   Fri, 18 Mar 2022 16:38:44 +0800
Message-ID: <20220318083844.24859-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <72f7feabe22064365457b5b72dfb1972ba2b3151.camel@mediatek.com>
References: <72f7feabe22064365457b5b72dfb1972ba2b3151.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

>> >  		}
>> >  	}
>> >  
>> > +	if (of_address_to_resource(dev->of_node, 0, &addr) < 0)
>> > +		mtx->addr = 0L;
>> 
>> addr is phys_addr_t, which means that it holds a physical address.
>> 0 may be a valid address in some platforms, so I think
>> we should not set mtx->addr = 0L when of_address_to_resource fails.
>> Maybe probe fail by returning dev_err_probe()?
>> 
>> Thanks,
>> Miles
>
>Hi Miles,
>
>This does lead to the situation you mentioned, and sorry for the
>deficient dts parsing flow. Maybe we should follow "gce-client" usage
>and add a check condition when needed to avoid compatibility issues?
>
>Thanks,
>Moudy

According to Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml,
it is required to have a reg field in the mutex node. So I think we can
fail in this case.

Thanks,
Miles
