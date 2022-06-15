Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084754CF97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349707AbiFORUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbiFORUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:20:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8320F74;
        Wed, 15 Jun 2022 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655313600; x=1686849600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u56Bi9DvFHb/XdAQOUiAeLpbMmqzlMitze3wOCr4cck=;
  b=HieceRV1dFhsS0YvzUuJDNqIR6kgmGoxJFQcCWpQ5Tcs2cykEL5APjTU
   5qOXZT0WqIAmrvO9FYSN9MSGjJCwmpTt2Y+Awst7/KY3MJwDrd7Z2U2Oz
   Vd+o5Kd67xl9rzJWzJSrtsnmmt7eLFPALT1frgMrbZ04aV+93KqhJRG4J
   2uJcIxRy2FJwXuWQpZZvZ2krad0rxQ78h2Y0gJbWA90GWNYkNc2lnBgFn
   YieImNXQgJT+SxFWg3qJkRu6CnXlQwcwAfSP9+AJ8Q35vkKdTSB1muogq
   7l3eclS8DsFlWEKa3tgCe2EUxLj5rVU1Z3gIW1R/24IjaYw8q96LgALxU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279091676"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279091676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 10:19:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="762561193"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 10:19:47 -0700
Date:   Wed, 15 Jun 2022 10:19:30 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220615171930.GA1523982@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <YqlQgbDUTJ6k9UBY@iweiny-desk3>
 <20220615050752.GA1521419@alison-desk>
 <Yqn0XqfPd4q89pL7@iweiny-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqn0XqfPd4q89pL7@iweiny-server>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:01:50AM -0700, Ira Weiny wrote:
> On Tue, Jun 14, 2022 at 10:07:52PM -0700, Alison Schofield wrote:
> > On Tue, Jun 14, 2022 at 08:22:41PM -0700, Ira Weiny wrote:
> > 
> 
> [snip]
> 
> > > > +
> > > > +	do {
> > > > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> > > > +				       sizeof(pi), po, cxlds->payload_size);
> > > > +		if (rc)
> > > > +			goto out;
> > > > +
> > > > +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> > > > +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> > > > +
> > > > +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> > > > +				&o_time);
> > > > +			rc = -ENXIO;
> > > > +			goto out;
> > > 
> > > I guess the idea is that this return will trigger something else will clear the list,
> > > rebuild the list, and perform a scan media request?
> > > 
> > Per CXL Spec 8.2.9.5.4.1: The poison list may be incomplete when the list
> > has overflowed. User can perform a Scan Media to try to clear and rebuild
> > the list, with no guarantee that the overflow will not recur.
> > 
> > So yes to what you are saying. This return value should indicate to
> > user space that a Scan Media should be issued. Issuing the Scan Media
> > to the device does lead the device to rebuild it's list, as you say.
> > Also, when we get the Scan Media results, the device is able to report
> > partial results and tell the host to collect the error records, and
> > then restart the scan, get results again, and on and on until the scan
> > is complete.
> > 
> > Perhaps a clarification - there is not a logical pairing of Scan Media
> > followed by Get Poison List.  Scan Media followed by Get Scan Media
> > Results is the logical pairing. Get Poison List is getting a snapshot
> > of the poison list at a point in time. The device adds DPAs to the list
> > when the device detects poison, some devices run their own backround
> > scans and add to the poison list, and then there are the user initiated
> > actions (Scan Media and Poison Inject) that can affect the list.
> > 
> > > I'm just wondering if this loop should continue to clear the list and then let
> > > something else do the scan media request?
> > 
> > It's not like the _MORE status where the device is telling the host to
> > come back and gather more. I think the action of failing, and letting
> > user initiated a Scan Media is correct course here.
> 
> Fair enough.  But I guess I'm still confused by the spec.  The way I read it
> yesterday (and I could be wrong) was that the OS was supposed to read the
> entries to clear the list?  Is that not true?

I think - not true.

Get_Poison_List has no effect on the contents of the list itself.
Even with its MORE flag, it is not clearing any poison, it's just
telling the host that it had more records than could fit in one
device payload so they will have to delivered to the host in multiple
requests. I'd expect issuing multiple Get Poison List requests would
get same results.  (unless of course the media was going bad quickly

Maybe you are conflating w other cmds: Scan Media & Clear Poison

> 
> I the device will clear the list internally when Scan Media is run?

Spec says device 'rebuids' the list. I might guess that's a clear and
start anew, but not the hosts business. As a host, we wait for Scan
Media to complete before issuing Get Scan Media Results or Get Poison
List.
> 
> At this point I'm just trying to understand not necessarily objecting to the
> patch.

NP.  The questions are helpful!

> 
> Ira
> 
> > 
> > So, this response got kind of long winded. As you can see, especially
> > if one looks in the spec as I know you are, there are additional
> > commands that need to be implemented to complete the ARS feature set.
> > And, of course, we'll offer user space tooling (NDCTL and libcxl).
> > 
