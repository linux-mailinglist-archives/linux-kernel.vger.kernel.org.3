Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71435A4377
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiH2G7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2G7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:59:35 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E802124E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:59:34 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id og21so13825525ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=d0XLGL5mfncbPh3lhzLMsvGwbv0FlnsgLNAmMGSW4d4=;
        b=bJtLBYyYDnLuguAy6LSO1Spvv836TnDC3U7IsKgoqSetAsi3jVEX+pqgzvBfD13NuP
         xO+L5Ii9BMCKaG8UDlA0lb01jSTMwxSQHkyJuU7YaVCBZ7Qv/aoAfgp2tVNJ8JL50z8S
         zzRNLJIUdu362n0hzuACvlMWXhI9xy/toZCUThFgr9xjLataIU++NLh8kONTJif33s+G
         btoj/0Hpi6cWCGqVppzyemgj9VM80vy5jUqgsgE/5FrDIAeaGDh2HqqK2eriwQRbIiZ+
         sAsZVBgV++ZUDJ8sfCIpt4AARUD3WXa8qJFZSWI20X0ox2mg3q4iP8mBxAyXYLJk3tn4
         fI2w==
X-Gm-Message-State: ACgBeo1Fsw9fproxsI65WDG5Nl9feqAjn0PP0dHF6zdCwVBPZCeperog
        I+UvHO5gL6Vn7bAPdCN1xPnOIkkTnZA=
X-Google-Smtp-Source: AA6agR4uM1wF6i3uK4f/JwJqT7wsDSMwXLC/j1Fh09erlwTigrGc00JEHBFykVD01IWGi9tFbQe1Ng==
X-Received: by 2002:a17:907:628a:b0:72f:678d:6047 with SMTP id nd10-20020a170907628a00b0072f678d6047mr12474797ejc.456.1661756373028;
        Sun, 28 Aug 2022 23:59:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j19-20020a508a93000000b0043ba7df7a42sm5299292edj.26.2022.08.28.23.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 23:59:32 -0700 (PDT)
Message-ID: <7f8d878b-ca7b-9bc0-6962-1c7de28c2c7b@kernel.org>
Date:   Mon, 29 Aug 2022 08:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] tty: n_gsm: avoid call of sleeping functions from
 atomic context
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Starke <daniel.starke@siemens.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, Hillf Danton <hdanton@sina.com>
References: <20220827195548.191180-1-pchelkin@ispras.ru>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220827195548.191180-1-pchelkin@ispras.ru>
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

On 27. 08. 22, 21:55, Fedor Pchelkin wrote:
> Syzkaller reports the following problem:
...
> The patch replaces tx_lock spinlock with mutex in order to avoid the
> problem. Also kick_timer timer_list is replaced with kick_timeout
> delayed_work to be able to synchronize with mutexes, as suggested by
> Hillf Danton <hdanton@sina.com>.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 32dd59f96924 ("tty: n_gsm: fix race condition in gsmld_write()")
> Fixes: c568f7086c6e ("tty: n_gsm: fix missing timer to handle stalled links")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> v1->v2: sorry, now adapted patch from 5.10 to upstream
> v2->v3: replaced a kick_timer with a delayed_work

Please do so separately. That is, split the below 2 changes into two 
patches.

> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -248,7 +248,7 @@ struct gsm_mux {
>   	bool constipated;		/* Asked by remote to shut up */
>   	bool has_devices;		/* Devices were registered */
>   
> -	spinlock_t tx_lock;
> +	struct mutex tx_mutex;
>   	unsigned int tx_bytes;		/* TX data outstanding */
>   #define TX_THRESH_HI		8192
>   #define TX_THRESH_LO		2048
> @@ -256,7 +256,7 @@ struct gsm_mux {
>   	struct list_head tx_data_list;	/* Pending data packets */
>   
>   	/* Control messages */
> -	struct timer_list kick_timer;	/* Kick TX queuing on timeout */
> +	struct delayed_work kick_timeout;	/* Kick TX queuing on timeout */
>   	struct timer_list t2_timer;	/* Retransmit timer for commands */
>   	int cretries;			/* Command retry counter */
>   	struct gsm_control *pending_cmd;/* Our current pending command */

thanks,
-- 
js
suse labs

