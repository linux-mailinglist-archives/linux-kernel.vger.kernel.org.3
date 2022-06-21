Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3C553171
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350229AbiFUL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350206AbiFUL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:56:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32211460
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655812569; x=1687348569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/tvqmmY87ynNDfSEF+t2tTr16WuLbzPZWDAOw24aL+A=;
  b=hpddexWr6F2TRq8ctUfbrpGZo3RHhL5QokKxZ3Teha/HLRs5L6sddE31
   mykQM6LQesoKHdANRjG9NG7IFdnDrMg3iX809GR/WffpYK4OQhSddUSCM
   +r9OwH02oNIT41vm2nThqKzpjjS8hr5vAurgWyjkk3ac3WLOAhRbNvVwh
   5vwbnZfE/pODR4OdyqBJG9hvy3ar7+tC28qtkBlkasnKIi6reSjaxSMH8
   PCA4ZrglXfRiI/nfhwgn1dvX7MUFWymtYx/jKASmyHQEAPIycwT4z9U96
   M3wejdmhaP3tNvz114PZLW/NHML6r5NkR+XraJcW4FpKI4+MISRvf5k/H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="259920743"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="259920743"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:56:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="614719465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:56:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3cUG-000qzt-NT;
        Tue, 21 Jun 2022 14:56:04 +0300
Date:   Tue, 21 Jun 2022 14:56:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <YrGx1Bs8Goj3/TLv@smile.fi.intel.com>
References: <20220607174120.34981-1-andriy.shevchenko@linux.intel.com>
 <20220615162054.GA571776@louislifei-OptiPlex-7090>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615162054.GA571776@louislifei-OptiPlex-7090>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:20:54AM +0800, Li Fei1 wrote:
> On Tue, Jun 07, 2022 at 08:41:20PM +0300, Andy Shevchenko wrote:
> > After the commits for userspace [1][2] the uuid field is not being
> > used in the ACRN code. Update kernel to reflect these changes.
> > I.e. we do the following:
> > - adding a comment explaining that it's not used anymore
> > - replacing the specific type by a raw buffer
> > - updating the example code accordingly
> > 
> > [1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> > [2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> > 
> > Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> > Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Signed-off-by: Fei Li <fei1.li@intel.com>

Dunno if SoB works for Greg, works for me.
Thanks!

Greg, can this be applied?

-- 
With Best Regards,
Andy Shevchenko


