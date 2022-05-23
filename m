Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CBC5310B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiEWLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiEWLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:50:01 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829350B01;
        Mon, 23 May 2022 04:50:00 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id p19so141649wmg.2;
        Mon, 23 May 2022 04:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N1nlHpQGkhpETBLn7DVnm9aoYftb8hDcQhD93W5TBWw=;
        b=FjCqNFcXqjwYndyKIDczXYNqvFa2gc27ypaDAK4pcg/9mjrowCYm5mcQVxZ+9Dw09B
         8H/diQlaQRtmQ0P6/eHFZmJjQqzIj0eYhpH5cAM2HIh/6MN2PMLuZRprwolIY83eJe5P
         grcr9lSj78ZOJhBrd+0i2CxuS+zqhB3OwKk19emv51IgnXKqDB0HQZM1bvpYFyuoZqL6
         r+YaaoDpW/bbpE1nyUA8sa5j704O1asKg0YKBTQnt6OX3I2fiqJLF+QNc1sUwvxrEJ4e
         lgH5rRkB08eynMQFxVPC0UzgsXQOjstt0dKFOFxwIbXd/wiIDGPMvCvpZU4Sw5s/+76H
         vLbA==
X-Gm-Message-State: AOAM530SfrYL6P3EGtYDcjFzSg/x2hM29/ZJcqsxFer3556aR4On3j/T
        6uCi9KglkOczRK2X9O1I3GsiRzFOQpFAbQ==
X-Google-Smtp-Source: ABdhPJyQGxBLy/Dwu8qGc5oJh/OwtIfA+usO3RQysMcGbs8WKFYLQmL+BkSYN+ddbEnkYS9MJkqGpg==
X-Received: by 2002:a7b:c242:0:b0:397:43cd:8095 with SMTP id b2-20020a7bc242000000b0039743cd8095mr9240429wmj.174.1653306599326;
        Mon, 23 May 2022 04:49:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d21-20020adfa415000000b0020cd8f1d25csm9937431wra.8.2022.05.23.04.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 04:49:58 -0700 (PDT)
Message-ID: <999ae7a0-4699-17be-8045-af856237f133@kernel.org>
Date:   Mon, 23 May 2022 13:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/9] tty: n_gsm: fix missing timer to handle stalled
 links
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220519070757.2096-1-daniel.starke@siemens.com>
 <20220519070757.2096-4-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220519070757.2096-4-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 05. 22, 9:07, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The current implementation does not handle the situation that no data is in
> the internal queue and needs to be sent out while the user tty fifo is
> full.
> Add a timer that moves more data from user tty down to the internal queue
> which is then serialized on the ldisc. This timer is triggered if no data
> was moved from a user tty to the internal queue within 10 * T1.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 43 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> See patch 6 regarding changes since to v1.
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 0a9924445968..3a4a2394d970 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
...
> @@ -833,6 +834,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>   	list_add_tail(&msg->list, &gsm->tx_list);
>   	gsm->tx_bytes += msg->len;
>   	gsm_data_kick(gsm, dlci);
> +	mod_timer(&gsm->kick_timer, jiffies + 10 * gsm->t1 * HZ / 100);

The formula deserves an explanation. And why 10 * X / 100, and not X / 10?

> @@ -1062,9 +1058,9 @@ static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
>    *	renegotiate DLCI priorities with optional stuff. Needs optimising.
>    */
>   
> -static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
> +static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
>   {
> -	int len;
> +	int len, ret = 0;

Why is ret signed?

>   	/* Priority ordering: We should do priority with RR of the groups */
>   	int i = 1;
>   
> @@ -1087,7 +1083,11 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
>   		/* DLCI empty - try the next */
>   		if (len == 0)
>   			i++;
> +		else
> +			ret++;
>   	}
> +
> +	return ret;
>   }
>   
>   /**

thanks,
-- 
js
suse labs
