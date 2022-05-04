Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFA519FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbiEDMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbiEDMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:54:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206634BBC;
        Wed,  4 May 2022 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651668667; x=1683204667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QViVx1DZnpgHjCekzYN+RthuhzyIH8/WXaQo0oT1cno=;
  b=WhWGDpT4yEb+vWDtNK7Dl4D7UxCJmc8YaRvgq8RgGc2hucnZ8vw4rpUB
   1nnoEkmyZ52ydA0QBPUeY/KPGM7hoCZB+BEDQTiomVIcIn4nVAz9rxsVB
   /pjK2XfMK/Nv8k9VR6w6bDJL1zqRzHZ2mEdNY3GDMHxPigQDPj0XYMQ0q
   1cmr/SYvcWBTO1ge0f6cESySCfKScGqYyGJ+1Pb+yI38NPkvT2MIxxAvV
   zF2y/Z25Khps3bMPATWEOLySOcD1wXt0c4PiMFMiMnv4jYP8nPB9kIBYi
   k7Pv/FhGk2yrvg5/YZpOs1ffQiN2v8z47KSnnd7BA8T5T5JK/tKoQPS72
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255222031"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="255222031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:51:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="620792210"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:51:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nmET7-00BsqV-PJ;
        Wed, 04 May 2022 15:51:01 +0300
Date:   Wed, 4 May 2022 15:51:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 0/2] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
 <20220308193522.26696-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308193522.26696-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:35:20PM +0100, Henning Schild wrote:
> This switches the simatic-ipc modules to using the p2sb interface
> introduced by Andy with "platform/x86: introduce p2sb_bar() helper".
> 
> It also switches to one apollo lake device to using gpio leds.
> 
> I am kind of hoping Andy will take this on top and propose it in his
> series.

First of all, they are not applicable to my current version [1] of the series
(it maybe something changed in the Simatic drivers upstream, because I have got
conflicts there. For the record, I'm using Linux Next as a base.

Second question is could it be possible to split first patch into three, or it
has to be in one?

[1]: https://gitlab.com/andy-shev/next/-/tree/topic/p2sb-next
It would be nice if you can perform another round of testing.

> Henning Schild (2):
>   simatic-ipc: convert to use common P2SB accessor
>   leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver
> 
>  drivers/leds/simple/Kconfig                   |  11 ++
>  drivers/leds/simple/Makefile                  |   3 +-
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 108 ++++++++++++++++++
>  drivers/leds/simple/simatic-ipc-leds.c        |  77 +------------
>  drivers/platform/x86/simatic-ipc.c            |  43 +------
>  drivers/watchdog/Kconfig                      |   1 +
>  drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
>  .../platform_data/x86/simatic-ipc-base.h      |   2 -
>  8 files changed, 139 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
> 
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


