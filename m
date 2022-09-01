Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47805AA0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiIAUI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiIAUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:08:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77196764;
        Thu,  1 Sep 2022 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662062934; x=1693598934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEaao3foBhQw2Xuc0GTtdg6hbZmqlCpEihIK2n8Jim8=;
  b=TJayDPsgqEjk5tiHztuG8leDRBg/al8Rz3oAz5XsGuKpf7wwwciSmPgK
   zzAKKuTDefjKawl21R0tm2BFEGZRecURim/V76lpJgKyzl2ovWDs3RP43
   vRTSm5k/MrpRiHr8aW06H6CDHswJ57TRD+GE5dM3++Hh9yi9HAlCq1jwO
   FhQDKE3SwGQkaKEvNYGvVcfzaPcmKXxj1HwlJsuJnh+9jQj0bfZc5ciIi
   ZPHqukwuLFh6nzjMbjjWCiR9Msi9q5H7LE0r5Xe1TSOTWtP3J6jM786wO
   wMxzeNNBN74Eq41uNvsAzboWrDa/VFRNBeZzggTeDLNwsqTwCrkFINNK0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="382115562"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="382115562"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:08:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563603640"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:08:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTqUX-0071pb-2n;
        Thu, 01 Sep 2022 23:08:45 +0300
Date:   Thu, 1 Sep 2022 23:08:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 12/19] hwmon: (mr75203) fix voltage equation for
 negative source input
Message-ID: <YxERTTubyKb9oy8P@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-13-farbere@amazon.com>
 <Yw9OSJogapyla1Jr@smile.fi.intel.com>
 <a05adc0e-35f8-9e77-9e3e-83de851b651b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05adc0e-35f8-9e77-9e3e-83de851b651b@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:47:39PM +0300, Farber, Eliav wrote:
> On 8/31/2022 3:04 PM, Andy Shevchenko wrote:
> > On Tue, Aug 30, 2022 at 07:22:05PM +0000, Eliav Farber wrote:
> > > According to Moortec Embedded Voltage Monitor (MEVM) series 3 data
> > > sheet,
> > > the minimum input signal is -100mv and maximum input signal is +1000mv.
> > > When n was small enough, such that PVT_N_CONST * n < PVT_R_CONST it
> > > resulted in n overflowing to a very large number (since n is u32 type).
> > > 
> > > This change fixes the problem by casting n to long and replacing shift
> > > right with div operation.
> > 
> > Fixes tag?
> 
> For v4 I modified the commit message to (hopefully) be more
> understandable:
> 
> "
> According to Moortec Embedded Voltage Monitor (MEVM) series 3 data
> sheet, the minimum input signal is -100mv and maximum input signal
> is +1000mv.
> 
> On 64 bit machines sizeof(u32) = 4 and sizeof(long) = 8.
> So when measuring a negative input and n is small enough, such that
> PVT_N_CONST * n < PVT_R_CONST, it results in n overflowing to a very
> large number which is not negative (because 4 MSB bytes of val are 0).
> 
> This change fixes the sign problem and supports negative values by
> casting n to long and replacing shift right with div operation.
> "

What I meant is to add the tag of the commit which this one is fixing.
We have Fixes tag format for that. You may see how it's done by looking
into Git history: git log --grep Fixes:

-- 
With Best Regards,
Andy Shevchenko


