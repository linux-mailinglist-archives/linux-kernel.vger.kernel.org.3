Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD5564DC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiGDGkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGDGkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:40:09 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E251265F;
        Sun,  3 Jul 2022 23:40:08 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id h23so14907855ejj.12;
        Sun, 03 Jul 2022 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B/wRitQyZlFvkStkqCHaB8oKHN1RIFGsWN/eGD+ncfY=;
        b=1+ODjNl6XKSj/Xin0p+i1FMq/8NVSTU2N2nWbjSrsSfCizArW4vwUEI3MrAsmIueWX
         k9Kf1UkYlFkO/AC2cEoY7dAcex0BY8MVjcAK21NUfWvK75xvuMyIFePSPYZezwTbs5F9
         s68bBPyn8Pxb7pIfACYRKRVjYqmIYTGSRRZjtXiu76AgG4SvdAK3Ais72fYJmHonIACo
         o7C35KJ/8FjwFda25h9typw5u65SbPl2Jd0xNhWCiJvH9FdJkL+3HxVLAlDuaCSqOjic
         Vz7GC8xFGCUvS8BlwMBE+6RlMuPIjdwoF7GI0HSZdsUI545wCUJRXSUTsgyQWb4GcB7u
         mBpA==
X-Gm-Message-State: AJIora82O+q4dcLc63BRlTDSQvnXhuowNpH0yl7zDcxsLA5Yqy26RilR
        GbmLDEvMDfJ9BsbAgzcF+rE=
X-Google-Smtp-Source: AGRyM1sysPXg2Jas7Q+gCFiElgkWow1koIHrJh5jA1C276gBjw157Qhxd9Zn4F+hG8+LIrncbJJkRA==
X-Received: by 2002:a17:906:8a74:b0:72a:9098:9a15 with SMTP id hy20-20020a1709068a7400b0072a90989a15mr15077646ejc.679.1656916806783;
        Sun, 03 Jul 2022 23:40:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906698a00b00705fa7087bbsm13960423ejr.142.2022.07.03.23.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 23:40:06 -0700 (PDT)
Message-ID: <a7104148-2c11-8235-9282-5731639316f5@kernel.org>
Date:   Mon, 4 Jul 2022 08:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] serial: 8250_bcm7271: Save/restore RTS in
 suspend/resume
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220629160208.3167955-1-f.fainelli@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220629160208.3167955-1-f.fainelli@gmail.com>
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

On 29. 06. 22, 18:02, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> Commit 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming
> from S2") prevented an early enabling of RTS during resume, but it did
> not actively restore the RTS state after resume.
> 
> Fixes: 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming from S2")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_bcm7271.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index 9b878d023dac..b9cea38c8aff 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
...
> @@ -1180,7 +1184,15 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
>   		start_rx_dma(serial8250_get_port(priv->line));
>   	}
>   	serial8250_resume_port(priv->line);
> -	port->mctrl = priv->saved_mctrl;
> +
> +	if (priv->saved_mctrl & TIOCM_RTS) {
> +		/* Restore RTS */
> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl |= TIOCM_RTS;
> +		spin_unlock_irqrestore(&port->lock, flags);
> +		port->ops->set_mctrl(port, port->mctrl);

Calling ->set_mctrl w/o port->lock doesn't look really safe.

regards,
-- 
js
suse labs
