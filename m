Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C04CBFF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiCCOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiCCOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:25:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490518DAB8;
        Thu,  3 Mar 2022 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646317463; x=1677853463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OJ2pn+NedzWwxwM6qUw5HhmBKI5W1MZrhLmvx3RZ4jg=;
  b=YX1Hndy3wQ6bjtt2CCIJ7ATGzd+X/2gKwX5WRmqCpi3WR3kkCUMy2d6i
   0czh6Q5d7njGXY389VDnBcu+kZiF8SacwZwvT4c1YUmfn1578MtyVhkTB
   l9BRtY37CZWWZCK5jYHdRdy29ibq8p7QwCT8dFb0UDS6koMStPrvQEdxd
   YOSUQjpOn/ygwDLESx8h+CF9ic0T8zu2qK6XoD6stx9hKC+4CWr/sTF/l
   wYk8S2r9OTzbMcUUKVe40blHBD4eBUuyAcTe6iYpBg6exq6byTg/QLvay
   7BAKoVf4k76DNq78PDno7vtciDFvFB4cOubE8I5RvGghO8QVy8P/htXC/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234298076"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234298076"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 06:24:22 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511445311"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 06:24:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPmMg-00ApVI-5F;
        Thu, 03 Mar 2022 16:23:34 +0200
Date:   Thu, 3 Mar 2022 16:23:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <YiDPZbHkwABl2GBE@smile.fi.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220210135522.26562-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 01:31:56PM +0000, Sa, Nuno wrote:

...

> > +	ref = fwnode_find_reference(child, "adi,cold-junction-
> > handle", 0);
> > +	if (ref) {
> 
> This is nok. It needs to be 'if (IS_ERR(ref))'. We then should return
> ERR_CAST() in case of errors inside the if block.

This is a good catch!

> As this reference
> is also optional, we need to nullify ref in case we don't find the
> it. Otherwise fwnode_handle_put() breaks.

No, this is not correct. fwnode_handle_put() is ERR_PTR aware.

> We also need to use ptr error logic in the other places where
> fwnode_find_reference() is used. Although, in the other cases
> the ref is mandatory, so there's no need to care with breaking
> fwnode_handle_put().
> 
> After these changes (I think the changes are straight enough;
> but I can re-test if you or Jonathan ask for it):
> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> 

-- 
With Best Regards,
Andy Shevchenko


