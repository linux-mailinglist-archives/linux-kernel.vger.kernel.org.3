Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E430F5973EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiHQQNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiHQQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:12:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8396A1A7D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:12:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oOLeF-0004Ag-27; Wed, 17 Aug 2022 18:12:03 +0200
Message-ID: <f4483d7d55f1f1f4dcd0ad020840561481aa2fd8.camel@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH 1/3] dma-buf: heaps: add Linaro secure dmabuf
 heap support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Olivier Masse <olivier.masse@nxp.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>
Cc:     =?ISO-8859-1?Q?Cl=E9ment?= Faure <clement.faure@nxp.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "nd@arm.com" <nd@arm.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Date:   Wed, 17 Aug 2022 18:12:01 +0200
In-Reply-To: <eef2fc413695cb96a5071627bfe44830f80cfe9e.camel@ndufresne.ca>
References: <20220805135330.970-1-olivier.masse@nxp.com>
         <20220805135330.970-2-olivier.masse@nxp.com>
         <20220805154139.2qkqxwklufjpsfdx@000377403353>
         <7e61668164f8bf02f6c4ee166e85abc42b5ee958.camel@nxp.com>
         <20220812163922.v7sf3havi5dpgi5u@000377403353>
         <de46324d8fa8fb6a8dda4641e531d30842410744.camel@nxp.com>
         <eef2fc413695cb96a5071627bfe44830f80cfe9e.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 17.08.2022 um 10:29 -0400 schrieb Nicolas Dufresne:
> Hi Folks,
> 
> Le mardi 16 août 2022 à 11:20 +0000, Olivier Masse a écrit :
> > Hi Brian,
> > 
> > 
> > On ven., 2022-08-12 at 17:39 +0100, Brian Starkey wrote:
> > > Caution: EXT Ema
> > > 
> 
> [...]
> 
> > > 
> > > Interesting, that's not how the devices I've worked on operated.
> > > 
> > > Are you saying that you have to have a display controller driver
> > > running in the TEE to display one of these buffers?
> > 
> > In fact the display controller is managing 3 plans : UI, PiP and
> > video. The video plan is protected in secure as you can see on slide
> > 11:
> > https://static.linaro.org/connect/san19/presentations/san19-107.pdf
> 
> 
> 
> just wanted to highlight that all the WPE/GStreamer bit in this presentation is
> based on NXP Vendor Media CODEC design, which rely on their own i.MX VPU API. I
> don't see any effort to extend this to a wider audience. It is not explaining
> how this can work with a mainline kernel with v4l2 stateful or stateless drivers
> and generic GStreamer/FFMPEG/Chromium support.
> 
> I'm raising this, since I'm worried that no one cares of solving that high level
> problem from a generic point of view. In that context, any additions to the
> mainline Linux kernel can only be flawed and will only serves specific vendors
> and not the larger audience.
> 
> Another aspect, is that this design might be bound to a specific (NXP ?)
> security design. I've learn recently that newer HW is going to use multiple
> level of MMU (like virtual machines do) to protect the memory rather then
> marking pages. Will all this work for that too ?
> 
I have not looked in any of this for quite a while, but IIRC the plan
was something like that:

The NXP RDC hardware is able to segment the DDR memory into sections
and define access policies for all masters in the system. So for
example for the secure VPU to display controller path you would define
such a section, where only the VPU is able to write and DCSS is able to
read from. CPU or other masters are not allowed to use this section.
This then gets exposed to Linux as a DMA heap. The VPU driver could
then allocate capture buffers from this heap and share them via dma-buf
to the DCSS driver.
Both drivers can live in non-trusted userspace and even the address
allocation for the DMA heap can be done from Linux. Non-trusted Linux
kernel/userspace just has no way to access the buffers directly.

The more interesting question is on the VPU side: how do you make sure
that the capture buffer is located in secure memory when the output
buffer containing the secret bitstream is also in a secure heap? I
guess you need some kind of TEE application to validate those settings,
which means you can't give the non-trusted driver direct MMIO access to
the VPU.

Regards,
Lucas

