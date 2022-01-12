Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E948CD51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357850AbiALU5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:57:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:63575 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357832AbiALU5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642021051; x=1673557051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TIrMR31Gxy/LkW656Oj/2kCSFeWLOvsdWeqh/DqRJ9U=;
  b=fbk47w7Z1J7QWZFUxtuJge0+lUIkKdq1k4O4Jo2fHVlFgFk/koQjdrS0
   4xHViwrVNycTldetdag9RHNCbInDn9IylaRG7AnhwWhlE8sdP9/Wt03DL
   UitaPrEVmwE3OMQDvdWlqIfNU0RWzIECSugwhphfc8aamVVynlF3Q7aZ0
   wIhFNmNnosz4fi6z/rnsEdNAqKKYZ1sQ/efOlu1Twsxj5tEFz4K9tp/7Z
   1PqYO7UrRDybM+l+0eFjBUXxI2elLvWw0vSW/MyoQ+AiN0ZdxkkfbD6qo
   fMDfyqbuYXnAjEOz4WmsP26JFr0iVV3gj8mWFQLyh3oAGKXlWNTCfuHZN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243647762"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243647762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:57:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="613714379"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:57:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7kfF-009vQq-28;
        Wed, 12 Jan 2022 22:56:13 +0200
Date:   Wed, 12 Jan 2022 22:56:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Subject: Re: [GIT PULL] pin control changes for v5.17
Message-ID: <Yd9AbO+Id7y1+IY+@smile.fi.intel.com>
References: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
 <CAHk-=whcTsfaQWjNKP+DUSqfo+3rf1o8-N9CpjpogMhAxiJZ=Q@mail.gmail.com>
 <Yd88UBp9uaDSc2qW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd88UBp9uaDSc2qW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:38:40PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 12, 2022 at 11:09:23AM -0800, Linus Torvalds wrote:
> > On Wed, Jan 12, 2022 at 3:23 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > - There will be conflicts! Kconfig and Makefile conflicts due to
> > >   some RISC-V Starfive patches getting merged through the
> > >   SoC tree while we were tidying up the Kconfig and Makefile
> > >   (to avoid merge conflicts, heh) there is a resolution in linux-next
> > >   which was discussed and reviewed to be correct.
> > 
> > Whoever sorted the Makefile entries (yeah, it was Andy) isn't very good at it.
> 
> Indeed. Sorry for that, I will send an update for next cycle.
> 
> > The broken sorting put CONFIG_PINCTRL_STMFX before CONFIG_PINCTRL_ST,
> > and I have no idea how you can sort that way.
> > 
> > I left the broken sorting in place, because changing the sort order in
> > the merge would just be even *more* confusing.
> > 
> > There may be other cases of that kind of oddity, I just happened to
> > notice that one because the 'starfive' thing ended up having that same
> > 'st' beginning, and I went D'Oh when trying to make sure my merge kept
> > the ordering.


I setup a little experiment, since I'm using vim, there are two possibilities
to sort the selection, i.e. using internal sort and calling external !sort.

Using internal gives:

-obj-$(CONFIG_PINCTRL_STMFX)    += pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_ST)       += pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STARFIVE) += pinctrl-starfive.o
+obj-$(CONFIG_PINCTRL_STMFX)    += pinctrl-stmfx.o


Using external gives:

+obj-$(CONFIG_PINCTRL_STARFIVE) += pinctrl-starfive.o
 obj-$(CONFIG_PINCTRL_STMFX)    += pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_ST)       += pinctrl-st.o
-obj-$(CONFIG_PINCTRL_STARFIVE) += pinctrl-starfive.o


Now you may easily see what happened.


-- 
With Best Regards,
Andy Shevchenko


