Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1B4F1655
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357548AbiDDNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355839AbiDDNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:46:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D8255B9;
        Mon,  4 Apr 2022 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649079903; x=1680615903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T19XjXYvbgpn6NckOV4XRq/o/sODuRMg5HApsOJ4KFA=;
  b=H5k3AdzDuOnNeqGlXYGMrnqNqd72b4lYMEUxqdN3FmWWuv5drPlz8HXr
   EcKCtv9CVaQYcOsOxqnN2XhevrAzoU60MXbLFyEBXgT4mIfks6hF6bI8v
   jQsnHxW1gSUCj538DrLEMFni5MDLp60S5BwCCISxmpRxld1x7EMtb2jmF
   z2d5TTFNJsFJNM0Gp1njfrsWPCm/3JypavVrt9sqDeqbht616If6gVECv
   XvS+I2+MjP5YzYcHSNZUzyFA4bmHvT7De2rfGFpR7npaUlQrNnmPRswC0
   pXRmnL926wnW9qONKuIcOmUq7x457tV2xD9/kopiE4ywgNBA1Rua6/Hya
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="248028993"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="248028993"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:45:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="651498324"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:44:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbN0M-00CgZO-R8;
        Mon, 04 Apr 2022 16:44:26 +0300
Date:   Mon, 4 Apr 2022 16:44:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Subject: Re: [PATCH v6] serial/8250: Use fifo in 8250 console driver
Message-ID: <Ykr2OmXZyByrZ1uu@smile.fi.intel.com>
References: <20220401194645.1738747-1-wander@redhat.com>
 <20220401194645.1738747-2-wander@redhat.com>
 <Ykq7FXhQfsvr9TtC@smile.fi.intel.com>
 <CAAq0SUn4Z2y4-7fJcZ-T5rrnuwdJCt2+W-bGGmCxU6t+pA165A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUn4Z2y4-7fJcZ-T5rrnuwdJCt2+W-bGGmCxU6t+pA165A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 10:27:30AM -0300, Wander Costa wrote:
> On Mon, Apr 4, 2022 at 6:32 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Apr 01, 2022 at 04:46:42PM -0300, Wander Lairson Costa wrote:

...

> > > +     use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> > > +             /*
> > > +              * BCM283x requires to check the fifo
> > > +              * after each byte.
> > > +              */
> > > +             !(up->capabilities & UART_CAP_MINI) &&
> >
> > Perhaps you need to also comment why we are using tx_loadsz and not fifosize.
> 
> Maybe it is better to document their difference in the struct
> declaration and not in a random usage.

Here, when one reads a code (as a non-familiar with the area), the use of
tx_loadsz confuses if one saw previously fifosize used somewhere. So, I agree
that it's good to document in the structure, but here it's also good to have
a comment to briefly hint the reader why this and not the other one is used.

-- 
With Best Regards,
Andy Shevchenko


