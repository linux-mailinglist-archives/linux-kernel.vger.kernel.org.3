Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64AF5ABAED
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIBWqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIBWqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:46:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A3786D9;
        Fri,  2 Sep 2022 15:46:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z29so5175390lfb.13;
        Fri, 02 Sep 2022 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=8JyF5h1NzfqWpROtOZhApbTwVUFn3bdqXHoSB9MDQ6Q=;
        b=jMimy5l5I4oiotjXk9cJr4xyY85ZSfbD1DEoXg6aNV8fouwI8CONs+rTpAgqtCH1+T
         ca79nzi0ofPuaAEgn1018ViDEzA29byQF5e1MtFSpGlPs43a3R21MzIWAyWLXC1xuZTU
         F1spXQFW6g3+lzWT0YcSGis1gu+rtKjgNGumpfIuPldZtZlDDRiq8XAmn8PaOR3Ld+vH
         dIwBqTIW277HRUDAVWdQ6UNJmXEHDNuTLSUjMRKgyFVidhq8gVcUY7XcDForzdkSU354
         3wdAK2hu16bhVWulujk6Jo9dEOMw2fJuU9nvSFvW9Ae7JaTUosGsxYAK8Ip4DqNaW5lZ
         v/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8JyF5h1NzfqWpROtOZhApbTwVUFn3bdqXHoSB9MDQ6Q=;
        b=CScZCH375eLPm+bf/gDjLD0L6SkrmyEpoaoWTnjrbxCwtFCvxOfprvcCJeb4485Tal
         OvNeFmkOCPlSuebWBvF8iF6bTjjqzxiE6P0IVKJDmvAoXGnIlEU98iJ/1Z8R/BJvUlDt
         BW6IvQ3dEdaNWNUldelQ221HoiV/VN4q4m2//+tRiz1Z/fm3340zvme+ha9dp3/aULy9
         OBTmxyDCjTSJxTRssEGL6kSS/s7cSKcm0qy6Ot7RdRlP0dzvey1vE8jReeb42PB/Xwjn
         PZhV7mCYxUb/oSmiazKrEZewuHyuYkoVfjZ2g9o/z6li+Vu5hiGKbN0S1NZYQExnsmkQ
         jkLw==
X-Gm-Message-State: ACgBeo2eCHfE/Tzdii99z0BfrIlIvaLxEOTQYIqpagy5WgHBDDg1hL3l
        YvY1V/rlPTgu1Qj5bCLjjFw=
X-Google-Smtp-Source: AA6agR6UpPhKUdRy7tF5AdDr2ocQqKxR8YXOGWLA/s7cUP7xh7CnnbgU/GcgvHPr2a6POowJgzvarg==
X-Received: by 2002:a05:6512:16a1:b0:48a:87a2:103c with SMTP id bu33-20020a05651216a100b0048a87a2103cmr14428914lfb.554.1662158794090;
        Fri, 02 Sep 2022 15:46:34 -0700 (PDT)
Received: from mobilestation ([83.220.236.124])
        by smtp.gmail.com with ESMTPSA id s4-20020a05651c048400b0025e040510e7sm316253ljc.74.2022.09.02.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:46:33 -0700 (PDT)
Date:   Sat, 3 Sep 2022 01:46:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MIPS: loongson32: Fix the validation failure of LS1B &
 LS1C Ethernet PHY
Message-ID: <20220902224630.tik2zt7vpwv3pcww@mobilestation>
References: <20220818050019.1924408-1-keguang.zhang@gmail.com>
 <20220821171030.wc343w6zmrtcz5to@mobilestation>
 <CAJhJPsW0HTs+=PD2JvXZVTkm9zrnRYKtEwLNv3dsVsf1AUNjDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsW0HTs+=PD2JvXZVTkm9zrnRYKtEwLNv3dsVsf1AUNjDQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 09:31:25PM +0800, Kelvin Cheung wrote:
> Hi Serge,
> Your patch also works for me.

Great. Could you submit it for review then with your tested-by tag
added?

> But what about the plat_dat->interface? Is it obsolete?

No. As I said in the patch log it's still used in the STMMAC driver
but for the MAC-PCS mode setting. Such PCS isn't available on the most
of the cases so the "phy_interface" field should be mainly utilized
instead while the "interface" field is supposed to be left untouched.
See the commit 0060c8783330 ("net: stmmac: implement support for
passive mode converters via dt") for details.

-Sergey

> 
> Serge Semin <fancer.lancer@gmail.com> 于2022年8月22日周一 01:10写道：
> >
> > Hello Keguang
> >
> > On Thu, Aug 18, 2022 at 01:00:19PM +0800, Keguang Zhang wrote:
> > > From: Kelvin Cheung <keguang.zhang@gmail.com>
> > >
> > > The Ethernet of LS1B/LS1C doesn't work due to the stmmac driver
> > > using phylink_generic_validate() instead of stmmac_validate().
> > > Moreover the driver assumes the PHY interface mode
> > > passed in platform data is always supported.
> > >
> > > stmmaceth stmmaceth.0 eth0: validation of gmii with support 00000000,00000000,000062cf and advertisement 00000000,00000000,000062cf failed: -EINVAL
> > > stmmaceth stmmaceth.0 eth0: stmmac_open: Cannot attach to PHY (error: -22)
> > >
> > > This patch sets phy_interface field of platform data.
> >
> > I've got a similar fix in my repo, though didn't have a chance to test
> > it out due to lacking any loongson hardware. I've discovered the
> > issues on my still going way of the STMMAC driver refactoring. Anyway
> > IMO the problem is a bit different than you describe and should be
> > fixed in a bit different way. Please see a patch attached to this
> > email. Could you test it out on your hw? If it fixes the problem you
> > can resend it as v2 patch.
> >
> > -Sergey
> >
> > >
> > > Fixes: 04a0683f7db4 ("net: stmmac: convert to phylink_generic_validate()")
> > > Fixes: d194923d51c9 ("net: stmmac: fill in supported_interfaces")
> > > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > > ---
> > >  arch/mips/loongson32/common/platform.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> > > index 794c96c2a4cd..741aace80b80 100644
> > > --- a/arch/mips/loongson32/common/platform.c
> > > +++ b/arch/mips/loongson32/common/platform.c
> > > @@ -147,8 +147,10 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
> > >       .phy_addr               = -1,
> > >  #if defined(CONFIG_LOONGSON1_LS1B)
> > >       .interface              = PHY_INTERFACE_MODE_MII,
> > > +     .phy_interface          = PHY_INTERFACE_MODE_MII,
> > >  #elif defined(CONFIG_LOONGSON1_LS1C)
> > >       .interface              = PHY_INTERFACE_MODE_RMII,
> > > +     .phy_interface          = PHY_INTERFACE_MODE_RMII,
> > >  #endif
> > >       .mdio_bus_data          = &ls1x_mdio_bus_data,
> > >       .dma_cfg                = &ls1x_eth_dma_cfg,
> > >
> > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > > --
> > > 2.34.1
> > >
> 
> 
> 
> -- 
> Best regards,
> 
> Kelvin Cheung
