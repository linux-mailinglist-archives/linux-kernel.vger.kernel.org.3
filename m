Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009359E836
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiHWRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343780AbiHWRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A394D4D4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661263728; x=1692799728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4lie7gCXObgs3m8jIr59zMMngmZ8Lu+4cTjSxyVLY4Q=;
  b=eDyy4F3TCPpAIoPxiiRiphl8Or7CVkiPCJxXlvTSBkz1n6Ve7pNgyFhe
   tXI12tKAocPX+WkFmrwSej9KEDgnsXZ8dxaVAQ3V7aoT7uW3xiKVDKmwx
   5RHTGKD/K7V+wGKW+C9ftYYrhUBqnIctP0VUJjXSMSnoo+y4l2VIDh//5
   K0G6ULGOtHlD+1DtwVojNc2bkE0i2NnCA/TIeSHTPkJVFi25t27qv1iRn
   M83lux+ymElvoaLJSsSPubfOwgFMvwv9SYLXUJp4kqCkNhTv0Fq0Lh/6Y
   49ZpnDrzT4YmuCJsgoF7Bl+zijmj0h7UK6jcCuFMBKFscRJ2fSXpRtszw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319742037"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="319742037"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:08:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="735491062"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:08:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUaA-002T4V-1A;
        Tue, 23 Aug 2022 17:08:42 +0300
Date:   Tue, 23 Aug 2022 17:08:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct
 device
Message-ID: <YwTfam7KZKzgn8sq@smile.fi.intel.com>
References: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
 <YvIK0KMi1yECL9vc@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvIK0KMi1yECL9vc@myrica>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:20:48AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Aug 01, 2022 at 07:51:42PM +0300, Andy Shevchenko wrote:
> > In order to make the underneath API easier to change in the future,
> > prevent users from dereferencing fwnode from struct device.
> > Instead, use the specific device_match_fwnode() API for that.

> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks!

Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko


