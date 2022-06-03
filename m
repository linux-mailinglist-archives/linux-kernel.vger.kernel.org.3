Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5E53CD95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiFCQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiFCQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:54:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3BA517FA;
        Fri,  3 Jun 2022 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654275289; x=1685811289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+9kqzkRua+/duStmsCCB0EK7KhyEmKZ5kB1ESim+XA=;
  b=MPVVIhF/SKKM/1B2j/F1gyJ6nZhNlKMMvcOgw1X/sdiaOBnzYGpYjeXR
   OlL9kay2OTdC/P5xqBZ86fYVgNTTpo9ruXT8PP06kuMSubzfxZDSEdelf
   aoJgXyHNy2ziap3UidzXzMiTYGVyQOiwnEbiXusGTKHpuB3CpD/DA73Vf
   C92gwu4/y2fGLx388+JvPORAM6pTP0XPOy6Uhym8Ng7epmfY433Kjjhog
   n9VYo9s39/xGR+plIho2ff5a8CzjhpNPoVeSMpmi764uhBa45J+jWo/WF
   TTrRl5+qh6dtjHEOsh7QrwZJZTlcT8lteg1wCc5xoTbjaObarpakZu8di
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="256774511"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="256774511"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 09:54:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="563867301"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 09:54:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nxAZP-000Sbs-He;
        Fri, 03 Jun 2022 19:54:43 +0300
Date:   Fri, 3 Jun 2022 19:54:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/6] iio: adc: meson_saradc: Don't attach managed
 resource to IIO device object
Message-ID: <Ypo80/NpWLLP43jm@smile.fi.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
 <20220603170612.561edfbf@jic23-huawei>
 <20220603172307.5d2f3c52@jic23-huawei>
 <20220603172920.3239bbd6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603172920.3239bbd6@jic23-huawei>
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

On Fri, Jun 03, 2022 at 05:29:20PM +0100, Jonathan Cameron wrote:
> On Fri, 3 Jun 2022 17:23:07 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:

...

> Andy, put a cover letter on these larger series - if nothing else it gives
> somewhere convenient for people to give tags for the whole series, or 
> maintainer to say what they are doing with it.

I'll try to remember this. The series was started from only a couple of patches
and grew to this big, and I forgot to add a cover letter when it seems not
anymore obvious what has been done.

> Anyhow, I'm fine with the series, but will leave it on list for a while
> longer, particularly to get patch 6 some eyes + testing.
> 
> Currently I plan to drop the fixes tag from this first patch, but I'm prepared
> to be convinced it's a bug fix rather than a consistency cleanup.

Fine with me, thanks!

-- 
With Best Regards,
Andy Shevchenko


