Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05034A304C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiA2P2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 10:28:17 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48420 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239029AbiA2P2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 10:28:16 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDpe6-000583-FB; Sat, 29 Jan 2022 16:28:10 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rename and sort the rk356x usb2 phy handles
Date:   Sat, 29 Jan 2022 16:28:09 +0100
Message-ID: <3736463.EBuT6JFcjP@diego>
In-Reply-To: <64f539b5-30b2-c0b7-17bf-c448b507713e@wolfvision.net>
References: <20220127190456.2195527-1-michael.riesch@wolfvision.net> <FBB7C392-C5E0-4E34-AC17-5323414623F5@gmail.com> <64f539b5-30b2-c0b7-17bf-c448b507713e@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 29. Januar 2022, 10:59:32 CET schrieb Michael Riesch:
> Hello Peter and Piotr,
> 
> On 1/29/22 10:23, Piotr Oniszczuk wrote:
> > 
> > 
> >>
> >> Good Evening,
> >>
> >> While I'm not against this idea, my main concern still stands.
> >> I spent a great deal of thought on this, and decided to go the route I
> >> did to maintain consistency with previous generations.
> >> As such, I see one of three paths here:
> >> - Pull this patch only and depart rk356x from previous SoCs.
> >> - Do the same for previous SoCs to maintain consistency.
> >> - Drop this patch to maintain consistency with previous SoCs.
> >>
> >> I ask that others weigh in here, as offline discussion has produced
> >> mixed results already.
> > 
> > just pure user perspective
> > 
> > (who spent last weeks considerable time to develop DT for rk3566 tvbox. 99% of my work was by reading/learning from other boards existing DT's. Any inconsistencies in DTs makes work for such ppl like me much more harder):
> > 
> > For option 1 - i don't see value
> > For option 2 - what is reward for extra work needs to be done on all other SoCs?
> > 
> > so option 3 seems to be natural choice...
> > 
> > in other words:
> > 
> > for me:
> > option 1 brings practically zero value + increased inconsistency.
> > option 2: extra work - but consistency is like in option 3 (so where is value?)
> > 
> > so option 3 offers the same consistency - but without extra work...
> >  
> > just my 0.02$
> 
> Of course this change is purely cosmetic and it is reasonable to ask for
> the practical value. It is just that technically the quartz64 dts is not
> sorted alphabetically at the moment. The u2phy* nodes should be but
> before the uart* nodes to follow the convention. On the other hand, it
> may be nice to have the usb2 phys and controllers grouped in the dts.
> The proposed renaming would allow all the mentioned nodes sorted
> alphabetically and grouped logically.
> 
> Therefore I had option 1 in mind. I don't see any dependencies between
> the different SoCs and think we can make a fresh start here.

correct :-) .

I do see each SoC individually and while I try to have people follow some
styling guidelines everywhere (ordering of properties, ordering of nodes)
I don't really want people to fear what some other SoC has done before.

But even these rules evolve sometimes, when something seems to work
better than before.

We have nowadays 9 years of Rockchip SoC history in the kernel.
Thanks to general dt-binding conventions most nodes have specific
names anyway (mmc@... etc), but for example trying to rename stuff
in older SoCs that has worked for years now is for one error-prone
as Michael pointed out, but also introduces unnecessary churn,
when these old SoCs (thinking of rk3188, rk3288 and friends but also things
like the rk3368) are essentially "finished" and most likely won't see that
much additional support for stuff added.


Heiko


> Option 2 is not really feasible, we would almost definitely break
> something existent.
> 
> Option 3 is feasible, of course. However, I would sort the nodes
> alphabetically (u2phy*, then uart*, then usb*). Works for me as well,
> although it is not that nice IMHO.
> 
> Since many boards with the RK3566 and RK3568 will pop up in near future
> we should do the change right now (if we want to do it), as of course
> all the board files need to be changed. Therefore I wanted to bring this
> matter up now. Let's agree on something and move on.
> 
> Best regards,
> Michael
> 




