Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBE5314E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiEWQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiEWQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:24:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784668986;
        Mon, 23 May 2022 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653323054; x=1684859054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mgeF5UP7Wf9c6WWHGWu8/vp/irc3h+dCZkex5X4gbCU=;
  b=WSuKqj1H4aSbRjJhMyeKdYpMIxsrfE5Yxw6BVXRMqnHYprQrX9SAQUG3
   e4tunAjdWkYXeh0NPDcX6MH1DMW1+EGPP6bEP9NCxMMI+FO/50d6hLPUD
   LlgHgdaQFZCkay0TpOhoFE2hN2liev9JfLIO2hEIfmr0r475IJSorYWnB
   op29ti0Wq0eAFB0XvQ5AuwuTZZC48M+eSULtP/dMgkWSErumSCDvpFbrR
   O3JChT+3X4NH80v1wpg2pOImHNALkOfQr+9wVxZ7Get2neXwlLRQNrlBa
   fDE13/UqSUR/vQpal0DupceGbmn0JrmYkdkqZ7Kl4FbCi59kWaDrXAd0X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253776859"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="253776859"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 09:24:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="577479194"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 09:24:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ntAqm-000JLn-IX;
        Mon, 23 May 2022 19:24:08 +0300
Date:   Mon, 23 May 2022 19:24:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v3 0/4] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <You1KI78zbXmApm+@smile.fi.intel.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513083652.974-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:36:48AM +0200, Henning Schild wrote:
> changed since v2:
>  - put GPIO led module under same config switch
>  - some style changes from review
>  - init gpios with gpiod_get_index and drop gpiod_set_value
>  - drop bogus "if" from watchdog Kconfig
> 
> changed since v1:
>  - rebased
>  - split p1 into p1-3
> 
> This switches the simatic-ipc modules to using the upcoming p2sb 
> interface introduced by Andy with 
> "platform/x86: introduce p2sb_bar() helper".
> The series relies on these p2sb changes already applied and Andy will
> likely take them into his series at some point.
> 
> It also switches to one apollo lake device to using gpio leds.

Hmm... This series misses LEDS maintainer. Okay, I will include them when
sending v6 after v5.19-rc1.

-- 
With Best Regards,
Andy Shevchenko


