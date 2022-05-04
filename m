Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1C519B45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiEDJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347029AbiEDJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:18:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD52252A4;
        Wed,  4 May 2022 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651655671; x=1683191671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eKFjZ/eVF8ElceRlB71qNooFaIa0RunpC73Yf+SQ4NI=;
  b=jD4DoSSdwyGD9EqxBsOA/2ZK8iLqHPTna0GxuG8gWpsA7YCu7MYVh+je
   Xe/jwZGT36s1VO+xAbkGXj3FdBcKAusu6w1J2hfx/Lt3zlNgSVKJaW06S
   T7SK5d9x/9j/3+JEq3gHLmo/kYJVtEIUpDlHEt7omcYzPAaY3cPknVF3O
   5NAvtHhjHwA7HoLr34cwe4UMNbue94/vfpLKwKceEydCIWqA0/TfxJM+N
   2JfqIGZ2QfpK0FFh7j5N/Qk8rYFDu0zTJuejqPC4G4E5syPkyhdPdD4Me
   ZVIf8Ke1bgo+jT5pvRgSDP0lVl0pJhc85EkIJ83ZtLfUvzyOF4clCL+VE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265297879"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="265297879"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:14:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="620726815"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:14:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nmB5W-00Bp5R-99;
        Wed, 04 May 2022 12:14:26 +0300
Date:   Wed, 4 May 2022 12:14:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting
 the UUID
Message-ID: <YnJD8pYFcBBD2g5T@smile.fi.intel.com>
References: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
 <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
 <YnEBtk4ltlsep5/m@smile.fi.intel.com>
 <092fbb39-9a62-80ce-b3bc-62a597d8a718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <092fbb39-9a62-80ce-b3bc-62a597d8a718@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 12:28:18PM -0700, Florian Fainelli wrote:
> On 5/3/22 03:19, Andy Shevchenko wrote:
> > On Wed, Apr 13, 2022 at 08:38:41AM -0700, Florian Fainelli wrote:
> > > On 4/12/2022 4:32 AM, Andy Shevchenko wrote:
> > > > There is export_uuid() function which exports uuid_t to the u8 array.
> > > > Use it instead of open coding variant.
> > > > 
> > > > This allows to hide the uuid_t internals.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > > v3: rebased on the latest vanilla, added Andrew since it has no move for 1y+
> > > 
> > > I don't think this is going to be picked up unless we designate a entry in
> > > the MAINTAINERS file, I don't mind taking this via the Broadcom ARM SoCs
> > > pull request if this does not move.
> > 
> > I saw your patch has been picked up to up-to-date MAINTAINERS record.
> > Can this one now be picked up too?
> 
> Please resubmit targeting David Miller's net-next tree since this is how
> patches would be merged moving forward. Thanks!

Done, thanks!

-- 
With Best Regards,
Andy Shevchenko


