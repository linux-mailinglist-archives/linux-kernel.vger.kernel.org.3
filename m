Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26095851A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiG2Ofi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiG2Ofe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:35:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141B2714E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659105333; x=1690641333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fwz8XfsoWTAQMn6YI+beTtjBFPHAbaqLdcKiH2LGAyU=;
  b=lSVFMNhs7FDabNTHCXHz2SAnl/T95tHNsyv8Zg4lYBzfUtbWIR8hgxVG
   tkdBLrj7WATeaQ0qbfYPRIjONwTKV6A2/m/UmIzumhf67ogIgi6tSkAQL
   aAqazpVJ18+NSb6iDrT2hC0J+rYmjv0l+5BV2Ni99TFbNVpwurHs/DyKd
   DdfA989Ie/poP2KuiQm4IS7OhYcAFZG37wwrBMXI1ukVAucHocSbrUM8Z
   11hwXWZKhnXlAz8FCkULPZbwK5JHx6tZmSeAGJBbf3SK/bHBK9lITXpPm
   tiTuvoNavIQEpTxFCU2i0WDaEFNzZEn5rvLuvl0YRO2pR5wfWojgEfQ9A
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268541827"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="268541827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:35:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="669288400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:35:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oHR5K-001eZm-10;
        Fri, 29 Jul 2022 17:35:26 +0300
Date:   Fri, 29 Jul 2022 17:35:26 +0300
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
Message-ID: <YuPwLq+D8k53GZa3@smile.fi.intel.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
 <Yt605xj898VSAsA3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt605xj898VSAsA3@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:21:11PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 25, 2022 at 03:55:27PM +0100, Mark Rutland wrote:
> > On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > > At many places in kernel, It is necessary to convert sysfs input
> > > to corrosponding bool value e.g. "false" or "0" need to be converted
> > > to bool false, "true" or "1" need to be converted to bool true,
> > > places where such conversion is needed currently check the input
> > > string manually, kstrtobool() can be utilized at such places but
> > > currently it doesn't have support to accept "false"/"true".
> > > 
> > > Add support to accept "false"/"true" as valid string in kstrtobool().
> > > 
> > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > I've just spotted that this broke arm64's "rodata=full" command line option,
> 
> That isn't a documented option.
> 
>         rodata=         [KNL]
>                 on      Mark read-only kernel memory as read-only (default).
>                 off     Leave read-only kernel memory writable for debugging.
> 
> Hopefully this is an object lesson in why you need to update the
> documentation when you extend a feature.
> 
> > since "full" gets parsed as 'f' = FALSE, when previously that would have been
> > rejected. So anyone passing "rodata=full" on the command line will have rodata
> > disabled, which is not what they wanted.
> > 
> > The current state of things is a bit messy (we prase the option twice because
> > arch code needs it early), and we can probably fix that with some refactoring,
> > but I do wonder if we actually want to open up the sysfs parsing to accept
> > anything *beginning* with [tTfF] rather than the full "true" and "false"
> > strings as previously, or whether it's worth reverting this for now in case
> > anything else is affected.
> 
> Well, that's going to break people who've started using the new option.
> As a quick fix, how about only allowing either "f\0" or "fa"?

I think we need to be more strict in kstrtobool(), i.e. 'f\0' ('t\0') and 'fal'
('tru') perhaps?


-- 
With Best Regards,
Andy Shevchenko


