Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39B95AA068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiIATvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIATvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:51:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13D474D9;
        Thu,  1 Sep 2022 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061881; x=1693597881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k5zr5cn7hQsp9fLMDnqTgBbt08cY9uQCohw6Rm0BqxI=;
  b=ZMvFsflWrWRlRo3AMQ/7bJvN0Ni4CAbAi4XH7R65BTO8iPxrWNOu7CW2
   a16hubBIqCo4mm1wSerSYY7Po/+5YkgFcG6cy2F3Y7OwCmNJ4KVP1dV5j
   8U2Ua+vG61kDbEaK2WSN1p6VUPUQ9GBlUCBObA+wjxO6g3XjTpLmX7aaa
   U5CxIBMO0yzS8pfn8PGITlGNuSOrwlw+jmZ6kqIDjxzW09IYoIihyoDDb
   /S0zN0SSCg3m7cQepPioMKxfv0zqsD9ElehYZp8t+7a7q+7xSyPBlxX2j
   q1Zk7kxz6YaBabvggqbBpyxu/z6EE0/FNn4U5oB1vSZRj0Cl4OOYkrn5V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294554904"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="294554904"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:51:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563598121"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:51:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTqBQ-0071RD-3A;
        Thu, 01 Sep 2022 22:49:00 +0300
Date:   Thu, 1 Sep 2022 22:49:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel, vm-map" not defined
Message-ID: <YxEMrF9lpNLiJwiO@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
 <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
 <71d6d57c-2165-5fe3-515d-9395022921e2@roeck-us.net>
 <2f5c5828-87b9-f3d2-e3d3-0200adbe830c@amazon.com>
 <20220901144434.GB3477025@roeck-us.net>
 <ceef1c33-1af5-53d1-5e5b-5aeb5d2679ca@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceef1c33-1af5-53d1-5e5b-5aeb5d2679ca@amazon.com>
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

On Thu, Sep 01, 2022 at 06:24:51PM +0300, Farber, Eliav wrote:
> On 9/1/2022 5:44 PM, Guenter Roeck wrote:
> > On Thu, Sep 01, 2022 at 11:39:58AM +0300, Farber, Eliav wrote:

...

> > There should be some error handling to catch this case (ie if the number
> > of entries does not match the expected count), or if a value in the array
> > is larger or equal to vm_num. Today the latter is silently handled as end
> > of entries (similar to 0xff), but that should result in an error.
> > This would avoid situations like
> >        intel,vm-map = [01 02 03 04 05];
> > ie where the person writing the devicetree file accidentally entered
> > index values starting with 1 instead of 0. A mismatch between vm_num
> > and the number of entries in the array is silently handled as if there
> > was no property at all, which is at the very least misleading and
> > most definitely unexpected and should also result in an error.
> 
> I assume it is possible to tell according to the return value, if property
> doesn’t exist at all, or if it does exists and size of array in
> device-tree is smaller than vm_num.
> In [PATCH v3 17/19] Andy wrote that “code shouldn't be a YAML validator.
> Drop this and make sure you have correct DT schema” so I’m a bit confused
> if code should validate “intel,bm-map” or if it is the user responsibility.
> As this property was not added by me, I prefer not to fix it as part of
> this series of patches.

I'm just a messenger of Rob's words. If I'm mistaken I would like Rob to
correct me.

-- 
With Best Regards,
Andy Shevchenko


