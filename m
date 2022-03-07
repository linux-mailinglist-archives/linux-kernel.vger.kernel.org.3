Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11A84D0219
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiCGOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbiCGOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:53:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DED35DED;
        Mon,  7 Mar 2022 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646664773; x=1678200773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/3k4mHvlZwTsHccmScqQ+aEtnwgFzJWdq9diAD46iw=;
  b=EW+xC8wu/RN1SOmZiDloMXefskH/qZxfu2Fk1duvFJQIA2UOupxz29aW
   faXtvtArfoWkdspdYTIbRU58P/mlJQunIdPsm4/gqKoNhth8vM8jJp0WG
   MjdBSEQ/K/KQ6jwT2skTgk7cPPiQNN+Gs+ywuHCDV07bHWzCuwW8o47Mq
   U6GmI0fiSk/M4SAG9s0WXgo61/J1lXtATwZKBYDkZ48HJrnVN/aYgTJW5
   vHZrPjl+240/A45NGd5h2iJiFW60iTXNbm83zpZ5acloPbvaLAx2z/K+4
   RkEM17MhfKaWIcUYF82+Mrhf7QvoAKsTk7gRNDVDdhTHHiG2NjKi3Bg28
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254136272"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254136272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 06:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="687559044"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Mar 2022 06:52:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Mar 2022 16:52:45 +0200
Date:   Mon, 7 Mar 2022 16:52:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 3/7] usb: typec: mux: Check dev_set_name() return value
Message-ID: <YiYcPa2XE2MlKVQU@kuha.fi.intel.com>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-3-bjorn.andersson@linaro.org>
 <YiXZkqPQxqQ9I0VH@smile.fi.intel.com>
 <YiYXywEEz7WZQhfd@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYXywEEz7WZQhfd@ripper>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:33:47AM -0800, Bjorn Andersson wrote:
> On Mon 07 Mar 02:08 PST 2022, Andy Shevchenko wrote:
> 
> > On Sun, Mar 06, 2022 at 07:40:36PM -0800, Bjorn Andersson wrote:
> > > It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> > 
> > Thanks!
> > Shouldn't we have a Fixes tag and be sent separately for this cycle?
> > 
> 
> It seems appropriate to add:
> 
> Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
> 
> 
> If the maintainer would prefer to get this into v5.18, it could either
> be picked ahead of the rest of the series, or I can resubmit it on its
> own. I don't think it's a critical fix though.

Me neither.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > > 
> > > Changes since v3:
> > > - New patch
> > > 
> > >  drivers/usb/typec/mux.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > > index c8340de0ed49..d2aaf294b649 100644
> > > --- a/drivers/usb/typec/mux.c
> > > +++ b/drivers/usb/typec/mux.c
> > > @@ -131,8 +131,11 @@ typec_switch_register(struct device *parent,
> > >  	sw->dev.class = &typec_mux_class;
> > >  	sw->dev.type = &typec_switch_dev_type;
> > >  	sw->dev.driver_data = desc->drvdata;
> > > -	dev_set_name(&sw->dev, "%s-switch",
> > > -		     desc->name ? desc->name : dev_name(parent));
> > > +	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));
> > 
> > We may use shorten form of the ternary
> > 
> > 	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ?: dev_name(parent));
> > 
> > at the same time, but it's up to you.
> > 
> 
> I looked at it, but felt it was an unrelated change and decided to leave
> it as is.
> 
> > Either way code looks good to me,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> 
> Thanks,
> Bjorn
> 
> > > +	if (ret) {
> > > +		put_device(&sw->dev);
> > > +		return ERR_PTR(ret);
> > > +	}
> > >  
> > >  	ret = device_add(&sw->dev);
> > >  	if (ret) {
> > > @@ -338,8 +341,11 @@ typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
> > >  	mux->dev.class = &typec_mux_class;
> > >  	mux->dev.type = &typec_mux_dev_type;
> > >  	mux->dev.driver_data = desc->drvdata;
> > > -	dev_set_name(&mux->dev, "%s-mux",
> > > -		     desc->name ? desc->name : dev_name(parent));
> > > +	ret = dev_set_name(&mux->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));
> > 
> > Ditto.
> > 
> > > +	if (ret) {
> > > +		put_device(&mux->dev);
> > > +		return ERR_PTR(ret);
> > > +	}
> > >  
> > >  	ret = device_add(&mux->dev);
> > >  	if (ret) {
> > > -- 
> > > 2.33.1
> > > 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 

-- 
heikki
