Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EFF5572D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFWGIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiFWGID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:08:03 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3085E44A1C;
        Wed, 22 Jun 2022 23:07:51 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id t5so6298509eje.1;
        Wed, 22 Jun 2022 23:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t6P+OEr0vrvpoPfUHObsMCgB6b3hmJkinrDt6rRS438=;
        b=8BUgWMSfTAhLk4L1Ji+3kgabm7zr1yzHrTGc00QxJqGGJZkysZhkbfbNQQcFBMdFi3
         1uSAglJXg9UbNjg3JRd/6MXT49vN2JrEm+W+dUvN8kyu61+LMVBnnK5e+UulMLOwLAbZ
         K9L+mJNflekphxNqy1WQ+cJcbA2esR1hM90kThCPWIdNoT9h1ipA1P2qiZYrwllDQCxf
         zN9ryX83xN9rRZ9qyvpsLc2BYS9KCIoUDlhcE+RLQmL8fGgRBmNcQ3sLkULGSvOijijc
         u6F+176UrxPRsr6e/cXkKxH86OiOV44JKlkasJg8ILJrphed2HzBw1Y+u3MThTqSjUP8
         +7zg==
X-Gm-Message-State: AJIora+cwpAapQaPGoGIMtat7sz8+WhDmeHE4WECVdpqYch8sQH+aqBs
        z087ckBFjrs+eCRHf3grWOw=
X-Google-Smtp-Source: AGRyM1tn6B67l/KiBQ/N+kEIHBz4CdfpAEFNHBqKz02petrPe74UxMGHsnlG2ds/8MuCKUkLJu1t9A==
X-Received: by 2002:a17:906:dc8f:b0:723:a62a:cd0e with SMTP id cs15-20020a170906dc8f00b00723a62acd0emr2420289ejc.444.1655964469427;
        Wed, 22 Jun 2022 23:07:49 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d21-20020a056402517500b00435640c141esm13717890ede.93.2022.06.22.23.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 23:07:48 -0700 (PDT)
Message-ID: <9284b3dd-3da5-1a52-1e92-a434cfe2e1e1@kernel.org>
Date:   Thu, 23 Jun 2022 08:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()
 which otherwise could return a sub-optimal clock rate.
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org
References: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 06. 22, 19:57, Vijaya Krishna Nivarthi wrote:
> In the logic around call to clk_round_rate, for some corner conditions,
> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> exact clock rate was not found lowest clock was being returned.
> 
> Search for suitable clock rate in 2 steps
> a) exact match or within 2% tolerance
> b) within 5% tolerance
> This also takes care of corner conditions.
> 
> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")

Hmm, provided the complexity, was this worth it -- how many typos/bugs 
can be in such complex and twisted functions?

The original intention was not to touch the driver when new HW arrives. 
Now it looks like you'd be chasing corner cases like these for quite 
some releases.

So going back in time, reconsidering the whole thing: how often do you 
expect the original rate table would need to be updated?

NACK

in any way -- see my comment below -- if you really want to go this 
path, you'd need to split this.

> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 134 ++++++++++++++++++++++++++--------
>   1 file changed, 102 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2e23b65..8d247c1 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -943,52 +943,123 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>   	return 0;
>   }
>   
> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> -			unsigned int sampling_rate, unsigned int *clk_div)
> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
> +			unsigned int *clk_div, unsigned int percent_tol, bool *exact_match)
>   {
> +	unsigned long freq;
> +	unsigned long div, maxdiv, new_div;
> +	unsigned long long mult;
>   	unsigned long ser_clk;
> -	unsigned long desired_clk;
> -	unsigned long freq, prev;
> -	unsigned long div, maxdiv;
> -	int64_t mult;
> -
> -	desired_clk = baud * sampling_rate;
> -	if (!desired_clk) {
> -		pr_err("%s: Invalid frequency\n", __func__);
> -		return 0;
> -	}
> +	unsigned long test_freq, offset, new_freq;
>   
> +	ser_clk = 0;
>   	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
> -	prev = 0;
> +	div = 1;
>   
> -	for (div = 1; div <= maxdiv; div++) {
> -		mult = div * desired_clk;
> -		if (mult > ULONG_MAX)
> +	while (div <= maxdiv) {
> +		mult = (unsigned long long)div * desired_clk;
> +		if (mult != (unsigned long)mult)
>   			break;
>   
> -		freq = clk_round_rate(clk, (unsigned long)mult);
> -		if (!(freq % desired_clk)) {
> -			ser_clk = freq;
> -			break;
> +		/*
> +		 * Loop requesting a freq within tolerance and possibly exact freq.
> +		 *
> +		 * We'll keep track of the lowest freq inexact match we found
> +		 * but always try to find a perfect match. NOTE: this algorithm
> +		 * could miss a slightly better freq if there's more than one
> +		 * freq between (freq - offset) and (freq) but (freq) can't be made
> +		 * exactly, but that's OK.
> +		 *
> +		 * This absolutely relies on the fact that the Qualcomm clock
> +		 * driver always rounds up.
> +		 * We make use of exact_match as an I/O param.
> +		 */
> +
> +		/* look only for exact match if within tolerance is already found */
> +		if (ser_clk)
> +			offset = 0;
> +		else
> +			offset = (mult * percent_tol) / 100;
> +
> +		test_freq = mult - offset;
> +		freq = clk_round_rate(clk, test_freq);
> +
> +		/*
> +		 * A dead-on freq is an insta-win, look for it only in 1st run
> +		 */
> +		if (*exact_match) {
> +			if (!(freq % desired_clk)) {
> +				ser_clk = freq;
> +				*clk_div = freq / desired_clk;
> +				return ser_clk;
> +			}
> +		}
> +
> +		if (!ser_clk) {
> +			new_div = DIV_ROUND_CLOSEST(freq, desired_clk);
> +			new_freq = new_div * desired_clk;
> +			offset = (new_freq * percent_tol) / 100;
> +
> +			if (new_freq - offset <= freq && freq <= new_freq + offset) {
> +				/* Save the first (lowest freq) within tolerance */
> +				ser_clk = freq;
> +				*clk_div = new_div;
> +				/* no more search for exact match required in 2nd run */
> +				if (!(*exact_match))
> +					break;
> +			}
>   		}
>   
> -		if (!prev)
> -			ser_clk = freq;
> -		else if (prev == freq)
> +		div = freq / desired_clk + 1;
> +
> +		/*
> +		 * Only time clock framework doesn't round up is if
> +		 * we're past the max clock rate. We're done searching
> +		 * if that's the case.
> +		 */
> +		if (freq < test_freq)
>   			break;
> +	}
> +
> +	*exact_match = false;
> +	return ser_clk;
> +}
> +
> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> +			unsigned int sampling_rate, unsigned int *clk_div)

This cannot be reviewed properly. Care to split this into 2-3 patches? 
Looks at the nesting and the complexity, it also looks like you need 
more helper functions.

> +{
> +	unsigned long ser_clk;
> +	unsigned long desired_clk;
> +	unsigned long desired_tol;
> +	bool exact_match;
>   
> -		prev = freq;
> +	desired_clk = baud * sampling_rate;
> +	if (!desired_clk) {
> +		pr_err("%s: Invalid frequency\n", __func__);
> +		return 0;
>   	}
>   
> -	if (!ser_clk) {
> -		pr_err("%s: Can't find matching DFS entry for baud %d\n",
> -								__func__, baud);
> +	/* try to find exact clock rate or within 2% tolerance */
> +	ser_clk = 0;
> +	exact_match = true;
> +	desired_tol = 2;
> +
> +	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
> +	if (ser_clk) {
> +		if (!exact_match)
> +			pr_warn("Cannot find exact match clk_rate, using one within 2 percent tolerance\n");
>   		return ser_clk;
>   	}
>   
> -	*clk_div = ser_clk / desired_clk;
> -	if (!(*clk_div))
> -		*clk_div = 1;
> +	/* try within 5% tolerance now, no need to look for exact match */
> +	exact_match = false;
> +	desired_tol = 5;
> +
> +	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
> +	if (ser_clk)
> +		pr_warn("Cannot find exact match clk_rate, using one within 5 percent tolerance\n");
> +	else
> +		pr_err("Cannot find suitable clk_rate, giving up\n");
>   
>   	return ser_clk;
>   }
> @@ -1021,8 +1092,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>   	if (ver >= QUP_SE_VERSION_2_5)
>   		sampling_rate /= 2;
>   
> -	clk_rate = get_clk_div_rate(port->se.clk, baud,
> -		sampling_rate, &clk_div);
> +	clk_rate = get_clk_div_rate(port->se.clk, baud, sampling_rate, &clk_div);
>   	if (!clk_rate)
>   		goto out_restart_rx;
>   

thanks,
-- 
js
suse labs
