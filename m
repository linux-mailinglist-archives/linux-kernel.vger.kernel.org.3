Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA8525E74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378672AbiEMIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378617AbiEMIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:51:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74E13CA27;
        Fri, 13 May 2022 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652431884; x=1683967884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vbiwJ3oECFneiZfDrZnlastQvaXlmzzrksRp4lU3pjo=;
  b=IacgqthOW9r1NQKGQfu7ejX5X0s/xDrhPRDzRaCVSpePnbOPFG04c7fW
   FBHarerNP1HCaQ2AKy2ALtla4qn3a2dnVOIVTuAiSEuUDT/cFy23SkSVZ
   Q51qr+/kyTTNpZ2cvIHxxPyi+n0Xxv4eTonbK2qgdWP+a4pZZXRcbCUy9
   Xbp1lFNENva0T/sgEFGyqbZuKrSc/PDZjcMYjGNuTwPCw2RgQSXr83odV
   fz79C66cJntyodHc9JK73YZuT/TCXDPoeV4hqM+4OUrfxzHUkoeQCvdRu
   OajucK3g658sbWbOs1t7rnpOezJkQ35+6gk+M5HSY7uPioeoJN+nP9RNZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333290234"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="333290234"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:51:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="740078163"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:51:18 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 13 May 2022 11:51:16 +0300
Date:   Fri, 13 May 2022 11:51:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 3/5] pinctrl: baytrail: make irq_chip immutable
Message-ID: <Yn4cBK1/F9VhNZ1I@lahna>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
 <20220512173921.8210-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512173921.8210-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:39:19PM +0300, Andy Shevchenko wrote:
> Since recently, the kernel is nagging about mutable irq_chips:
> 
>    "not an immutable chip, please consider fixing it!"
> 
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
> 
> While at it, switch to use hwirq variable instead of offset for
> the sake of consistency.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
