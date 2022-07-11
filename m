Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0DA56D4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGKGj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKGj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:39:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DEE958F;
        Sun, 10 Jul 2022 23:39:19 -0700 (PDT)
X-UUID: f4fd4755152b4d7893277abe529ecfae-20220711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:67e0f1dd-950b-4808-a105-27c9b3924890,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:67e0f1dd-950b-4808-a105-27c9b3924890,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:4bf5ef63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:1b5f598990c8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: f4fd4755152b4d7893277abe529ecfae-20220711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1062755303; Mon, 11 Jul 2022 14:39:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 11 Jul 2022 14:39:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jul 2022 14:39:10 +0800
Message-ID: <9bbc0472bafa6116618e9861c3566d470c30c619.camel@mediatek.com>
Subject: Re: [PATCH 1/5] usb: mtu3: fix coverity of string buffer
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Mon, 11 Jul 2022 14:39:10 +0800
In-Reply-To: <YsfcFXtkDxe6ndFT@kroah.com>
References: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
         <YsfcFXtkDxe6ndFT@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 09:26 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 08, 2022 at 03:18:59PM +0800, Chunfeng Yun wrote:
> > Use snprintf instead of sprintf which could cause buffer overflow.
> 
> How can it cause an overflow?
Maybe I didn't describe it clearly, this patch is used to fix coverity
check warning of string buffer, in fact no overflow happens.

> 
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/mtu3/mtu3.h         | 4 +++-
> >  drivers/usb/mtu3/mtu3_debugfs.c | 2 +-
> >  drivers/usb/mtu3/mtu3_gadget.c  | 4 ++--
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
> > index 8408e1b1a24a..9893dd1bafbb 100644
> > --- a/drivers/usb/mtu3/mtu3.h
> > +++ b/drivers/usb/mtu3/mtu3.h
> > @@ -92,6 +92,8 @@ struct mtu3_request;
> >  
> >  #define BULK_CLKS_CNT	4
> >  
> > +#define MTU3_EP_NAME_LEN	12
> > +
> >  /* device operated link and speed got from DEVICE_CONF register */
> >  enum mtu3_speed {
> >  	MTU3_SPEED_INACTIVE = 0,
> > @@ -272,7 +274,7 @@ struct ssusb_mtk {
> >   */
> >  struct mtu3_ep {
> >  	struct usb_ep ep;
> > -	char name[12];
> > +	char name[MTU3_EP_NAME_LEN];
> >  	struct mtu3 *mtu;
> >  	u8 epnum;
> >  	u8 type;
> > diff --git a/drivers/usb/mtu3/mtu3_debugfs.c
> > b/drivers/usb/mtu3/mtu3_debugfs.c
> > index d27de647c86a..a6f72494b819 100644
> > --- a/drivers/usb/mtu3/mtu3_debugfs.c
> > +++ b/drivers/usb/mtu3/mtu3_debugfs.c
> > @@ -132,7 +132,7 @@ static void mtu3_debugfs_regset(struct mtu3
> > *mtu, void __iomem *base,
> >  	if (!mregs)
> >  		return;
> >  
> > -	sprintf(mregs->name, "%s", name);
> > +	snprintf(mregs->name, MTU3_DEBUGFS_NAME_LEN, "%s", name);
> 
> Where does name come from?  It looks like you control this string, so
> there is no overflow anywhere.
Yes, don't encounter overflow at all, but there is warning when scanned
by coverity in our internal project branches.

> 
> >  	regset = &mregs->regset;
> >  	regset->regs = regs;
> >  	regset->nregs = nregs;
> > diff --git a/drivers/usb/mtu3/mtu3_gadget.c
> > b/drivers/usb/mtu3/mtu3_gadget.c
> > index 30999b4debb8..a751e0533c2d 100644
> > --- a/drivers/usb/mtu3/mtu3_gadget.c
> > +++ b/drivers/usb/mtu3/mtu3_gadget.c
> > @@ -635,8 +635,8 @@ static void init_hw_ep(struct mtu3 *mtu, struct
> > mtu3_ep *mep,
> >  
> >  	INIT_LIST_HEAD(&mep->req_list);
> >  
> > -	sprintf(mep->name, "ep%d%s", epnum,
> > -		!epnum ? "" : (is_in ? "in" : "out"));
> > +	snprintf(mep->name, MTU3_EP_NAME_LEN, "ep%d%s", epnum,
> > +		 !epnum ? "" : (is_in ? "in" : "out"));
> 
> Same here, you already control this string size, so where is the
> issue?
Just fix coverity warning.

Thanks a lot

> 
> thanks,
> 
> greg k-h

