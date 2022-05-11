Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B1522C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbiEKGVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiEKGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:21:40 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9262CFE
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:21:39 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id s15so144478wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2tlDJgz+9usXh4sQZsnAN1uNQ0keJ/ax9odH+Zqwp9k=;
        b=VRNR9lIhuqNjhvqgrcNBuEE6+eh4uHKDUM1BuQEmPgSkMb+2sJcaJ3mcINjHC/ZyZ0
         bKBYVSBD0Bn9naU+8fzaQK5MTAKTodzRx17Vlt1csSSBJ9kCyDTmsxEI8hfSkZ9W+d6T
         moqAR5ZsBUUAKfTtxH6vHINwhQXQNuz5vpf++hSJzHN3dwwbNkQk3Cw45nfrDs81b08M
         8VhZI4EJ/u2Zjv1s0S4xk/5ZNlJuzpOnlLvAYFxd4aj0ICAiIeZuqDl4bfOEVYEp/S2e
         XWc53hPDnsBqrTvpBarlWKDa2TpyETeMbr1RwW5GYL12B/GbEbjgdoetSE3FHjB9E/N1
         04KA==
X-Gm-Message-State: AOAM531I+7+dypmIIH4AoBKPUYX+hUPpxoF1jcOM51rPQf5yLEapRG4v
        N2k3TJUfSXI3HCAEWqYRiMoKI8rgYsU8rQ==
X-Google-Smtp-Source: ABdhPJy5ea8xWcMx7HfM5sXuIOMVnOH1XmWWgMyusbuDHUymramjidV1PIpllGz92tW/l9F3QIzq2w==
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id g9-20020adfd1e9000000b0020c6c7614d5mr21793303wrd.375.1652250097877;
        Tue, 10 May 2022 23:21:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v124-20020a1cac82000000b003946433a829sm1154560wme.11.2022.05.10.23.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:21:37 -0700 (PDT)
Message-ID: <91c006d0-c6ff-71fa-f0c3-22cf1896fc02@kernel.org>
Date:   Wed, 11 May 2022 08:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tty: Remove pointless synchronize_irq() in
 uart_port_shutdown()
Content-Language: en-US
To:     Thomas Pfaff <tpfaff@pcs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <4fe2d4a1-fc6a-c7fa-d884-5ebd01bebd3@pcs.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <4fe2d4a1-fc6a-c7fa-d884-5ebd01bebd3@pcs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 05. 22, 15:54, Thomas Pfaff wrote:
> From: Thomas Pfaff <tpfaff@pcs.com>
> 
> Calling synchronize_irq() after free_irq() is pointless, the context to
> the irq is already lost.
> It was noticed while creating the bugfix "genirq: Synchronize interrupt
> thread startup".

That's correct for most drivers. But some drivers don't call free_irq() 
in ->shutdown(). So you likely have to move the synchronization to them. 
By a quick grep, I found icom, jsm, sccnxp, sifive, sunhv, and sunzilog.

> Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
> ---
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57840cf90388..b76e76e650ba 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1704,12 +1704,6 @@ static void uart_port_shutdown(struct tty_port *port)
>   	 */
>   	if (uport)
>   		uport->ops->shutdown(uport);
> -
> -	/*
> -	 * Ensure that the IRQ handler isn't running on another CPU.
> -	 */
> -	if (uport)
> -		synchronize_irq(uport->irq);
>   }
>   
>   static int uart_carrier_raised(struct tty_port *port)
> 
> 


-- 
js
suse labs
