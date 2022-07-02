Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AC564338
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiGBWp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 18:45:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B0B1DF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656801957; x=1688337957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EHPFiSOBoXpWqoj2nriA2KCGhR11TUndu2UF+4ZjQ3g=;
  b=XzgMmCgSJ2tG5G/XT85y1PebKPS1bz8G4yDXSnzI6yvq/8pX4pPTYGk+
   gKPshCaeOydDM3Et/PSD6L8SIQJZMwFOp5MyNpZyYW0W3KK/6ZUaYEXNd
   LbIDlvKHVoyGQpBgFro1gD6ejuVj5njNcV3QNhgHPWomKMW4UNOaCbzzf
   E9axJN2CPQ4y+kF1mCvUKOOWtWJXohFffuHBbsS6qvAs5R9E23WKSLe2X
   em16+xwnGu64wcTesIzQCW1Vhipm8aFK69lO8fJ9hJkxviwqRT0RR52aD
   ASaAh9wBpNJMFE6O05LI56CUgPRgFCa2a5f1TzjT2AdC4fIcmrakvdS34
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="281637015"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="281637015"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 15:45:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="659789341"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 15:45:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7ls7-0013zv-1D;
        Sun, 03 Jul 2022 01:45:51 +0300
Date:   Sun, 3 Jul 2022 01:45:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: Intel: catpt: remove duplicating driver
 data retrieval
Message-ID: <YsDKnw7Crs8sP9MN@smile.fi.intel.com>
References: <20220702223243.51364-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702223243.51364-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 01:32:43AM +0300, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to acpi_match_device() API.
> Hence there is no need to duplicate the call. Just check what the former
> returns.

This patch is wrong and it's late here, and I'm blind. Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


