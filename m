Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D119C5A5C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiH3Gp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiH3Gpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:45:53 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903182317A;
        Mon, 29 Aug 2022 23:45:52 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id nc14so15224654ejc.4;
        Mon, 29 Aug 2022 23:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+OZpuLhh8hWqKNGZJp0lYNoL06o9pq04W9l8IHLxggE=;
        b=oXJlMPncQ/22vcAnUKM5NJ5tI6XMe9kNhjO+nol+lMWo7aqCGbpfk+FUKIOH8i3uE/
         AFe1pXioG9JTC4PS/dXeGbt98GqbxLtMhUozVhPj8QPZRmIOm8Kli4vWrgyAKtBaWeof
         YxcirFnkhlE3+bsj5WUStAsD6lE0LN/ovsNMA7lIBaJQTaFQznnia4xREwbD0q6FeqbB
         LQg0Sib2pfJ0TR2qmznXYOdGcYxJi4wBD0/Xldt5Ashvk7F/pNqBNMF/jFmhuqFE6PLX
         DxYS/5C07rwY8Hkbmt9PQIvGuiI6hn4sO8qE9NMXT+tJMyj5sbLKC8ZbWtLFN+bEo8xx
         NQuA==
X-Gm-Message-State: ACgBeo0hk+SyDaD0hmK+RKOoT2ZKaIjYYthvJl4ltmo6uL1QlZcrr97t
        64Ld5/vUEggInTGMVjXCzRA=
X-Google-Smtp-Source: AA6agR4SUNMHSWC+ymRyrGrtm3M4dmsRjIgzoUCEDP33nu3mirxlGYIKov3OouXFV+iXXkIeUN0SIQ==
X-Received: by 2002:a17:907:7214:b0:731:465d:a77c with SMTP id dr20-20020a170907721400b00731465da77cmr15448829ejc.308.1661841951157;
        Mon, 29 Aug 2022 23:45:51 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b0073dc897e040sm5381456ejg.51.2022.08.29.23.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:45:50 -0700 (PDT)
Message-ID: <b8b99c89-0feb-5abd-59dd-851e8f0f19d2@kernel.org>
Date:   Tue, 30 Aug 2022 08:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] serial: sh-sci: CIRC_CNT_TO_END() is enough
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
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

On 23. 08. 22, 16:18, Ilpo Järvinen wrote:
> Testing also CIRC_CNT() with CIRC_CNT_TO_END() is unnecessary because
> to latter alone covers all necessary cases.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/sh-sci.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 0075a1420005..6d2f5a08ff1f 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1408,9 +1408,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>   	head = xmit->head;
>   	tail = xmit->tail;
>   	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
> -	s->tx_dma_len = min_t(unsigned int,
> -		CIRC_CNT(head, tail, UART_XMIT_SIZE),
> -		CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
> +	s->tx_dma_len = CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE);
>   	if (!s->tx_dma_len) {
>   		/* Transmit buffer has been flushed */
>   		spin_unlock_irq(&port->lock);

-- 
js
suse labs

