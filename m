Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7196A59EADA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiHWSWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiHWSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC74D4E9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661272738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xe29dpH/lEwoUgqXwXUV/OMUbK9mfNYESN56Bn6Kzu4=;
        b=h8i3ZF1w8xZH7LSICIqdhLRhzQiS4uFZLtvu4bUrXEP6o8H/6Kfapxjlo66MF2QcR5GtMv
        9UXi1pKD2reSsrnXUyW43bDpc9p33+/LYQr/mFzBFlwc930ESJamJxJ11W4KHfJcAvE9Zc
        rUcwNTxi6Xwi2baKeXUAHRUA7g1odgQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-joQNCANQNbuH5uDalBXHew-1; Tue, 23 Aug 2022 12:38:17 -0400
X-MC-Unique: joQNCANQNbuH5uDalBXHew-1
Received: by mail-qt1-f198.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so10901025qtb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=xe29dpH/lEwoUgqXwXUV/OMUbK9mfNYESN56Bn6Kzu4=;
        b=dmNAVsLs854rXYQHjcFPVj3mxlWs9KwmkcSX4nTxe7WDAyLqYdblC1lc7XuEvEAalN
         5ime52YkMbv1dzaQabNO4ubOKB4ly32FDV0ieC8WxpNxGXJwoYbiPsbZ4Y73YpsuuhQ+
         SZmwgU8N2ck18MZna+wII7DuZWCUCImSTGqMTVkFbNS3PZrqlkkCR/n3uYnEvV/ZMrtZ
         lOxXp7ADbsDN1XM3JFKCEjCQXUgA/83hHx/D4hRlnVqRR0CGKV+/V5j7M2PYA/+19Om6
         C57yQvNZVVKmFl1SZGHznqqdNRec5+EL7luxBA8SZCS+7DwwHZPWKnzyxzeKLWP3h15U
         nfBw==
X-Gm-Message-State: ACgBeo0FXFoBGiZ4UvTQIYnGDSnKW5IEKzgjuvTHv203iTwu3yePmQ5N
        iJ25EYo6Ay2sE0G9jXRC4oC8GYgWc/JSRm60o8qIN7YVZIk2BQzwIBf9SALw6DNlV88Vo+AT/PD
        DkrFFI06Wecbrp4T8MGdSIqQc
X-Received: by 2002:ad4:5aae:0:b0:496:dd09:9cc6 with SMTP id u14-20020ad45aae000000b00496dd099cc6mr10131378qvg.130.1661272685342;
        Tue, 23 Aug 2022 09:38:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7hiUx6KqHne7ie641hJobc8RQc2G0WUgp2XEXEJJ0nVJG12HNX/e7DZI8cUcUAGpyGHTvJlQ==
X-Received: by 2002:ad4:5aae:0:b0:496:dd09:9cc6 with SMTP id u14-20020ad45aae000000b00496dd099cc6mr10131352qvg.130.1661272685049;
        Tue, 23 Aug 2022 09:38:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a0d8900b006bc0c544d01sm6580768qkl.131.2022.08.23.09.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:38:04 -0700 (PDT)
Message-ID: <d6cfce0d7210762bf0c4130ea4d59470cbabfb56.camel@redhat.com>
Subject: Re: [PATCH 2/4] net: mediatek: sgmii: ensure the SGMII PHY is
 powered down on configuration
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alexander 'lynxis' Couzens <lynxis@fe80.eu>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Golle <daniel@makrotopia.org>
Date:   Tue, 23 Aug 2022 18:38:00 +0200
In-Reply-To: <20220823161712.2cafa970@javelin>
References: <20220820224538.59489-1-lynxis@fe80.eu>
         <20220820224538.59489-3-lynxis@fe80.eu>
         <efd1c89e3bbd7364ef381292c9ceff430cbeda8d.camel@redhat.com>
         <20220823161712.2cafa970@javelin>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-23 at 16:17 +0200, Alexander 'lynxis' Couzens wrote:
> On Tue, 23 Aug 2022 15:18:31 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On Sun, 2022-08-21 at 00:45 +0200, Alexander Couzens wrote:
> > > The code expect the PHY to be in power down which is only true
> > > after reset. Allow changes of the SGMII parameters more than once.
> > > 
> > > Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> > > ---
> > >  drivers/net/ethernet/mediatek/mtk_sgmii.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_sgmii.c
> > > b/drivers/net/ethernet/mediatek/mtk_sgmii.c index
> > > a01bb20ea957..782812434367 100644 ---
> > > a/drivers/net/ethernet/mediatek/mtk_sgmii.c +++
> > > b/drivers/net/ethernet/mediatek/mtk_sgmii.c @@ -7,6 +7,7 @@
> > >   *
> > >   */
> > >  
> > > +#include <linux/delay.h>
> > >  #include <linux/mfd/syscon.h>
> > >  #include <linux/of.h>
> > >  #include <linux/phylink.h>
> > > @@ -24,6 +25,9 @@ static int mtk_pcs_setup_mode_an(struct mtk_pcs
> > > *mpcs) {
> > >  	unsigned int val;
> > >  
> > > +	/* PHYA power down */
> > > +	regmap_write(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL,
> > > SGMII_PHYA_PWD);  
> > 
> > in mtk_pcs_setup_mode_an() and in mtk_pcs_setup_mode_force() the code
> > carefully flips only the SGMII_PHYA_PWD bit. Is it safe to overwrite
> > the full register contents?
> 
> I've read out the register without my patch and it's 0x0. The old driver
> worked as long the engine came out of reset.
> When writing the single bit SGMII_PHYA_PWD (0x10), the register might
> end up containing 0x19 and as long 0x9 is in the register the link
> doesn't work.
> 
> I've tested the driver with a mt7622 and Daniel Golle tested it with a
> mt7986.
> 
> 
> > 
> > > +
> > >  	/* Setup the link timer and QPHY power up inside SGMIISYS
> > > */ regmap_write(mpcs->regmap, SGMSYS_PCS_LINK_TIMER,
> > >  		     SGMII_LINK_TIMER_DEFAULT);
> > > @@ -36,6 +40,10 @@ static int mtk_pcs_setup_mode_an(struct mtk_pcs
> > > *mpcs) val |= SGMII_AN_RESTART;
> > >  	regmap_write(mpcs->regmap, SGMSYS_PCS_CONTROL_1, val);
> > >  
> > > +	/* Release PHYA power down state
> > > +	 * unknown how much the QPHY needs but it is racy without
> > > a sleep
> > > +	 */
> > > +	usleep_range(50, 100);  
> > 
> > Ouch, this looks fragile, without any related H/W specification. 
> 
> The datasheet [1] doesn't say anything about it. I'ven't found a
> mediatek SDK which adds a usleep(). It seems they always expect the
> SGMII came out of reset and don't change after initial configured.
> But without it, it's racy.
> 
> [1] MT7622 Reference Manual, v1.0, 2018-12-19, 1972 pages

I see. 

Since it looks like a new revision of this patchset will be needed - as
per Russell comments - I suggest to extend/replace the comments with
something more alike this longer description, it will make the future
mainteinance simpler.

Thanks,

Paolo

