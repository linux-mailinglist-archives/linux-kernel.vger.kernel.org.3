Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8A51FA00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiEIKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiEIKgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:36:15 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7986D200F52;
        Mon,  9 May 2022 03:32:21 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id b19so18770489wrh.11;
        Mon, 09 May 2022 03:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2sYDLhBqgK1eJ+0rBvVHI+WzqwEFLfQswJVDMagdYSQ=;
        b=HYNcmJ8Edd8pMk5ofM5OCaHGFvtJ/vFBox8A9Aq1O7P/D4QfZl8aGNQ5CbNkqvw6xi
         C1zjLKYhcVeC/vMX2h6mh55PsUhkhyQuhm3P18bcW6tCVw+XQMuWHHqEnOcTH79Yl3rS
         Jr8lO3O7P7wf+K/WxNbiIMi/a4of+11M3aCGD5KajbprFISmpv5UfjY51RJNZuN9a/ss
         2Mu8NbwoTQU3yjjrUeoSPOdbtU/grfmX1stgUjAnIYAis51VHa5/sSDo/frygQdusrMl
         8eYUB4YWIz8zftfWogr0CvyFRAg0FhTR9kWhLICTDDHfcK9Hr087hPUCl0SLPmMYycj0
         aEHA==
X-Gm-Message-State: AOAM533vyyVfjHLjsCRJEt718aikH2xtM6+nEuX7fKP5D4Nhl09/ipk3
        9PjbLkgEzhguw8ILB8ntqbfEB/d0eOLFSg==
X-Google-Smtp-Source: ABdhPJwBbEjldU3ovsXYo5ZFog5JJGQdbFcO1n50ahxbCUJLiYFrBoenDbdWAdsQ1Lw2D5uf/b/Pnw==
X-Received: by 2002:a5d:4045:0:b0:20a:cac6:d33d with SMTP id w5-20020a5d4045000000b0020acac6d33dmr13782215wrp.657.1652092315717;
        Mon, 09 May 2022 03:31:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600016c300b0020c5253d8cesm10356372wrf.26.2022.05.09.03.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:31:55 -0700 (PDT)
Message-ID: <f55e96d0-6683-0aef-4d4c-5c635e85aabd@kernel.org>
Date:   Mon, 9 May 2022 12:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] tty: n_gsm: fix invalid gsmtty_write_room() result
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220504081733.3494-1-daniel.starke@siemens.com>
 <20220504081733.3494-3-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220504081733.3494-3-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 05. 22, 10:17, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> gsmtty_write() does not prevent the user to use the full fifo size of 4096
> bytes as allocated in gsm_dlci_alloc(). However, gsmtty_write_room() tries
> to limit the return value by 'TX_SIZE' and returns a negative value if the
> fifo has more than 'TX_SIZE' bytes stored. This is obviously wrong as
> 'TX_SIZE' is defined as 512.
> Define 'TX_SIZE' to the fifo size and use it accordingly for allocation to
> keep the current behavior. Return the correct remaining size of the fifo in
> gsmtty_write_room() via kfifo_avail().

Right.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index bcb714031d69..fd8b86dde525 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -137,6 +137,7 @@ struct gsm_dlci {
>   	int retries;
>   	/* Uplink tty if active */
>   	struct tty_port port;	/* The tty bound to this DLCI if there is one */
> +#define TX_SIZE		4096    /* Must be power of 2. */

Only that I'd not put the macro definition here. But outside the structure.

>   	struct kfifo fifo;	/* Queue fifo for the DLCI */
>   	int adaption;		/* Adaption layer in use */
>   	int prev_adaption;
> @@ -1731,7 +1732,7 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
>   		return NULL;
>   	spin_lock_init(&dlci->lock);
>   	mutex_init(&dlci->mutex);
> -	if (kfifo_alloc(&dlci->fifo, 4096, GFP_KERNEL) < 0) {
> +	if (kfifo_alloc(&dlci->fifo, TX_SIZE, GFP_KERNEL) < 0) {
>   		kfree(dlci);
>   		return NULL;
>   	}
> @@ -2976,8 +2977,6 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
>    *	Virtual tty side
>    */
>   
> -#define TX_SIZE		512
> -
>   /**
>    *	gsm_modem_upd_via_data	-	send modem bits via convergence layer
>    *	@dlci: channel
> @@ -3217,7 +3216,7 @@ static unsigned int gsmtty_write_room(struct tty_struct *tty)
>   	struct gsm_dlci *dlci = tty->driver_data;
>   	if (dlci->state == DLCI_CLOSED)
>   		return 0;
> -	return TX_SIZE - kfifo_len(&dlci->fifo);
> +	return kfifo_avail(&dlci->fifo);
>   }
>   
>   static unsigned int gsmtty_chars_in_buffer(struct tty_struct *tty)


-- 
js
suse labs
