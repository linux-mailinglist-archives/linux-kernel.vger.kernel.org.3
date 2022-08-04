Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0895897FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiHDHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiHDHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:00:30 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1AD52;
        Thu,  4 Aug 2022 00:00:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id j8so9969918ejx.9;
        Thu, 04 Aug 2022 00:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ECLfKYmeenEL4SeYJZvv5l6e7YoOhn0B24jd3MKIjIw=;
        b=MG9Ji2XLFBueKpvQdtDEQM3mZ0IKBD0JSgN+FCcmvfBhMB/PuPZKv+ML9rbU++U3ur
         BKj4l+LxufbhkiXRu9vD/979BRQiC+F/ewJPfSxaJzoEJxCsvzRpgQ6reOmPVuZR9mgN
         AcyQF4VqLngDXLLmzjnX98BcxPxtp+VRerykD1DUkoVTXQxgVptS2FV+IGBrIrU0OJoh
         +Hea2OZBiz81R1jcq3Y6uD1vXFNuv0hpWqQkapAXlUBhRfkl6XiMVqEFtrhAz0TOcPq8
         g8ySZw7mb/oUZnoexbLFb44QneV85vD2cYBHKhiA11mFW7sWePXxSaIWm7laTXrNK4Gk
         tr5A==
X-Gm-Message-State: ACgBeo3EBkwNie52bRu31pGNPfUM094w3ScREh7m7llPgkveaSzNuoka
        QS6/JrXTQ6HC6yn7Aov9J6M=
X-Google-Smtp-Source: AA6agR4yFpx47dVm/RC/ZkrlkXcUG4sIfJIv18K9LaDTRO1FlCl9Tyd5iQoHsYNTYyYgRgYODCa/gg==
X-Received: by 2002:a17:907:7601:b0:730:3da4:217c with SMTP id jx1-20020a170907760100b007303da4217cmr335873ejc.563.1659596428094;
        Thu, 04 Aug 2022 00:00:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b007307d099ed7sm4978ejc.121.2022.08.04.00.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 00:00:27 -0700 (PDT)
Message-ID: <e49e5b1f-d178-3e39-87f1-1cccba31ace1@kernel.org>
Date:   Thu, 4 Aug 2022 09:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Fix %lu -> %u in print
 statements
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220802132250.1.Iea061e14157a17e114dbe2eca764568a02d6b889@changeid>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220802132250.1.Iea061e14157a17e114dbe2eca764568a02d6b889@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 22, 22:23, Douglas Anderson wrote:
> When we multiply an unsigned int by a u32 we still end up with an
> unsigned int. That means we should specify "%u" not "%lu" in the
> format code.
> 
> NOTE: this fix was chosen instead of somehow promoting the value to
> "unsigned long" since the max baud rate from the earlier call to
> uart_get_baud_rate() is 4000000 and the max sampling rate is 32.
> 4000000 * 32 = 0x07a12000, not even close to overflowing 32-bits.

Acked-by: Jiri Slaby <jirislaby@kernel.org>

I wonder, how this became unnoticed by the 0day bot?

> Fixes: c474c775716e ("tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index f754619451dc..f7c1f1807040 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1033,12 +1033,12 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>   		sampling_rate, &clk_div);
>   	if (!clk_rate) {
>   		dev_err(port->se.dev,
> -			"Couldn't find suitable clock rate for %lu\n",
> +			"Couldn't find suitable clock rate for %u\n",
>   			baud * sampling_rate);
>   		goto out_restart_rx;
>   	}
>   
> -	dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
> +	dev_dbg(port->se.dev, "desired_rate-%u, clk_rate-%lu, clk_div-%u\n",
>   			baud * sampling_rate, clk_rate, clk_div);
>   
>   	uport->uartclk = clk_rate;


-- 
js
suse labs
