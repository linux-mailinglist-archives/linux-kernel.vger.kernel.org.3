Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3D5A670E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiH3PN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiH3PNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:13:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049901286F7;
        Tue, 30 Aug 2022 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661872392; x=1693408392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wTIUsBF5sTdJ6JbPdR2fBQZlqEWSeLoC7AVXPmb6j1c=;
  b=cF8HA9zl2aRv0tb2hi69bsC/kc7LoUHCIqOZw0PlDqFTRx5Ycjh1pm//
   s/S4nbwW6s8MIXUnx6LjAtUMfFuUo/bkSWcy3cxti0Kx2vs5LTVsYDZjt
   dT3Tg48bdx3J3UdJPCjGzzBqA397zGaRb+EnJ5uIy/DvJJfZcvwXfRuGk
   jaHIM6pUQIY6ZJ/3B+DmXUBqfac/adfYDlHaw32AZqJ9mviKY/U0LmiHz
   63uFowhgaJMjEThcMONk3+LNEQnQrlqvzySmCS+7LXhkzNI+aIxOY/Qy+
   UOas9UPM8uNHLNejFcoxHQeAZoaacAwWIfnm264tIvUcX4zy0ZE8rF6Th
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295984540"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="295984540"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 08:13:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562682956"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 08:13:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oT2vF-0060PI-2k;
        Tue, 30 Aug 2022 18:13:01 +0300
Date:   Tue, 30 Aug 2022 18:13:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com
Subject: Re: [PATCH v9 00/10] Add MediaTek MT6370 PMIC support
Message-ID: <Yw4o/Sx6frEtaFDp@smile.fi.intel.com>
References: <20220830033729.9219-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830033729.9219-1-peterwu.pub@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:37:20AM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> This patch series add MediaTek MT6370 PMIC support and add a index macro
> to <linear_range.h>. The MT6370 is a highly-integrated smart power
> management IC, which includes a single cell Li-Ion/Li-Polymer switching
> battery charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
> 
> First, in this series of patches,
> 'dt-binding: mfd', 'mfd driver' has been applied by Lee in the v7.
> https://lore.kernel.org/all/YvJdpq0MWNPQZw5c@google.com/
> https://lore.kernel.org/all/YvJdxEpC2cB58Bq9@google.com/
> 
> 'tcpci driver' has been applied by Greg in the v8.
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=c2a8ea5997fdfeb43eda259d5533234c3cae05d7
> 
> Second, the LED RGB driver is based on Andy's patch which moves
> led_init_default_state_get() to the global header.
> https://lore.kernel.org/all/20220805154907.32263-3-andriy.shevchenko@linux.intel.com/
> 
> In addition, we added a macro to the <linear_range.h> for declaring the
> linear_range struct simply (see patch v9-0005) and made some changes for
> MT6370 drivers (see v9 section of the change log below).

Your cover letter is dangling. Make sure you are using --cover-letter --thread
when preparing the series.

-- 
With Best Regards,
Andy Shevchenko


