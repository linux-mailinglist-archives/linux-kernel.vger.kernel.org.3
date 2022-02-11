Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465924B296B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349373AbiBKPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:50:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:50:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F9521F;
        Fri, 11 Feb 2022 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644594609; x=1676130609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+rMHPS4MzlHYwF2LNkcbdQXAv9bTBqR5fbIX4yipko=;
  b=F5fMBW/BP+c7orAvtr93n1Cg6cU5LlUFXjw3BQmsodWLQtwL/S56/zRL
   TSSUFAWIsVp06zyt6r4jVLFXQlHF40cKQTWMOQZLuF7dPlOA2hK91qJGo
   8nEBm1aJ1vvFEX1D8xC2BAK8KdnfvTK6nQHSbRZB9IkSTD/CFrLvZjdL8
   2jHZUmJ6i7iEzLmM7CJDY3u0RyN6JHW/wqVe3xqkHZi4EuRn8BqXQ+dMT
   6k66d6iBx7T8UlXJ0ViqtiV0v/SfBye3lnNolR5gQ6y/YjPqh+aN3htxs
   A4RMSsdsbIQ1KX8pfm6hXadwbfwzKtocP+P1nc3giZBfnT9VcNNSBvlXF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336175556"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="336175556"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:50:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="772124467"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:50:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIYAV-003UjX-Jt;
        Fri, 11 Feb 2022 17:49:07 +0200
Date:   Fri, 11 Feb 2022 17:49:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 3/6] drm: Add driver for Solomon SSD130x OLED displays
Message-ID: <YgaFc++EP3/hv+iA@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-4-javierm@redhat.com>
 <YgZJpi4llqr93U9Y@smile.fi.intel.com>
 <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
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

On Fri, Feb 11, 2022 at 01:05:57PM +0100, Javier Martinez Canillas wrote:
> On 2/11/22 12:33, Andy Shevchenko wrote:
> > On Fri, Feb 11, 2022 at 10:19:24AM +0100, Javier Martinez Canillas wrote:

...

> >> + * Helper to write command (SSD130X_COMMAND). The fist variadic argument
> >> + * is the command to write and the following are the command options.
> > 
> > This is not correct explanation. Please, rephrase to show that _each_ of the
> > options is sent with a preceding command.
> >
> 
> It's a correct explanation IMO from the caller point of view. The first argument
> is the command sent (i.e: SSD130X_SET_ADDRESS_MODE) and the next ones are the
> the command options (i.e: SSD130X_SET_ADDRESS_MODE_HORIZONTAL).
> 
> The fact that each command and options are preceding with a SSD130X_COMMAND
> value is part of the protocol of the device and a detail that's abstracted
> away by this helper function to the callers.

My previous suggestion about bulk transaction was purely based on this
(misinterpreted) description. Can we make sure somehow that another reader
don't trap into the same?

...


> >> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
> >> +					    &ssd130xfb_bl_ops, NULL);
> >> +	if (IS_ERR(bl)) {
> > 
> >> +		ret = PTR_ERR(bl);
> >> +		dev_err_probe(dev, ret, "Unable to register backlight device\n");
> >> +		return ERR_PTR(ret);
> > 
> > 		dev_err_probe(dev, PTR_ERR(bl), "Unable to register backlight device\n");
> > 		return bl;
> > 
> > ?
> 
> No, because this function's return value is a struct ssd130x_device pointer,
> not a struct backlight_device pointer.

	return ERR_CAST(bl);

-- 
With Best Regards,
Andy Shevchenko


