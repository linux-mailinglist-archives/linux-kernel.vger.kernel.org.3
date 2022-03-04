Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7E4CDB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiCDRvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiCDRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:51:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB1E1B54;
        Fri,  4 Mar 2022 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646416247; x=1677952247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8gdC/LTDrr4qcvIX6OPCBxrk+BVbgh5qgr9DkwVSOOU=;
  b=npfMvh+m/Bj6va7xhfG5hWScX84tApKuC/3XDJdVQg8zrQrSmnv14uap
   o9YTYj8pHtjQaT2A9dyaPPsvPhxC+V+szUBFYqfIDp0FolQA/c5bgiaZn
   CEG1T0h7lbaYfpSbJ6KfhOwNrvNRLD6/FcdX7StJZkGBbs95Iu37IZTdo
   1CVK5ETtDi+4WxtrotLivc+SlldPpw8ueKm0cwsGuoCo+zRogUTloMlFR
   VqnRt2YBHgRawgjsC8+vB5p/g0a+/zku6XtHQIHhvCipMKPpr+gqDgCO0
   eu9HRfRb2dGOKsv4kZqt0K10LAlfJ+R45+zHhVjCAHDZpw9mPp/qP07ix
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253755655"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="253755655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 09:50:47 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="509047350"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 09:50:44 -0800
Date:   Fri, 4 Mar 2022 17:50:38 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YiJRQQmSxA/fbm6P@silpixa00400314>
References: <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314>
 <Yh/znCnZzWaL49+o@gondor.apana.org.au>
 <YiDHT31ujlGdQEe/@silpixa00400314>
 <YiEVPc2cd38AnLZB@gmail.com>
 <YiEyGoHacN80FcOL@silpixa00400314>
 <YiE21aPGG5DHwJvb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiE21aPGG5DHwJvb@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:44:53PM +0000, Eric Biggers wrote:
> On Thu, Mar 03, 2022 at 09:24:42PM +0000, Giovanni Cabiddu wrote:
> > On Thu, Mar 03, 2022 at 07:21:33PM +0000, Eric Biggers wrote:
> > > If these algorithms have critical bugs, which it appears they do, then IMO it
> > > would be better to disable them (either stop registering them, or disable the
> > > whole driver) than to leave them available with low cra_priority.  Low
> > > cra_priority doesn't guarantee that they aren't used.
> > Thanks for your feedback Eric.
> > 
> > Here is a patch that disables the registration of the algorithms in the
> > QAT driver by setting, a config time, the number of HW queues (aka
> > instances) to zero.
> > 
> > ---8<---
> > From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > Subject: [PATCH] crypto: qat - disable registration of algorithms
> > Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
> > 
> > The implementations of aead and skcipher in the QAT driver do not
> > support properly requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
> > If the HW queue is full, the driver returns -EBUSY but does not enqueue
> > the request.
> > This can result in applications like dm-crypt waiting indefinitely for a
> > completion of a request that was never submitted to the hardware.
> > 
> > To avoid this problem, disable the registration of all skcipher and aead
> > implementations in the QAT driver by setting the number of crypto
> > instances to 0 at configuration time.
> > 
> > This patch deviates from the original upstream solution, that prevents
> > dm-crypt to use drivers registered with the flag
> > CRYPTO_ALG_ALLOCATES_MEMORY, since a backport of that set to stable
> > kernels may have a too wide effect.
> > 
> > commit 7bcb2c99f8ed032cfb3f5596b4dccac6b1f501df upstream
> > commit 2eb27c11937ee9984c04b75d213a737291c5f58c upstream
> > commit fbb6cda44190d72aa5199d728797aabc6d2ed816 upstream
> > commit b8aa7dc5c7535f9abfca4bceb0ade9ee10cf5f54 upstream
> > commit cd74693870fb748d812867ba49af733d689a3604 upstream
> > 
> > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > ---
> >  drivers/crypto/qat/qat_common/qat_crypto.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Sounds good; is there any reason not to apply this upstream too, though?
> You could revert it later as part of the patch series that fixes the driver.
Makes sense. I'm going to send it upstream and Cc stable as documented
in https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html#option-1
I will then revert this change in the set that fixes the problem.

Thanks,

-- 
Giovanni
