Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6350B47538E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhLOHOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:14:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:62426 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240324AbhLOHOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:14:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239116968"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239116968"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:14:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="753265360"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:14:44 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2B42920657;
        Wed, 15 Dec 2021 09:14:42 +0200 (EET)
Date:   Wed, 15 Dec 2021 09:14:42 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        rafael@kernel.org, shawnx.tu@intel.com, tian.shu.qiu@intel.com,
        chiranjeevi.rapolu@intel.com, hyungwoo.yang@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] media: imx208: Support device probe in non-zero ACPI
 D state
Message-ID: <YbmV4hHrixPAeQYD@paasikivi.fi.intel.com>
References: <1636447715-15526-1-git-send-email-bingbu.cao@intel.com>
 <1636447715-15526-5-git-send-email-bingbu.cao@intel.com>
 <Ybi/b0QYV2BwSbQk@paasikivi.fi.intel.com>
 <374d87f4-a3e5-fbaa-b4eb-c1ac1bd983dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374d87f4-a3e5-fbaa-b4eb-c1ac1bd983dd@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bingbu,

On Wed, Dec 15, 2021 at 11:13:03AM +0800, Bingbu Cao wrote:
> 
> 
> On 12/14/21 11:59 PM, Sakari Ailus wrote:
> > Hi Bingbu,
> > 
> > On Tue, Nov 09, 2021 at 04:48:33PM +0800, Bingbu Cao wrote:
> >> Tell ACPI device PM code that the driver supports the device being in
> >> non-zero ACPI D state when the driver's probe function is entered.
> >>
> >> Also do identification on the first access of the device, whether in probe
> >> or when starting streaming.
> >>
> >> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> >> ---
> >>  drivers/media/i2c/imx208.c | 77 +++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 48 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/imx208.c b/drivers/media/i2c/imx208.c
> >> index 6f3d9c1b5879..b9f6d5f33b58 100644
> >> --- a/drivers/media/i2c/imx208.c
> >> +++ b/drivers/media/i2c/imx208.c
> >> @@ -296,6 +296,9 @@ struct imx208 {
> >>  	/* OTP data */
> >>  	bool otp_read;
> >>  	char otp_data[IMX208_OTP_SIZE];
> >> +
> >> +	/* True if the device has been identified */
> >> +	bool identified;
> >>  };
> >>  
> >>  static inline struct imx208 *to_imx208(struct v4l2_subdev *_sd)
> >> @@ -619,6 +622,34 @@ static int imx208_set_pad_format(struct v4l2_subdev *sd,
> >>  	return 0;
> >>  }
> >>  
> >> +static int imx208_identify_module(struct imx208 *imx208)
> >> +{
> >> +	struct i2c_client *client = v4l2_get_subdevdata(&imx208->sd);
> >> +	int ret;
> >> +	u32 val;
> >> +
> >> +	if (imx208->identified)
> >> +		return 0;
> > 
> > Otp access requires this as well.
> 
> Sakari, thanks for your review.
> 
> Yes, OTP read will trigger the LED blink, but I am not sure it makes sense that camera
> framework try to read the OTP data without streaming, and it would complain once fail to
> access the OTP data.

That might be the case, but the interface this driver provides is
accessible in the user space before streaming is enabled. Accessing
sensor's other registers shouldn't be done before the sensor is identified.

> > 
> > How about adding a runtime PM resume callback for this?
> 
> For the runtime PM callback, what is the benefit adding a callback here as will call try
> pm_runtime_get_sync() each stream on?

My suggestion is to identify the sensor from the runtime PM resume callback
(which this driver doesn't have yet), i.e. not here.

-- 
Kind regards,

Sakari Ailus
