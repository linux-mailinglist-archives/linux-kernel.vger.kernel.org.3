Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCD5A0A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiHYHpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbiHYHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:45:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6BDA2DA1;
        Thu, 25 Aug 2022 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661413511; x=1692949511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sl6ubljrae41HflpL13HoTVWCPjIUWo7xLVS3fMd/JM=;
  b=Muf2fMGd2AR0d90hrJxLPfPR7Ldd7isDKfpbDQMpNEQmeTTLKU0WQANF
   +inG2mKno+yZHlSvVo4FhYAQIQ0JXkIMP0n5J5QvL2wcvNO8QBmdI050H
   XcjLS+ItJZDJlVKfOm6Fpxl34XOpXmEGdqlLQ05jMuTZOtpFVpR18N8hj
   pmBa0Nwfw3PQCK6WEVntDR6abrqOxpqAbNHRwG8TzF3tmJ5r4Ff514EmK
   pWM6Y7aHNfrqyd4HpfjLdqwFiGV/HmB+aysm+FIpG7r/BSMJjh3rTkZSn
   Rb2xwdBgF14sX1j0KDOPfA3QpVDZ+eL0mEcB2BLnvpvWlt0EqTIRANmIi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291741736"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291741736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 00:45:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="560926021"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 00:45:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 307252029D;
        Thu, 25 Aug 2022 10:45:06 +0300 (EEST)
Date:   Thu, 25 Aug 2022 07:45:06 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     sbinding@opensource.cirrus.com, andriy.shevchenko@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, rafael@kernel.org
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer
 reading functions
Message-ID: <YwcogrMqqEO5KmPb@paasikivi.fi.intel.com>
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
 <20220825072505.316002-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825072505.316002-1-ardb@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Aug 25, 2022 at 09:25:05AM +0200, Ard Biesheuvel wrote:
> > The current code expects the type of the value to be an integer type,
> > instead the value passed to the macro is a pointer.
> > Ensure the size comparison uses the correct pointer type to choose the
> > max value, instead of using the integer type.
> > 
> > Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
> > 
> > Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Can we get this queued up and sent out please? This is breaking some ACPI arm64
> systems, which use device properties for their MAC addresses.
> 
> Some grumbling about the original patch below.
> 
> > ---
> >  drivers/acpi/property.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 7b3ad8ed2f4e..b1d4a8db89df 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1043,10 +1043,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
> >  				break;					\
> >  			}						\
> >  			if (__items[i].integer.value > _Generic(__val,	\
> > -								u8: U8_MAX, \
> > -								u16: U16_MAX, \
> > -								u32: U32_MAX, \
> > -								u64: U64_MAX, \
> > +								u8 *: U8_MAX, \
> > +								u16 *: U16_MAX, \
> > +								u32 *: U32_MAX, \
> > +								u64 *: U64_MAX, \
> >  								default: 0U)) { \
> 
> Why is there a default here? Having one is what hides the fact that the patch was completely broken.

I think the default can be removed. I can send a patch.

> 
> >  				ret = -EOVERFLOW;			\
> >  				break;					\
> > 
> 
> Also, I must ask: given how broken the original patch is, I suppose no testing whatsoever was done? 

Testing was done but it failed to uncover this. It seems all the properties
in the system were of buffer type.

Please wrap your lines before 80. It'll be easier to read that way.

-- 
Kind regards,

Sakari Ailus
