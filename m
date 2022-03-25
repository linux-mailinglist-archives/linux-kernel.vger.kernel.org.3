Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453DF4E73B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359174AbiCYMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354872AbiCYMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:46:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF949AE49;
        Fri, 25 Mar 2022 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648212311; x=1679748311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdZASh07jW2Uv04tJUTvIVlVtrgvV4l0iqkBPrtHDqo=;
  b=C8EAqH4uKmzXCc9SLoJJPZMV20ONab2h8vY8dFLDSSIvwrE0SxR8AfnX
   Yha34C4dp0IaDPf8glP6VsGUHAj95bkwjOO7vyfVlWjalIj2Z+7NrSILZ
   Od+eUvknkVaPtul46nuqotEEJlo08n1fzKy7gdCquRRmjKllzDkXAiikt
   /UbOCC55rf+lhiVz4cKUV0RBFE4WKw9bPJ9vhE8FVttRlLT8EO5cef7e4
   jYIu6+TT/ipQIwP67yWgz5WRVEwRa38mhCivvFElitTjOhoGQ40IMoK7Z
   N7/gZGvR4t0jj8/y5y/xSuoYYol3Haum0A8XCKbloG+GWmmyrWviAmN9u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321818956"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321818956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="584452838"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:45:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXjIw-006Olr-TO;
        Fri, 25 Mar 2022 14:44:34 +0200
Date:   Fri, 25 Mar 2022 14:44:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <Yj25Mp2Ai0jKQtN3@smile.fi.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:02:12PM +0200, Andy Shevchenko wrote:
> There is no need to use atomic bit operations when allocating a minor
> number since it's done under a mutex. Moreover, one of the operations
> that is in use is non-atomic anyway.

Shall I resend the series without this patch, or can you apply the rest
if you have no comments / objections?

-- 
With Best Regards,
Andy Shevchenko


