Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B554CC17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiFOPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiFOPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:02:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BEE393C2;
        Wed, 15 Jun 2022 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655305323; x=1686841323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hJAhfYzF+yu1xLm71TuIkWGPdd6jKFjKq0bsAGAs7G8=;
  b=aseDf1SxIPOhy+X0Izu1LJoP+1WsyK+8eYkVfIT25A0Z3U4AjwAAE/VG
   j0wTVDbk/CzWaEH4IsQZROganhSaCvHLX55w5zQk1AaMx03D8kSVLwDiL
   zfBq7MfnWnNC7cSWYHRnJGFLPlL8zIhnJXgRynrgqgHhDYHYfZsvj4kg3
   VInGbbNI9iCS8tEeJ2pburXb6tWi4eVn2m59Y6ks37UaTU7t4rKJruxBc
   9a5+5l9q1CnWx8mk1rpoObLnvxvDq0fIUK7m6GO/Y+kD3QhsecAYPFp1y
   eCHUJZEm9zr5/oeKT+t4kfilnP8eGFjbFiAyVkG14fXMlsCy++38v6xuy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277783683"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277783683"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="911704883"
Received: from iweiny-server.sc.intel.com (HELO localhost) ([172.25.222.75])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:01:50 -0700
Date:   Wed, 15 Jun 2022 08:01:50 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <Yqn0XqfPd4q89pL7@iweiny-server>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <YqlQgbDUTJ6k9UBY@iweiny-desk3>
 <20220615050752.GA1521419@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615050752.GA1521419@alison-desk>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:07:52PM -0700, Alison Schofield wrote:
> On Tue, Jun 14, 2022 at 08:22:41PM -0700, Ira Weiny wrote:
> 

[snip]

> > > +
> > > +	do {
> > > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> > > +				       sizeof(pi), po, cxlds->payload_size);
> > > +		if (rc)
> > > +			goto out;
> > > +
> > > +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> > > +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> > > +
> > > +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> > > +				&o_time);
> > > +			rc = -ENXIO;
> > > +			goto out;
> > 
> > I guess the idea is that this return will trigger something else will clear the list,
> > rebuild the list, and perform a scan media request?
> > 
> Per CXL Spec 8.2.9.5.4.1: The poison list may be incomplete when the list
> has overflowed. User can perform a Scan Media to try to clear and rebuild
> the list, with no guarantee that the overflow will not recur.
> 
> So yes to what you are saying. This return value should indicate to
> user space that a Scan Media should be issued. Issuing the Scan Media
> to the device does lead the device to rebuild it's list, as you say.
> Also, when we get the Scan Media results, the device is able to report
> partial results and tell the host to collect the error records, and
> then restart the scan, get results again, and on and on until the scan
> is complete.
> 
> Perhaps a clarification - there is not a logical pairing of Scan Media
> followed by Get Poison List.  Scan Media followed by Get Scan Media
> Results is the logical pairing. Get Poison List is getting a snapshot
> of the poison list at a point in time. The device adds DPAs to the list
> when the device detects poison, some devices run their own backround
> scans and add to the poison list, and then there are the user initiated
> actions (Scan Media and Poison Inject) that can affect the list.
> 
> > I'm just wondering if this loop should continue to clear the list and then let
> > something else do the scan media request?
> 
> It's not like the _MORE status where the device is telling the host to
> come back and gather more. I think the action of failing, and letting
> user initiated a Scan Media is correct course here.

Fair enough.  But I guess I'm still confused by the spec.  The way I read it
yesterday (and I could be wrong) was that the OS was supposed to read the
entries to clear the list?  Is that not true?

I the device will clear the list internally when Scan Media is run?

At this point I'm just trying to understand not necessarily objecting to the
patch.

Ira

> 
> So, this response got kind of long winded. As you can see, especially
> if one looks in the spec as I know you are, there are additional
> commands that need to be implemented to complete the ARS feature set.
> And, of course, we'll offer user space tooling (NDCTL and libcxl).
> 
