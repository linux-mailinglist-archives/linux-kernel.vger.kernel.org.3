Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F189C4E88AB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiC0QH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiC0QHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:07:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FC12617;
        Sun, 27 Mar 2022 09:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A39B80BFA;
        Sun, 27 Mar 2022 16:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A8C340EC;
        Sun, 27 Mar 2022 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648397171;
        bh=hInmacrtqqLCdMotd9oxcwLtJbwkVKG97iU/e/STNnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pc8P3/fmvIb2IQx5O871aJOyhREnvqIDmex0+sOUHG2RVUHs5rzDKGvWqCs8qY5/2
         YOt+Ou3wzKTRnISQeAnWqWmegSjYKsimFBOJjVHs6Ehtd+AsPPIzk+ol+4G6qXX7aB
         40O9SIHJPnTcLgM0fmvuCfR3EMc50PRUf2PIMn2sPIRyjRDemvcaDFiP8UejGpWG3l
         FjWPgyeb198uLZWEgGdN+F2exmzLZ4s7sAQKGI1t72fFfNIpPeVCbsKwYSdS6R8l5U
         kOwUvhj/DQD1W26rQKnU1ZcazYmPSFTNmu7rI4uZosUBK4B6K708m4VFRlhH9rorNa
         5vLdpMhsADq3g==
Date:   Sun, 27 Mar 2022 17:13:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Colin Ian King <colin.king@intel.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] iio: palmas: shut up warning about calibration mismatch
 (due to noise)
Message-ID: <20220327171343.28d582e7@jic23-huawei>
In-Reply-To: <18533164-C17A-4CA1-A882-5A160D370498@goldelico.com>
References: <1cee45bfc3fa2ab59dcc17242fb52468035360a1.1646743982.git.hns@goldelico.com>
        <20220320155259.0fc79dd3@jic23-huawei>
        <18533164-C17A-4CA1-A882-5A160D370498@goldelico.com>
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

On Sun, 20 Mar 2022 17:28:21 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Jonathan,
> 
> > Am 20.03.2022 um 16:52 schrieb Jonathan Cameron <jic23@kernel.org>:
> > 
> > On Tue,  8 Mar 2022 13:53:03 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >   
> >> Although technically checking for ADC values below 0 is correct,
> >> because they are outside of the calibration values, there is usually
> >> noise which spuriously fills the console log with error messages if
> >> calculated input voltage gets close to 0V.
> >> 
> >> Ignore small negative calculated values, but clamp them to 0.
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>  
> > Hi.
> > 
> > Should we treat this as a fix or a cleanup?
> > 
> > I don't mind either way.  
> 
> I don't mind either since we have it for long time in our distribution kernel.
> 
> BR and thanks,
> Nikolaus

Treated as cleanup so applied to the togreg branch of iio.git, but for now
only pushed out as testing because I'll be rebasing on rc1 next week.

Thanks,

Jonathan

> 
> > 
> > Jonathan
> > 
> >   
> >> ---
> >> drivers/iio/adc/palmas_gpadc.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> >> index f9c8385c72d3..bcfa6a7f6cb2 100644
> >> --- a/drivers/iio/adc/palmas_gpadc.c
> >> +++ b/drivers/iio/adc/palmas_gpadc.c
> >> @@ -376,7 +376,8 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
> >> 					adc->adc_info[adc_chan].gain_error;
> >> 
> >> 	if (val < 0) {
> >> -		dev_err(adc->dev, "Mismatch with calibration\n");
> >> +		if (val < -10)
> >> +			dev_err(adc->dev, "Mismatch with calibration var = %d\n", val);
> >> 		return 0;
> >> 	}
> >>   
> >   
> 

