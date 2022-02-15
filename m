Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD94B68EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiBOKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:11:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiBOKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:11:53 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5656E4D8;
        Tue, 15 Feb 2022 02:11:44 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id w2so12536171edc.8;
        Tue, 15 Feb 2022 02:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cKQXKyaFZ5kuu1GMgfND0ggs03Lr5z/PMoX+zi4JYlY=;
        b=Sj6m85QT+HhlgReHDvDFautuFXtTgD+6aIudyP9znIR++OWXqWOr8smRBlmoeWvu5t
         WCtaXD3aS73hAMm9kScBszddE06tNTG+tlCVIVlMnzqsTMgZkQahRv8pLB1v5vO7sQXV
         //SQsh1gmhf/AnDvWCsSq5uJtkfv8xVLy69gVN0lepQ9w4EUbDN8LAWJV8PaKoczoF5a
         W5c1TLSjMCFlg4B9YnngsXiL3AdVkGIHWmN2n/6K+uZne8V0IaE4rfG71Aervz15u0aD
         e+Nex0z1Ol0pJ4V+zDzMG1EB8bw0NjzuFJnQkbtvfIJtXSwmNTqWSLDP82bGjMlozZNa
         DEhA==
X-Gm-Message-State: AOAM533OUWGmscx/4tz2a/VXON+uFsFvBgXMEwJtL3Zmz133jp9VTRH+
        rnVmYB11uHWyjmO3MjiStdM=
X-Google-Smtp-Source: ABdhPJwO1Rq3s9uIHAB2p/5amRbesGSASP5c0ln4yMfqEjLyiYGzsLu5YWIKTDrLZ2b3KRwJ00/LxA==
X-Received: by 2002:a50:d5cd:: with SMTP id g13mr3098975edj.268.1644919902724;
        Tue, 15 Feb 2022 02:11:42 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y16sm8747049ejd.72.2022.02.15.02.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 02:11:42 -0800 (PST)
Message-ID: <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
Date:   Tue, 15 Feb 2022 11:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] serial: 8250_mid: Balance reference count for PCI
 DMA device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qing Wang <wangqing@vivo.com>
References: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
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

On 15. 02. 22, 11:09, Andy Shevchenko wrote:
> The pci_get_slot() increases its reference count, the caller
> must decrement the reference count by calling pci_dev_put().

And what about the -EINVAL case?

> Fixes: 90b9aacf912a ("serial: 8250_pci: add Intel Tangier support")
> Fixes: f549e94effa1 ("serial: 8250_pci: add Intel Penwell ports")
> Depends-on: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its own driver")
> Reported-by: Qing Wang <wangqing@vivo.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_mid.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
> index efa0515139f8..e6c1791609dd 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c
> @@ -73,6 +73,11 @@ static int pnw_setup(struct mid8250 *mid, struct uart_port *p)
>   	return 0;
>   }
>   
> +static void pnw_exit(struct mid8250 *mid)
> +{
> +	pci_dev_put(mid->dma_dev);
> +}
> +
>   static int tng_handle_irq(struct uart_port *p)
>   {
>   	struct mid8250 *mid = p->private_data;
> @@ -124,6 +129,11 @@ static int tng_setup(struct mid8250 *mid, struct uart_port *p)
>   	return 0;
>   }
>   
> +static void tng_exit(struct mid8250 *mid)
> +{
> +	pci_dev_put(mid->dma_dev);
> +}
> +
>   static int dnv_handle_irq(struct uart_port *p)
>   {
>   	struct mid8250 *mid = p->private_data;
> @@ -330,9 +340,9 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	pci_set_drvdata(pdev, mid);
>   	return 0;
> +
>   err:
> -	if (mid->board->exit)
> -		mid->board->exit(mid);
> +	mid->board->exit(mid);
>   	return ret;
>   }
>   
> @@ -342,8 +352,7 @@ static void mid8250_remove(struct pci_dev *pdev)
>   
>   	serial8250_unregister_port(mid->line);
>   
> -	if (mid->board->exit)
> -		mid->board->exit(mid);
> +	mid->board->exit(mid);
>   }
>   
>   static const struct mid8250_board pnw_board = {
> @@ -351,6 +360,7 @@ static const struct mid8250_board pnw_board = {
>   	.freq = 50000000,
>   	.base_baud = 115200,
>   	.setup = pnw_setup,
> +	.exit = pnw_exit,
>   };
>   
>   static const struct mid8250_board tng_board = {
> @@ -358,6 +368,7 @@ static const struct mid8250_board tng_board = {
>   	.freq = 38400000,
>   	.base_baud = 1843200,
>   	.setup = tng_setup,
> +	.exit = tng_exit,
>   };
>   
>   static const struct mid8250_board dnv_board = {


-- 
js
suse labs
