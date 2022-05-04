Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9467151A13B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350795AbiEDNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350791AbiEDNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:48:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2756254
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651671919; x=1683207919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZ4vphBXVfB/HfWb5Clb91wOAr0PLx69sTjqh3lXPSw=;
  b=G/Z8EAzW/+vTzORVkEw10dP4dpdesc47Y/8Tv7n7ZHJwzK5Pg2/08yjX
   5vNSXOsLCAwLmN3X+Ip5vlWBaEYnRAGU0/KknNnxyxdNGYGjlc/CY5UEm
   04S6jlkrMi9SctZzLGXwN85jjJh/XeuZA+I0q2O3yutmkz5A5Ve9hAR3v
   VGueUiaNgh0Q/XRuOknLYJUMhgD30G0AJI47s1p8jWF2cm5pPSpa2kGhG
   JCVqn3H1qyyybXSxasx0vghJH61ELfix6rvTO4aSWZr/k4u34li3Gk8Ip
   A5AkJvWOO6LuLA5Iq6FVWzZ/xViaaGjozFWVkZpLjU1zGVaajSKagq8Pa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255235853"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="255235853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 06:45:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="734403682"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 06:45:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nmFJZ-00Btne-Fp;
        Wed, 04 May 2022 16:45:13 +0300
Date:   Wed, 4 May 2022 16:45:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node
 assignment
Message-ID: <YnKDaTVDoqgFeQHz@smile.fi.intel.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com>
 <Yk2PE7+oEEtGri95@smile.fi.intel.com>
 <CACRpkdbqfNiWQG6ayqMXACby4xkW0pY6JhdYE-x+pWkSxJU5TQ@mail.gmail.com>
 <87fsm7fkbt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsm7fkbt.fsf@mpe.ellerman.id.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:42:30AM +1000, Michael Ellerman wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
> > On Wed, Apr 6, 2022 at 3:02 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >> On Mon, Mar 28, 2022 at 03:16:08PM +0200, Linus Walleij wrote:
> >> > On Wed, Mar 23, 2022 at 6:43 PM Andy Shevchenko
> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> >
> >> > > Let GPIO library to assign of_node from the parent device.
> >> > > This allows to move GPIO library and drivers to use fwnode
> >> > > APIs instead of being stuck with OF-only interfaces.
> >> > >
> >> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> >
> >> > That's a nice patch.
> >> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> Thanks!
> >>
> >> Can we have this applied now?
> >
> > I think Michael Ellerman could help with this?
> >
> > Michael?
> 
> Yep, I'll pick it up when I start putting things into next.
> 
> That's usually the week after rc2, but I had a break for Easter.

Any new on this? I haven't seen it yet in Linux Next.

-- 
With Best Regards,
Andy Shevchenko


