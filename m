Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104714B2B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbiBKRRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:17:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351229AbiBKRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:17:47 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019939E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:17:45 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IZYAni8WyeHnVIZYAnZcuB; Fri, 11 Feb 2022 18:17:44 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 11 Feb 2022 18:17:44 +0100
X-ME-IP: 90.126.236.122
Message-ID: <2d5e9096-e40d-13af-234a-539108df1c50@wanadoo.fr>
Date:   Fri, 11 Feb 2022 18:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 04/49] iio: fix opencoded for_each_set_bit()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-iio@vger.kernel.org
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-5-yury.norov@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220210224933.379149-5-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/02/2022 à 23:48, Yury Norov a écrit :
> iio_simple_dummy_trigger_h() is mostly an opencoded for_each_set_bit().
> Using for_each_set_bit() make code much cleaner, and more effective.
> 
> Signed-off-by: Yury Norov <yury.norov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/iio/dummy/iio_simple_dummy_buffer.c | 48 ++++++++-------------
>   1 file changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index d81c2b2dad82..3bc1b7529e2a 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -45,41 +45,31 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>   {
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *indio_dev = pf->indio_dev;
> +	int i = 0, j;
>   	u16 *data;
>   
>   	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>   	if (!data)
>   		goto done;
>   
> -	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
> -		/*
> -		 * Three common options here:
> -		 * hardware scans: certain combinations of channels make
> -		 *   up a fast read.  The capture will consist of all of them.
> -		 *   Hence we just call the grab data function and fill the
> -		 *   buffer without processing.
> -		 * software scans: can be considered to be random access
> -		 *   so efficient reading is just a case of minimal bus
> -		 *   transactions.
> -		 * software culled hardware scans:
> -		 *   occasionally a driver may process the nearest hardware
> -		 *   scan to avoid storing elements that are not desired. This
> -		 *   is the fiddliest option by far.
> -		 * Here let's pretend we have random access. And the values are
> -		 * in the constant table fakedata.
> -		 */
> -		int i, j;
> -
> -		for (i = 0, j = 0;
> -		     i < bitmap_weight(indio_dev->active_scan_mask,
> -				       indio_dev->masklength);
> -		     i++, j++) {
> -			j = find_next_bit(indio_dev->active_scan_mask,
> -					  indio_dev->masklength, j);
> -			/* random access read from the 'device' */
> -			data[i] = fakedata[j];
> -		}
> -	}
> +	/*
> +	 * Three common options here:
> +	 * hardware scans: certain combinations of channels make
> +	 *   up a fast read.  The capture will consist of all of them.
> +	 *   Hence we just call the grab data function and fill the
> +	 *   buffer without processing.
> +	 * software scans: can be considered to be random access
> +	 *   so efficient reading is just a case of minimal bus
> +	 *   transactions.
> +	 * software culled hardware scans:
> +	 *   occasionally a driver may process the nearest hardware
> +	 *   scan to avoid storing elements that are not desired. This
> +	 *   is the fiddliest option by far.
> +	 * Here let's pretend we have random access. And the values are
> +	 * in the constant table fakedata.
> +	 */

Nitpicking: you could take advantage of the tab you save to use the full 
width of the line and save some lines of code.

Just my 2c.

CJ


> +	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
> +		data[i++] = fakedata[j];
>   
>   	iio_push_to_buffers_with_timestamp(indio_dev, data,
>   					   iio_get_time_ns(indio_dev));

