Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315434F961D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiDHMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiDHMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:50:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1ACF3FA7;
        Fri,  8 Apr 2022 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422129; x=1680958129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fyPhH983rnz7ANS3kCWC9cdmOb0b8sUABX/0ZPpm5R0=;
  b=BiTG+HZf8LgSNKpgtuawTxAOU4K7hXtBTzHm/GLOzCTHwwrjmYr11ecM
   3IO2NV5Xm+2NplpLODN1N3GXzTExfvdDZMFcxphpupJkyy926dRZkjVQi
   cGu8/vqKm3wJ6Mm0MEtZ7jLLse3T0i4xRy71ZoXvBEBF8SPWbXFnZLbCc
   QzE0TQeQdv4c3vWS4kAlTxwO6ed0USJQZs7aGQDylbn3evoI+Mrx/EKvq
   DFlDC4NfEw06l7U5RqUIPj/w2ZHN84xVVATpUNp9mzOslItXMolTCrRA0
   +iOAt/n/Vw5MXeUelEGUEfTF4yMGAG3Tl0s6ouTAjvQcR+Po0zKanEJwj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261760531"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261760531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:48:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="653244341"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:48:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncnz8-000Hts-EJ;
        Fri, 08 Apr 2022 15:45:06 +0300
Date:   Fri, 8 Apr 2022 15:45:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/3] tty: Add functions for handling flow control chars
Message-ID: <YlAuUpOZ4IVqZTFk@smile.fi.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
 <20220408113954.9749-2-ilpo.jarvinen@linux.intel.com>
 <YlAkK16xqh3DgY20@smile.fi.intel.com>
 <d79c4c20-1cfd-a3a1-516b-b6b51360527c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d79c4c20-1cfd-a3a1-516b-b6b51360527c@linux.intel.com>
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

On Fri, Apr 08, 2022 at 03:20:07PM +0300, Ilpo Järvinen wrote:
> On Fri, 8 Apr 2022, Andy Shevchenko wrote:
> > On Fri, Apr 08, 2022 at 02:39:52PM +0300, Ilpo Järvinen wrote:
> > > Move receive path flow control character handling to own function
> > > and a helper.
> > > 
> > > This seems cleanest approach especially once skipping due to lookahead
> > > is added. Its downside is the duplicated START_CHAR and STOP_CHAR
> > > checks.
> > > 
> > > No functional changes.
> > 
> > But it seems the change. See below.
> > 
> > ...
> > 
> > > +static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > > +{
> > > +	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
> > > +}
> > > +
> > > +/* Returns true if c is consumed as flow-control character */
> > > +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > > +{
> > > +	if (!n_tty_is_char_flow_ctrl(tty, c))
> > > +		return false;
> > > +
> > > +	if (c == START_CHAR(tty)) {
> > > +		start_tty(tty);
> > > +		process_echoes(tty);
> > 
> > > +	} else if (c == STOP_CHAR(tty)) {
> > 
> > In the original code no 'else' was present.
> >
> > Perhaps it's not a functional change, but this detail has to be explained.
> 
> Correct that the previous code didn't have else, however, there was return 
> with the same effect. Adding this else here was no accident from my part 
> but it is intentionally there to have no functional change for the 
> START_CHAR == STOP_CHAR case!

Perhaps you can split this change to a separate patch with this explanation
given.

> > > +		stop_tty(tty);
> > > +	}
> > > +
> > > +	return true;
> > > +}


-- 
With Best Regards,
Andy Shevchenko


