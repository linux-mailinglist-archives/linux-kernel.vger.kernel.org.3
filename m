Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914B2525425
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357359AbiELRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357346AbiELRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:51:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC93630F;
        Thu, 12 May 2022 10:51:26 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295343453"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="295343453"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:36:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="566808809"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:36:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1npCjE-00FIF6-8R;
        Thu, 12 May 2022 20:35:56 +0300
Date:   Thu, 12 May 2022 20:35:55 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 00/10] gpiolib: Handle immutable irq_chip structures
Message-ID: <Yn1Fe4WPp3ZaUERj@smile.fi.intel.com>
References: <20220419141846.598305-1-maz@kernel.org>
 <Yn0/DIl3+i/heRH6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn0/DIl3+i/heRH6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:08:28PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 19, 2022 at 03:18:36PM +0100, Marc Zyngier wrote:
> > This is a followup from [2].
> > 
> > I recently realised that the gpiolib play ugly tricks on the
> > unsuspecting irq_chip structures by patching the callbacks.
> > 
> > Not only this breaks when an irq_chip structure is made const (which
> > really should be the default case), but it also forces this structure
> > to be copied at nauseam for each instance of the GPIO block, which is
> > a waste of memory.
> 
> Is this brings us to the issue with IRQ chip name?
> 
> The use case in my mind is the following:
> 1) we have two or more GPIO chips that supports IRQ;
> 2) the user registers two IRQs of the same (by number) pin on different chips;
> 3) cat /proc/interrupt will show 'my_gpio_chip XX', where XX is the number.
> 
> So, do I understand correct current state of affairs?
> 
> If so, we have to fix this to have any kind of ID added to the chip name that
> we can map /proc/interrupts output correctly.

Hmm... Some drivers are using static names, some -- dynamically prepared (one
way or another). Either way I think the ID is good to have if we still miss it.

-- 
With Best Regards,
Andy Shevchenko


