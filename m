Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E954822E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiFMI3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiFMI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:01 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D013D1A;
        Mon, 13 Jun 2022 01:28:58 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so4149706wmq.0;
        Mon, 13 Jun 2022 01:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tupb+riFWiaYOqmvblkOLc8FOdhvfJSmDVJxPFdpfFw=;
        b=D7q9B49maHG/g/rDV1D0fCV4zc6EUQQmzaNwypno6swPFm+W+F/zsu6VihGcDl8wvm
         PoIA5+JmOViA57MpefW7q/A/NKECl5P7ihHcT7gaRFKOcWRNoIcNFFJ9HiNDXfUXoPlY
         MlNtXiJLJqiqii94JSBYoSAmbQJke3fqDOh22vEg28LVWEZ7XqIvL1JqXXBhK5Hb0SEi
         of/82otH0Fptz/iB+udVHZI0Sikhg5RoOVBUFzKmx/K4uu3Q2OY+SJIgSoWAyYxkiCaQ
         UyuPWeWiSxb2GjHV1ltTswROJ7H+UoAjY/o8bnP6wWPB/zV3r0THjp4xL00mKDBUq7Su
         DcvQ==
X-Gm-Message-State: AOAM533gU5VOuGACzUH6KlB9eB0YpwofrqMcERWNyns3s0VgxLB36615
        7I0iNdepmQh27vjEsg6NZyQ=
X-Google-Smtp-Source: ABdhPJxKW1KENykCcEwHU01gimMOS636bAvWJHU2vfwvyXcq0N2q+DOyBPfPadf44AN/eXnbf3c8cA==
X-Received: by 2002:a05:600c:354a:b0:39c:4ebf:fb4c with SMTP id i10-20020a05600c354a00b0039c4ebffb4cmr13200867wmq.142.1655108936843;
        Mon, 13 Jun 2022 01:28:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d4a07000000b00213abce60e4sm7564269wrq.111.2022.06.13.01.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 01:28:56 -0700 (PDT)
Message-ID: <e722f97b-cb18-2d8c-b3f1-38eca21f6a3f@kernel.org>
Date:   Mon, 13 Jun 2022 10:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] serial: 8250_pericom: Use UART_LCR_DLAB
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220613075736.12283-1-ilpo.jarvinen@linux.intel.com>
 <20220613075736.12283-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220613075736.12283-2-ilpo.jarvinen@linux.intel.com>
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
> Use UART_LCR_DLAB instead of literal.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/8250/8250_pericom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
> index 95ff10f25d58..b8d5b7714a9d 100644
> --- a/drivers/tty/serial/8250/8250_pericom.c
> +++ b/drivers/tty/serial/8250/8250_pericom.c
> @@ -73,7 +73,7 @@ static void pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
>   			struct uart_8250_port *up = up_to_u8250p(port);
>   			int lcr = serial_port_in(port, UART_LCR);
>   
> -			serial_port_out(port, UART_LCR, lcr | 0x80);
> +			serial_port_out(port, UART_LCR, lcr | UART_LCR_DLAB);
>   			serial_dl_write(up, divisor);
>   			serial_port_out(port, 2, 16 - scr);
>   			serial_port_out(port, UART_LCR, lcr);


-- 
js
suse labs
