Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2244B632E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiBOFzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:55:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBOFzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:55:50 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC738F9BD;
        Mon, 14 Feb 2022 21:55:41 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a8so41914453ejc.8;
        Mon, 14 Feb 2022 21:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gp8ebT5rOJ2rAFinWwNQFlP6FSvniebTOjl8cmXAgEY=;
        b=EsphDjdXfTtnyNS4Txc3RCr02CfJNaPcTwSMUFPtvY9J0nwJ7WXfLF+/hpFFMfYbfS
         btGk/CJg5Zdl5eYyToNZFgjJEL5LjvLAQePsXxWxQj6nb7+q7YOcj8Cov9w4aI9i+95n
         3tmuMm5SwffXKz1i05mUJnPzvDpqWicvhxwQxJu1LkdRDVE+Yy02ObHlBeRXKfDuwrfR
         KKKS0oI+4MA8R19Aq1F6XQT+mU75Wb4pI1jpYU8kjsjwLOcifs7eaaG/r37S+NfjTd7W
         D2E6jr/5jyogTaBc/v9LgIzcHqRn0om/nC6RpIdqVjHF09c1U4tMp9Zm53uXHy75Pf7+
         Asbg==
X-Gm-Message-State: AOAM533WOMUYj/1n6j/aq6wymuzox7layOQmOn94qgd39CZ2tgzfwMcH
        Gnv49v3NYgtrayhwDsBtSoEwfedzRws=
X-Google-Smtp-Source: ABdhPJyrPL/Y79/an13ElJxSImi+bGwiinWqWkElWMGy55bQXJVKYjwB12opX7WttphtP3ne6+pdXA==
X-Received: by 2002:a17:907:16a8:: with SMTP id hc40mr1617582ejc.739.1644904539831;
        Mon, 14 Feb 2022 21:55:39 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p16sm6035084ejn.54.2022.02.14.21.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 21:55:39 -0800 (PST)
Message-ID: <67ace5d3-02b3-034d-969f-9a05bbdd8e30@kernel.org>
Date:   Tue, 15 Feb 2022 06:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] tty: serial: 8250: add missing pci_dev_put() before
 return
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644890454-65258-1-git-send-email-wangqing@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1644890454-65258-1-git-send-email-wangqing@vivo.com>
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

On 15. 02. 22, 3:00, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> pci_get_slot() increases its reference count, the caller must
> decrement the reference count by calling pci_dev_put()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>   drivers/tty/serial/8250/8250_lpss.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index d3bafec..57e462f
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -149,6 +149,8 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>   	/* Disable TX counter interrupts */
>   	writel(BYT_TX_OVF_INT_MASK, port->membase + BYT_TX_OVF_INT);
>   
> +	pci_dev_put(dma_dev);


What about the "return -ENODEV" few lines above?

>   	return 0;
>   }
>   


-- 
js
suse labs
