Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7F472198
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhLMHUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:20:21 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44742 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229695AbhLMHUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:20:20 -0500
X-UUID: 07cee0b2e577421d86b982df49550b9e-20211213
X-UUID: 07cee0b2e577421d86b982df49550b9e-20211213
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1083407559; Mon, 13 Dec 2021 15:20:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Dec 2021 15:20:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Dec 2021 15:20:15 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <ohad@wizery.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] remoteproc: use %pe format string to print return error code
Date:   Mon, 13 Dec 2021 15:20:15 +0800
Message-ID: <20211213072015.32235-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211116162933.GA2318486@p14s>
References: <20211116162933.GA2318486@p14s>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Good day,
> 
> On Tue, Nov 16, 2021 at 09:57:03PM +0800, Mark-PK Tsai wrote:
> > > > > > Use %pe format string to print return error code which
> > > > > > make the error message easier to understand.
> > > > > >
> > > > > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > > > > ---
> > > > > >  drivers/remoteproc/remoteproc_core.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > > > index 502b6604b757..2242da320368 100644
> > > > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > > @@ -575,8 +575,8 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > > > > >                                            dma_get_mask(rproc->dev.parent));
> > > > > >         if (ret) {
> > > > > >                 dev_warn(dev,
> > > > > > -                        "Failed to set DMA mask %llx. Trying to continue... %x\n",
> > > > > > -                        dma_get_mask(rproc->dev.parent), ret);
> > > > > > +                        "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > > > > > +                        dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> > > > >
> > > > > Macro ERR_PTR() is used to convert error codes to pointer type when
> > > > > returning from a function - I fail to see how doing so in a dev_warn()
> > > > > context can make the message easier to understand.  Can you provide an
> > > > > example?
> > > >
> > > > Hi,
> > > >
> > > > When dma_coerce_mask_and_coherent() fail, the output log will be as following.
> > > >
> > > > format          log
> > > > %x              Trying to continue... fffffffb
> > > > %d              Trying to continue... -5
> > > > %pe             Trying to continue... -5        (if CONFIG_SYMBOLIC_ERRNAME is not set)
> > > > %pe             Trying to continue... -EIO      (if CONFIG_SYMBOLIC_ERRNAME=y)
> > >
> > > When failing, functions dma_coerce_mask_and_coherent() returns -EIO.
> > > Casting that to a (void *) with ERR_PTR() does not change that value.
> > > Since variable @ret is already declared as "int" the real fix is to
> > > change "%x" to "%d".
> > 
> > There're some other drivers do the same thing in the recent kernel, so I think
> > it's fine to casting the `ret` to a (void *) for more user friendly.
> > But I suppose it would depend on the maintainer's opinion.
> > 
> > So how about previous patch I sent, which also fix this issue by using %d.
> > 
> > https://lore.kernel.org/lkml/20211102120805.27137-1-mark-pk.tsai@mediatek.com/
> 
> I had not seen Russell's reply in the link you posted above.  I am not
> completely sure about his solution but his insight and guidance in kernel
> programming have precedence over mine.
> 
> I will take this patch.
> 
> Thanks,
> Mathieu
> 

Hi,

Sorry to disturb you.
Is this patch queued?
Just want to make sure it has not been forgotten.
