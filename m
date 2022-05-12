Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177E15249A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352304AbiELJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352377AbiELJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:57:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2725C5045C;
        Thu, 12 May 2022 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652349428; x=1683885428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ulaCPfybGFTVCcH+ydh23paG+OmMRRGrYmal9E2wDg=;
  b=ZGoEPOct66vaOnboh6UC1F4VqM80sELBNRCzfKlUZcnH0VaG2417V8gb
   o21XrtxRpECFMqtHxLIZj8bG+t5uOru8PSCcd0zSA75E82EhdUXq4T88x
   FdQWJQnQx0N5eyNjLk+h8YUnkn8JoSjhO/2cQs6mhNNmlwDV03DucJxUy
   fa3MIoTRkY5gon0QWJCWbPn/y8lfR4clutM3y38RolUHrnMA2lS7CTYHK
   SrKkiRUSElNCLbIJ8KOFY0sXO3w0BHrmOwQxCS4EY1Rhkw+iXT5Sgdmd5
   b0sDkM1XUxVEKT3klSqJhgPuBNuNOp7bgQVL3TPR1Jup0IgntlO5Z2Jl+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="252006696"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="252006696"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:57:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="739622755"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:57:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1np5Z7-00F9nh-Gl;
        Thu, 12 May 2022 12:57:01 +0300
Date:   Thu, 12 May 2022 12:57:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB
 accessor
Message-ID: <YnzZ7XeHqRaBka50@smile.fi.intel.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
 <20220511153905.13980-3-henning.schild@siemens.com>
 <7c458add-a496-6b3a-a04f-e6b68865daf4@roeck-us.net>
 <20220512105836.3fb3ff95@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512105836.3fb3ff95@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:58:36AM +0200, Henning Schild wrote:
> Am Wed, 11 May 2022 11:03:04 -0700
> schrieb Guenter Roeck <linux@roeck-us.net>:
> > On 5/11/22 08:39, Henning Schild wrote:

...

> > Also, I just noticed that P2SB is neither in mainline nor
> > in linux-next, meaning this code won't even compile right now.
> > That should be mentioned in the introduction e-mail (the use
> > of "introduced" suggests that it is already there; you could
> > just use "will be introduced" instead).
> 
> It was kind of in the cover letter, but maybe not verbose enough. Sorry
> for the confusion. v1 was sent in-reply-to on top of P2SB, maybe i will
> do that again for v3 but for sure point out the order in case i send it
> without the reply.

A new version of a series should start a new thread. Just use cover letter
to explain the dependencies. My expectations here is to see v3 with comments
addressed and I will incorporate it into v6 of mine. Then LKP and other
bots will be happy to test all bunch. Also, I would wait a bit for your v3,
so maintainers will have time to give their tags and/or comments.

-- 
With Best Regards,
Andy Shevchenko


