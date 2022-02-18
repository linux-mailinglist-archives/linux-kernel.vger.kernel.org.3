Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8654BB177
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiBRFfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:35:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:34:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E601783AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645162481; x=1676698481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZmmDTIxi0lu2DZF0PIAIbRLyfoDOnSLD948kCfctC0=;
  b=lvmvS5W0sTmCHltY3qEs6gKuWlaEa35MBzul1khdFmIFZ1WgWCpqUsKH
   lWHh4CzEBEEeLZ889zipoZ1Fry5f6Io/BPc5mMUnjpUdyg6hFImxiEdZ0
   oXp82WbNSvSsrT/wtX+02mGQ0na8tiOPyFWSGQ0ffjgCYmlfhavQXzEOo
   Iq/cePYju049wnW1yJg8wZfvjMMghb49CIKZf6AXJh/w5ybl5Xkfv+lF7
   vh5qRrG6Lo9UtBpNX2ZoHyYfgYMJg77DGQozEOQYgufHu+Ehu3f7tyHez
   8Fenvj2obUekhnzolLH50NL/5YTyeqZ0lWVwZ5Wzd9lTuN+4YJ1Bx6rbI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251255013"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="251255013"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 21:34:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="777898092"
Received: from rbfawkes-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.127.120])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 21:34:41 -0800
Date:   Thu, 17 Feb 2022 21:34:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/44] mm/pkeys: PKS Testing, add pks_mk_*() tests
Message-ID: <Yg8v8XPyDTH4O2rr@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-20-ira.weiny@intel.com>
 <00b87c5f-b4ed-7593-827c-0e1114b8b456@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b87c5f-b4ed-7593-827c-0e1114b8b456@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:45:03AM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> >  bool pks_test_callback(void)
> >  {
> > -	return false;
> > +	bool armed = (test_armed_key != 0);
> > +
> > +	if (armed) {
> > +		pks_mk_readwrite(test_armed_key);
> > +		fault_cnt++;
> > +	}
> > +
> > +	return armed;
> > +}
> 
> Where's the locking for all this?  I don't think we need anything fancy,
> but is there anything preventing the test from being started from
> multiple threads at the same time?  I think a simple global test mutex
> would probably suffice.

Good idea.  Generally I don't see that happening but it is good to be safe.

> 
> Also, pks_test_callback() needs at least a comment or two about what
> it's doing.

The previous patch which adds this call in the fault handler contains the
following comment which is in the final code:

/*
 * pks_test_callback() is called by the fault handler to indicate it saw a pkey
 * fault.
 *
 * NOTE: The callback is responsible for clearing any condition which would
 * cause the fault to re-trigger.
 */

Would you like more comments within the function?

> 
> Does this work if you have a test armed and then you get an unrelated
> PKS fault on another CPU?  I think this will disarm the test from the
> unrelated thread.

This code will detect a false fault.  But the other unrelated fault will work
correctly.

I've debated if the test code should use a specific fault callback...  :-/
That breaks my test which iterates all keys...  but would fix this problem.

Ira
