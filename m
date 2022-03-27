Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91EB4E8887
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiC0P4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiC0P4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:56:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F884766D;
        Sun, 27 Mar 2022 08:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED329B80C6A;
        Sun, 27 Mar 2022 15:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB9FC340EC;
        Sun, 27 Mar 2022 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648396470;
        bh=ibHIK/AF0yzHNSgjtV23+zvC7O5KH8ZeucA4+1CGxOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fxCd3aWoBdPEJEknWYv7BbLUmba7+1GqWa8tkRfoy3QslYAgaxjUdeXi7vsofltVh
         bd+iHYgbX5YGX2AruyNgQQknjb9QI5AyymZVjtJsMz87ej75ywOGJi3diY5AAiaBfQ
         YoDToC4+BwoXnk+TytQdBmXsAxsuEUCAN+LFPhV3cCfM8LBmmNSYIh55SUd+0/zyoP
         rT2CSS5oZ655zX16WqVo9ZXbMb1rumpPYteXAPkcrdN0Amr48fVvVEPG3fG1j/UKQ2
         6yMyKrHV3XuHZOfQoTj43uBfJIFiam/MHCdMsEkirUAtYqs9MkTuB95pIQ4z/JECV9
         y2+QezZmx/OdA==
Date:   Sun, 27 Mar 2022 17:02:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio:imu:bmi160: disable regulator in error path
Message-ID: <20220327170202.5fbe76a3@jic23-huawei>
In-Reply-To: <20220327165336.799db3ac@jic23-huawei>
References: <20220318070900.2499370-1-ztong0001@gmail.com>
        <20220327154005.806049-1-ztong0001@gmail.com>
        <20220327165336.799db3ac@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 16:53:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 27 Mar 2022 08:40:05 -0700
> Tong Zhang <ztong0001@gmail.com> wrote:
> 
> > Regulator should be disabled in error path as mentioned in _regulator_put().
> > Also disable accel if gyro cannot be enabled.
> > 
> > [   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
> > [   16.240453] Call Trace:
> > [   16.240572]  <TASK>
> > [   16.240676]  regulator_put+0x26/0x40
> > [   16.240853]  regulator_bulk_free+0x26/0x50
> > [   16.241050]  release_nodes+0x3f/0x70
> > [   16.241225]  devres_release_group+0x147/0x1c0
> > [   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]
> > 
> > Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>  
> oops. Raced with you ;)
> 
> Anyhow, I added the tag, so no problem.

on closer inspection b4 was clever and picked v3 up anyway.

J
> 
> Jonathan
> 
> > ---
> > v2: also disable accel when gyro fail to enable
> > v3: add tag
> >  drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 824b5124a5f5..01336105792e 100644
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
> > @@ -741,29 +741,37 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >  	if (use_spi) {
> >  		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
> >  		if (ret)
> > -			return ret;
> > +			goto disable_regulator;
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
> > -		return ret;
> > +		goto disable_accel;
> >  
> >  	return 0;
> > +
> > +disable_accel:
> > +	bmi160_set_mode(data, BMI160_ACCEL, false);
> > +
> > +disable_regulator:
> > +	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> > +	return ret;
> >  }
> >  
> >  static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,  
> 

