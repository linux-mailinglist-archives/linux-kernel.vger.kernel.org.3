Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE555A5CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiH3HbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiH3Hah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:30:37 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB86F243
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:30:30 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id z2so13038200edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=D0ZDbdxbbQ5HDlih+lQz8/f9S3Kh2+eOoZWA4GaC/og=;
        b=JREkfywxW1W5aQ08aXz6AuKXniElW7oFe3crKhCXKjlhfQrsLwFCjlGvgmvmfNAToF
         Smt0VI9qoaJVPZMI63mdiwGLGZTbxfbWYBTzbaycczCom4NqPJl9SF8BCMqfdrt8jiyD
         /uRCixIwncWqoaUCNwI5KNrLWK0PCub0s2ZUyVSFP9Eibo9/xtwyrkuz7OVmFya/PrnW
         yOSI9D6m2tgTbpYUWEcONc33Djso5fyxHtn6MvL6aBDnj5m0vNOwWlOlC4EJ7ajk04+7
         VjlNK8MTG6tE8Ee2SplT2dSofYfKbvq/glO6Kwok2YPYXpfQlJe+dcgEkPggpsGrbTlL
         9kJw==
X-Gm-Message-State: ACgBeo3WT50n05ezxC4g9oyx3GboTHdxBKQ4M/JWjZExR2ZR+i2x0OUV
        d5X3pd1Kcc0tG5OxEA/GUR4=
X-Google-Smtp-Source: AA6agR7Pn+7xqzUD08Lxpn1rYHvNKHgRd+60bOpwAfm22nimKP91uo5onPnx733eETVuyfZ6Dp2TfA==
X-Received: by 2002:a05:6402:530c:b0:43b:c6bf:a496 with SMTP id eo12-20020a056402530c00b0043bc6bfa496mr2101631edb.282.1661844628931;
        Tue, 30 Aug 2022 00:30:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id bc17-20020a056402205100b00445e1489313sm6722960edb.94.2022.08.30.00.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:30:28 -0700 (PDT)
Message-ID: <46019fb5-dcc1-f0df-4043-e25e6db3c226@kernel.org>
Date:   Tue, 30 Aug 2022 09:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] tty: n_gsm: replace kicktimer with delayed_work
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, Hillf Danton <hdanton@sina.com>
References: <20220829131640.69254-1-pchelkin@ispras.ru>
 <20220829131640.69254-2-pchelkin@ispras.ru>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220829131640.69254-2-pchelkin@ispras.ru>
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

On 29. 08. 22, 15:16, Fedor Pchelkin wrote:
> A kick_timer timer_list is replaced with kick_timeout delayed_work to be
> able to synchronize with mutexes as a prerequisite for the introduction
> of tx_mutex.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

But I think this conflicts with Tetsuo's cleanup [1]. So one of you will 
likely have to rebase and resubmit.

[1] 
https://lore.kernel.org/all/2110618e-57f0-c1ce-b2ad-b6cacef3f60e@I-love.SAKURA.ne.jp/

> Fixes: c568f7086c6e ("tty: n_gsm: fix missing timer to handle stalled links")
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> v1->v2: sorry, now adapted patch from 5.10 to upstream
> v2->v3: replaced a kick_timer with a delayed_work
> v3->v4: separated kick_timer and tx_mutex into different patches
> 
>   drivers/tty/n_gsm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index caa5c14ed57f..c4164c85ffd4 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -256,7 +256,7 @@ struct gsm_mux {
>   	struct list_head tx_data_list;	/* Pending data packets */
>   
>   	/* Control messages */
> -	struct timer_list kick_timer;	/* Kick TX queuing on timeout */
> +	struct delayed_work kick_timeout;	/* Kick TX queuing on timeout */
>   	struct timer_list t2_timer;	/* Retransmit timer for commands */
>   	int cretries;			/* Command retry counter */
>   	struct gsm_control *pending_cmd;/* Our current pending command */
> @@ -1009,7 +1009,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>   	gsm->tx_bytes += msg->len;
>   
>   	gsmld_write_trigger(gsm);
> -	mod_timer(&gsm->kick_timer, jiffies + 10 * gsm->t1 * HZ / 100);
> +	schedule_delayed_work(&gsm->kick_timeout, 10 * gsm->t1 * HZ / 100);
>   }
>   
>   /**
> @@ -1984,16 +1984,16 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
>   }
>   
>   /**
> - *	gsm_kick_timer	-	transmit if possible
> - *	@t: timer contained in our gsm object
> + *	gsm_kick_timeout	-	transmit if possible
> + *	@work: work contained in our gsm object
>    *
>    *	Transmit data from DLCIs if the queue is empty. We can't rely on
>    *	a tty wakeup except when we filled the pipe so we need to fire off
>    *	new data ourselves in other cases.
>    */
> -static void gsm_kick_timer(struct timer_list *t)
> +static void gsm_kick_timeout(struct work_struct *work)
>   {
> -	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
> +	struct gsm_mux *gsm = container_of(work, struct gsm_mux, kick_timeout.work);
>   	unsigned long flags;
>   	int sent = 0;
>   
> @@ -2458,7 +2458,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
>   	}
>   
>   	/* Finish outstanding timers, making sure they are done */
> -	del_timer_sync(&gsm->kick_timer);
> +	cancel_delayed_work_sync(&gsm->kick_timeout);
>   	del_timer_sync(&gsm->t2_timer);
>   
>   	/* Finish writing to ldisc */
> @@ -2501,7 +2501,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>   	if (dlci == NULL)
>   		return -ENOMEM;
>   
> -	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
> +	INIT_DELAYED_WORK(&gsm->kick_timeout, gsm_kick_timeout);
>   	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
>   	INIT_WORK(&gsm->tx_work, gsmld_write_task);
>   	init_waitqueue_head(&gsm->event);
> @@ -2946,7 +2946,7 @@ static int gsmld_open(struct tty_struct *tty)
>   
>   	gsmld_attach_gsm(tty, gsm);
>   
> -	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
> +	INIT_DELAYED_WORK(&gsm->kick_timeout, gsm_kick_timeout);
>   	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
>   	INIT_WORK(&gsm->tx_work, gsmld_write_task);
>   

-- 
js
suse labs

