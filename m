Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF853544B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348900AbiEZUOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiEZUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:13:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC77C1EC4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653596037; x=1685132037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0J3P8mCVmRJH4VExXC4e3LOi9we7yQ54YNUzVR9BQ9Y=;
  b=KNAHQXbdTFieoE8nYXOJdPw3snxuBQwxOYcMTDVcvKK6pdQOWJUTg6Kd
   gVbZryAm7+JMZMFtnMaufscDCoaon0pY0EEEPH79GZhxwBx+JOBHAx3z4
   rsmLj5S7uS6Mx/lGR7hfBn5Q9yXncZQzn8x5ojCGfx0OFb4zkzd/vCfRH
   5jDsSrKwHjA7PrsVIygAnaVyue9gmXkliSDXDa3+I2d16ziYcd9u7eFZf
   vtUeVx3k17mlQ4y7ohm1prPfvVbfKT8czApX7yMkXZqkNU8A/zugHHsQS
   bK1AEinlgPelU+HE0zKbeKRqYN3pRyVwKRIoAFSPNMjT+c+nzB9s1MurF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274279075"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274279075"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="902196364"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 May 2022 13:13:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id F1E04109; Thu, 26 May 2022 23:13:54 +0300 (EEST)
Date:   Thu, 26 May 2022 23:13:54 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv3 2/3] x86/tdx: Clarify RIP adjustments in #VE handler
Message-ID: <20220526201354.v5a6fsi4aiuet2d7@black.fi.intel.com>
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-3-kirill.shutemov@linux.intel.com>
 <89f55141-a71c-1fd8-e1be-96355c63c03a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f55141-a71c-1fd8-e1be-96355c63c03a@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:02:48AM -0700, Dave Hansen wrote:
> On 5/24/22 15:10, Kirill A. Shutemov wrote:
> > +static int ve_instr_len(struct ve_info *ve)
> > +{
> > +	/*
> > +	 * If the #VE happened due to instruction execution, GET_VEINFO
> > +	 * provides info on the instruction.
> > +	 *
> > +	 * For #VE due to EPT violation, info provided by GET_VEINFO not usable
> > +	 * and kernel has to decode instruction manually to find out its
> > +	 * length. Catch such cases.
> > +	 */
> > +	if (WARN_ON_ONCE(ve->exit_reason == EXIT_REASON_EPT_VIOLATION))
> > +		return 0;
> > +
> > +	return ve->instr_len;
> > +}
> 
> I'm not super happy with how this comment ended up.  First, let's put
> the comment next to the code to which it applies, like:
> 
> 	/*
> 	 * ve->instr_len is not defined for EPT violations.  For those,
> 	 * the kernel must decode instructions manually and should not
> 	 * be using this function.
> 	 */
> 	if (WARN_ON_ONCE(ve->exit_reason == EXIT_REASON_EPT_VIOLATION))
> 		return 0;
> 
> 	/*
> 	 * Assume that the #VE occurred due to instruction execution.
> 	 */
> 	return ve->instr_len;

Would it be helpful if the function has a whitelist of exit resons where
using ve->instr_len is safe? WARN_ONCE() and return 0 otherwise.

-- 
 Kirill A. Shutemov
