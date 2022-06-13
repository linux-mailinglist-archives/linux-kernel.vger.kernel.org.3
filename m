Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BD548225
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiFMI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbiFMI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:28:31 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D412757;
        Mon, 13 Jun 2022 01:28:30 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id a15so6133311wrh.2;
        Mon, 13 Jun 2022 01:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hBtcUvM74HCV9u8vUlhcOue6ctsIhFbgdVClXbpGCNQ=;
        b=iLdtkcnFnvBj+s/QCzNtL1bW+qOXi7CbchvrHIwR/HTU/qi6l9Ic5B+glg0j6vDkE5
         ZsVv0qDX8ufh0XDzW8EAIiIy4EIriPELMOICQ2YetB8+llvnW8oNLhqwc6KAUnzcU0lm
         wZx245m/IKQYX2Vls5KUs2heCvWQqQIZjWjPyl8wgHDUIA14/94OE1TMeN0I+5/ZXISe
         K/31BCDafWrheQrs5453LBbOxVj17qCsQYArP8KV0JMbOV0Bs258JpglFDcYJZ9F4uEF
         A9MQbSeGjmKkBpoOpal6938tNViKTKbL9J33Nnq8QkOHwrG5XNVpwF5kMSJws9ILPryu
         tUyg==
X-Gm-Message-State: AOAM532wxfGwdNQOYSJJ++l4gX1hpMP27IPH6J8Xhua6ArbbmD1Lue5V
        cMKhQYnTDeScaXyIbkBU3kY4EjRWBOLPog==
X-Google-Smtp-Source: ABdhPJxFmgXHOMghqLKZ2Ukn1poGFL1jpCdV5xds0HjrqG3tqDnmo7a2inSaGbYsaLu00fyjFfNnyg==
X-Received: by 2002:adf:f706:0:b0:20e:6788:c2b6 with SMTP id r6-20020adff706000000b0020e6788c2b6mr56239494wrp.633.1655108908965;
        Mon, 13 Jun 2022 01:28:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc850000000b0039c96b97359sm1789466wml.37.2022.06.13.01.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 01:28:28 -0700 (PDT)
Message-ID: <1a631963-8b76-b14a-892c-9e22a23a55f7@kernel.org>
Date:   Mon, 13 Jun 2022 10:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] serial: 8250: Use UART_LCR_WLEN8 instead of literal
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220613075736.12283-1-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220613075736.12283-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 06. 22, 9:57, Ilpo Järvinen wrote:
> Use UART_LCR_WLEN8 instead of literal 0x03 in size_fifo().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/8250/8250_port.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 953b0fadfd4c..8365c7ad3576 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -843,7 +843,7 @@ static int size_fifo(struct uart_8250_port *up)
>   	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
>   	old_dl = serial_dl_read(up);
>   	serial_dl_write(up, 0x0001);
> -	serial_out(up, UART_LCR, 0x03);
> +	serial_out(up, UART_LCR, UART_LCR_WLEN8);
>   	for (count = 0; count < 256; count++)
>   		serial_out(up, UART_TX, count);
>   	mdelay(20);/* FIXME - schedule_timeout */


-- 
js
suse labs
