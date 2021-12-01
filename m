Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD6464D82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbhLAMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbhLAMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:10:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22DC061574;
        Wed,  1 Dec 2021 04:07:27 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id r130so24247776pfc.1;
        Wed, 01 Dec 2021 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=P7xA6Q5sc8/na1l8eu8LhLUapeP2XtOXuq1ysdswzxI=;
        b=hoJfIjkbzMgn4KWhcQ1vdBQ/nOezb/jvdp/9Hd0E1WURD0yGKgcR8DXXWZCvPwoCQY
         EPxQurfo7b7SAet4E7KfpMwgu/yIkFB9nYSkzabRcirugsR4dCwfiOOfdOF+barZeofD
         5c3Bs1HROvW9tNZ7VHHtWpd0DKBSRlHH2Bb2kpBeyp3vFbAxPkZRYnDww/76XmsVKDdO
         RSjMVsPfULK5oHSjVQ/bRWM0Wx+cxLZfUAlLgZYM4kajI5KaqH4sHIyyFk55hOuOfOzj
         sYzU6ClEIhFDX0rva4AGasc/+V0CWI4v/HJx1jxXJVIaJpoEdvSCDWf9cYxhyi4N/anN
         drmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=P7xA6Q5sc8/na1l8eu8LhLUapeP2XtOXuq1ysdswzxI=;
        b=bzS/9PswMNmdttaGypzovjKaqav6IWqSsEXV7va0R+58hRNXf2MC5NqWHAxWz6iv0f
         kQ5/Xqoj3mPwm+MGERiHJZSbj7Ud4ARvzaZyycC9IrrKigx7t/rA3MPkyHkTBHA4BDQI
         CAC8zlk9zvUR7Rq3BV+MRnX8F4u+Fxv19F08fPMLtV6pL1RLeQWr17nGg4f1+7/rYtHJ
         /h+8bXZB6dr67SH/6aKqxgQCKa9J+rp+OJuEZ0P8Gaa9gR5t6fKyp8axnK7LdR67FUpk
         WpgBB76/Ffd/vzT1ujwA1GBk6rx0X9Z1RxP6MIS32RUjfTBmZWeay7LUBgp5ijREXlf4
         NAYQ==
X-Gm-Message-State: AOAM5301g5gmayjfLtdYaz6nWHUcHHLJm+oHGyRRZ4LoOja4JG65CuTQ
        Rl499hdiga4ZjyOeTd9Fw7M=
X-Google-Smtp-Source: ABdhPJxMhJge5UWfvARKrvZ9kCV10VrKtBLJu8NlUF0Jexmrqz38TQzii0tNPBMn2rlt36CFqKIyLg==
X-Received: by 2002:a05:6a00:1946:b0:44d:8136:a4a4 with SMTP id s6-20020a056a00194600b0044d8136a4a4mr5590547pfk.46.1638360446471;
        Wed, 01 Dec 2021 04:07:26 -0800 (PST)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id k14sm25224102pff.6.2021.12.01.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 04:07:26 -0800 (PST)
Message-ID: <27572974b2d665e97d8ede5ce8328b7733dca36d.camel@gmail.com>
Subject: Re: [PATCH 02/17] media: atomisp: pci: fix punit_ddr_dvfs_enable()
 argument for mrfld_power up case
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Patrik Gfeller <patrik.gfeller@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alan <alan@linux.intel.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 01 Dec 2021 21:07:22 +0900
In-Reply-To: <721eda4c6b65a0c0da4b85e1b24bada769890816.camel@gmail.com>
References: <20211017161958.44351-1-kitakar@gmail.com>
         <20211017161958.44351-3-kitakar@gmail.com>
         <YW1Vj5jGybs8gXWr@smile.fi.intel.com>
         <721eda4c6b65a0c0da4b85e1b24bada769890816.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 22:25 +0900, Tsuchiya Yuto wrote:
> On Mon, 2021-10-18 at 14:07 +0300, Andy Shevchenko wrote:
> > On Mon, Oct 18, 2021 at 01:19:42AM +0900, Tsuchiya Yuto wrote:
> > > When comparing with intel-aero atomisp [1], it looks like
> > > punit_ddr_dvfs_enable() should take `false` as an argument on mrfld_power
> > > up case.
> > > 
> > > Code from the intel-aero kernel [1]:
> > > 
> > >         int atomisp_mrfld_power_down(struct atomisp_device *isp)
> > >         {
> > >         [...]
> > >         	/*WA:Enable DVFS*/
> > >         	if (IS_CHT)
> > >         		punit_ddr_dvfs_enable(true);
> > > 
> > >         int atomisp_mrfld_power_up(struct atomisp_device *isp)
> > >         {
> > >         [...]
> > >         	/*WA for PUNIT, if DVFS enabled, ISP timeout observed*/
> > >         	if (IS_CHT)
> > >         		punit_ddr_dvfs_enable(false);
> > > 
> > > This patch fixes the inverted argument as per the intel-aero code, as
> > > well as its comment. While here, fix space issues for comments in
> > > atomisp_mrfld_power().
> > > 
> > > Note that it does not seem to be possible to unify the up/down cases for
> > > punit_ddr_dvfs_enable(), i.e., we can't do something like the following:
> > > 
> > >         if (IS_CHT)
> > >         	punit_ddr_dvfs_enable(!enable);
> > > 
> > > because according to the intel-aero code [1], the DVFS is disabled
> > > before "writing 0x0 to ISPSSPM0 bit[1:0]" and the DVFS is enabled after
> > > "writing 0x3 to ISPSSPM0 bit[1:0]".
> > > 
> > > [1] https://github.com/intel-aero/linux-kernel/blob/a1b673258feb915268377275130c5c5df0eafc82/drivers/media/pci/atomisp/atomisp_driver/atomisp_v4l2.c#L431-L514
> > > 
> > > Fixes: 0f441fd70b1e ("media: atomisp: simplify the power down/up code")
> > > Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
> > > ---
> > >  drivers/staging/media/atomisp/pci/atomisp_v4l2.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> > > index 0511c454e769..f5362554638e 100644
> > > --- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> > > +++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> > > @@ -711,15 +711,15 @@ static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
> > >  
> > >  	dev_dbg(isp->dev, "IUNIT power-%s.\n", enable ? "on" : "off");
> > >  
> > > -	/*WA:Enable DVFS*/
> > > +	/* WA for PUNIT, if DVFS enabled, ISP timeout observed */
> > 
> > P-Unit
> 
> Thanks, I'll fix this next time I send.

For the record, this is already fixed in the latest media_stage tree.

> > >  	if (IS_CHT && enable)
> > > -		punit_ddr_dvfs_enable(true);
> > > +		punit_ddr_dvfs_enable(false);
> > >  
> > >  	/*
> > >  	 * FIXME:WA for ECS28A, with this sleep, CTS
> > >  	 * android.hardware.camera2.cts.CameraDeviceTest#testCameraDeviceAbort
> > >  	 * PASS, no impact on other platforms
> > > -	*/
> > > +	 */
> > >  	if (IS_BYT && enable)
> > >  		msleep(10);
> > >  
> > > @@ -727,7 +727,7 @@ static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
> > >  	iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ, MRFLD_ISPSSPM0,
> > >  			val, MRFLD_ISPSSPM0_ISPSSC_MASK);
> > >  
> > > -	/*WA:Enable DVFS*/
> > > +	/* WA:Enable DVFS */
> > >  	if (IS_CHT && !enable)
> > >  		punit_ddr_dvfs_enable(true);
> > >  
> > > -- 
> > > 2.33.1
> > > 
> > > 
> > 
> 

