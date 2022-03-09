Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA67A4D2EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiCIMUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCIMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:20:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9217227B;
        Wed,  9 Mar 2022 04:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646828385; x=1678364385;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2XNQVwdKnvrJJjNli7sgRrYSwBvQxLv8hzZcl5S1ao8=;
  b=bNbOXVk7hj9vukwuL4bJBXN242qxUDXmB4b0wi+ZZBDeNwUN4OCFkggZ
   FcW9eXwxbvhA0KHTtZNeg0RqKiZfjHdU1rNnkMX6uZEvwc4gFV+wPLkQJ
   OvC3uNqTwyqRWEGiLTB+Nc+pt4eu4Z4T/8Rxmko3zdBfEzbaw7v38kCX/
   DmvF1eHMBuITbJz7lIxDRzVL3xukJBitm4vaWVTo04ouVD47nPztdidzn
   A3wi66wpnJXEQPkRJWwCfWd88NpikeIEur91sv9SCb4PEkvIyEIZHBykC
   WkPl57MZhy7nBIa30j1wYqMsheGZEAeWh4dbcXc7plG6o7PM5Cl1ub9sh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341390397"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="341390397"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 04:19:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="554095705"
Received: from vladi-laptop.ger.corp.intel.com ([10.252.32.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 04:19:41 -0800
Date:   Wed, 9 Mar 2022 14:19:39 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
In-Reply-To: <c2607267-798b-d7a0-86f6-4a729c22911f@linux.intel.com>
Message-ID: <9c2d96c0-44cf-c84c-5ff7-34c74716a23b@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de> <c2607267-798b-d7a0-86f6-4a729c22911f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1618434843-1646828384=:1769"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1618434843-1646828384=:1769
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 7 Mar 2022, Ilpo Järvinen wrote:

> On Sun, 6 Mar 2022, Lukas Wunner wrote:
> 
> > On Wed, Mar 02, 2022 at 11:56:00AM +0200, Ilpo Järvinen wrote:
> 
> > > +	/*
> > > +	 * XXX: Though we could interpret the "RTS" timings as Driver Enable
> > > +	 * (DE) assertion/de-assertion timings, initially not supporting that.
> > > +	 * Ideally we should have timing values for the Driver instead of the
> > > +	 * RTS signal.
> > > +	 */
> > > +	rs485->delay_rts_before_send = 0;
> > > +	rs485->delay_rts_after_send = 0;
> > 
> > I don't quite understand this code comment.
> 
> It seemed to be missing one "Enable" word.
> 
> Here's my interpretation of it (this comment was written by somebody 
> else, perhaps either Heikki or Andy):
> 
> Since this HW has dedicated DE/RE in contrast to RTS, it is not specified 
> anywhere that delay_rts_* should apply to them as well and that the 
> writer of that comment was hoping to have something dedicated to them
> rather than repurposing RTS-related fields.
> 
> I could of course change this if everything called RTS should be applied 
> to DE as well?

Now that it has been pretty much established that anything called "rts" 
should be applied to DE as well, I took another look on implementing these 
delays.

It turns out to be impractical to do/ineffective because "serial clock 
periods" are used as the unit by the HW ("serial clock periods" is not as 
clearly defined by the datasheet as I'd like but it is most likely based 
on the high-rated uartclk cycles). With the uartclk I've on test HW, the 
combined delay with max turnaround time and DE assert/de-assert timings 
cannot do even the smallest possible non-zero value (1 msec). That's 
because the TAT and DET registers allow only 16-bit and 8-bit values for 
delays.

I also attempted to test it by writing the maximum values into them and 
got no visible difference. There a note about +1 for delay in TAT so to 
play safe I put 0xfff0 instead 0xffff (if the HW couldn't handle that 
16-bit overflow properly).

Perhaps the SW half-duplex with DE/RE will have to be used to cover this 
case?


-- 
 i.

--8323329-1618434843-1646828384=:1769--
