Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C784DE93A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiCSQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:14:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06753D49C;
        Sat, 19 Mar 2022 09:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48928B80D77;
        Sat, 19 Mar 2022 16:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641D8C340EC;
        Sat, 19 Mar 2022 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647706364;
        bh=HEyacrIGIQx8ML6gFJ0fCuLhS4KAbHC0o85BgDkcqos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=butfp4FgFHm0rh60BX22Y4ltRLIH25uM4CSZrSxehKc7QUD9E9gGzJ8wCODRs1Ple
         2QnQRkXCvHuiAY5oJHqjgeL3GVJiYfrwmOGJDika19Ei5Z8Ws6xSBHrLTwwSwOuuGI
         JvZHKOgauBsGk0XUAZtoviZ+0ph1Z0y1atP4IY1jZoiPt5ZGAW9AKMk1n7DGORC6ZJ
         4m3tHTvDYpYXu0UmIGOG/BS3YVQK212SvNmwHnCkfANYN1tproROz+E7Kj/SycMvYa
         duWinaF5RnMVp3IIaHuptw75khFTw2BhD0njGxoyDC3d3xf/GvL0Og8dP3lPpAV5nD
         5oTPqmRGirbXw==
Date:   Sat, 19 Mar 2022 16:20:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:imu:bmi160: disable regulator in error path
Message-ID: <20220319162006.13c60c1f@jic23-huawei>
In-Reply-To: <YjSTK4yun3kiulB1@smile.fi.intel.com>
References: <20220318070900.2499370-1-ztong0001@gmail.com>
        <YjSTK4yun3kiulB1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 16:11:55 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 18, 2022 at 12:09:00AM -0700, Tong Zhang wrote:
> > regulator should be disabled in error path as mentioned in _regulator_put()
> > 
> > [   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
> > [   16.240453] Call Trace:
> > [   16.240572]  <TASK>
> > [   16.240676]  regulator_put+0x26/0x40
> > [   16.240853]  regulator_bulk_free+0x26/0x50
> > [   16.241050]  release_nodes+0x3f/0x70
> > [   16.241225]  devres_release_group+0x147/0x1c0
> > [   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]  
> 
> Seems legit. Currently we call it only when something else is failed afterwards.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Indeed this is fixing a real issue, but only one of two similar issues.
(I'd never have looked closely at this code without you spotting the first one :)

If I were writing this driver from scratch I would register
multiple devm_add_action_or_reset() callbacks and I note that even though
we might have turned the power off we haven't handled the other state
set in this init function.

1) Regulator disable.
2) bmi160_set_mode(bmi_data, BMI160_GYRO, false);
3) bmi160_set_mode(bmi_data, BMI160_ACCEL, false);

An alternative is to add handling for the first set_mode() in here being
unwound if the second fails.  See below.  

> 
> > Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  drivers/iio/imu/bmi160/bmi160_core.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 824b5124a5f5..f12446edb5ce 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >  
> >  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
> >  	if (ret)
> > -		return ret;
> > +		goto disable_regulator;
> >  
> >  	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
> >  
> > @@ -741,29 +741,34 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >  	if (use_spi) {
> >  		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
> >  		if (ret)
> > -			return ret;
> > +		goto disable_regulator;
> >  	}
> >  
> >  	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
> >  	if (ret) {
> >  		dev_err(dev, "Error reading chip id\n");
> > -		return ret;
> > +		goto disable_regulator;
> >  	}
> >  	if (val != BMI160_CHIP_ID_VAL) {
> >  		dev_err(dev, "Wrong chip id, got %x expected %x\n",
> >  			val, BMI160_CHIP_ID_VAL);
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> > +		goto disable_regulator;
> >  	}
> >  
> >  	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
> >  	if (ret)
> > -		return ret;
> > +		goto disable_regulator;
> >  
> >  	ret = bmi160_set_mode(data, BMI160_GYRO, true);
> >  	if (ret)

If this fails, we should also undo the previous call as well. For readability
use goto disable_accel; then fix it under that new label.
 
> > -		return ret;
> > +		goto disable_regulator;
> >  
> >  	return 0;
> > +
> > +disable_regulator:
> > +	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> > +	return ret;
> >  }
> >  
> >  static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > -- 
> > 2.25.1
> >   
> 

