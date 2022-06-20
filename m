Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E2551495
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiFTJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiFTJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:40:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D52713DC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655718028; x=1687254028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8iqhr4KydNATVVKAcJ44zXcS6Whoj6IfbzSPbsz85A=;
  b=Z3G1TdH/bTVIffaYRVS+iSCG+xHVHtKDoDIRhhtyI1ftqRckqjwOQjZa
   AqkPy/KEFdTShNtP5epn60VCn60U7B68M3MdtghiNtZv4MqqzxsAbQNQs
   2IeaHEstKw3hLT+p/JqJBIElpzC+zt3RyV9uaHdvGdrbIAcFdB08L3Fp2
   +35kLoWeLIVLLRgq0uwoQ9neh8d/25L8LfXzEZj3QmU70ezmTrymQQAZU
   isbqBIOm+E0U7mF0c/x6ll2K/QuRrRGsi3auT6w1hkTAz1jz5Nzr/rt8K
   DZzfe9jRjlcWAg9o4mnBLe69UyDAMRnu9PXQfLv+LU8OW1Ez0yWe3Ir/4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343844716"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343844716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:40:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="689372091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:40:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3DtP-000h2Y-Sv;
        Mon, 20 Jun 2022 12:40:23 +0300
Date:   Mon, 20 Jun 2022 12:40:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 2/2] mfd: intel_soc_pmic_chtwc: Switch from
 __maybe_unused to pm_sleep_ptr() etc
Message-ID: <YrBAh700cCCHB2d8@smile.fi.intel.com>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
 <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
 <9cfa54dc-ba15-65ff-dd96-ac314cc7b4e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfa54dc-ba15-65ff-dd96-ac314cc7b4e1@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:48:01AM +0200, Hans de Goede wrote:
> On 6/16/22 19:10, Andy Shevchenko wrote:
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM_SLEEP support is simpler and less heavier for builds
> > than the use of __maybe_unused attributes.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I see that this basically converts the code to the new way of dealing
> with pm_ops, so after a second look:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


