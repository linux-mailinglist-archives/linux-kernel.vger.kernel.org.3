Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE32E500E23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiDNM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiDNM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:56:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB092330;
        Thu, 14 Apr 2022 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649940841; x=1681476841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rj+6tUX+bw1tLSJ0e26tOOsFBu+/kktSZig0hs8PVoQ=;
  b=J2IiTg+N3yz4s0dQwrCBmCwph/GuEDAeHRFGUQJ/CuUvnU/BDds/y85j
   WE9tl+dfU7bp/cRII0kZb5PmyPzkpiZC3H/Dyw4TRwPa/7Tk0+PxrF1lp
   a8B7cCLxysBWEiIanQNwEE+iPPy9PvtPWye5uMV2AN+Z2iQchXUAlFSw6
   svIpPEi3dK013wUdhLGE9EcWgRkklYqGx9R1oKVhzWDSmTOAQv+7SwsGe
   SxwYLmZ73AHJuLzwdfTUVRA5DNVy+kZwEpjSr/9IUjVd29M6Xd5OCAMW0
   LK5+IfQ0BbrqgFDUUNtKzESqV5jlZJfVVHK/DKk1ZuEUuAMwvDCSk2/Ln
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="263098836"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="263098836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:54:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="552670090"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:53:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neyyy-002K2W-HG;
        Thu, 14 Apr 2022 15:53:56 +0300
Date:   Thu, 14 Apr 2022 15:53:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: core: Convert to use firmware node handle
 instead of OF node
Message-ID: <YlgZZMPVDU9Yc7l5@smile.fi.intel.com>
References: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
 <fd9aa60147aba2d76e4b2d1b82011c610d3e52d6.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd9aa60147aba2d76e4b2d1b82011c610d3e52d6.camel@gmail.com>
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

On Thu, Apr 14, 2022 at 09:17:22AM +0200, Nuno Sá wrote:
> On Wed, 2022-04-13 at 21:02 +0300, Andy Shevchenko wrote:
> > Switch the IIO core to use firmware node handle instead of OF node.
> > This will allow to get label from firmware on non-OF systems.
> > 
> > Note, this doesn't change of_iio_*() APIs for now.

> So I was actually planning to send the same patch today or in the next
> few days. I do also have the conversion of inkern.c so I guess we can
> move in 3 different ways:
> 
> 1. If you are planning or already have some work with it, I'm more than
> fine in just forgetting my patches and let you do it (you are cleaning
> all the drivers already)
> 
> 2. I can send the patch (without this one) already for reviewing... It
> won't apply because I think there will be some conflicts with some of
> the drivers you changed already. Fun fact, remove of.h from iio.h and
> you see some drivers relying on it for property.h and mod_devicetable.h
> 
> 3. Just wait for your latest patches to be merged and send mine next
> week.
> 
> Up to you :)

Thanks for letting me know. I think the best course of actions now is
to settle down with what I have sent and you then rebase your stuff and
sent out for review. I will help with reviewing and I'm glad to hear
that you are step ahead of me. I wasn't planning to chase the inkern.c
in the future (at least nearest future).

That said, it seems like fits the #3 from the above list you provided.

-- 
With Best Regards,
Andy Shevchenko


