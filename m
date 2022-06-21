Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD17553419
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350061AbiFUOAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345600AbiFUOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:00:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A41CFC0;
        Tue, 21 Jun 2022 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655820041; x=1687356041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HaIHmdDuWNWs5ZY/z5rbTpXTCQ5tcbRSe3Xe+h2LBBU=;
  b=dK0yhS23np6whT1VvrB459g+eiuGTeT4eXwjq9+jkr0IjTWBnJJPVP/j
   EGc/YL/qwwoiDZh3QThJtdzbnGcoWXrBieH1GuCZyF+0oOUrivjUhPvm8
   FIzr1u/W/4pa4DbCzLj9NQ87pn33FLDuAxg/z8MJJDec1ciln7nsL0MkU
   y4j71WYW/H5F74FoiwVYOX5BUmZmZ8bLyxeRP5CHiQJ34s34FvwN06AfJ
   Um0HNPl37T3wFF4WRB9jsYiWst6mkRa0Ffw7Ysb+3Ai/SlaefCm7rP6bv
   z3S3PjWToBERizN1gsVaIg7a3XMpHM+d6M/vzCmBE91aMY6T4LoRvn+sN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="277672115"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="277672115"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:00:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="714983313"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:00:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o3eQl-000rZF-Rb;
        Tue, 21 Jun 2022 17:00:35 +0300
Date:   Tue, 21 Jun 2022 17:00:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: mxs_lradc_ts: Warning due to "0 is an invalid IRQ number"
Message-ID: <YrHPA+TBKZU/RuSz@smile.fi.intel.com>
References: <CAOMZO5D7z=Eg=WYgzrpqn9VoU8HxMeBbEZiv9KLjMVD1_kRo+w@mail.gmail.com>
 <20200701224145.GA3616172@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701224145.GA3616172@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Marc in case I'm utterly wrong in my conclusion below.

