Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB574B1071
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiBJOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:30:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbiBJOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:30:27 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01109B92;
        Thu, 10 Feb 2022 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644503428; x=1676039428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=raoLlF1RJ+lMrQ5oJTeQR9ZgMBhNkETVNbVQPX0SD0k=;
  b=PUlXK2cM5gIB6Ghiexz2EZ+hKJ8FdBzXpVfkwM90FNJJ/z3ZwOqdsngm
   P1zd23rZmW/Fl2P/FCveIowBjXDm4qqBrXv7pxBG9mma1p4Vu7Y5Amp+P
   eV+FrdW2LkjoduwckzWMTEoWUq0Q3TKbEcfJjcT+HXcpmmN39emYduW09
   qBnGP5Fg4+Vv3xc6EaRGJOSmsZZgi8L1KJN8NaU5wZIJN+KbZisS84T4N
   Sw/n8s1IYklkcBjBsWY0oH+nSxdJyexgiKj8dSzrfdjw/ZYoG4trxP6Pa
   TPlmuB2sRcYwTrUiB2eXRFk+LbtHjJALW9yI18ox6b+YIKFHIdoLrlEYD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310238769"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="310238769"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="679163361"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 10 Feb 2022 06:30:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Feb 2022 16:30:23 +0200
Date:   Thu, 10 Feb 2022 16:30:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, kyletso@google.com,
        jackp@codeaurora.org, andy.shevchenko@gmail.com,
        unixbhaskar@gmail.com, subbaram@codeaurora.org,
        mrana@codeaurora.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] usb: typec: ucsi: possible deadlock in ucsi_pr_swap() and
 ucsi_handle_connector_change()
Message-ID: <YgUhf9o5F98dZyxn@kuha.fi.intel.com>
References: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
 <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
 <43d6c3b5-17e6-63a8-21fa-3ff9f478ada7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43d6c3b5-17e6-63a8-21fa-3ff9f478ada7@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:24:42AM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2022/2/9 22:30, Heikki Krogerus wrote:
> > On Wed, Feb 09, 2022 at 11:50:57AM +0800, Jia-Ju Bai wrote:
> > > Hello,
> > > 
> > > My static analysis tool reports a possible deadlock in the ucsi driver in
> > > Linux 5.16:
> > > 
> > > ucsi_pr_swap()
> > >    mutex_lock(&con->lock); --> Line 962 (Lock A)
> > >    wait_for_completion_timeout(&con->complete, ...) --> Line 981 (Wait X)
> > > 
> > > ucsi_handle_connector_change()
> > >    mutex_lock(&con->lock); --> Line 763 (Lock A)
> > >    complete(&con->complete); --> Line 782 (Wake X)
> > >    complete(&con->complete); --> Line 807 (Wake X)
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
> > This is probable a regression from commit ad74b8649bea ("usb: typec:
> > ucsi: Preliminary support for alternate modes"). Can you test does
> > this patch fix the issue (attached)?
> 
> Hi Heikki,
> 
> Thanks for the reply and patch.
> After the patch is used, my tool does not report this deadlock in the ucsi
> driver.
> Thus, I think this patch should be okay to fix the deadlock :)

Thanks for testing it. I'll tag you as the reporter and tester in the
patch.

Br,

-- 
heikki
