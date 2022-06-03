Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBA53CC0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiFCPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbiFCPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:11:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD65506C4;
        Fri,  3 Jun 2022 08:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57071B82359;
        Fri,  3 Jun 2022 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9814EC385A9;
        Fri,  3 Jun 2022 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654269090;
        bh=prtQe0mqDshbUfvhhY5Wz4YhnC7CpDqr1UqcZBTJU0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2FwOiwTQSBSNmmrgyGTFQNEHYZIIc6srQpUMt+TgN99yinQuOC9sJfiHvxHj1NrN
         9oOqavMqzrcNmEJkRKFrICftneUXpKdXaGxRcR5jx1t2qKMc2menxBOlT/1U5r7NsG
         xOr3fi4k+Yb3ssAVlMo3Vo3zOGwicrCHHy8o/5mG4o3PSZfoRTTMEUXi9HRF1v9/mj
         580/FZfvhnGYFzTELGemltU0I1hL5tfNjirkOf1yCVI5zVS+tX5oFWHry1H+QP1aCN
         9AbUZDYOMuZFrtICz5UcLaNHeMsSMSauMkcKJTE/lls46JYe6E7IfpECXFL+r43QRE
         JMVycKsRoc1IA==
Date:   Fri, 3 Jun 2022 16:20:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lars@metafoo.de,
        svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn
Subject: Re: [PATCH v4] iio: vadc: Fix potential dereference of NULL pointer
Message-ID: <20220603162029.6ed3c3b3@jic23-huawei>
In-Reply-To: <20220603160222.1ad6ef49@jic23-huawei>
References: <20220522120109.7ead18a7@jic23-huawei>
        <1653238427-73587-1-git-send-email-lyz_cs@pku.edu.cn>
        <20220603160222.1ad6ef49@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 16:02:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 22 May 2022 09:53:47 -0700
> Yongzhi Liu <lyz_cs@pku.edu.cn> wrote:
> 
> > The return value of vadc_get_channel() needs to be checked to
> > avoid use of NULL pointer. vadc_do_conversion() already provides
> > error prints in at least some of it's error paths. Thus it is
> > reasonable to add the null pointer check on prop and drop the
> > extra reporting in vadc_measure_ref_points().
> > 
> > Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>  
> 
> Hi
> 
> Biggest remaining thing is squashing
> ret = -ENODEV;
> return ret;
> 
> into the shorter
> return -ENODEV;
> 
One additional process thing I didn't mention before now as this is a
single patch.

Generally for IIO at least, don't send new versions in reply to old threads.
The threads can get very deep and confusing, so I'd much rather a new thread
for each version.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/adc/qcom-spmi-vadc.c | 38 ++++++++++++++++++++++++++++----------
> >  1 file changed, 28 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> > index 34202ba..43a52b1 100644
> > --- a/drivers/iio/adc/qcom-spmi-vadc.c
> > +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> > @@ -358,22 +358,33 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
> >  	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
> >  
> >  	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
> > +	if (!prop) {
> > +		dev_err(vadc->dev, "Please define 1.25V channel\n");  
> Probably makes more sense to have the error as 
> "No 1.25V channel found\n");
> 
> It's not obvious to anyone getting this error what 'define' might mean
> without them looking at the code, so I'd rather we just said what had
> gone wrong rather offering incomplete advice.
> 
> > +		ret = -ENODEV;  
> 
> Don't bother assigning a variable just to return it in the next line.
> 
> return -ENODEV;
> 
> > +		return ret;
> > +	}
> >  	ret = vadc_do_conversion(vadc, prop, &read_1);
> >  	if (ret)
> > -		goto err;
> > +		return ret;
> >  
> >  	/* Try with buffered 625mV channel first */
> >  	prop = vadc_get_channel(vadc, VADC_SPARE1);
> > -	if (!prop)
> > +	if (!prop) {
> >  		prop = vadc_get_channel(vadc, VADC_REF_625MV);
> > +		if (!prop) {
> > +			dev_err(vadc->dev, "Please define 0.625V channel\n");  
> "No 0.625V channel found\n"
> > +			ret = -ENODEV;  
> 
> return -ENODEV;
> 
> > +			return ret;
> > +		}
> > +	}
> >  
> >  	ret = vadc_do_conversion(vadc, prop, &read_2);
> >  	if (ret)
> > -		goto err;
> > +		return ret;
> >  
> >  	if (read_1 == read_2) {
> >  		ret = -EINVAL;
> > -		goto err;
> > +		return ret;
> >  	}
> >  
> >  	vadc->graph[VADC_CALIB_ABSOLUTE].dy = read_1 - read_2;
> > @@ -381,25 +392,32 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
> >  
> >  	/* Ratiometric calibration */
> >  	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
> > +	if (!prop) {
> > +		dev_err(vadc->dev, "Please define VDD channel\n");  
> 
> "No VDD channel found\n"
> 
> > +		ret = -ENODEV;
> > +		return ret;
> > +	}
> >  	ret = vadc_do_conversion(vadc, prop, &read_1);
> >  	if (ret)
> > -		goto err;
> > +		return ret;
> >  
> >  	prop = vadc_get_channel(vadc, VADC_GND_REF);
> > +	if (!prop) {
> > +		dev_err(vadc->dev, "Please define GND channel\n");  
> 
> "No GND channel found\n"
> 
> > +		ret = -ENODEV;
> > +		return ret;  
> 
> return -ENODEV;
> 
> > +	}
> >  	ret = vadc_do_conversion(vadc, prop, &read_2);
> >  	if (ret)
> > -		goto err;
> > +		return ret;
> >  
> >  	if (read_1 == read_2) {
> >  		ret = -EINVAL;
> > -		goto err;
> > +		return ret;  
> 
> return -ENODEV;
> 
> >  	}
> >  
> >  	vadc->graph[VADC_CALIB_RATIOMETRIC].dy = read_1 - read_2;
> >  	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
> > -err:
> > -	if (ret)
> > -		dev_err(vadc->dev, "measure reference points failed\n");
> >  
> >  	return ret;  
> 
> Can't get here with anything other than ret == 0 so
> 	return 0;
> to make that explicit.
> 
> 
> >  }  
> 

