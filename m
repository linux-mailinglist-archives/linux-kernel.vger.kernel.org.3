Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC14948D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiATHrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:47:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:42050 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234741AbiATHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642664832; x=1674200832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k66lU1JL12krAlyCZXCQ7scFXV91USBAQzSdeunbTmg=;
  b=UQ11bT64eYGm24wQstsKzEGAMeIlV1rb1eq+KycoHxFFkNu7JEEI0kVH
   isMKDDJ3JdmZuIIzJ5FB2AeBpq9X7lEa9ucAeDOrVPyVa8HlftSSXbZwH
   qpobaIzzQzctcWS4ZPw3bxgNaDlA/Iu0EmabLr+GDmINCJO8rB15LOWW4
   haB2O6AKO+Ap/cqKJjHO1y5aK9ACGSii3830N1xJtq1jEfwg75jGE36Xy
   hdeKrO9hOkucHtzRGBDjX1nbbr5XFQREI3RZfxwC2XMU3J0cLvr4pwG8f
   UZVv3tJ5Aee5ougOwjRcAY2kdSYlLqVtmz2ahntSWugf3eZ359ickHjof
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="308630135"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="308630135"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 23:47:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="518519217"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 23:47:09 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 20 Jan 2022 09:44:52 +0200
Date:   Thu, 20 Jan 2022 09:44:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kane Chen <kane.chen@intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Fix a glitch when updating IRQ
 flags on a preconfigured line
Message-ID: <YekS9O5Xhl6VL9GM@lahna>
References: <20220119181915.27519-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119181915.27519-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:19:15PM +0200, Andy Shevchenko wrote:
> The commit af7e3eeb84e2 ("pinctrl: intel: Disable input and output buffer
> when switching to GPIO") hadn't taken into account an update of the IRQ
> flags scenario.
> 
> When updating the IRQ flags on the preconfigured line the ->irq_set_type()
> is called again. In such case the sequential Rx buffer configuration
> changes may trigger a falling or rising edge interrupt that may lead,
> on some platforms, to an undesired event.
> 
> This may happen because each of intel_gpio_set_gpio_mode() and
> __intel_gpio_set_direction() updates the pad configuration with a different
> value of the GPIORXDIS bit. Notable, that the intel_gpio_set_gpio_mode() is
> called only for the pads that are configured as an input. Due to this fact,
> integrate the logic of __intel_gpio_set_direction() call into the
> intel_gpio_set_gpio_mode() so that the Rx buffer won't be disabled and
> immediately re-enabled.
> 
> Fixes: af7e3eeb84e2 ("pinctrl: intel: Disable input and output buffer when switching to GPIO")
> Reported-by: Kane Chen <kane.chen@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Please mark this for stable too.
