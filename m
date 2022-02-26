Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DC4C573D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiBZSCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBZSCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:02:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AC151C55;
        Sat, 26 Feb 2022 10:01:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54872CE02C8;
        Sat, 26 Feb 2022 18:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43379C340E8;
        Sat, 26 Feb 2022 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645898491;
        bh=TDyKTB/CFLnyzEPr8uvusnVgxqT3Ocd+xmt5byyq/N0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nO7QQ84KGvXRmqcRcVjz7s47qz+CigW7ouQQxrQ2O0qhffJXqL0FnUtTxJc+MpgfE
         J2ph2kqQTMC8vQc+y2h5MaVLLX/+nt96X1av+tICSLHrfnHE5nxA2jyI5iTCoBsbru
         8wpVgExsqhmX4GX72IuqdHbTncu8y/myz3DspwRkSHjLqVdL2VY98U07jx2lFVXHqQ
         dnSNqFYIHBs5clmyX/GVMUbv5qeE8RnuIuf7RKEu+h5EK/TpzgZ5FRu4hI+qhxqea7
         RZuhEAyeRTP5R+8dGXpW3FMer9r55IaTxEcsb2kJ1RFICG0/KK1Dlz7i8QkBj0VGnN
         t075xzYYjqCTw==
Date:   Sat, 26 Feb 2022 18:08:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio:accel:adxl367: fix missing unlock on error in
 adxl367_buffer_predisable()
Message-ID: <20220226180832.77cf4fd5@jic23-huawei>
In-Reply-To: <c2a836f26c3246dc93c8ccadb85c5a02@analog.com>
References: <20220224020302.2177607-1-yangyingliang@huawei.com>
        <c2a836f26c3246dc93c8ccadb85c5a02@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Thu, 24 Feb 2022 09:38:06 +0000
"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:

> Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Sorry. I normally try to pick up the earliest fix when I get
multiple fixes for the same thing but I failed to notice
yours before applying the one Dan sent out!

As a result I've already picked that one up

Thanks for the patch though and I'll check more carefully next
time!

Jonathan

> 
> > -----Original Message-----
> > From: Yang Yingliang <yangyingliang@huawei.com>
> > Sent: Thursday, February 24, 2022 4:03 AM
> > To: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > Cc: jic23@kernel.org; Tanislav, Cosmin <Cosmin.Tanislav@analog.com>
> > Subject: [PATCH -next] iio:accel:adxl367: fix missing unlock on error in
> > adxl367_buffer_predisable()
> > 
> > [External]
> > 
> > Add the missing unlock before return from function
> > adxl367_buffer_predisable()
> > in the error handling case.
> > 
> > Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/iio/accel/adxl367.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > index b452d74b1d4d..bdc95409abed 100644
> > --- a/drivers/iio/accel/adxl367.c
> > +++ b/drivers/iio/accel/adxl367.c
> > @@ -1359,7 +1359,7 @@ static int adxl367_buffer_predisable(struct iio_dev
> > *indio_dev)
> > 
> >  	ret = adxl367_set_measure_en(st, true);
> >  	if (ret)
> > -		return ret;
> > +		goto out;
> > 
> >  	ret = adxl367_set_temp_adc_mask_en(st, indio_dev-  
> > >active_scan_mask,  
> >  					   false);
> > --
> > 2.25.1  
> 

