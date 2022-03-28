Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A694E92C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiC1KwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiC1KwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:52:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB14198A;
        Mon, 28 Mar 2022 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648464625; x=1680000625;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=NMKlDRrWVU3oduK1nKD+bbA3te2Pbh9SaIncM+0rnMk=;
  b=nA7TPX/fgWLjfmgN4fW0uXEL3ZaUO4T0mB+7Ffa/eK2PNBdSwZNeCOmm
   +6/Ywgv8QwmJzgA54GEIeS2tDb23LI27huhG1/xxeKrhMzFo0G2YqXQzL
   Wa1HincZmoGitMLB+DCrUKVVJUNuHhQbzPBmTebrzkNKOzgntzfFhZjS1
   w59Vy6Gj5Y13g1i8VOMefvudUkvcHlPeyJ8YM4yGbMfsgYVKZ0ugE9nAQ
   nvPCL82DLHSzhW2UVCeYt3RJt2UW0WOUCNzZrXuyiEm9zM/sY7swyQTgC
   FT31xGyZQs33tEZKcWhLGlfUSxgVNgEmKOS4RgzYp2UNeynQykLxmwQtH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="238901754"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="238901754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 03:50:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="520962489"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 03:50:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nYmwX-0083s4-9E;
        Mon, 28 Mar 2022 13:49:49 +0300
Date:   Mon, 28 Mar 2022 13:49:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YkGSzCykWvPXX89O@smile.fi.intel.com>
References: <20220317085019.3987-1-wsa+renesas@sang-engineering.com>
 <20220317085019.3987-2-wsa+renesas@sang-engineering.com>
 <YjiC6Lg5k5gK/BfP@smile.fi.intel.com>
 <YkGB3AgME/OZAdoG@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGB3AgME/OZAdoG@ninjato>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:37:32AM +0200, Wolfram Sang wrote:

> > > +	mutex_lock(&priv->lock);
> > > +
> > > +	vfree(priv->blob.data);
> > 
> > 	priv->blob.data = NULL;
> > 	priv->blob.size = 0;
> > 
> > > +	p = vzalloc(val);
> > > +	if (!p) {
> > > +		val = 0;
> > > +		ret = -ENOMEM;
> > > +	}
> > 
> > 	p = vzalloc(val);
> > 	if (!p)
> > 		return -ENOMEM;
> > 
> > > +	priv->blob.data = p;
> > > +	priv->blob.size = val;
> 
> I don't like assigning 'priv' memebers twice, so I'd like to keep it as
> is.

But this will give better understanding of the steps the code performs, no?
(Because this function basically contains two steps at once. I assume it's
 done this way due to absence of vrealloc(), right?)

But we have kvrealloc(). Can it be used here?

...

> > Can it be wrapped by DEFINE_SHOW_ATTRIBUTE()?
> 
> I don't see a way. Do you?

Me neither. I mixed this up with (not upstreamed yet) DEFINE_STORE_ATTRIBUTE.

-- 
With Best Regards,
Andy Shevchenko


