Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850F565BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiGDQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiGDQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:21:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303B384
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656951659; x=1688487659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xyXs9nOKE5kOELoI4oJbIuwpDppoegku8WgrxRZHARM=;
  b=OoAyzXUe9fKjnc5S2EjYEROHXFnWNCHxCarst6rgmTwcXJRtiU9ks1UR
   gSOx5XZak6aS2Xd3Y2AO7ojp4WZMlpdC7LYnQNDYdDrY9/SI0Kc2mdRZK
   z3RNwBREa0TqLtJ3bqbBTmhph03aFGFUQXrdDaX6LS3vao4IbRvEfTwuI
   pqsRQoWb9TZIsKXsfcheExfcf0rX2FaA/o6I8bU+pkVp/1xKP/cGg788h
   j6UtDgbUkESjWODfJvEK/eFF87rMScIx592RjbVrU6HYeL9/xXW1OMUvg
   YmJX/nlvdYOqN3k5r99MmDhn+F3djD6IJb8Ooak1xNB4Whxd8fAKq1euP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369487987"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="369487987"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:20:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649676565"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:20:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o8OoX-0015Ad-1D;
        Mon, 04 Jul 2022 19:20:45 +0300
Date:   Mon, 4 Jul 2022 19:20:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ASoC: Intel: catpt: remove duplicating driver
 data retrieval
Message-ID: <YsMTXVYv/ks+nyqu@smile.fi.intel.com>
References: <20220703145152.62297-1-andriy.shevchenko@linux.intel.com>
 <9c67d656-9990-7206-58b4-3de25d8341a0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c67d656-9990-7206-58b4-3de25d8341a0@linux.intel.com>
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

On Mon, Jul 04, 2022 at 10:36:33AM +0300, Péter Ujfalusi wrote:
> On 03/07/2022 17:51, Andy Shevchenko wrote:

...

> We could just pass the "(const struct catpt_spec *)id->driver_data" in
> place of spec to catpt_dev_init() and we can get rid of the local
> temporary pointer?

I would not go this way for non-POD types.

> If not, then I would cast out the spec before it's use:
> spec = (const struct catpt_spec *)id->driver_data;
> catpt_dev_init(cdev, dev, spec);

This I can do (as well as in the other patch).

-- 
With Best Regards,
Andy Shevchenko


