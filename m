Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ADE4BBE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiBRRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:25:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiBRRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:25:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F022B6222
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645205112; x=1676741112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5f5JDzLplFmvvlqdfeuY85FDd5GMFEphOULZXgLWA20=;
  b=Cr3ZQ2wUHaQmMGOb9mZHgBamIbODRpmb7PdZl48J07hhrRYgGhiJ7avf
   qAQsY/fU3hfAFUv3Ijb5BgVVZ+H6hYTAlLr6tY1sMBh1Uat8WJbtqrc/+
   2fmtKGM9nYscIxealgESfAcOweNgxWtn0CVTnh5G0CrpA6Od3Dghu6x7c
   0E5GCL6LFVL37qJc2yWgQxQgvCRE7QS+cI4KWtCDc45bHIBxSBjXC8PBE
   aaeZB0+1m6/NohD7ttY67P7oaoNwEgvkvVjCcZwlc4XAG/L9UYyqajDyU
   x9vrfkJVnwVYGE0eeTMt30t28J/STUDUD67FzWEMY3gA39Fj6d8SmxZQA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="238574048"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238574048"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 09:25:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="504067766"
Received: from rabecker-mobl.amr.corp.intel.com (HELO localhost) ([10.212.87.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 09:25:11 -0800
Date:   Fri, 18 Feb 2022 09:25:11 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/44] mm/pkeys: PKS Testing, add pks_mk_*() tests
Message-ID: <Yg/Wd4We9uinmGYk@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-20-ira.weiny@intel.com>
 <00b87c5f-b4ed-7593-827c-0e1114b8b456@intel.com>
 <Yg8v8XPyDTH4O2rr@iweiny-desk3>
 <311ef2df-dd49-0711-aa8b-fa88a87ff196@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311ef2df-dd49-0711-aa8b-fa88a87ff196@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 07:28:04AM -0800, Dave Hansen wrote:
> On 2/17/22 21:34, Ira Weiny wrote:
> > On Tue, Feb 01, 2022 at 09:45:03AM -0800, Dave Hansen wrote:
> >> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> >>>  bool pks_test_callback(void)
> >>>  {
> >>> -	return false;
> >>> +	bool armed = (test_armed_key != 0);
> >>> +
> >>> +	if (armed) {
> >>> +		pks_mk_readwrite(test_armed_key);
> >>> +		fault_cnt++;
> >>> +	}
> >>> +
> >>> +	return armed;
> >>> +}
> >>
> >> Where's the locking for all this?  I don't think we need anything fancy,
> >> but is there anything preventing the test from being started from
> >> multiple threads at the same time?  I think a simple global test mutex
> >> would probably suffice.
> > 
> > Good idea.  Generally I don't see that happening but it is good to be safe.
> 
> I'm not sure what you mean.
> 
> In the kernel, we always program as if userspace is out to get us.  If
> userspace can possibly do something to confuse the kernel, it will.  It
> might be malicious or incompetent, but it will happen.
> 
> This isn't really a "good to be safe" kind of thing.  Kernel code must
> *be* safe.

Yes

> 
> >> Also, pks_test_callback() needs at least a comment or two about what
> >> it's doing.
> > 
> > The previous patch which adds this call in the fault handler contains the
> > following comment which is in the final code:
> > 
> > /*
> >  * pks_test_callback() is called by the fault handler to indicate it saw a pkey
> >  * fault.
> >  *
> >  * NOTE: The callback is responsible for clearing any condition which would
> >  * cause the fault to re-trigger.
> >  */
> > 
> > Would you like more comments within the function?
> 
> Ahh, it just wasn't in the context.
> 
> Looking at this again, I don't really like the name "callback" is almost
> always a waste of bytes.  Imagine this was named something like:
> 
> 	pks_test_induced_fault();
> 
> ... and had a comment like:
> 
> /*
>  * Ensure that the fault handler does not treat
>  * test-induced faults as actual errors.
>  */

Ok.  At this point this may go away depending on how I resolve the ability to
test all the keys.  pks_test_callback() was critical for that feature without
introducing a bunch of ugly test code in pks-keys.h and pkeys.c.

> 
> >> Does this work if you have a test armed and then you get an unrelated
> >> PKS fault on another CPU?  I think this will disarm the test from the
> >> unrelated thread.
> > 
> > This code will detect a false fault.  
> 
> That's a bug that's going to get fixed, right? ;)

Yep.  Not sure how at the moment.

Ira
