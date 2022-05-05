Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FA51BDF6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357102AbiEEL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357064AbiEEL1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:27:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BEE53E23
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651749839; x=1683285839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L6Ngp94hHGWsNcgFnS5I3Kj6GypsoRDxbkj/M+UXs1s=;
  b=gV+phVfF2NMAPg0tx90ln55iz8myW4+NHj2Qd4hYVvX2Mm5m9QHVTtHM
   Q1gvAanK+7Hq57q1q8edfm17aXUpkj9c/ehmDFXCP3q1HlXF4s+D8yMl/
   xXDb74BLW6pAjt5a2LXpATyAS23r/Wabzf6zX+Fcr+N0ZdAhzp2Yic2O7
   uUjNC5sGRethKupmvGDB0WTbHoePY9Bdn1R+6KgEV/ur3d/GNmTtZJEsu
   JI1HtfLrqQsruOyJqTfPLi7+G2BeJ6fqzpipVdWoWksk8okfarun/WROD
   3IXriiGIbKx+wEaliOMpNafrzG1imMgGKiw3ti4M56qic1e5ja61cDTro
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293276416"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="293276416"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 04:23:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="600004091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 04:23:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nmZaL-00CG2M-Lf;
        Thu, 05 May 2022 14:23:53 +0300
Date:   Thu, 5 May 2022 14:23:53 +0300
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
Message-ID: <YnOzyTMKUIOB4My2@smile.fi.intel.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com>
 <Yk2PE7+oEEtGri95@smile.fi.intel.com>
 <CACRpkdbqfNiWQG6ayqMXACby4xkW0pY6JhdYE-x+pWkSxJU5TQ@mail.gmail.com>
 <87fsm7fkbt.fsf@mpe.ellerman.id.au>
 <YnKDaTVDoqgFeQHz@smile.fi.intel.com>
 <87wnf0tf3l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnf0tf3l.fsf@mpe.ellerman.id.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:04:46PM +1000, Michael Ellerman wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Thu, Apr 21, 2022 at 08:42:30AM +1000, Michael Ellerman wrote:

...

> > Any new on this? I haven't seen it yet in Linux Next.
> 
> It's in today's next (next-20220505).

Got it, thank you!

-- 
With Best Regards,
Andy Shevchenko


