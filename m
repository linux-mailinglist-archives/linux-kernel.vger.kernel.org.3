Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BDD5A5C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiH3GqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiH3GqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:46:05 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C152A241;
        Mon, 29 Aug 2022 23:46:04 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id fy31so19729020ejc.6;
        Mon, 29 Aug 2022 23:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BpRfN1pSgxiJKfxO+ukvt+8fBJYSg5yrpFeqfi+28Qw=;
        b=MsBLz4fm35QZxPEUJ2yfAX9y6G1gqBtjUB1c/0w/Vtc7FevEn1WotBNqfoCGJeVI6O
         6/VQNRsbprVO019Q4nqSwgyyTrSj3MgOo19Tbx64FMXKTKoi8SdLZBJu92vD28FB8T00
         Qy5qWQTYy5ShmPe/F63/wSCK5TYsn/c8GvyIylH3sPxP0jFyI8KNGUV/vXot/TKEy9Ue
         uy0ybUKZyIhasQDC03ukciP8+/Fr5jk/2aDd0vVDtBZ+XI4skKbxKpTYQr9BS4LSXoHk
         BKVI+sqvOc5m8k59sTEYRRDn80fqV6l2FSF1uRZ2vi/xgTzhtmvdMvIG3jLPDGyJoqwb
         rlrg==
X-Gm-Message-State: ACgBeo3eVUeFRdXNQ2Ib+PDVYdeW1S4BUjdYgEOZN7vnX1QvRxDUiw9p
        Pc/fd1qoP/52slS/bAryu1JA3IGyaH0f3w==
X-Google-Smtp-Source: AA6agR4IhXo8yyGUSf5krohGI1XhZz0WHySDTZoY/P4bCe7OyOnCORb4PUFJFFPu0e+S1Tt7ildtZw==
X-Received: by 2002:a17:907:1ca9:b0:741:4f9a:5984 with SMTP id nb41-20020a1709071ca900b007414f9a5984mr8825205ejc.86.1661841962418;
        Mon, 29 Aug 2022 23:46:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i25-20020a50fd19000000b00447d4109e16sm5696026eds.87.2022.08.29.23.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:46:02 -0700 (PDT)
Message-ID: <4696090f-d459-61dc-1707-3a17760406c9@kernel.org>
Date:   Tue, 30 Aug 2022 08:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/3] serial: sh-sci: tail is already on valid range
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
 <20220823141839.165244-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823141839.165244-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 23. 08. 22, 16:18, Ilpo Järvinen wrote:
> There is no need to and tail with UART_XMIT_SIZE - 1 because tail is
> already on valid range.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/sh-sci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 6d2f5a08ff1f..2ddcd7eec71e 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1407,7 +1407,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>   	spin_lock_irq(&port->lock);
>   	head = xmit->head;
>   	tail = xmit->tail;
> -	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
> +	buf = s->tx_dma_addr + tail;
>   	s->tx_dma_len = CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE);
>   	if (!s->tx_dma_len) {
>   		/* Transmit buffer has been flushed */

-- 
js
suse labs

