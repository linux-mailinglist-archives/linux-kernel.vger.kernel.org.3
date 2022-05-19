Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D752DE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiESUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiESUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:09:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7FA5AB1;
        Thu, 19 May 2022 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652990974; x=1684526974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDoXax/th/czTvvvNqgEoZ9RHXqUd3i3Aslf+3U5d4g=;
  b=VIaqdnqkdjPXqsMpZ4mcufY0Gd5gvWnzC5gYqmxpoaDwkv7eVYwARkFM
   DOIeCIFqpU7Ly8BEANNeP/tm/34VJaijdQct+NvnXmZoBXRkOYJQh6s6P
   nX9dSCv1gfy5VU2M91knXm0OW9lOBRprP9UvKD6XrahyfaUGwbVlVOnBL
   99imdASXtiGtsWoYAyjC53rNk0ccUqOqXy4Nox4dbd2x6/YmbmrbmHStn
   5VRapJMkTb3ooPcK9xkQt5jYIfNMA99ZoO9KoQty6gjXC3KlNbITwRgtV
   vjrJGT5fEiP4nZU/5ZOBnvYZNyv/an9COgjEqdrbLb4Tygz073/jdk6jk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="332982453"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="332982453"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:09:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="524265158"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:09:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nrmSb-000GDJ-Sk;
        Thu, 19 May 2022 23:09:25 +0300
Date:   Thu, 19 May 2022 23:09:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uri Arev <me@wantyapps.xyz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Baker <len.baker@gmx.com>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Srivathsa Dara <srivathsa729.8@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix checkpatch.pl struct should normally
 be const
Message-ID: <Yoaj9baQHs9gZpz5@smile.fi.intel.com>
References: <20220519172503.10821-1-me@wantyapps.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172503.10821-1-me@wantyapps.xyz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:25:01PM +0300, Uri Arev wrote:
> This simple patch fixes a checkpatch.pl warning in `fbtft/fbtft-core.c`.
> 
> Reported by Checkpatch:
> WARNING: struct fb_ops should normally be const

...

> -	fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
> +	const fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);

Why?

-- 
With Best Regards,
Andy Shevchenko


