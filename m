Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916D561787
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiF3KSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiF3KSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:18:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1A11473;
        Thu, 30 Jun 2022 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656584321; x=1688120321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kPmwEBc1KMTjojvqHZLvMTlSrK6OdbuwU9EWM04xHY4=;
  b=W3daoP71+atQEBfLPS/6JWnzcCiDeTsDtduxGmwEQk3Gzx/wxJtZo0SK
   unJVSGq3opZ6wnaMScZSgEY8p/Fyhh/6KRMxA7I4hJHevgbF2UJlyKCaL
   SQIi4gFHm+g+vnmGGIHSE5V6KCbhmDkwI7ybLIOjSZjPFBrPdk+eie8Bb
   K+IaNYBAHt2isFdW1qkFbMECiIKtXpvwsCgCkkAuWZkNww8xbqUN2XlSV
   C1Z9oqUqrlcmEbPlaLmVeKqgcJSCXrog6ZZ7evUYH66dRRX/yb9LRBvuA
   Ah2MtwL+QIJlKIQFDCCqpSqad+kgHDc2ilb43LBA1uunkNyIdiy0OChYz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279854332"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="279854332"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:18:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="541279538"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:18:36 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 30 Jun 2022 13:18:33 +0300
Date:   Thu, 30 Jun 2022 13:18:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/9] usb: typec: Add support for retimers
Message-ID: <Yr14eZexhvvrWrOS@lahna>
References: <20220629233314.3540377-1-pmalani@chromium.org>
 <20220629233314.3540377-2-pmalani@chromium.org>
 <Yr1cN1I14BR6rN3U@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1cN1I14BR6rN3U@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:17:59AM +0300, Heikki Krogerus wrote:
> On Wed, Jun 29, 2022 at 11:32:19PM +0000, Prashant Malani wrote:
> > Introduce a retimer device class and associated functions that register
> > and use retimer "switch" devices. These operate in a manner similar to
> > the "mode-switch" and help configure retimers that exist between the
> > Type-C connector and host controller(s).
> > 
> > Type C ports can be linked to retimers using firmware node device
> > references (again, in a manner similar to "mode-switch").
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> Cool! This looks really good to me.
> 
> I'll add Mika here, just to keep him in the loop. Thunderbolt/USB4 can
> control the same physical retimers over the SBU line. Right now there
> is no conflict, but I think we want to later be able to use these
> devices to upgrade the retimer firmware, and that is something that
> the Thunderbolt/USB4 already does. So let's keep an eye on this.
> 
> I wonder, would it make sense to later make the thunderbolt_retimer
> devices also part of the device class that's introduced here? I think
> that way it would be easier to later figure out which
> thunderbolt_retimer and which retimer_switch represent the same
> physical retimer. And perhaps it would also be more clear for the user
> space to have a single device class for the retimers?

I agree this makes sense.
