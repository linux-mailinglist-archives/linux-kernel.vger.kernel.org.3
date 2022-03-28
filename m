Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025944E9026
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiC1Iao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiC1Iaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:30:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93114090;
        Mon, 28 Mar 2022 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648456137; x=1679992137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bX7y6PYsoKmkrmqLzNupZvbiwlzgwmoedmetGhJMRzs=;
  b=hPL/X0jFULZlU73qPGP2e6OsawjNVFfCoXYEibm3BmS5rGPiuczOAySU
   /Rcn4JsTdlGH6yG+XXA/Pu9V60EGa1baRb+5rZEXb5ZD8uOEWx5kqz3gX
   vIWPGor57quoXZkCM+n+HAWPvWFqowv32dO3zQVyrcR6WSJvprCNm8ShN
   IUPfahaY/NUQktIJGfG40LPrEnAVOs3toXAqI8qkwCzo31kvAZkq8yKnd
   8YZEIRRUhPjWQ6k1CRzabImukS/J9afjeY9psTkyKkjK26YPgVw/06/AZ
   rtcBV6wZMvbpU/BrRN9dwuNMcuf7ZsQAx8ZNNAJeSaE//C4Zq4JJOZZfk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="239542233"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="239542233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 01:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="694288700"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Mar 2022 01:28:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Mar 2022 11:28:52 +0300
Date:   Mon, 28 Mar 2022 11:28:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jack Pham <quic_jackp@quicinc.com>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, kyletso@google.com,
        andy.shevchenko@gmail.com, unixbhaskar@gmail.com,
        subbaram@codeaurora.org, mrana@codeaurora.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] usb: typec: ucsi: possible deadlock in ucsi_pr_swap() and
 ucsi_handle_connector_change()
Message-ID: <YkFxxAfvpennEZYg@kuha.fi.intel.com>
References: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
 <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
 <20220325203959.GA19752@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220325203959.GA19752@jackp-linux.qualcomm.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:39:59PM -0700, Jack Pham wrote:
> Hi Heikki,
> 
> On Wed, Feb 09, 2022 at 04:30:31PM +0200, Heikki Krogerus wrote:
> > On Wed, Feb 09, 2022 at 11:50:57AM +0800, Jia-Ju Bai wrote:
> > > Hello,
> > > 
> > > My static analysis tool reports a possible deadlock in the ucsi driver in
> > > Linux 5.16:
> > > 
> > > ucsi_pr_swap()
> > >   mutex_lock(&con->lock); --> Line 962 (Lock A)
> > >   wait_for_completion_timeout(&con->complete, ...) --> Line 981 (Wait X)
> > > 
> > > ucsi_handle_connector_change()
> > >   mutex_lock(&con->lock); --> Line 763 (Lock A)
> > >   complete(&con->complete); --> Line 782 (Wake X)
> > >   complete(&con->complete); --> Line 807 (Wake X)
> > > 
> > > When ucsi_pr_swap() is executed, "Wait X" is performed by holding "Lock A".
> > > If ucsi_handle_connector_change() is executed at this time, "Wake X" cannot
> > > be performed to wake up "Wait X" in ucsi_handle_connector_change(), because
> > > "Lock A" has been already held by ucsi_handle_connector_change(), causing a
> > > possible deadlock.
> > > I find that "Wait X" is performed with a timeout, to relieve the possible
> > > deadlock; but I think this timeout can cause inefficient execution.
> > > 
> > > I am not quite sure whether this possible problem is real.
> > > Any feedback would be appreciated, thanks :)
> > 
> > This is probable a regression from commit ad74b8649bea ("usb: typec:
> > ucsi: Preliminary support for alternate modes"). Can you test does
> > this patch fix the issue (attached)?
> 
> We encountered a slightly different twist to this bug.  Instead of
> deadlocking, we see that the dr_swap() / pr_swap() operations actually
> jump out of the wait_for_completion_timeout() immediately, even before
> any partner change occurs.  This is because the con->complete may
> already have its done flag set to true from the first time
> ucsi_handle_connector_change() runs, and is never reset after that.
> 
> In addition to the unlocking below, I think we need to also add
> reinit_completion() calls at the start of ucsi_{pr,dr}_swap().

OK. I'll add that to the patch.

thanks,

-- 
heikki
