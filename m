Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82C44B0785
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiBJHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:50:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiBJHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:50:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089F1086
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:50:03 -0800 (PST)
X-UUID: 6cdd44ab8bbd4f69b30eb8ff0670bc6a-20220210
X-UUID: 6cdd44ab8bbd4f69b30eb8ff0670bc6a-20220210
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 459675619; Thu, 10 Feb 2022 15:49:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Feb 2022 15:49:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Feb 2022 15:49:53 +0800
Message-ID: <face7ccf80520ecad1b75f01f74314ddb483b88b.camel@mediatek.com>
Subject: Re: [RFC PATCH] component: Add common helpers for compare/release
 functions
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        <dri-devel@lists.freedesktop.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "James Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        <iommu@lists.linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-kernel@vger.kernel.org>, "Joerg Roedel" <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Rob Clark <robdclark@gmail.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Date:   Thu, 10 Feb 2022 15:49:53 +0800
In-Reply-To: <29deffd6-aac4-f085-bcd5-f5a2d02784a8@arm.com>
References: <20220128081101.27837-1-yong.wu@mediatek.com>
         <29deffd6-aac4-f085-bcd5-f5a2d02784a8@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-28 at 13:04 +0000, Robin Murphy wrote:
> On 2022-01-28 08:11, Yong Wu wrote:
> [...]
> > diff --git a/include/linux/component.h b/include/linux/component.h
> > index 16de18f473d7..5a7468ea827c 100644
> > --- a/include/linux/component.h
> > +++ b/include/linux/component.h
> > @@ -2,6 +2,8 @@
> >   #ifndef COMPONENT_H
> >   #define COMPONENT_H
> >   
> > +#include <linux/device.h>
> > +#include <linux/of.h>
> >   #include <linux/stddef.h>
> >   
> >   
> > @@ -82,6 +84,22 @@ struct component_master_ops {
> >   	void (*unbind)(struct device *master);
> >   };
> >   
> > +/* A set common helpers for compare/release functions */
> > +static inline int compare_of(struct device *dev, void *data)
> > +{
> > +	return dev->of_node == data;
> > +}
> 
> Note that this is effectively just device_match_of_node(), although
> I 
> guess there is an argument that having a nice consistent set of 
> component_match API helpers might be worth more than a tiny code
> saving 
> by borrowing one from a different API.

Thanks for this tip. I could try use this, Let the maintainer decide.

> 
> Either way, however, I don't think there's any good argument for 
> instantiating separate copies of these functions in every driver
> that 
> uses them. If they're used as callbacks then they can't actually be 
> inlined anyway, so they may as well be exported from component.c as 

oh. The MTK iommu keeps this inline for long time... OK, I will try
to move into the component.c and export them.

(Sorry for the late reply due to New Year holidays.)

> normal so that the code really is shared (plus then there's nice 
> symmetry with the aforementioned device_match API helpers too).
> 
> Thanks,
> Robin.
  

