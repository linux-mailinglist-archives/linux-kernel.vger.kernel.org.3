Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6374CBBAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiCCKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiCCKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:48:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4649913CEEF;
        Thu,  3 Mar 2022 02:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646304493; x=1677840493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XERL7zQnkfENm2cJG9WqtvSSN/OYkhjEjtnM4+TkMjc=;
  b=PJtT/4CCe8zIFceXZVouAaaFcAspOTQzXtQ6M0P2Jt6e5OUi+z2/bKbb
   KrPlNftsahfI9pCbN7JsaJ/M0slhuCiO/BhYh2b8NW0SzZarU+vf+j+Kf
   EyfxJnCGm/qBL1ryd3TFrVMvVJS88fMjuVCrzdiSw4bOGAt3b4+cdjl56
   0nH6DPKnfKQ4wAbdpJIdYfIHvpsSuVAJVBnMgvBJY/KfE2H55pMmPdiUt
   BBKZz7YwL72mhJgVDF29Ek9O8EYfFg+mjKbGKcYWXH1I7D7Wv5ONwl8A9
   LCfImoUGFqrg9JMF2RIZW98rqIJ2no5C2bQYTUUgg8USWXHclYc+vLqqd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="241061517"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="241061517"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:48:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="640136529"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:48:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPizT-00AkGn-Hz;
        Thu, 03 Mar 2022 12:47:23 +0200
Date:   Thu, 3 Mar 2022 12:47:23 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Sanil, Shruthi" <shruthi.sanil@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Message-ID: <YiCcu7unsP5YDxun@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
 <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
 <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
 <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:17:33AM +0100, Daniel Lezcano wrote:
> On 03/03/2022 07:18, Sanil, Shruthi wrote:

> > > > > > > > +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) { +
> > > > > > > > pr_err("%pOF: Prescaler is not enabled\n", np);
> > > > > > > > +		ret = -ENODEV; +	}
> > > > > > > 
> > > > > > > Why bail out instead of enabling the prescalar ?
> > > > > > 
> > > > > > Because it is a secure register and it would be updated by
> > > > > > the bootloader.
> > > > > Should it be considered as a firmware bug ?
> > > > 
> > > > No. This is a common driver across products in the series and
> > > > enablement of this bit depends on the project requirements.
> > > > Hence
> > > > to be sure from driver, we added this check to avoid
> > > > initialization of the driver in the case where it cannot be
> > > > functional.
> > > 
> > > I'm not sure to get the meaning of 'project requirements' but (for
> > > my understanding) why not describe the timer in the DT for such
> > > projects?
> > > 
> > 
> > OK, I understand your point now. We can control the driver
> > initialization from device tree binding rather than add a check in
> > the driver. But isn't it good to have a check, if enabling of the bit
> > is missed out in the FW? This can help in debugging.
> 
> So if the description is in the DT but the prescaler bit is not enabled then
> the firmware is buggy, IIUC. Yeah, this check would help, may be add more
> context in the error message, eg. "Firmware has not enabled the prescaler
> bit" or something like that

For this we also use a FW_BUG prefix to printf()-like functions.

-- 
With Best Regards,
Andy Shevchenko


