Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C3544E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiFIOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFIOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:00:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC1B31;
        Thu,  9 Jun 2022 07:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1A96B82D5B;
        Thu,  9 Jun 2022 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9FAC34114;
        Thu,  9 Jun 2022 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654783214;
        bh=LmGPGQgFlXDp39gkuaUh/QQ94CuUMZoIes/TMms8Jfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F22F5K/aPgI/wT/JwFq3XZhGIWh9x6u3peG/NtDCkXeoOvHm2BToOMwNFhQFopdwm
         +7atn6OwSfogpGGrhsA082Fk807mMpFGQ0olpsjEk0dqSBniHrLDK/U67dTVW/DFnF
         7lWOJGc7L5f7Yed98S6MvagMr2R9+PpVHvHrkvB+hB9vjP6B4E4JpmPIk3l4itdrZq
         vLqMb/sEfG6uaPiAQ1DtQqipPWyETU49oMR6z5WqbZ6YNYgOwM0y3a2dyfZIOqVmXj
         CCs2220Q22QLKKAWceh5PpRuVhDqVH0KDQEIqhJSs3bEM69HajO1jvV2EEUrWdnAbx
         JEkAVA26cc9VA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzIhm-0005EB-Ke; Thu, 09 Jun 2022 16:00:10 +0200
Date:   Thu, 9 Jun 2022 16:00:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        gushengxian <gushengxian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: flexcop-usb: fix sanity check of bNumEndpoints
Message-ID: <YqH86qB4wfYctyYP@hovoldconsulting.com>
References: <20220602055027.849014-1-dzm91@hust.edu.cn>
 <YphciEToNtxIUrzU@hovoldconsulting.com>
 <CAD-N9QUfeN7qQ-S20x9mU=-rd38nPFeont2dYT2+-phTxdqMvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QUfeN7qQ-S20x9mU=-rd38nPFeont2dYT2+-phTxdqMvA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 09:42:15AM +0800, Dongliang Mu wrote:
> On Thu, Jun 2, 2022 at 2:45 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Jun 02, 2022 at 01:50:24PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > Commit d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type
> > > ") adds a sanity check for endpoint[1], but fails to modify the sanity
> > > check of bNumEndpoints.
> > >
> > > Fix this by modifying the sanity check of bNumEndpoints to 2.
> >
> > Are you sure that d725d20e81c2 ("media: flexcop-usb: sanity checking of
> > endpoint type) was correct?
> 
> I am not sure if fc_usb->uintf->cur_altsetting->endpoint[1] is right or not.
> 
> But the sanity check of bNumEndpoints does not match the following dereference.

I should know better than try to be subtle on the internet: Your fix is
wrong.

You need to try to understand the code you're changing. Not just do
pattern matching.

> > > Fixes: d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type")
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
> > > index 7835bb0f32fc..eb54bfdda01f 100644
> > > --- a/drivers/media/usb/b2c2/flexcop-usb.c
> > > +++ b/drivers/media/usb/b2c2/flexcop-usb.c
> > > @@ -509,7 +509,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
> > >               return ret;
> > >       }
> > >
> > > -     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
> > > +     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 2)
> > >               return -ENODEV;
> > >       if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[1].desc))
> > >               return -ENODEV;
> >
> > It looks like it should have verified the type of endpoint[0] here
> > instead.
> 
> This sanity check originally makes sure the
> fc_usb->uintf->cur_altsetting->endpoint[0] in
> flexcop_usb_transfer_init.

Yes, and that is the only endpoint that this driver uses.

I've posted a fix here:

	https://lore.kernel.org/r/20220609135341.19941-1-johan@kernel.org

Johan
