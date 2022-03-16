Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DD4DB5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355862AbiCPQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245249AbiCPQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:18:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE48DF38;
        Wed, 16 Mar 2022 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647447441; x=1678983441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcKl2PVj7cL9qGm0V13d5bFBvlloVdpeh1fZ2EcBCrw=;
  b=PuxED/wdtmHlT7kgWik3R3KU8qHfIfgFTuk/zvytWN28cJdt8Zau67DL
   v1CXGjNVhJUcUyaU/5f4e1wwJHZEik0qunLJcywKfGxg+c0zI5pJR13la
   7wFcfsEJqcWYwIZ9g14d+I36c4zYVmXif2x81eZ1Xy36JvYlkhX45CVck
   nR2xLb0y2EzllDIIlCQQot8LxrT/N7Rdr0kJznSPqbxefwjakF+XdQ3AW
   gqNbYdBuJ9hS2Sr3UiRK9p6V+myFoUcE3u/jdGwjv5MREaPamFQAC5yWl
   nUYx4yZJqq1S1IiDgHcRikNBO7vpxN1xHF/rQgfNBiB60fcnEKS7WSKj3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236595347"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236595347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:15:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="498503918"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:15:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUWIF-000zUm-Kd;
        Wed, 16 Mar 2022 18:14:35 +0200
Date:   Wed, 16 Mar 2022 18:14:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, rostedt@goodmis.org,
        senozhatsky@chromium.org, andre.goddard@gmail.com,
        sudipm.mukherjee@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: Re: [PATCH v4 0/5] tty/8250: Use fifo in 8250 console driver
Message-ID: <YjIM6y7bwc+UzZCU@smile.fi.intel.com>
References: <20220316143646.13301-1-wander@redhat.com>
 <YjIMn/cBf7STIxBU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjIMn/cBf7STIxBU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:13:19PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 16, 2022 at 11:36:39AM -0300, Wander Lairson Costa wrote:
> > This version fixes the bugs reported in version v3. The first patch
> > is the same patch of v3 as is. The following commits fix the issues in the
> > original patch. For details, please check the commit log of each patch.
> > 
> > I tested these patches in the following systems:
> > 
> > * IBM X3550 M3
> > * HP ProLiant DL380 Gen9
> > * HP ProLiant BL480c G1
> > * Dell PowerEdge R910
> > * Cisco UCSC-C220-M3S
> > 
> > I cc everybody that reported problems with the previous version of this
> > patch so they can retest and confirm their systems work flawlessly.
> 
> I have got this only message and I don't see any good changelog what has
> been done between v3 and v4.
> 
> > Wander Lairson Costa (5):
> >   serial/8250: Use fifo in 8250 console driver
> >   serial/8250: Use the cache value of the FCR register
> >   serial/8250: Use tx_loadsz as the transmitter fifo size
> >   serial/8250: exclude BCM283x from console_fifo_write
> >   serial/8250: Only use fifo after the port is initialized in
> >     console_write

If you are going to (re-)send a new version, please Cc to Ilpo as well.

-- 
With Best Regards,
Andy Shevchenko


