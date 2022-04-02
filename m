Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD74F0504
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358334AbiDBQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358437AbiDBQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF7112109B;
        Sat,  2 Apr 2022 09:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B29260B60;
        Sat,  2 Apr 2022 16:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19287C34110;
        Sat,  2 Apr 2022 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648917683;
        bh=Rjz+B7crTurKM0RORXJ3TgrTC5tbLzg9y46rgD7LmpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sbPP49t7ikeIxsFpkag86YK8dgs/7a+fZeqKBcs4nEfc9nnl11w22XG37UhCDFQIg
         i/oqvIaBTxnacEO4cvS9wDftnBFkn7srBB+hAVKfiTxaJN7qo2Yp1uhQyPC69RRzcF
         fIAQWx4XD2rFMhVTO5l1LFvZnxIUtuX9TcX0SCKDA1RmYC67qGvKFZmMdPGYAWln/3
         p6EFwgiieANDCisWi7GO8hx5kgQS4NuPtnfXyW8Pvu43iGYa7SobOibZX8eVSE+V2Z
         4L6WLdKjs6XxJKCXWfnvFNie03oUJl+eUndge49qjzDEnyro5v7hOsaaXwyJ6o9/EU
         TlzQYVu/dJ9hQ==
Date:   Sat, 2 Apr 2022 17:49:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220402174903.035f1181@jic23-huawei>
In-Reply-To: <ffcdf821-38f2-f8d7-2bcd-8ea51cad1b96@collabora.com>
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-4-shreeya.patel@collabora.com>
        <20220327153049.10e525e9@jic23-huawei>
        <ffcdf821-38f2-f8d7-2bcd-8ea51cad1b96@collabora.com>
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

On Wed, 30 Mar 2022 01:33:19 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> On 27/03/22 20:00, Jonathan Cameron wrote:
> 
> Hi Jonathan,
> 
> Thanks for your detailed review. I am working on v2 with the modifications
> suggested by you.
> 
> Just one comment inline.
> 

...

> >> +static int ltrf216a_set_it_time(struct ltrf216a_data *data, int itime)
> >> +{
> >> +	int i, ret, index = -1;
> >> +	u8 reg;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
> >> +		if (int_time_mapping[i] == itime) {
> >> +			index = i;
> >> +			break;
> >> +		}
> >> +	}
> >> +	/* Make sure integration time index is valid */
> >> +	if (index < 0)
> >> +		return -EINVAL;
> >> +
> >> +	if (index == 0) {  
> > Switch statement seems more appropriate than this stack of if else
> >  
> >> +		reg = 0x03;  
> > reg isn't a great name as I assume this is the value, not the address
> > which was my first thought... Perhaps reg_val?  
> >> +		data->int_time_fac = 4;
> >> +	} else if (index == 1) {
> >> +		reg = 0x13;
> >> +		data->int_time_fac = 2;
> >> +	} else {
> >> +		reg = (index << 4) | 0x02;  
> > Unless I'm missing something index == 2 if we get here.
> > So why the calculation?  I'd suggest defining the two fields and using
> > FIELD_PREP() to set up each part probably to one of a set of
> > #define LTRF216A_ALS_MEAS_RATE_  
> 
> I think the calculation here is to set the default value when the
> integration time = 1. 

1 isn't a possible value in int_time_available.

I guess you mean 100ms in which case if this were a switch statement

	switch (index) {
	case 0: /* 400msec */
		reg = 0x03;
		data->int_time_fac = 4;
		break;
	case 1: /* 200msec */
		reg = 0x13;
		data->int_time_fac = 2;
		break;
	case 2: /* 100sec */
		reg = 0x22;
		data->int_time_fac = 1;
		break; 
	}

btw from datasheet, 50ms and 25ms also seem possible, why not support them?

Note the switch might be better handled as a constant look up table of appropriate
structures.

> In this case, reg value will be 34 (0x22) which
> is the default value of ALS_MEAS_RATE register.

> 
> I will still confirm it once from Zhigang before sending a v2.
> 
> >> +		data->int_time_fac = 1;
> >> +	}
> >> +
>
Jonathan
