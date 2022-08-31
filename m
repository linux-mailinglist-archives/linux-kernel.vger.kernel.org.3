Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753EF5A7C21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiHaLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:21:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D353B7284;
        Wed, 31 Aug 2022 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661944913; x=1693480913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M92Pfvc8u2C40rstouDUt/HHpZGFqaCW7WB6u5ALgYg=;
  b=nqKlbmadwyr22qfEExKTc8A37D5KGLuQ6GxYr8SMy9nvRyD6nxBk/hR2
   F1drixPNb8uNoCDB5uEnx2SvN0MJH8AiS6BXnb6OXhtwNeFS2icwxAk4m
   zdNMkhZFf0yeiJ8NNM7pshLlzy7uqGBuKTZ9Zqsah2Mu425fawoTij8n2
   JJyAeptM6vudL2BUBoGcvOds1DgkCI/CpiydWW4q1EBOfw9pcj2eVzdTw
   bgq9fD31TdjkqKKYlsVOeHVfcKpx4lZC1EA8/6rJ29fdWGtG+FK50kBnR
   RL9qnPVOpmpwxdkuD2pUO7nF0tTCP6iDUqKpnGLbMEu8UwPogFXB52dLP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282398438"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="282398438"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 04:21:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="857433797"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 04:21:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTLmy-006LZk-2D;
        Wed, 31 Aug 2022 14:21:44 +0300
Date:   Wed, 31 Aug 2022 14:21:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com,
        rahul.tanwar@linux.intel.com
Subject: Re: [PATCH v3 07/19] hwmon: (mr75203) enable polling for all VM
 channels
Message-ID: <Yw9ESGq6zR3lwK+f@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-8-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-8-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:00PM +0000, Eliav Farber wrote:
> Configure ip-polling register to enable polling for all voltage monitor
> channels.
> This enables reading the voltage values for all inputs other than just
> input 0.

...

> +		val = GENMASK(pvt->c_num - 1, 0) | VM_CH_INIT |

I believe in this case (BIT(pvt->c_num) - 1) is better, but not sure
if c_num can be 32.

> +		      IP_POLL << SDIF_ADDR_SFT |
> +		      SDIF_WRN_W | SDIF_PROG;

-- 
With Best Regards,
Andy Shevchenko


