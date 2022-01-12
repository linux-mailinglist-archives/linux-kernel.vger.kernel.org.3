Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B51E48CD27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357675AbiALUkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:40:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:34975 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357655AbiALUj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642019997; x=1673555997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nNEUA/P/1w/GkH+jNBDAOF/3Gc4E5HEnxKB0wtLwd1A=;
  b=TazIcftFprC6og4prNGjP58eGSycDdQ0SrLTxmJ896qGJUOeUr8nwtE9
   BRzFSQzXOJMRkdpDkBrFnWz414VPoQle5CWL7PgkmNBOG+GxDxqpSibgV
   dUBjY8apKk/rIWnZ4jPDLjFHpl81LzPh9qa9K8A1ebxssKSmKnIRg/QnI
   3KwIdrlUPXysJKVV4JscqleggSjyhy4y1TrqJXIYdEl893AQF4lBi0M9W
   87ciq+L3rMVIKfynAotxX4hQC/yv5d+cEU86bFVCJDkYO5AJ7+DeiFbZH
   DcN2+VVXC+FAG80uBicUAhx0UxFPWaKamFmfrgPVqQz3G0cd6GKxmyMR/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244053669"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244053669"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:39:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="623604095"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:39:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7kOG-009v4J-KR;
        Wed, 12 Jan 2022 22:38:40 +0200
Date:   Wed, 12 Jan 2022 22:38:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Subject: Re: [GIT PULL] pin control changes for v5.17
Message-ID: <Yd88UBp9uaDSc2qW@smile.fi.intel.com>
References: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
 <CAHk-=whcTsfaQWjNKP+DUSqfo+3rf1o8-N9CpjpogMhAxiJZ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcTsfaQWjNKP+DUSqfo+3rf1o8-N9CpjpogMhAxiJZ=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:09:23AM -0800, Linus Torvalds wrote:
> On Wed, Jan 12, 2022 at 3:23 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > - There will be conflicts! Kconfig and Makefile conflicts due to
> >   some RISC-V Starfive patches getting merged through the
> >   SoC tree while we were tidying up the Kconfig and Makefile
> >   (to avoid merge conflicts, heh) there is a resolution in linux-next
> >   which was discussed and reviewed to be correct.
> 
> Whoever sorted the Makefile entries (yeah, it was Andy) isn't very good at it.

Indeed. Sorry for that, I will send an update for next cycle.

> The broken sorting put CONFIG_PINCTRL_STMFX before CONFIG_PINCTRL_ST,
> and I have no idea how you can sort that way.
> 
> I left the broken sorting in place, because changing the sort order in
> the merge would just be even *more* confusing.
> 
> There may be other cases of that kind of oddity, I just happened to
> notice that one because the 'starfive' thing ended up having that same
> 'st' beginning, and I went D'Oh when trying to make sure my merge kept
> the ordering.
> 
> The sort order is fine in the Kconfig file. Maybe some odd sorting got
> confused by the next non-letter character (either ')' after the config
> name, or '.o' of the object file name).
> 
> Obviously not a big deal, but it's an oddity.

-- 
With Best Regards,
Andy Shevchenko


