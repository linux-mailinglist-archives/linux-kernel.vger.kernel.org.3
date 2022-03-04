Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508974CCE24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiCDG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiCDG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:58:00 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0FE418DAB9;
        Thu,  3 Mar 2022 22:57:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9549480E1;
        Fri,  4 Mar 2022 06:55:47 +0000 (UTC)
Date:   Fri, 4 Mar 2022 08:56:59 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QW5kcsOp?= Hentschel <nerv@dawncrow.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 6/7] bus: ti-sysc: Implement SoC revision handling
Message-ID: <YiG4O2h4oVX7CqIe@atomide.com>
References: <20200221195256.54016-1-tony@atomide.com>
 <20200221195256.54016-7-tony@atomide.com>
 <CAHCN7xJ0j4kZXiQs-5GrrKLxXYgkYJsnNDreH0MKi8mHPs_Xvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ0j4kZXiQs-5GrrKLxXYgkYJsnNDreH0MKi8mHPs_Xvw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Adam Ford <aford173@gmail.com> [220302 14:37]:
> I apologize for digging up an old thread, but I finally managed to get
> my hands on an OMAP3503.  It seems like older kernels do not boot at
> all or hang somewhere in the boot process.  I am still seeing a
> difference in behavior between OMAP3503 and OMAP3530, where 3505
> throws a bunch of splat and a kernel panic, while the 3530 appears to
> boot happily.
> 
> Using the latest 5.17-rc6, I had to remove some IVA and SGX references
> from omap_l3_smx.h to get the 3503 to stop crashing on boot.

OK interesting, I did not know those registers are not accessible
on 3503.

> Do you have any ideas how we can make the omap3_l3_app_bases and
> omap3_l3_debug_bases more cleanly remove the IVA and SGX references
> if/when OMAP3503 is detected?  I assume the same algorithm would have
> to detect a AM3703 as well.  I'm trying to get my hands on an AM3703
> to see if there is similar behavior as what I'm seeing on the
> OMAP3503.

As there are possibly multiple omap3 variants used on the same
boards, we need to rely on the runtime detection of the SoC.
So yeah soc_device_attribute is the way to go here.

I don't recall any similar issues booting 3703 but it's been a while
so worth testing for sure.

Regards,

Tony
