Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0295113F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiD0JCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiD0JCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:02:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 584751E8A0E;
        Wed, 27 Apr 2022 01:58:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 79C9380E4;
        Wed, 27 Apr 2022 08:55:36 +0000 (UTC)
Date:   Wed, 27 Apr 2022 11:58:38 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
Message-ID: <YmkFvmE+2CD3Bjs+@atomide.com>
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmkBAsa+fKlp/GcV@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [220427 08:40]:
> Hi,
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [220426 20:16]:
> > Hi Tony,
> > I ran across a new issue on the OpenPandora (omap3530) first appearing with v5.18-rc1.
> > It seems as if there is something happening within the omap3 L3 irq handler which
> > is used (only?) for the wl1251. And this triggers the timeout BUG_ON() in
> > omap3_l3_app_irq().
> > 
> > I have not seen this issue on the GTA04.
> > 
> > It goes away if I remove the wlan interrupt from omap3-pandora-common.dtsi.
> > Interestingly, removing the wl1251.ko does NOT stop it. So it is not the driver.
> > 
> > git bisect reported:
> > 
> > a1c510d0adc604bb143c86052bc5be48cbcfa17c is the first bad commit
> > commit a1c510d0adc604bb143c86052bc5be48cbcfa17c
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Thu Sep 23 09:15:53 2021 +0200
> > 
> >     ARM: implement support for vmap'ed stacks
> >     
> > Any ideas?
> 
> We had to add commit 8cf8df89678a ("ARM: OMAP2+: Fix regression for smc
> calls for vmap stack") to fix vmap related issues in case you have not
> seen that one yet. This seems different though, it's like the L3 interrupt
> handler is not reading the right register?
> 
> Not sure why the L3 interrupt is triggering, that could be caused by
> another issue with the wl1251 somewhere.

Can you maybe try to temporarily disable the L3 driver and see if the stack
trace is more accurate on what goes wrong? Just comment out the line for
postcore_initcall_sync(omap3_l3_init) in drivers/bus/omap_l3_smx.c. The
system will hang on the invalid access rather than triggering the L3
error first.

Regards,

Tony
