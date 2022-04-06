Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D664F6362
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiDFPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiDFPaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:30:01 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F66B7487;
        Wed,  6 Apr 2022 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649249231; x=1680785231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wlWFg6t46t3NvWgILYEYk3MILOUFjuxD9AUfU8kuuVg=;
  b=TCgXXVlkyLjNyEHKq0mtGbR0eaa55oDLcIf73AJth0ZmfoyiPIa5CFBx
   Va8rzz7S0ZYI/Nf0Ld8rWfRuFuXoEP4Jp8ahOgWWNGIh68ae2cPle3ms+
   GpgQxFw9tfTySzKB4rlY0qjdITuk2Wqlt2UZYaEVwfnG9w9fdUl8iEqJj
   FksQplCOKsbEKt6+pA6W6LrlezzyBiaBd9oUWCex7F+4qN/qVdG4zYtpd
   8pRRIATzMGWWwphdVo6+CySDC7Z0jBeJUBe6Sm/aIsDCmj2SUUju8xSE+
   T/T75MQOs9Xh0PCorKBiEqM5Y4IJ+ONrg0rIkF2wxHsccKNFWpyO/4vfE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="321729238"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="321729238"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:44:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="523909218"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:44:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc509-000DvT-HH;
        Wed, 06 Apr 2022 15:43:09 +0300
Date:   Wed, 6 Apr 2022 15:43:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: alderlake: Fix register offsets for
 ADL-N variant
Message-ID: <Yk2K3T0dLrBWgjPS@smile.fi.intel.com>
References: <20220405170251.72154-1-andriy.shevchenko@linux.intel.com>
 <Yk0gnG+oqpARzC+m@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk0gnG+oqpARzC+m@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 08:09:48AM +0300, Mika Westerberg wrote:
> On Tue, Apr 05, 2022 at 08:02:51PM +0300, Andy Shevchenko wrote:
> > It appears that almost traditionally the N variants have deviations
> > in the register offsets in comparison to S one. This is the case
> > for Intel Alder Lake as well. Fix register offsets for ADL-N variant.
> > 
> > Fixes: 114b610b9048 ("pinctrl: alderlake: Add Intel Alder Lake-N pin controller support")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed for fixes, thanks!

-- 
With Best Regards,
Andy Shevchenko


