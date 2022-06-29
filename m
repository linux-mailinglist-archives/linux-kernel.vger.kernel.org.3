Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8527856054C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiF2QEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiF2QEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:04:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E741ADB3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656518597; x=1688054597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33ErILRp6RTuMV5lrsYjOdd5VxHX6jSjNy/+L/osBvc=;
  b=TsephYRSkNOUAwCqwnetajjAtGWMp2k9AXsXDho6KOtpzoMV4z7AcmrH
   2sjGeAJaNl1zzHl8vp9LmyQdPC8DPRrYca2HtK3/ucofG8ifYahy81keb
   q5zsibNCEHkecs+RzdLVet1QZXgGOu0U0Uh9r1pDWsZtQUTA+19vXHHOx
   dID+eCMhsW64kvbf6nglsDTa/rlLROheHVSKUwGakNJAdhAlbVp9csrSX
   XTt9c0/XUmMTOEIdszJ8ogN0S4jE0F7Uu1KCaaQdeHovPt/iNr/mtJMt5
   1LKzuLkLEE2HPefbo1qdcfN/oGy9HH4OjnLRRYSYD8yMmqcGK98Iu61lW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343757216"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="343757216"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:03:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="680563066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:03:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6a9o-000xsJ-R6;
        Wed, 29 Jun 2022 19:03:12 +0300
Date:   Wed, 29 Jun 2022 19:03:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <Yrx3wH8lnlKpDSdN@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
 <YruJk4aAmFo/mihX@smile.fi.intel.com>
 <35153061-0d52-1c77-5921-e8ea0a662b3b@redhat.com>
 <807c2530-9382-9469-3e47-00770b3521bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807c2530-9382-9469-3e47-00770b3521bd@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 03:19:17PM +0200, Hans de Goede wrote:
> On 6/29/22 15:18, Hans de Goede wrote:
> > On 6/29/22 01:06, Andy Shevchenko wrote:
> >> On Mon, Jun 20, 2022 at 11:04:38AM +0200, Hans de Goede wrote:
> >>> p.s.
> >>>
> >>> I've added this commit to my local tree, so that the next time I boot
> >>> a device with a CRC PMIC it will get some testing.
> >>
> >> Have you had a chance to boot such device?
> > 
> > Not yet, but I've just put a new kernel on one of these devices
> > and everything still works fine AFAICT:
> > 
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> p.s.
> 
> This is for the entire series.

Thanks, I applied it locally in case I would need to send another version with
some additional flags for `git format-patch`. Otherwise I hope Lee can catch
up it from here.

-- 
With Best Regards,
Andy Shevchenko


