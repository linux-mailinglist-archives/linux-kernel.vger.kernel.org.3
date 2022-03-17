Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADFD4DBFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiCQHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiCQHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:08:00 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A67679;
        Thu, 17 Mar 2022 00:06:43 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id b15so5408306edn.4;
        Thu, 17 Mar 2022 00:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pnGDpE7h6Qwm7jpuPXAkv5jYm5jyweWlH4y/NG7xMVw=;
        b=BUWy/CwDRxfls+gUsD0Yn/UHsj7Fim6XyXsxpehQhjGJuT0aMOVh6CSuaQeUxB4j9f
         mBQXwIgbmPHU9/8ELQCj/HufOyoSQv9TWifco+x7iHHnRv8L4/vrXJjtXJArvw0W7gTd
         se+181ruK+NTjM/9wI8YbEx/pNf40gTUWASZHWT2UpSdXKxxRBexptecMpq7pWb0dxV/
         WJtn7TJIKpbhcEjs8aWG+GrKhzPfoPhH7mp3YxQRL54cPUll8JZ2/Fw6aVc9Bt62aSav
         O5QZ/VKrcw4g+gdPVlg0+1eenYM0eDLFBBfE4SJ+vc/C6nTMQeVcocEwDD/vlTt2NFzU
         aazA==
X-Gm-Message-State: AOAM531GlAAbI4pJ6rRGFoVUTWCRjLEb6wBe34bgkuifazyMgxFUGyqP
        3fqmV/1dWkdR+xZfyqPkhhw=
X-Google-Smtp-Source: ABdhPJy/hq37aySKEIjBncTRHCWYqedom3Y0ELtxjz/Ydy07dGZaqVSVDaevsO82u5DyjouvWYWk5g==
X-Received: by 2002:a05:6402:1d4d:b0:416:c489:b784 with SMTP id dz13-20020a0564021d4d00b00416c489b784mr2878883edb.304.1647500801689;
        Thu, 17 Mar 2022 00:06:41 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id ga5-20020a1709070c0500b006de43e9605asm1897233ejc.181.2022.03.17.00.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:06:41 -0700 (PDT)
Message-ID: <4914513f-cdb8-7698-be7f-968d343c5693@kernel.org>
Date:   Thu, 17 Mar 2022 08:06:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 5/5] serial/8250: Only use fifo after the port is
 initialized in console_write
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
References: <20220316143646.13301-1-wander@redhat.com>
 <20220316143646.13301-6-wander@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220316143646.13301-6-wander@redhat.com>
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

On 16. 03. 22, 15:36, Wander Lairson Costa wrote:
> The serial driver set the value of uart_8250_port.fcr in the function
> serial8250_config_port, but only writes the value to the controller
> register later in the initalization code.
> 
> That opens a small window in which is not safe to use the fifo for
> console write.
> 
> Make sure the port is initialized correctly before reading the FCR
> cached value.
> 
> Unfortunately, I lost track of who originally reported the issue. If
> s/he is reading this, please speak up so I can give you the due credit.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>   drivers/tty/serial/8250/8250_port.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 4acf620be241..7e2227161555 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3416,6 +3416,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>   		!(up->capabilities & UART_CAP_MINI) &&
>   		up->tx_loadsz > 1 &&
>   		(up->fcr & UART_FCR_ENABLE_FIFO) &&
> +		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&

Cannot be port->state be NULL sometimes here?

>   		/*
>   		 * After we put a data in the fifo, the controller will send
>   		 * it regardless of the CTS state. Therefore, only use fifo


-- 
js
suse labs
