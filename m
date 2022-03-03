Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E64CBBB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiCCKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiCCKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:49:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8517B8A5;
        Thu,  3 Mar 2022 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646304543; x=1677840543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8Hn2MkWZigfBwq1GCD+cJI3iKLw0jmw7S0oiYdMWeQ=;
  b=HPSkXU0LbccmtthvNbqYUtuhpg0otWWV0ni3BL3SGlIDmBzBs9v6O1Xe
   n0IcEXPydsJrfgnCUSmYr4d8I7RrYC3Mn35UZXUgYwop6nNkCKo+fQnAB
   KlRV+e8kVkOitaUVUGLmKytc5r1NSFN3vn7b7kFmneR6qtfImHY15wz6o
   xIqHSEXxHq8t4pfvnlZBeSsUrDpHUQ3CAeS2iItZpvg/TCm7/PYxDUtGw
   RkMs5KCICmM3/fRGZMjEMMjReJTU4o1h5KJ7JXb+Oxh9i9wU8dFVimz91
   xRCzzc3ar93cc6KOmwi3LyusgKeueyDak2Dtm02XTsRYEGpj9j9ZFB9Gp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="241061690"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="241061690"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:49:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="493899152"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:49:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPj0I-00AkIL-1K;
        Thu, 03 Mar 2022 12:48:14 +0200
Date:   Thu, 3 Mar 2022 12:48:13 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Message-ID: <YiCc7YzF2SQfzLST@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
 <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
 <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
 <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
 <DM4PR11MB5549B22251EDF0D6D5800932F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5549B22251EDF0D6D5800932F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
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

On Thu, Mar 03, 2022 at 10:23:43AM +0000, Sanil, Shruthi wrote:
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Sent: Thursday, March 3, 2022 3:48 PM
> > On 03/03/2022 07:18, Sanil, Shruthi wrote:

...

> > So if the description is in the DT but the prescaler bit is not enabled then the
> > firmware is buggy, IIUC. Yeah, this check would help, may be add more
> Yes, right. It would mean the FW is buggy.

Make use of FW_BUG prefix instead of "Firmware" in the message.

-- 
With Best Regards,
Andy Shevchenko


