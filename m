Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246F84A67A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiBAWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiBAWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:20:12 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23397C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:20:10 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1nF1VK-0004B3-6t; Tue, 01 Feb 2022 23:20:02 +0100
Date:   Tue, 1 Feb 2022 22:19:59 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     justinkb@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
Message-ID: <YfmyD7bmJS9f+e+m@makrotopia.org>
References: <20220130024335.114461-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130024335.114461-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:43:35AM +0800, Jiasheng Jiang wrote:
> On Fri, Jan 28, 2022 at 10:26:51PM +0800, Paul Mulders wrote:
> > I guess this breaks all MT7622 SoCs since it'll prematurely exit
> > init_clks (and subsequently init_scp) completely once devm_clk_get
> > fails to get a reference to the mm clock producer (which happens to be
> > the first one tried). This is because MT7623 has a GPU (so no mm
> > clock) and MT7622 doesn't, and as a result the other clock producer
> > pointers never get initialized (and other stuff in init_scp after
> > returning from the error never happens).
> >
> > The patch seems fundamentally flawed, I guess it was either not tested
> > at all, or only tested on a MT7623. The initialization functions seem
> > designed with the idea that it's ok if some clocks aren't present, so
> > stopping the initialization when one of them isn't present seems
> > wrong. (For example, there is also a MT7622B variant of the MT7622
> > which probably also lacks some clocks MT7622(A) does have).
> 
> I don't think the patch for init_clks() is flawed.
> At most it is incompleted.
> What it did is like fixing a potential error in the tool platform
> providing service for the upper application, like what you said,
> MT7623 and MT7622.
> We should not keep the error in the platform because of the upper
> application.
> And it seems like it is MT7622 that is flawed.
> The better way is to fix both the bug in init_clks() and its caller,
> MT7622.

I agree that further cleaning is needed here.
Yet the commit in it's current form very obviously breaks at least the
MT7622 platform if no further fixes are applied.

Imho the whole approach of this driver to hard-code the names of all
clocks it could try to grab in a string-array accompanied by an enum
is flawed.

The correct approach would likely be to add the clocks actually present
to the device tree of each SoC and then grab only those.

I can see that mt2701.dtsi and mt7623.dtsi both have some clocks
defined for scpsys, mt7622.dtsi however lacks them.
I didn't check other MediaTek SoCs which also use scpsys.
