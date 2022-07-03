Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A756564870
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiGCPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:36:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C593762C9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656862614; x=1688398614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9KtnUXijkw+SsbUzhzgcSO+B35FVl4swxgVzrpAHbjQ=;
  b=RIaL4oa2XKBx6oYOUz1vcJWKt744pnYtibzHd1ECU5FMslh3hEih5Y3M
   qHc21Ze3abBiirhfYhfnaK6zhlwj0hO4TzkjCefwzIGBFYIedP4WcT63D
   OSBagmE0S3N/rsxM9WTCInyO2BLWqT2jcjDcxP4Z3tF2FcXozuS6ntppZ
   XA9B6fCng0pkyLIoMSpwgEiSj/3AkmkdVcNls97wq281TSNC02WXIMcxe
   bW6DqW/W14Buw2jwePGaJywvChTo8CoxbBef/sW+xJY0XkYdvFK9pd0eY
   goZDwYouWx1sr9YH4/M3pNjmOHZb9I3hmWYUx5vKxxrBOMK1j1SvTstk7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="271729747"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="271729747"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 08:36:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="624793392"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 08:36:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o81eS-0014QN-36;
        Sun, 03 Jul 2022 18:36:48 +0300
Date:   Sun, 3 Jul 2022 18:36:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
Message-ID: <YsG3kKwmoqF2MxU2@smile.fi.intel.com>
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
 <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:29:59AM +0100, Richard Fitzgerald wrote:
> On 03/06/2022 18:07, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.
> 
> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks!

It's a month passed without any other news about this patch.
Is this a problem in the MAINTAINERS database?

Who should take this?

+Cc: Liam, Mark

-- 
With Best Regards,
Andy Shevchenko


