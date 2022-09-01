Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDB5AA05B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiIATrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIATrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:47:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F6286C05;
        Thu,  1 Sep 2022 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061619; x=1693597619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K+qjlCNhhEYa6vAoO0LiHSR2znEMey6RlkEGVK0g59g=;
  b=je4i8lzInp2R93rbU5Qr55QCWvPZMnwqeICAdfwYiNoU0Q9syi3dCa8a
   0aVT4zhIThO/2zo/0Otu1br3v/rpt69KwgTf6NJnTNdtTF/L1VdFA/+2B
   Z6RN0PW9UIY/M0NYDNVD1wscWIA0xV0hoZhwBV06CQKvkZI4pLOrhWzYC
   0EHdtJc9A4w96aqACCzMbg5nI0wjukZZcadfHx2D6VUa/F8oUHW/5X919
   ynOlzb0BwjQofEB5aP4ti5U0zO73+KnCoBo9hsQYuTaefCWQ59byzrjJ/
   9Tx414T8hRxNW2npsxRPyNZpEt4K6hAw2A7MgGJJq9dlpRke9wnreoX/w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293390887"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293390887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:46:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="645796668"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:46:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTq9B-0071NR-1w;
        Thu, 01 Sep 2022 22:46:41 +0300
Date:   Thu, 1 Sep 2022 22:46:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 18/19] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <YxEMIdBMOeDBsu5D@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-19-farbere@amazon.com>
 <Yw9Qq+PIfxgXRIK2@smile.fi.intel.com>
 <646af681-38b0-1268-3798-c5434ca30bee@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <646af681-38b0-1268-3798-c5434ca30bee@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:54:21AM +0300, Farber, Eliav wrote:
> On 8/31/2022 3:14 PM, Andy Shevchenko wrote:
> > On Tue, Aug 30, 2022 at 07:22:11PM +0000, Eliav Farber wrote:

...

> > > +     pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> > 
> > > +     if (!pvt->dbgfs_dir) {
> > > +             dev_err(dev, "Failed to create dbgfs_dir\n");
> > > +             return -EINVAL;
> > > +     }
> > 
> > No, just don't check the return value of debugfs API calls.
> > 
> Do you mean that I should just do:
> debugfs_create_dir(dev_name(dev), NULL);
> Can you please explain why it's OK to ignore the return value?

Author of the debugfs is speaking:
https://patchwork.kernel.org/project/linux-wireless/patch/20190122152151.16139-38-gregkh@linuxfoundation.org/

-- 
With Best Regards,
Andy Shevchenko


