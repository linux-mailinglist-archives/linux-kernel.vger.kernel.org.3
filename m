Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E855305A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiFULAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiFULAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:00:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89429834;
        Tue, 21 Jun 2022 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655809247; x=1687345247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdbxRsGGheu6GBHdOyV1uGckiP8Rrf2B1AVqMjy5upc=;
  b=mxSemFqrZKmyc3bfydc9MHjFl4Hu4f4OwXcuWRvhLo7w1LpJGEfh1r5P
   E5xYg6Xcg1ZqqIJWm3Gzsaiv6pUlyZcDYO5wR6H8r/duMzig8D2ZiQzJP
   4Aqc3RPf4kmCpUA0lh5mWGRD10cLPGTv55x0yqgWlpIqryvSopqD89X1C
   tjlJ0BRluowb9e0rtWL26HQwxMRO+jk9Pq9Z4VsF8ZzxmnuH1jddloXLA
   JkU+3jschHJiYw7AyVUHF8tFLV2ZaERPuEi+eLcFmU2SaCdn9eiqsr0yS
   mySF0CqGgEu4Ifl/drcB8KYYfsqPc5mUyNPXRd6fcKVOqTRoZDRrILkYk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263123838"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263123838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:00:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="655092970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:00:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3baK-000qwz-Ou;
        Tue, 21 Jun 2022 13:58:16 +0300
Date:   Tue, 21 Jun 2022 13:58:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <YrGkSMUsMzTqBEJz@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 06:13:53PM -0300, Fabio Estevam wrote:
> On Mon, May 30, 2022 at 2:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> I tried to apply the same change inside
> drivers/input/touchscreen/mxs-lradc-ts.c:
> 
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -675,11 +675,9 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>                 if (irq < 0)
>                         return irq;
> 
> -               virq = irq_of_parse_and_map(node, irq);
> -
>                 mxs_lradc_ts_stop(ts);
> 
> -               ret = devm_request_irq(dev, virq,
> +               ret = devm_request_irq(dev, irq,
>                                        mxs_lradc_ts_handle_irq,
>                                        0, mxs_lradc_ts_irq_names[i], ts);
>                 if (ret)
> 
> but I still get the following warning:

So just to be sure. You got it before the above change applied, correct?

I'm wondering how this all LRADC was supposed to work. The IRQs are assigned
based on abstract numbering without any IRQ domain behind it. This is not how
it's designed in Linux. Adding Ksenija and Marek to shed a light.

> [    6.135583] ------------[ cut here ]------------
> [    6.140366] WARNING: CPU: 0 PID: 1 at drivers/base/platform.c:449
> __platform_get_irq_byname+0x74/0x90
> [    6.151053] 0 is an invalid IRQ number
> [    6.155201] Modules linked in:
> [    6.158444] CPU: 0 PID: 1 Comm: swapper Not tainted
> 5.18.5-00001-g3e38be7e4832 #108
> [    6.166537] Hardware name: Freescale MXS (Device Tree)
> [    6.172040]  unwind_backtrace from show_stack+0x10/0x14
> [    6.177503]  show_stack from __warn+0xc4/0x1cc
> [    6.182356]  __warn from warn_slowpath_fmt+0x90/0xc8
> [    6.187549]  warn_slowpath_fmt from __platform_get_irq_byname+0x74/0x90
> [    6.194698]  __platform_get_irq_byname from platform_get_irq_byname+0x10/0x30
> [    6.202286]  platform_get_irq_byname from mxs_lradc_ts_probe+0x19c/0x380
> [    6.209216]  mxs_lradc_ts_probe from platform_probe+0x58/0xb8
> [    6.215383]  platform_probe from really_probe+0xfc/0x288
> [    6.220907]  really_probe from __driver_probe_device+0x80/0xe4
> [    6.227145]  __driver_probe_device from driver_probe_device+0x30/0xd8
> [    6.234010]  driver_probe_device from __driver_attach+0x70/0xf4
> [    6.240137]  __driver_attach from bus_for_each_dev+0x74/0xc0
> [    6.246195]  bus_for_each_dev from bus_add_driver+0x154/0x1e8
> [    6.252359]  bus_add_driver from driver_register+0x74/0x108
> [    6.258131]  driver_register from do_one_initcall+0x8c/0x2fc
> [    6.264198]  do_one_initcall from kernel_init_freeable+0x184/0x210
> [    6.270588]  kernel_init_freeable from kernel_init+0x10/0x108
> [    6.276756]  kernel_init from ret_from_fork+0x14/0x3c
> [    6.282224] Exception stack(0xc8819fb0 to 0xc8819ff8)
> [    6.287444] 9fa0:                                     00000000
> 00000000 00000000 00000000
> [    6.295988] 9fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    6.304631] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    6.311392] irq event stamp: 128211
> [    6.315220] hardirqs last  enabled at (128221): [<c0069c44>]
> __up_console_sem+0x54/0x64
> [    6.323632] hardirqs last disabled at (128230): [<c0069c30>]
> __up_console_sem+0x40/0x64
> [    6.331821] softirqs last  enabled at (128200): [<c00098e4>]
> __do_softirq+0x31c/0x4bc
> [    6.340041] softirqs last disabled at (128191): [<c0020f04>]
> irq_exit+0x150/0x18c
> [    6.347913] ---[ end trace 0000000000000000 ]---
> [    6.364587] input: mxs-lradc-ts as
> /devices/soc0/80000000.apb/80040000.apbx/80050000.lradc/mxs-lradc-ts/input/input0
> 
> Any suggestions?

-- 
With Best Regards,
Andy Shevchenko


