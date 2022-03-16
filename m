Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17344DB5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbiCPQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiCPQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:15:20 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CBBAE78;
        Wed, 16 Mar 2022 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647447245; x=1678983245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eG1MKTEp/lLTZCxtFRGNr8K7zuChwr5qYDUwdyFj178=;
  b=NVvwDPX/w+Yuf/3xVxKI0arLuZiq6EXoB9OTxkecZU56FKgogHlfoLfQ
   xueY2Qzaf0jtNLVnStXB8lpKu7ygpbMZVlUyLfBLUfUEX49FnBzPxt5ry
   ERReH/crHzisFNxSDXAEo7tvSaawC+ennP+4P0pFu8OGz1VyuMAZkBmGc
   QErmOV4UTpbF8t5aSXjShPI63BHe8EWkJz1Fjwcz1MFtEy5hPgAUb7Z0P
   62i6eS0yN9X38zxh/SGqV+zzNAWFYCyP64Tg3Y2Ek/sZIycGL0xg7cNM0
   kQ1+1dz6y4/IXblRMgZGU4uXEzhsl0dCi63GnpL8AD6NU1cSdHVtHF2cH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317368787"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317368787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:14:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="598774648"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:14:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nUWH1-000zRv-S8;
        Wed, 16 Mar 2022 18:13:19 +0200
Date:   Wed, 16 Mar 2022 18:13:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wander Lairson Costa <wander@redhat.com>
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
Message-ID: <YjIMn/cBf7STIxBU@smile.fi.intel.com>
References: <20220316143646.13301-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316143646.13301-1-wander@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:36:39AM -0300, Wander Lairson Costa wrote:
> This version fixes the bugs reported in version v3. The first patch
> is the same patch of v3 as is. The following commits fix the issues in the
> original patch. For details, please check the commit log of each patch.
> 
> I tested these patches in the following systems:
> 
> * IBM X3550 M3
> * HP ProLiant DL380 Gen9
> * HP ProLiant BL480c G1
> * Dell PowerEdge R910
> * Cisco UCSC-C220-M3S
> 
> I cc everybody that reported problems with the previous version of this
> patch so they can retest and confirm their systems work flawlessly.

I have got this only message and I don't see any good changelog what has
been done between v3 and v4.

> Wander Lairson Costa (5):
>   serial/8250: Use fifo in 8250 console driver
>   serial/8250: Use the cache value of the FCR register
>   serial/8250: Use tx_loadsz as the transmitter fifo size
>   serial/8250: exclude BCM283x from console_fifo_write
>   serial/8250: Only use fifo after the port is initialized in
>     console_write

-- 
With Best Regards,
Andy Shevchenko


