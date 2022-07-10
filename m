Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA87A56D0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGJSn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:43:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1659FF9;
        Sun, 10 Jul 2022 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657478604; x=1689014604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vO0RJR3jJjMpynIlXhpQZAOyBkHLXFLhgEoQu85jxvs=;
  b=RflyDQiVHY6BjNUml2Y9ICMgRzZlyQqsHRapdyMwrGhtTmmNIAvGIEhE
   b2laVnBohMgLZ1TBaG+JyOeAInQ/Gg5MG9ZqPmnmSlz48S2r7nRqw7BO7
   +cSAcvaDfwUi9pvGtl2cCCBW1cfsxAYJZaMRavcCqhU4QmLM0mSDrzeoc
   nIOTkCCpTpPwWifdBinK6YzCap6W4CR8oHXbXkfc+dsmpH4UvGBp1xhAq
   Kde5QfuKBgr/jN+5yX/crNCf1xqaTluGrSLFXGKVol5KaA0ba3Q9ZRW0L
   ltUVGGY+w2Wn62xIrPvkQdyo1gCGqKnNx6OIT/BhccmHY3YpQyo6P6+vk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="264942141"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="264942141"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:43:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="544767979"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:43:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oAbtk-001A6w-1Z;
        Sun, 10 Jul 2022 21:43:16 +0300
Date:   Sun, 10 Jul 2022 21:43:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 0/8] Fixes and cleanup for RS485
Message-ID: <YssdxGoKAt5Rx2DK@smile.fi.intel.com>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
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

On Sun, Jul 10, 2022 at 06:44:34PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The following series includes cleanup and fixes around RS485 in the serial
> core and uart drivers:
> 
> Patch 1: ar933x: Fix check for RS485 support
> Patch 2: Remove superfluous code in ar933x.
> Patch 3: Set the rs485 termination GPIO in the serial core. This is needed
> 	 since if the gpio is only accessible in sleepable context. It also
> 	 is a further step to make the RS485 handling more generic.
> Patch 4: Move sanitizing of RS485 delays into an own function. This is in 
> 	 preparation of patch 4.
> Patch 5: Sanitize RS485 delays read from device tree.
> Patch 6: Correct RS485 delays in binding documentation.
> Patch 7: Remove redundant code in 8250_dwlib.
> Patch 8: Remove redundant code in 8250-lpc18xx.

> Changes in v4:
> - fixed logical error found by 
> - capitalize "uart" and "gpio" in commit messages

Please, avoid sending sequential version of the series more often than once per
a few days, recommended interval is one week.

-- 
With Best Regards,
Andy Shevchenko


