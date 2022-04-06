Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD94F5ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiDFMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiDFMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:54:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A5388C60;
        Wed,  6 Apr 2022 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649235486; x=1680771486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p8nBEB+MNXhz5UaO1/EM6bxXdwDLzhXQjFRAKQlIL8A=;
  b=bDsmAURJulz3qvXTukFLpsecKZSulv3Z6K31WeVy1fjSif1vNEPGFQa0
   tabQWoWlhd5KOx/6kj/BgFUzvVRMUVY9jlZE2vCJdEeV3Vzdzf+KA4czJ
   qdRS/MqjI5/KA1L6Bz6b1A6Htif8sOBEDN7rIKtE1m3BExXDqrNqpaiqq
   H8fbJIF8xJfB4Jg0sF1qRUCH/6qFN6RYtGifrW6BOlEA6EjaoYmHcqQ83
   k5bgv1wiSeam7dCy7+TZq4UorKCEFaAfMc2pGlfwpAz/j81CUxvBkKRBg
   reYGGZjRNBdepk4v+3huAijg6KFKgMUf3/HlgJ4Ylg/Vrb598e3C3dEHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241576990"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="241576990"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:57:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="608812355"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:57:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc1SR-000BIE-Aj;
        Wed, 06 Apr 2022 11:56:07 +0300
Date:   Wed, 6 Apr 2022 11:56:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] tty: Implement lookahead to process XON/XOFF timely
Message-ID: <Yk1Vp+nQQBRE+MjN@smile.fi.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
 <20220405102437.4842-3-ilpo.jarvinen@linux.intel.com>
 <YkxqGDsURPpkDM5W@smile.fi.intel.com>
 <fce9c28e-a334-3c70-3a6a-8812f11d8fc7@kernel.org>
 <Yk1VLWMmMu6jJEWo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yk1VLWMmMu6jJEWo@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:54:05AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 06, 2022 at 10:21:12AM +0200, Jiri Slaby wrote:
> > On 05. 04. 22, 18:11, Andy Shevchenko wrote:
> > > On Tue, Apr 05, 2022 at 01:24:37PM +0300, Ilpo Järvinen wrote:

> > > > +	if (c == START_CHAR(tty)) {
> > > > +		if (!lookahead_done) {
> > > > +			start_tty(tty);
> > > > +			process_echoes(tty);
> > > > +		}
> > > > +		return true;
> > > > +	}
> > > > +	if (c == STOP_CHAR(tty)) {
> > > > +		if (!lookahead_done)
> > > > +			stop_tty(tty);
> > > > +		return true;
> > > > +	}

> > > Looking into this I would first make a preparatory patch that splits out
> > > current code into something like
> > > 
> > > static bool __n_tty_receive_char_special_no_lookahead(struct tty_struct *tty, unsigned char c)
> > > {
> > > 	...current code...
> > > }
> > > 
> > > Then in the patch 1 you add
> > > 
> > > static bool __n_tty_receive_char_special_lookahead(struct tty_struct *tty, unsigned char c)
> > > {
> > > 	...
> > > }
> > > 
> > > static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
> > > 					 bool lookahead_done)
> > 
> > This should be dubbed better. Maybe n_tty_receive_char_flow_control()?
> > 
> > And I would place the if (I_IXON(tty)) to the caller. I am a bit lost in
> > this pseudo code, so maybe this doesn't make sense in your proposal. I have
> > something like in my mind:
> > 
> > if (I_IXON(tty))
> >   return n_tty_receive_char_flow_control();
> 
> My point to have three helpers which make each change cleaner:
> 
>   .-> n_tty_receive_char_flow_control_lah()
>   |
>   |  .-> n_tty_receive_char_flow_control_no_lah()
>   |  |
>   `- + -- n_tty_receive_char_flow_control()
> 
> Where no_lah variant can be split as preparatory patch prepending the current
> series.

Another possibility to keep one function, but split it first in a separate
patch and then modify.

> And yes, calling I_IXON at the caller seems better.
> 
> > Historically, these n_tty_receive* function names were a big mess. Don't
> > produce more of that by simply prepending only "__".
> > 
> > > {
> > > 	if (!I_IXON(tty))
> > > 		return false;
> > > 
> > > 	if (lookahead_done)
> > > 		return _lookahead();
> > > 
> > > 	return _no_lookahead();
> > > }

-- 
With Best Regards,
Andy Shevchenko


