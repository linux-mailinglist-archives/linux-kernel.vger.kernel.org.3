Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E006C4F962E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiDHMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiDHMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:55:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F516590;
        Fri,  8 Apr 2022 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422384; x=1680958384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j4WT+QkS5ARvkWcd8WkQSnzVMZ9Z9qQyb45mo3nJ7oE=;
  b=YCVU4UvSg5l8AGcem/mT/Swss1slAyd8L2uLOAkaHu9UumZ7XRXTuNII
   grJdVelC8RhlSTvezbOnXjBwmnh85a/56r70+Gy0La8vNronV0Jzj4LxJ
   3sirKQsFRac7wysJuCPXhZaWMSfSwPHR6FVFEg3Mdz35j3lJLB/ThW7PA
   Te8hZELb1Dhx6+CvWCFY2etKSKlKmYY0LZWM1p6OaBvuUg7DnRz9z/85F
   twoI1aTZcPtfcbZ/COvuHBHXYTyeN+6pEwT/21FiNJNydOR8yj5yy7+RN
   vp/mCIWzjCFvdiFF0HVaFavDbZtskfHdZ1cuj05/Cr783cuo2LvJdriEZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259184073"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259184073"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:53:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525365038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:53:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nco3E-000Hxa-C3;
        Fri, 08 Apr 2022 15:49:20 +0300
Date:   Fri, 8 Apr 2022 15:49:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] tty: Add lookahead param to receive_buf
Message-ID: <YlAvUL2rMreUZwdF@smile.fi.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
 <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com>
 <YlAjfAab+Oh3HcCR@smile.fi.intel.com>
 <42fc2746-6a7c-9b44-87a5-32f219c1231@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42fc2746-6a7c-9b44-87a5-32f219c1231@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:34:27PM +0300, Ilpo Järvinen wrote:
> On Fri, 8 Apr 2022, Andy Shevchenko wrote:
> > On Fri, Apr 08, 2022 at 02:39:53PM +0300, Ilpo Järvinen wrote:

...

> > > +		if (c == STOP_CHAR(tty)) {
> > > +			if (!lookahead_done)
> > 
> > But now it can be as below
> > 
> > 		if (c == STOP_CHAR(tty) && !lookahead_done)
> > 
> > > +				stop_tty(tty);
> > > +		} else if ((c == START_CHAR(tty) && !lookahead_done) ||
> > >  			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
> > >  			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> > >  			  c != SUSP_CHAR(tty))) {
> 
> Are you sure about this? ...If I make that change to the first if, the 
> second part of the else if's condition get a chance it didn't have 
> previously.

Oh, indeed. This will give a chance to the rest of the second conditional to be
triggered because of ||.

> What I'd like to do here is to take advantage of the function that was 
> added:
> 
> 		if (!n_tty_receive_char_flow_ctrl(tty, c) &&
> 		    tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
>         	    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> 	            c != SUSP_CHAR(tty))) {
> 			start_tty(tty);
> 			process_echoes(tty);
> 		}
> ...but it will change STOP_CHAR vs START_CHAR precedence for the case 
> where they're the same characters. I don't know if it matters.

No idea of impact of such change.

-- 
With Best Regards,
Andy Shevchenko


