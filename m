Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931B3494B40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiATJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:58:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:44111 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236220AbiATJ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642672684; x=1674208684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=raqwXEEy2MRn+bbuViAO9MIejxyTxPocYNFdzQABk90=;
  b=do2qPzkPUhDRJ1IHLuu+NPx+FxUwFes/Vwmj1suT5824zwb9tdqmxwP1
   VBcFFIUmoFzcJ9lHUsQXrHX+9n5yi9vdY+iyidF+s/vDpLtRFMAlFIIg+
   cLB+TK/biYhWwVd+8A+Z/snLXiL67xH6wnftKcRAplFJMXEFFQkxsPgOZ
   PwRPEEkl0w3Za/ZHwlmRD3DhbN3ELfa6N23mrJeLhYwo4vdP1JESmRqCD
   FIXrfnRFS0S+d5xcsDxJWtAd7kLOvKTkkWzY/R/RmTmTXhmBkZOb0zm8l
   gKKqElQdTaeAhnfyE/LCT6mI47vskXru4f8H4drm3/jINxge5abpqrsIf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="269714204"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="269714204"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:58:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="518553733"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:57:57 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id DEEF4203C8;
        Thu, 20 Jan 2022 11:57:24 +0200 (EET)
Date:   Thu, 20 Jan 2022 11:57:24 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     broonie@kernel.org, angus@akkea.ca, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v3] media: i2c: dw9714: add optional regulator support
Message-ID: <YekyBKHYqo0vrQ0k@paasikivi.fi.intel.com>
References: <20211129120754.1766570-1-martin.kepplinger@puri.sm>
 <8f4c0f74523ea615786942fe2a30f83a2d0e8c16.camel@puri.sm>
 <98d12c1acaf77772f51361b079dde7e982a6dafd.camel@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98d12c1acaf77772f51361b079dde7e982a6dafd.camel@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:04:17AM +0100, Martin Kepplinger wrote:
> Am Dienstag, dem 21.12.2021 um 18:33 +0100 schrieb Martin Kepplinger:
> > Am Montag, dem 29.11.2021 um 13:07 +0100 schrieb Martin Kepplinger:
> > > From: Angus Ainslie <angus@akkea.ca>
> > > 
> > > Allow the dw9714 to control a regulator and adjust suspend() and
> > > resume()
> > > to support both runtime and system pm.
> > > 
> > > Signed-off-by: Angus Ainslie <angus@akkea.ca>
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > > 
> > > 
> > > revision history
> > > ----------------
> > > v3: (thank you Mark and Sakari)
> > >  * use regulator_get() instead of regulator_get_optional()
> > > 
> > > v2: (thank you Mark)
> > >  * simplify the regulator_get_optional() error path
> > >  * fix regulator usage during probe()
> > > https://lore.kernel.org/linux-media/20211126090107.1243558-1-martin.kepplinger@puri.sm/
> > > 
> > > v1:
> > > https://lore.kernel.org/linux-media/20211125080922.978583-1-martin.kepplinger@puri.sm/
> > > 
> > > 
> > > 
> > >  drivers/media/i2c/dw9714.c | 32 +++++++++++++++++++++++++++++++-
> > >  1 file changed, 31 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/media/i2c/dw9714.c
> > > b/drivers/media/i2c/dw9714.c
> > > index 3863dfeb8293..81170bbe0e55 100644
> > > --- a/drivers/media/i2c/dw9714.c
> > > +++ b/drivers/media/i2c/dw9714.c
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/i2c.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <media/v4l2-ctrls.h>
> > >  #include <media/v4l2-device.h>
> > >  #include <media/v4l2-event.h>
> > > @@ -36,6 +37,7 @@ struct dw9714_device {
> > >         struct v4l2_ctrl_handler ctrls_vcm;
> > >         struct v4l2_subdev sd;
> > >         u16 current_val;
> > > +       struct regulator *vcc;
> > >  };
> > >  
> > >  static inline struct dw9714_device *to_dw9714_vcm(struct v4l2_ctrl
> > > *ctrl)
> > > @@ -145,6 +147,16 @@ static int dw9714_probe(struct i2c_client
> > > *client)
> > >         if (dw9714_dev == NULL)
> > >                 return -ENOMEM;
> > >  
> > > +       dw9714_dev->vcc = devm_regulator_get(&client->dev, "vcc");
> > > +       if (IS_ERR(dw9714_dev->vcc))
> > > +               return PTR_ERR(dw9714_dev->vcc);
> > > +
> > > +       rval = regulator_enable(dw9714_dev->vcc);
> > > +       if (rval < 0) {
> > > +               dev_err(&client->dev, "failed to enable vcc: %d\n",
> > > rval);
> > > +               return rval;
> > > +       }
> > > +
> > >         v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
> > >         dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> > >                                 V4L2_SUBDEV_FL_HAS_EVENTS;
> > > @@ -200,6 +212,9 @@ static int __maybe_unused
> > > dw9714_vcm_suspend(struct device *dev)
> > >         struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
> > >         int ret, val;
> > >  
> > > +       if (pm_runtime_suspended(&client->dev))
> > > +               return 0;
> > > +
> > >         for (val = dw9714_dev->current_val & ~(DW9714_CTRL_STEPS -
> > > 1);
> > >              val >= 0; val -= DW9714_CTRL_STEPS) {
> > >                 ret = dw9714_i2c_write(client,
> > > @@ -208,7 +223,12 @@ static int __maybe_unused
> > > dw9714_vcm_suspend(struct device *dev)
> > >                         dev_err_once(dev, "%s I2C failure: %d",
> > > __func__, ret);
> > >                 usleep_range(DW9714_CTRL_DELAY_US,
> > > DW9714_CTRL_DELAY_US + 10);
> > >         }
> > > -       return 0;
> > > +
> > > +       ret = regulator_disable(dw9714_dev->vcc);
> > > +       if (ret)
> > > +               dev_err(dev, "Failed to disable vcc: %d\n", ret);
> > > +
> > > +       return ret;
> > >  }
> > >  
> > >  /*
> > > @@ -224,6 +244,16 @@ static int  __maybe_unused
> > > dw9714_vcm_resume(struct device *dev)
> > >         struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
> > >         int ret, val;
> > >  
> > > +       if (pm_runtime_suspended(&client->dev))
> > > +               return 0;
> > > +
> > > +       ret = regulator_enable(dw9714_dev->vcc);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to enable vcc: %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +       usleep_range(1000, 2000);
> > > +
> > >         for (val = dw9714_dev->current_val % DW9714_CTRL_STEPS;
> > >              val < dw9714_dev->current_val + DW9714_CTRL_STEPS - 1;
> > >              val += DW9714_CTRL_STEPS) {
> > 
> > hi Sakari and all interested,
> > 
> > any objection to this addition? I run it for a long time now.
> > 
> > thank you,
> > 
> >                               martin
> > 
> > 
> 
> hi all, patchwork marked this as "changes requested":
> https://patchwork.linuxtv.org/project/linux-media/patch/20211129120754.1766570-1-martin.kepplinger@puri.sm/
> 
> I'm not aware of changes you wish to this. What do you think?

Oops! I wrote a reply but forgot to send it. I've just sent that.

-- 
Sakari Ailus
