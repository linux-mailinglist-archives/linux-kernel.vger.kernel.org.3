Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE8574B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiGNKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbiGNKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:46:27 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD3354CAD;
        Thu, 14 Jul 2022 03:46:26 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id x91so1883018ede.1;
        Thu, 14 Jul 2022 03:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mdZHN68nnDMwF7tgjBDSWcIdnt+cELpwBZVJBAjefvQ=;
        b=hxsg9NKfPHtAJXlsaBjbZYm+d6y3jnGqhVjhwZfbyFu37+r4Ik+rX6+5YdkCTj1j6q
         Zvnvt0lvbKCGIa9KjKmz8bNMBAwthXU3ZzIIsYWOJazQwZDazvGiEIR/yCFd1sDdh70d
         Cf9DXLtcEhx6dBQRBS+hTkVAjnS/lbvmAIQym4kfonSVAfqegB2MmbG7JHMSo/l4KRNx
         gyrHdg/Tl30y2VQOLeAM9ruxYvL8Ch/Aqgj8Pg1ZrZzA4gFKax1ODEVW8TDYVZ+mWDPy
         wCusAEYDSJS5LIC4UgtPcNcrTjTzBTrRLpGxgPydZVxtA7HB+g28mzY85YTL2QDFAs9x
         2W+w==
X-Gm-Message-State: AJIora96mc7UNIwd977YyQYlAGt4dLzmMamOgmLjfxBX+YArWcPvR4lm
        5aSobQrYQaFVL/J488kgRyw6oFJcXLVz0Q==
X-Google-Smtp-Source: AGRyM1syDuPlSQ3J3FJoTOFBJyVnDbl1sd0yL1SHmEfTsGCfRY7Ir7La5x85AMDOtIgmhPVSfr1Y4Q==
X-Received: by 2002:a05:6402:2997:b0:43b:247b:89cb with SMTP id eq23-20020a056402299700b0043b247b89cbmr2879714edb.91.1657795584887;
        Thu, 14 Jul 2022 03:46:24 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906329200b0072b2eab813fsm343840ejw.75.2022.07.14.03.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:46:24 -0700 (PDT)
Message-ID: <b973cfc2-d9a8-5d62-036f-14671cf56799@kernel.org>
Date:   Thu, 14 Jul 2022 12:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V5] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org
References: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 07. 22, 14:45, Vijaya Krishna Nivarthi wrote:
...
> +static unsigned long get_clk_div_rate(struct clk *clk, struct device *dev,
> +		unsigned int baud, unsigned int sampling_rate, unsigned int *clk_div)
> +{
> +	unsigned long ser_clk;
> +	unsigned long desired_clk;
> +
> +	desired_clk = baud * sampling_rate;
> +	if (!desired_clk) {
> +		dev_dbg(dev, "Invalid frequency\n");
> +		return 0;
>   	}
>   
> -	*clk_div = ser_clk / desired_clk;
> -	if (!(*clk_div))
> -		*clk_div = 1;
> +	/*
> +	 * try to find a clock rate within 2% tolerance, then within

"then within" ... "5" is missing, perhaps?

> +	 */
> +	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
> +	if (!ser_clk)
> +		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
> +
> +	if (!ser_clk)
> +		dev_err(dev, "Couldn't find suitable clock rate for %lu\n", desired_clk);
> +	else
> +		dev_dbg(dev, "desired_clk-%lu, ser_clk-%lu, clk_div-%u\n",
> +				desired_clk, ser_clk, *clk_div);
>   
>   	return ser_clk;
>   }
> @@ -1021,8 +1040,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>   	if (ver >= QUP_SE_VERSION_2_5)
>   		sampling_rate /= 2;
>   
> -	clk_rate = get_clk_div_rate(port->se.clk, baud,
> -		sampling_rate, &clk_div);
> +	clk_rate = get_clk_div_rate(port->se.clk, port->se.dev, baud,

Maybe worth passing whole geni_se (port->se) then?

> +					sampling_rate, &clk_div);
>   	if (!clk_rate)
>   		goto out_restart_rx;
>   

thanks,
-- 
js
suse labs
