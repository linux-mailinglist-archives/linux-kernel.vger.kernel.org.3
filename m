Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0E5573F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiFWHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFWHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:30:13 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ACC4664A;
        Thu, 23 Jun 2022 00:30:12 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id q6so2184021eji.13;
        Thu, 23 Jun 2022 00:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pCJQPDJM0DHo8w0E8CwSS4Lsl1UxwVygfcfBvOi6lBU=;
        b=C6/QgAodsRzn4CdaNJNeky+ySg7IQkmIY3i0QYuw38cslMhDnXhuTVPgprsKbdZuj4
         e/RYyr1U3JlHsNFeTInMrWIrHA2/S4S9zMpDb1QSUt1w6w2l4afj7eL/MorC3Ul3D06W
         vnFpaGQCuzgQPXQgz0C/TEwUHX7TKNN32Yuay0Zj0wdt49nLXV+8QPI9wT8ghE6WuYMZ
         N9revvgWXirS8O3fEDvvZM45eiveRBwHH76WeaHEM+IwVcGDcEkISr3v4ZwrTOk33rhP
         0stXI7VCkArNvoOjyyf1GpURPjL1IRXfNx53vj5AkvkgLWecGjQNQkVZbK83Jl4KEwIK
         cZog==
X-Gm-Message-State: AJIora8f8b0Au6F9/SS4zZMayJB1cQnWzOI9vzbWGzkUbu4exeelS8MS
        LE4AMMZOYX7RLaMULAXlFGY=
X-Google-Smtp-Source: AGRyM1uzgyyn+5wazWdjwR1XOCL14kh/tF9Cc3OS+496AVZLMjXbvILFPpyZx/g8PE1USH6/kwYwKA==
X-Received: by 2002:a17:906:2a86:b0:711:d8a5:cb0c with SMTP id l6-20020a1709062a8600b00711d8a5cb0cmr6783395eje.426.1655969411375;
        Thu, 23 Jun 2022 00:30:11 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l16-20020aa7cad0000000b0043585bb803fsm8076171edt.25.2022.06.23.00.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:30:10 -0700 (PDT)
Message-ID: <e864ffbc-5885-f648-01c4-68a598f942b9@kernel.org>
Date:   Thu, 23 Jun 2022 09:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/6] serial: Use UART_XMIT_SIZE
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-6-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220621124958.3342-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> --- a/include/linux/serial.h
> +++ b/include/linux/serial.h
> @@ -9,7 +9,6 @@
>   #ifndef _LINUX_SERIAL_H
>   #define _LINUX_SERIAL_H
>   
> -#include <asm/page.h>
>   #include <uapi/linux/serial.h>
>   
>   /* Helper for dealing with UART_LCR_WLEN* defines */
> @@ -25,11 +24,6 @@ struct async_icount {
>   	__u32	buf_overrun;
>   };
>   
> -/*
> - * The size of the serial xmit buffer is 1 page, or 4096 bytes
> - */
> -#define SERIAL_XMIT_SIZE PAGE_SIZE
> -
>   #include <linux/compiler.h>
>   
>   #endif /* _LINUX_SERIAL_H */
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 5518b70177b3..1767dee98021 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -296,6 +296,7 @@ struct uart_state {
>   	struct uart_port	*uart_port;
>   };
>   
> +/* The size of the serial xmit buffer is 1 page, or 4096 bytes */

That is not completely true, I'd remove the "or" part. Hmm, but then the 
comment is somehow superfluous as it says what we can see below. So 
maybe don't add it at all?

>   #define UART_XMIT_SIZE	PAGE_SIZE

thanks,
-- 
js
suse labs