On Wed, Jul 01, 2020 at 05:41:45PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 01, 2020 at 12:32:48PM -0300, Fabio Estevam wrote:
> > On Tue, Jun 16, 2020 at 8:52 PM Fabio Estevam <festevam@gmail.com> wrote:
> > > I am seeing the following warning on a imx28-evk running linux-next:
> > >
> > > [    7.625012] ------------[ cut here ]------------
> > > [    7.630111] WARNING: CPU: 0 PID: 1 at drivers/base/platform.c:317
> > > __platform_get_irq_byname+0x74/0x90
> > > [    7.639692] 0 is an invalid IRQ number
> > > [    7.643540] Modules linked in:
> > > [    7.646961] CPU: 0 PID: 1 Comm: swapper Not tainted
> > > 5.8.0-rc1-next-20200616-dirty #92
> > > [    7.654896] Hardware name: Freescale MXS (Device Tree)
> > > [    7.660434] [<c00105ec>] (unwind_backtrace) from [<c000e070>]
> > > (show_stack+0x10/0x14)
> > > [    7.668591] [<c000e070>] (show_stack) from [<c001aa90>] (__warn+0xe4/0x108)
> > > [    7.675941] [<c001aa90>] (__warn) from [<c001ab20>]
> > > (warn_slowpath_fmt+0x6c/0xb8)
> > > [    7.683575] [<c001ab20>] (warn_slowpath_fmt) from [<c0491b44>]
> > > (__platform_get_irq_byname+0x74/0x90)
> > > [    7.693101] [<c0491b44>] (__platform_get_irq_byname) from
> > > [<c0491b70>] (platform_get_irq_byname+0x10/0x48)
> > > [    7.703154] [<c0491b70>] (platform_get_irq_byname) from
> > > [<c056e234>] (mxs_lradc_ts_probe+0x190/0x384)
> > > [    7.712771] [<c056e234>] (mxs_lradc_ts_probe) from [<c0491850>]
> > > (platform_drv_probe+0x48/0x98)
> > > [    7.722806] [<c0491850>] (platform_drv_probe) from [<c048f7f0>]
> > > (really_probe+0x218/0x348)
> > > [    7.731530] [<c048f7f0>] (really_probe) from [<c048fa28>]
> > > (driver_probe_device+0x58/0xb4)
> > > [    7.740189] [<c048fa28>] (driver_probe_device) from [<c048fc2c>]
> > > (device_driver_attach+0x58/0x60)
> > > [    7.749471] [<c048fc2c>] (device_driver_attach) from [<c048fcb8>]
> > > (__driver_attach+0x84/0xc0)
> > > [    7.758394] [<c048fcb8>] (__driver_attach) from [<c048db28>]
> > > (bus_for_each_dev+0x70/0xb4)
> > > [    7.766977] [<c048db28>] (bus_for_each_dev) from [<c048eb24>]
> > > (bus_add_driver+0x154/0x1e0)
> > > [    7.775385] [<c048eb24>] (bus_add_driver) from [<c0490774>]
> > > (driver_register+0x74/0x108)
> > > [    7.783872] [<c0490774>] (driver_register) from [<c000a2fc>]
> > > (do_one_initcall+0x68/0x268)
> > > [    7.792467] [<c000a2fc>] (do_one_initcall) from [<c0a00fa0>]
> > > (kernel_init_freeable+0x160/0x1f4)
> > > [    7.801661] [<c0a00fa0>] (kernel_init_freeable) from [<c0720c58>]
> > > (kernel_init+0x8/0xf4)
> > > [    7.810165] [<c0720c58>] (kernel_init) from [<c0008510>]
> > > (ret_from_fork+0x14/0x24)
> > > [    7.818101] Exception stack(0xc748dfb0 to 0xc748dff8)
> > > [    7.823273] dfa0:                                     00000000
> > > 00000000 00000000 00000000
> > > [    7.831815] dfc0: 00000000 00000000 00000000 00000000 00000000
> > > 00000000 00000000 00000000
> > > [    7.840351] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > [    7.847322] irq event stamp: 273303
> > > [    7.850940] hardirqs last  enabled at (273311): [<c0066ed8>]
> > > console_unlock+0x390/0x534
> > > [    7.859314] hardirqs last disabled at (273328): [<c0066b8c>]
> > > console_unlock+0x44/0x534
> > > [    7.867605] softirqs last  enabled at (273344): [<c00097fc>]
> > > __do_softirq+0x2d4/0x450
> > > [    7.875817] softirqs last disabled at (273355): [<c001fe48>]
> > > irq_exit+0x150/0x174
> > > [    7.883472] ---[ end trace ddb222ada5cbf5cd ]---
> > > [    7.900004] input: mxs-lradc-ts as
> > > /devices/soc0/80000000.apb/80040000.apbx/80050000.lradc/mxs-lradc-ts/input/input0
> > >
> > > The touchscreen irq is defined as:
> > >
> > > enum mx28_lradc_irqs {
> > > MX28_LRADC_TS_IRQ = 0,
> > >
> > > Shouldn't we retrieve the IRQ number from the device tree instead?
> 
>   mxs_lradc_ts_probe()
>   {
>     ...
>     irq = platform_get_irq_byname(pdev, mxs_lradc_ts_irq_names[i]);
>     if (irq < 0)
> 	    return irq;
> 
>     virq = irq_of_parse_and_map(node, irq);
>     ...
>   }
> 
> That's not right, is it?  irq_of_parse_and_map() takes an *index*, but
> we're passing an IRQ.
> 
> mxs_lradc_adc_probe() also has the same pattern.

Yeah, you are right. This code is broken by design. But the issue is that MFD
driver supplies _index_ and not vIRQ from proper IRQ domain. I dunno how it's
supposed to work without dirty tricks in the GIC (or whatever interrupt
controller is there).

Since there is no response to this thread by the authors of the code, I would
mark it as BROKEN and perhaps remove from the kernel if no-one steps in to fix
this mess.

-- 
With Best Regards,
Andy Shevchenko


