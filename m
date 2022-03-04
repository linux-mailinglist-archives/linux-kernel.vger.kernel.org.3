Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22794CD464
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiCDMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiCDMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:42:13 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE51B3A59;
        Fri,  4 Mar 2022 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646397685; x=1677933685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tZrjSMkfDyWAM7wbgcIABphTmPYo+UOvDzf3GPP57ow=;
  b=R+0oKKBCnyJDqjegr5ATZSEOhYBYNz/+bDiXoQ6O+9U5+1KlKP+iXMg3
   cWhcbPOs8G4QTSsrl/l5L6+R4PM42LEWMX2wNBysnWGNiCTfg7V0A8czU
   Kk0HrIW7hC2Twq04bt0PDVT9hxCxdbsOjczekBXPvl89MgprPO9he66Qz
   t2zNW5WNVcIqKibSS62RF9+HBkE9a9DEPuXdLLv9mhSsj4y2vJ/YVK/TM
   1bbx95mlDKbUMQjXokZPeNi+gAC8AOEWwUaZTFP2+ASLbRkydxZMB2qFo
   NukUM/N1PKghDhW9PwS1OFqS1XP7i6l+cPSPsmgjMDlgiAJRMfm2GDaKC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="314682514"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="314682514"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:41:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="642499892"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:41:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ7Eb-00BDer-WF;
        Fri, 04 Mar 2022 14:40:38 +0200
Date:   Fri, 4 Mar 2022 14:40:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, colin.foster@in-advantage.com
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix interrupt parsing
Message-ID: <YiIIxXemSB8LIq8L@smile.fi.intel.com>
References: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
 <20220303203716.3012703-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303203716.3012703-3-horatiu.vultur@microchip.com>
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

On Thu, Mar 03, 2022 at 09:37:16PM +0100, Horatiu Vultur wrote:
> In the blamed commit, it removes the duplicate of_node assignment in the
> driver. But the driver uses this before calling into of_gpio_dev_init to
> determine if it needs to assign an IRQ chip to the GPIO. The fixes
> consists in using of_node from dev.

...

> -	irq = irq_of_parse_and_map(gc->of_node, 0);
> +	irq = irq_of_parse_and_map(info->dev->of_node, 0);

Why platform_get_irq() can't be used?

-- 
With Best Regards,
Andy Shevchenko


