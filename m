Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D26C48C0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351944AbiALJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:09:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:55558 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238120AbiALJJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641978546; x=1673514546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AXu4Sn7f0Nf9vLDXP59POrZr22J1Hc6Ks692FzUYPvo=;
  b=hG/2NHMlD/FAS7d8LdEv6ZVSo3rSdNemIQrByFYu5xQ06pSkk60jzi0t
   XEfQsbTqW20sybMSdDt7gkPb9j5dZUGvRUQ4YWO4KC1F712u/cP/vT8qU
   Dep538S93puj1EPmo6PIwHSjgII3JjMfimTOKTxVw4/JEk7ds3D/rtRfB
   xxBdIs1fcPFX/ywLOajOrA3ltVhpOElbv8ESqtAaoHHLkHQAoAK93VRPm
   1EAgUUtKURS/7yUOJVL3fGYMGn3vt5hADFXh76Yrvmv68/0HkUNqI3RKU
   tdME+JQQQTP1B1vqPwh4URpNvrQJVEAyEqz81UD5NYGOjxePsf15v5I4n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="307045425"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="307045425"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="670089739"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Jan 2022 01:09:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Jan 2022 11:09:03 +0200
Date:   Wed, 12 Jan 2022 11:09:02 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sing-Han Chen <singhanc@nvidia.com>
Subject: Re: [PATCH v4 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Message-ID: <Yd6ariWZtZN9PlBe@kuha.fi.intel.com>
References: <20220112054950.615341-1-waynec@nvidia.com>
 <Yd6IVb5hsc2jpXqn@kuha.fi.intel.com>
 <0ba8f2bf-9b8b-04a6-e016-821200456100@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba8f2bf-9b8b-04a6-e016-821200456100@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:41:50AM +0000, Wayne Chang wrote:
> Hi Heikki
> 
> Thanks for the review.
> 
> On 1/12/22 3:50 PM, Heikki Krogerus wrote:
> > 
> > 
> > Hi,
> > 
> > On Wed, Jan 12, 2022 at 01:49:50PM +0800, Wayne Chang wrote:
> >> From: Sing-Han Chen <singhanc@nvidia.com>
> >>
> >> after driver sending the UCSI_START cmd, CCGx would
> >> clear Bit 0:Device Interrupt in the INTR_REG if CCGX
> >> reset successfully.
> >>
> >> however, there might be a chance that other bits in
> >> INTR_REG are not cleared due to internal data queued
> >> in PPM and cause the driver thinks CCGx reset failed.
> >>
> >> the commit checks bit 0 in INTR_REG and ignore other
> >> bits. ucsi driver would reset PPM later.
> >>
> >> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")
> > 
> > So... no need to take this to the stable kernel releases?
> > 
> Should I put cc tag here?

Yes, Cc: stable@kernel.org, unless you have some good reason not to.
I'm guessing you don't. This stuff is also explained here:

https://docs.kernel.org/process/submitting-patches.html#select-the-recipients-for-your-patch

> >> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> >> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> >> ---
> > 
> > What has changed since v3 (and v2) - there is no patch changelog here?
> > 
> > In case this is new to you, you list those changes under that '---'
> > line so they don't become part of the permanent changelog:
> > 
> > https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
> > 
> The changes are resent for updating the commit messages.
> Added the Fixes tag which Greg asked for.
> Thanks for information. I went through the documents.
> Should I put the following messages in the patch after "---" or should I use resend in subject 
> for the commit messages updated?
> v3 -> v4 commit messages updated

I think you can say exactly what you did, like "Added the Fixes tag"
or whatever you did.

> v2 -> v3 commit messages updated

Ditto.

> v1 -> v2 commit messages updated

Ditto.

Since you are going to do one more version of this, could you also
start the sentences with upper-case letters in the commit message?
Normally I'm not very picky about the grammar stuff (I make plenty of
mistakes myself), but this time it's driving me crazy for some reason.

thanks,

-- 
heikki
