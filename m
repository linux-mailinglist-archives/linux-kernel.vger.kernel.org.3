Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58D9529EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiEQKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbiEQKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:11:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F244C41B;
        Tue, 17 May 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652782199; x=1684318199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o0rfa2LgldSLeyeg6O3xFJ5xH9GUQLhGfm/buC6Zf/Q=;
  b=ja58K5Odw1f9B6WjkZSQJ+2Sd7NgfggZ8M6PwrS6Rt5QWUHjTXN7A4EX
   Se7UhVOh9NvaAOB/NOrVAF2VZ8ubbI6St9i95ZJJAThLN7GHaaIcDpCU+
   SxWdsJMMLnlP7vSQKt8RjMIN6GTceQNWuODVf03tl0WoK1ju6yTTg2ctR
   kX6tZe+l2DgClv9e2UoOmprNHlQ8USAmihnX30IlAbZasBJO3W0c4F2cI
   3NyPzN8mvQ+F5R9kWmo38u5UYc8d+MI3xmvgwKrefwugpWZrBUzvKIQcz
   sftnLa2iKjHmh7TuAc7pW2JnO0el0XMfpUCyZ+0tfQY1MxNudxfEsxits
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="357544196"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="357544196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 03:09:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="816831982"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 03:09:55 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 17 May 2022 13:09:53 +0300
Date:   Tue, 17 May 2022 13:09:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: intel: make irq_chip immutable
Message-ID: <YoN0cdUdYQotyod9@lahna>
References: <20220516185618.32448-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516185618.32448-1-andriy.shevchenko@linux.intel.com>
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

On Mon, May 16, 2022 at 09:56:17PM +0300, Andy Shevchenko wrote:
> Since recently, the kernel is nagging about mutable irq_chips:
> 
>    "not an immutable chip, please consider fixing it!"
> 
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
> 
> While at it, align IRQ chip callback names with member names for
> the sake of consistency.

Or for the sake of inconsistency? ;-)  All the other structs are not
using this kind of alignment and I would like to keep this one matching
the rest too. Also I prefer the format currently used in the driver.
