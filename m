Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8054565BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiGDQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiGDQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:20:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5507F270
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656951588; x=1688487588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aCKzmIiBu49W8RI8z/u3rSgsHu2N2nzoFiWnk255af4=;
  b=LcqoaK9T+eXXmd3vkdUkAqnBWK7/HWAWiJEEBQpVnKF1P340qdLDjpuL
   zoq3S1tq+yp47PrTuKMjEsaZi8WpcbfKgMvxNaCUOpkQk5UT1oOwWQhpt
   IxEJd86DPjPIABBVLpI87vUi1eDTpfqQFbJmH+Fr/7ZswLz/By3cxlSAW
   /Sb9KlCm2TvMp6eh/ivrNWFFw9mqDDtJySqqK3agcWIbJZ5MfqWa0AExk
   P35xkhe+kz/9TEJaBqLK+/iDMZ8k4WJTTdbJxv2jnUwzgjiclNVaNB6OY
   Dnqs1iOKn/djUN7mO5CMmQOSiVSEkCPVmXHEkkvsOlI9vrJvhjsUO8Srj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="262956285"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="262956285"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:19:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="734878887"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:19:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o8OnV-0015AU-35;
        Mon, 04 Jul 2022 19:19:41 +0300
Date:   Mon, 4 Jul 2022 19:19:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: SOF: Intel: bdw: remove duplicating driver
 data retrieval
Message-ID: <YsMTHTcOWX4Q3W7f@smile.fi.intel.com>
References: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
 <91f156ba-5d93-63d6-5fa0-86614bc370d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91f156ba-5d93-63d6-5fa0-86614bc370d3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:31:48AM +0300, Péter Ujfalusi wrote:
> On 03/07/2022 17:35, Andy Shevchenko wrote:

...

> +	return sof_acpi_probe(pdev, (const struct sof_dev_desc *)id->driver_data);
>  }

> We don't use the desc in sof_broadwell_probe(), so we can just pass the id->driver_data

I prefer not to cast inside the function parameters when it's not about POD.

-- 
With Best Regards,
Andy Shevchenko


