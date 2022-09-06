Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA65AE6F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiIFLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiIFLyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:54:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CF13CF9;
        Tue,  6 Sep 2022 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662465283; x=1694001283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BglTHeEuNNVFp8jxILPr2zH0JGMkuFYyH3BFt9cHmlI=;
  b=RoSdIW/1EHiXQHRVaZX7wffeiAzmqb147I06facMsyeeQ16fejCXdr4R
   veIzdWcJ/GYzaUZN4NCPXcLT2aZXqaWqhyNNTQqriJi3ChWVPftILmVJS
   Vq9q0pzlcniePqoyv2IIRKbLCuYk43LEHAmM0Z4jgyUM4SDedjISPvZE/
   +c3sVZshgojmvaoKY76SVyyX8XYemixWcoJYw72XbEMwuRGi2JcXlApfR
   IEEimj3RPAcxd9mDD5ezVa/ZT9PcGViUjbOayehZcSUNBEWfBdodan98b
   I6KRQIy/WlDwNfeDYlN/uXHtkrYpXAEOpvOlWtGerWnInclqZkAJZxFXf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295306819"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="295306819"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 04:54:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565065780"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 04:54:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVX7x-0096Bf-0b;
        Tue, 06 Sep 2022 14:52:25 +0300
Date:   Tue, 6 Sep 2022 14:52:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: meson: Switch to use fwnode instead of
 of_node
Message-ID: <Yxc0eAsFDA9AMHeI@smile.fi.intel.com>
References: <20220905180034.73132-1-andriy.shevchenko@linux.intel.com>
 <b0d45e18-c92d-d187-2eac-851d975fbb7e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d45e18-c92d-d187-2eac-851d975fbb7e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:07:07AM +0200, Neil Armstrong wrote:
> On 05/09/2022 20:00, Andy Shevchenko wrote:
> > GPIO library now accepts fwnode as a firmware node, so
> > switch the driver to use it.

...

> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


