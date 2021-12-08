Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D346CE4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbhLHHY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:24:57 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43661 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbhLHHY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:24:56 -0500
Received: by mail-ed1-f41.google.com with SMTP id o20so5112025eds.10;
        Tue, 07 Dec 2021 23:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IVmLYGB580r43pIj6dV5gG4FJJTbCh6v3cE+UdalM8g=;
        b=V+ZuzsKZEYay3290CLvbE8E3DPhw3suzxYOxk8yY8+cQ+YEvMkJcVfEkns/CGnjTsL
         mymMtJtpCL9wcgJzwJ+a4Hl5NFr0jfeXSZMCMA9c8YGF/HAWYf1bYY7JKBLP25iGcxM7
         6R6kBXpRR8qe5k8l7BThhfLYUkx0N8BHWjXdpKG3a/+w0K50s4gEyb1+31BFVVNsq5cL
         aEBF07xBtUmx42xsgjDbtHbXyQ33CoZLr2v3Is+wvzXlD8cZueolVLm8rmcF9GjWzp9f
         vAAEiXhA7orjE398jDemG/dHrpYTfLHjcwZCDdEiK4u9L4j4sJsW/Vf4WRMlb9UCHKht
         0r/g==
X-Gm-Message-State: AOAM5322OeBmdoLIhZ9zu0o/6+MXjpb3nLAuG9BLvkMyzeiIXF2mRFkz
        UihkfMxia1z9IlB6dNyzN38zSCR3fXA=
X-Google-Smtp-Source: ABdhPJwrsPsBiVxoQtOIxXjMD4bQl982DZszilVOz/NRX5HWAILpBe4AQyF1a14sEt/I/MGnQKZqZA==
X-Received: by 2002:a17:907:ea5:: with SMTP id ho37mr5703164ejc.133.1638948083697;
        Tue, 07 Dec 2021 23:21:23 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id jg32sm1056775ejc.43.2021.12.07.23.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 23:21:23 -0800 (PST)
Message-ID: <7fd033ff-d1a5-9f1c-d8b9-5f51d63697fd@kernel.org>
Date:   Wed, 8 Dec 2021 08:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] tty: serial: fsl_lpuart: add timeout for
 wait_event_interruptible in .shutdown()
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20211203030441.22873-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211203030441.22873-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03. 12. 21, 4:04, Sherry Sun wrote:
> Use wait_event_interruptible in lpuart_dma_shutdown isn't a reasonable
> behavior, since it may cause the system hang here if the condition

Wait, _interruptible causes hangs? Under what circumstances?

> !sport->dma_tx_in_progress never to be true in some corner case, such as
> when enable the flow control, the dma tx request may never be completed
> due to the peer's CTS setting when run .shutdown().
> 
> So here change to use wait_event_interruptible_timeout instead of
> wait_event_interruptible, the tx dma will be forcibly terminated if the
> tx dma request cannot be completed within 300ms.
> Considering the worst tx dma case is to have a 4K bytes tx buffer, which
> would require about 300ms to complete when the baudrate is 115200.

300 looks like a magic number -- what if the rate is < 115200? Why not 
using port->timeout?

Anyway, in what scenario is this a problem? Both lpuart*_tx_empty() do:
if (sport->dma_tx_in_progress)
         return 0;

So wait_until_sent() should have waited for long enough already.

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> changes in V2
> 1. Increase the timeout to 300ms, need to consider the worst tx dma case.
> ---
>   drivers/tty/serial/fsl_lpuart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index ac5112def40d..3affe52a364d 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1793,8 +1793,8 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
>   	}
>   
>   	if (sport->lpuart_dma_tx_use) {
> -		if (wait_event_interruptible(sport->dma_wait,
> -			!sport->dma_tx_in_progress) != false) {
> +		if (wait_event_interruptible_timeout(sport->dma_wait,
> +			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <= 0) {
>   			sport->dma_tx_in_progress = false;
>   			dmaengine_terminate_all(sport->dma_tx_chan);
>   		}
> 


-- 
js
suse labs
