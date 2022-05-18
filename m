Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8075152B1C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiERFI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiERFIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:08:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BC64A3F5;
        Tue, 17 May 2022 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652850502; x=1684386502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+iSTe6Mh+en0o6j9xQzuQH9px9l+PlOCzYWCb780jo=;
  b=eBqtamRFnHkNt1LR3DshquHMN/hRQZzIHiMJ4qLjg0LOazSM9K19YsHR
   7GDPVHZe279O8Cey273f0rv2M3BF4n3Egz4j3TQlYV63eD11RF0WurPG9
   nX0h2rQ5wk0VL15E65OrlpXaPjZgwyKPYcWuQ+zj9a3w9uTZkdZlSiTVx
   oY7mhhBSnrX0JVkbTfwOsOktA6C3mLqINe2b6Z9FYBAONgShHFKBG9vMr
   lbHvmD5DgD36T6hmWVzpzQKCtoESlZc1ymmsdTB7oxJui5yizHRXVD/Up
   ggZr0Rdoe8pHY2qm9aKToyJXSHeMjWpLZLXK5rDFIEMfjRrxh0FP+Dn4Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270307435"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="270307435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 22:08:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="714226200"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 22:08:19 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 18 May 2022 08:08:17 +0300
Date:   Wed, 18 May 2022 08:08:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] pinctrl: intel: make irq_chip immutable
Message-ID: <YoR/QXuS+VlLVWto@lahna>
References: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 07:38:19PM +0300, Andy Shevchenko wrote:
> +static const struct irq_chip intel_gpio_irq_chip = {
> +	.name		= "intel-gpio",
> +	.irq_ack	= intel_gpio_irq_ack,
> +	.irq_mask	= intel_gpio_irq_mask,
> +	.irq_unmask	= intel_gpio_irq_unmask,
> +	.irq_set_type	= intel_gpio_irq_type,
> +	.irq_set_wake	= intel_gpio_irq_wake,
> +	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};

You still have the inconsistent alignment here.
