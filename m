Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1574E6109
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbiCXJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCXJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:23:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094BE9E9D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648113699; x=1679649699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71ipZJUWx3idAaB1NzFHZUhbPl5KmZA24N2IMFEUO6Q=;
  b=E7iDzFUMvvJMWRDz9kEKacD/Uaikk9V01DBFPs5383jhMxBT4ChkuNnV
   DOIiMcodDtJap61bfQV30rdw0iMy2ENixiRXM0xkvpDzwMLYNprv+SMZ2
   kBOP/7jTyKm+/B2r8aUNy4ttMMxajdgtgZYog8xaN9ixKbLvVbWh1/ifg
   uxzMkLJRknL/H1hMl90flDb1gzHYP16wPyPEQHkI2DVCscpeI5sEJ30wX
   u/GGssMtjOqhUpBYbzW76LDC0f9l7i8Gi3CUmlAD+Eh/yzXghJtphTjRd
   jWGOSGRKnqEdkMrIWqW32VjSSjofDIiLu53d0XkKv/T3VPYCYnVceM8HP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="257156802"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="257156802"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:21:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="544567615"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:21:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXJeP-005ifw-Ky;
        Thu, 24 Mar 2022 11:21:01 +0200
Date:   Thu, 24 Mar 2022 11:21:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] auxdisplay: lcd2s: make use of device property API
Message-ID: <Yjw3/bnw/tomFvZd@smile.fi.intel.com>
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
 <CANiq72kLxzRdXSQfjXBL9xixXBwbxOAhZ4fR_+GtgT5FXz7vaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kLxzRdXSQfjXBL9xixXBwbxOAhZ4fR_+GtgT5FXz7vaQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:02:20PM +0100, Miguel Ojeda wrote:
> On Tue, Mar 8, 2022 at 4:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Make use of device property API in this driver so that both OF based
> > system and ACPI based system can use this driver.
> 
> I applied the series to -next, but for my understanding: the device
> property API was already being used, even if non-OF platforms couldn't
> use the driver before this patch, right? i.e. the commit message seems
> like the patch modified the calls.

Not really. The device property supports the PRP0001 special ACPI device
that makes use of OF matching mechanism (via usage of OF match table).
Without above change when CONFIG_OF=n, this may not work. I.o.w. device
properties per se in use, but the mechanism of matching is not working.

-- 
With Best Regards,
Andy Shevchenko


