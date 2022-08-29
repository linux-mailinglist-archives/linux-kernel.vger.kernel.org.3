Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F805A5489
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiH2T0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiH2T0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:26:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D88A7C6;
        Mon, 29 Aug 2022 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661801166; x=1693337166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PtLKBNgjh+ULawwAW9/eSjnSKuCcdBTI5zbDgdybVL4=;
  b=lqteU+jaYYacIoIikUCDnhdreq2m1h5Vevv0u3m0XGa6Ul+FtCgCvDDt
   eVircrwFHwPorE4xZ+Dgtu/iUZSy6XXB2By/BvxXavHL/IlYq7LltmE4p
   t0J0rUXguHwQtlire/kUoWrEydRnVZjEXwWXRQoZT12dorFT02ZLRLT1W
   5fW/QfLaJKodDpsYi3AsZ8U7vW8g6HjDdHZlKmmzTS1zdOolH/TCZn+W2
   +60uLlg6kkTpJzwi19L1szhIx7h+JaMBm02tYC560EoD2ZdV58LCm3Dnf
   X1x2/XHcz2zmtK/NK+9pr6hmtpxDfKSzAON+cysl9sWkE4YDfweR/CKqV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="292558633"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="292558633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 12:26:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="679742081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 12:26:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oSkOW-005ep2-2a;
        Mon, 29 Aug 2022 22:26:00 +0300
Date:   Mon, 29 Aug 2022 22:26:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming
 an interrupt
Message-ID: <Yw0SyH9nwpk6Ymsw@smile.fi.intel.com>
References: <20220803042501.515-1-mario.limonciello@amd.com>
 <efb83a0c-7617-894e-a34d-37280238d5aa@redhat.com>
 <YwkDd+mAhyoSwVeq@smile.fi.intel.com>
 <MN0PR12MB610137D56D08C873C7647A9CE2769@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610137D56D08C873C7647A9CE2769@MN0PR12MB6101.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:16:45PM +0000, Limonciello, Mario wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, August 26, 2022 12:32
> > On Wed, Aug 03, 2022 at 05:07:15PM +0200, Hans de Goede wrote:
> > > On 8/3/22 06:24, Mario Limonciello wrote:

...

> > > Thanks, patch looks good to me:
> > >
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Pushed to my review and testing queue, thanks!

> Just to double check, you meant you took both patches, not just the first right?

Yes, I took 2 patches. To reduce a confusion I highly recommend to send a
series with a cover letter, so the answer to it will definitely be equal to
"yes, I have took all of them" if nothing else specified.

-- 
With Best Regards,
Andy Shevchenko


