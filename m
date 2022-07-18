Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B6578A66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiGRTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiGRTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988192FFF8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658171603; x=1689707603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfpGMUuM81j/VW9iWBnOI0YIldx7GwCl3+DCAYabqc4=;
  b=nelcHDQ4CJvKl+dqVbY9AiWfDF7uDtLxwcjSWvtMTch0ho0dGdrk3K5x
   0OJr9usv67eYmgA8bw4mX6sjslOOI6xCZhXRJCsYcwCScPUl15uUl+AxJ
   UM2yfbwX101AsJe8b4uyU7OReKZ58oN1cUkZf4iyr24R90ntLN/vJ1a6T
   WV+iNPbYDFCMmgvqfz2VPiWsrq1GLUpWQL27RppZtnP7FN9uL2O+qAwph
   IrCtBNXTE4V5/VTiqLk0qfhalHbdEku3Q7HHj30+3rmv16xxchfr4qaPG
   DuX1U40ReIefT+YlUSrkpd6rvWMRChawGNAE0MOZazOikzoqUCpZ3qHAd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="311986828"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311986828"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:13:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="630037408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:13:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oDWBB-001OPS-1s;
        Mon, 18 Jul 2022 22:13:17 +0300
Date:   Mon, 18 Jul 2022 22:13:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 1/1] irqchip/stm32-exti: Use INVALID_HWIRQ definition
Message-ID: <YtWwzW/Cou3/aia1@smile.fi.intel.com>
References: <20220715205203.82591-1-andriy.shevchenko@linux.intel.com>
 <87sfn14cns.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfn14cns.wl-maz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 10:41:59AM +0100, Marc Zyngier wrote:
> On Fri, 15 Jul 2022 21:52:03 +0100,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > Use specific definition for invalid IRQ. It makes the
> > code uniform in respect to the constant used for that.
> > No functional change intended.

...

> > -#define EXTI_INVALID_IRQ       U8_MAX
> > +#define EXTI_INVALID_IRQ       ((u8)INVALID_HWIRQ)
> 
> This looks like a terrible idea. It gives the impression that you can
> now rely on comparing the internal data structure field to
> INVALID_HWIRQ. Which is of course bound to fail.

I don't know how one can go to that conclusion, but okay, I understood you.

> To be honest, I'd rather *kill* INVALID_HWIRQ, because apart from
> cherryview, nobody even *checks* for this value by that name. So much
> for the "code uniformity"...

It's used by two or three, I don't remember by heart.

-- 
With Best Regards,
Andy Shevchenko


