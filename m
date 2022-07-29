Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DA5851A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiG2OhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiG2OhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:37:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0066170E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659105425; x=1690641425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QFxIPJPgK4IPpJ/HviS1EILZsgjtlw3yJGq/7HtHu+I=;
  b=fV5yWjzw/TIMmuDnV2j8c99bwRVpGxDYFV90qmICcADrSdDbsfDoi0LC
   +Uz8NxrVNKxW9X6LfHCcxxWHN1SJ/7Z3sJHgwxJFMI8s6FNzB2Mf4i0HY
   lWBHA+HZmf4sNlytmC/fsTzhJvP4eQ5VqkyY+DWz9FqnYWJMiEHiRV7z3
   pcTpjSuuHMBwNhUTmhK1xHouUeTQCNIxT0xOQjC6x10q249VSogIqLx37
   kK3dtxb4cBjLGo3TKaicqRI1AbCIIVm0fjE30fjA0+JBug7nwboFdrQRi
   ohWJwW9DMIbfycZ4BgXmKbS/u6dxp9/shpaO2t4L2noadgDxoSVBZbNnp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287532998"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="287532998"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:36:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="704215764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:36:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oHR6g-001eZv-1G;
        Fri, 29 Jul 2022 17:36:50 +0300
Date:   Fri, 29 Jul 2022 17:36:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, rf@opensource.cirrus.com,
        pmladek@suse.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <YuPwgmHbcQYsA4Kp@smile.fi.intel.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
 <Yt605xj898VSAsA3@casper.infradead.org>
 <YuPwLq+D8k53GZa3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPwLq+D8k53GZa3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 05:35:26PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 25, 2022 at 04:21:11PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 25, 2022 at 03:55:27PM +0100, Mark Rutland wrote:
> > > On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > > > At many places in kernel, It is necessary to convert sysfs input
> > > > to corrosponding bool value e.g. "false" or "0" need to be converted
> > > > to bool false, "true" or "1" need to be converted to bool true,
> > > > places where such conversion is needed currently check the input
> > > > string manually, kstrtobool() can be utilized at such places but
> > > > currently it doesn't have support to accept "false"/"true".
> > > > 
> > > > Add support to accept "false"/"true" as valid string in kstrtobool().
> > > > 
> > > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > I've just spotted that this broke arm64's "rodata=full" command line option,
> > 
> > That isn't a documented option.
> > 
> >         rodata=         [KNL]
> >                 on      Mark read-only kernel memory as read-only (default).
> >                 off     Leave read-only kernel memory writable for debugging.
> > 
> > Hopefully this is an object lesson in why you need to update the
> > documentation when you extend a feature.
> > 
> > > since "full" gets parsed as 'f' = FALSE, when previously that would have been
> > > rejected. So anyone passing "rodata=full" on the command line will have rodata
> > > disabled, which is not what they wanted.
> > > 
> > > The current state of things is a bit messy (we prase the option twice because
> > > arch code needs it early), and we can probably fix that with some refactoring,
> > > but I do wonder if we actually want to open up the sysfs parsing to accept
> > > anything *beginning* with [tTfF] rather than the full "true" and "false"
> > > strings as previously, or whether it's worth reverting this for now in case
> > > anything else is affected.
> > 
> > Well, that's going to break people who've started using the new option.
> > As a quick fix, how about only allowing either "f\0" or "fa"?
> 
> I think we need to be more strict in kstrtobool(), i.e. 'f\0' ('t\0') and 'fal'
> ('tru') perhaps?

Actually kstrtobool() has been designed as a generic parser that should have
lowest priority. It means that the code that uses it should take care of any
other custom cases _before_ calling for kstrtobool().

-- 
With Best Regards,
Andy Shevchenko


