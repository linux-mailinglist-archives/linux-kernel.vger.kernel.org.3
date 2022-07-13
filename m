Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB08573BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiGMRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiGMRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:21:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E1CE2B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657732863; x=1689268863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlqRDSG3uTORYT2sPgH9vU5seG1zCJ7cDC68V+8ciis=;
  b=LDYT/fL48o6B7IKYwzEKluK8M3WKxB446qeArXQG3c8xUvwZ1jL4PFUf
   bA4eacfxyVEEqDgNO6VMt6ARJgIPXN9M+QkMbXS++Y82kjfXya4WkHy6h
   nruMzLZ3LRFvbqB696mX9vTIu45RHiKJCV7fgMcIU8lmFEWDUSncwpSXK
   rWsxaqMMpfIAO4wVmNxy46OTPvGhNepEYe6HAC0c6zYjDNO1o5/odJ4Io
   Qt1HftZcWrK6bxvvwr60Bn9ZVtLpw3AeN/JCRrgc+ubrRQ1lS5QZ+/ubm
   x36Uv3UHLXrajgZ+IkFd5GsXZd4fUBxw0v20+QI3x3SI1pRodnTr7iMBa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="284047760"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="284047760"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:21:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570720808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:21:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBg2k-001CXQ-2r;
        Wed, 13 Jul 2022 20:20:58 +0300
Date:   Wed, 13 Jul 2022 20:20:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Fei Li <fei1.li@intel.com>, Shuo Liu <shuo.a.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Ys7++n8ZsmTY6J6s@smile.fi.intel.com>
References: <20220713170239.84362-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gReYjq5uBFZMF_r=fthTB6M_JpyG07-WAs=d+BC0H_Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gReYjq5uBFZMF_r=fthTB6M_JpyG07-WAs=d+BC0H_Yw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:10:18PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2022 at 7:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > After the commits for userspace [1][2] the uuid field is not being
> > used in the ACRN code. Update kernel to reflect these changes.
> > I.e. we do the following:
> > - adding a comment explaining that it's not used anymore
> > - replacing the specific type by a raw buffer
> > - updating the example code accordingly
> >
> > [1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> > [2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> 
> Why don't you use a Link tag for each of these?

I can use Link tags.

> > Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> > Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> 
> Typically, the changelog should explain what was wrong in a previous
> commit that is being fixed in the current one, but that information is
> missing here.

The advertised field confused users and actually never been used. So
the wrong part here is that kernel puts something which userspace
never used and hence this may confuse a reader of this code.

Would it be sufficient? Another way is to drop Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


