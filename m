Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A726A5A679D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiH3PpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3PpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:45:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE513F12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0rngN2Nly2Td71lXPLgCZdlPaLmW/RE3t+pErTGRmOg=; b=i4t5QpuE62W/R0OPwt7BoikIOg
        qkvx7dNlculI+V9fFOnhxHhGQdlLv41mEyF8oVKDElfC+Q5zB9d7RwyKC8608wBCtAY3u+SP8AwYi
        cBQHSPuPzKWfZ3rVG9OQdabM1xar0TF+Saz+aqxMcjRP1dhktJYGV2g+v3FNGJ/YVr6wAKHLbc5ET
        Ouk8TMMu5RkOrGmGyGM8spP+M7879Z8CdTP6MH40dsTKCqRiF2eiKYN0PsdCm/uLaGmY9Xn24pECw
        /xYonHXfHc/hVvL7WuBYeqtq6xLX5ksyZdwMcmY+QuYRqjO6d4grSoP4V60QciZY4ccbpiViteH7S
        ubQzV0kg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34004)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oT3Q1-0002z9-S5; Tue, 30 Aug 2022 16:44:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oT3Pw-0001fS-Ub; Tue, 30 Aug 2022 16:44:44 +0100
Date:   Tue, 30 Aug 2022 16:44:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        arnd@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
Message-ID: <Yw4wbMeQqpMbTwBw@shell.armlinux.org.uk>
References: <cover.1650539846.git.robin.murphy@arm.com>
 <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com>
 <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
 <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com>
 <CAMSo37XmxGn4VJJXwOca=mjHfmgYoh-i4bOs_DpP2LdjaN87wA@mail.gmail.com>
 <5c617d66-f04b-df26-bf7a-7f479d081ac2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c617d66-f04b-df26-bf7a-7f479d081ac2@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:36:19PM +0100, Robin Murphy wrote:
> On 2022-08-30 16:19, Yongqin Liu wrote:
> > Hi, Robin
> > 
> > Thanks for the kind reply!
> > 
> > On Tue, 30 Aug 2022 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote:
> > > 
> > > On 2022-08-27 13:24, Yongqin Liu wrote:
> > > > Hi, Robin, Christoph
> > > > 
> > > > With the changes landed in the mainline kernel,
> > > > one problem is exposed with our out of tree pvr module.
> > > > Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
> > > > the format like the following:
> > > >       arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> > > > DMA_FROM_DEVICE);
> > > > 
> > > > Not sure if you could give some suggestions on what I should do next
> > > > to make the pvr module work again.
> > > 
> > > Wow, that driver reinvents so many standard APIs for no apparent reason
> > > it's not even funny.
> > > 
> > > Anyway, from a brief look it seemingly already knows how to call the DMA
> > > API semi-correctly, so WTF that's doing behind an #ifdef, who knows?
> > > However it's still so completely wrong in general - fundamentally broken
> > > AArch64 set/way cache maintenance!? - that it looks largely beyond help.
> > > "Throw CONFIG_DMA_API_DEBUG at it and cry" is about the extent of
> > > support I'm prepared to provide for that mess.
> > 
> > For the moment, I do not care about the AArch64 lines, like if we only
> > say the following two lines:
> >      arm_dma_ops.sync_single_for_device(NULL, pStart, pEnd - pStart,
> > DMA_TO_DEVICE);
> >      arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> > DMA_FROM_DEVICE);
> > 
> > Could you please give some suggestions for that?
> 
> Remove them. Then remove the #ifdef __arch64__ too, since the code under
> there is doing a passable impression of generic DMA API usage, as long as
> one ignores the bigger picture.
> 
> arm64 already uses dma-direct. To say you don't care about the arm64 code
> when asking how to deal with ARM having now been converted to use dma-direct
> as well is supremely missing the point.

It should also be pointed out that this culture of bodging around the
DMA API by graphics drivers is entirely their own problem. If they used
the proper interfaces that the kernel provides (like the DMA API) rather
than thinking "I need to flush the caches in such-and-such a way here"
so I need to find a function somewhere in the kernel's interfaces that
I can get to in order to achieve that, and I don't care how that's done
then maybe their code wouldn't keep breaking.

This is really not our problem to solve.

This is not limited to just PVR. I've seen it with other stuff as well,
and it's the reason I was not in favour of exposing the dmac_*
functions that we have in arch/arm/mm - which are part of the DMA API
implementation, being moved into a header file. One can see from PVR
that they also made use of these before I intentionally hid them from
driver modules.

Basically, out of tree graphics drivers will bodge around to get access
to the specific cache manangement that they want to use - even if it
means abusing stuff that may mean that their crappy drivers break when
we make later changes.

As I say, it's entirely _their_ problem to solve if they don't want to
use our official interfaces. Or, they can decide to use our official
interfaces, which would be nice.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
