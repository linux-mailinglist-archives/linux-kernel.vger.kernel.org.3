Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B2651FA04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiEIKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiEIKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:34:19 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784EA2701B1;
        Mon,  9 May 2022 03:29:34 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so7992536wmn.1;
        Mon, 09 May 2022 03:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IpkNdWLB+i8ZcpamySoEP6TcMlhhIL5OjEgH/QYZ8SU=;
        b=o11In6S7LBuaox/9BnCEU/Zcu8hg8UU7h1t1QlYvCNGhXX2d+7csyKk8K+bOpgIIme
         RmIX8ZvewOoXFjkHECbPuJH8k+I1mLS1DdcnJZVA/DjzpKZ5VkYQ6DaN6n6KZZbtZIhU
         3rdN5sbacCXyVfXm1YjK97wS5JRaMjq+kOBsDz0N/bKMyIZXd3JYHcr2t7kVHDaJv6si
         CNFpPtXF6MItWT1i6wpH3jk7Tc8oh3MufAEDBK45+3VPo0nXlmXi5XumWIoK53fN4/Up
         K4hsPRK6IY9qrOnQTPFy2ZEE3m/ZNjSLDdaITjsZP6U8nwRnr0m54Pkmq1NKueJaq6x8
         lWYw==
X-Gm-Message-State: AOAM531fFmUZcd7pnTNeNRi2VPyHiyo1WbfGr5svxO6uiNSBSxRUXAqj
        y8UDRRJweJlHST0fWvaUH4BvXq45ugQ3Wg==
X-Google-Smtp-Source: ABdhPJycHZI96SBHadCmYXAiG7+2NnnXdRqqb9xx36dMWRkGOOinsULCdInyG0c6r6YC12nePB7imA==
X-Received: by 2002:a7b:c93a:0:b0:394:2583:69fe with SMTP id h26-20020a7bc93a000000b00394258369femr15664919wml.29.1652092115377;
        Mon, 09 May 2022 03:28:35 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b0038ec8b633fesm11890104wms.1.2022.05.09.03.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:28:34 -0700 (PDT)
Message-ID: <257e1972-a282-f5c9-40c4-a532fdfaf935@kernel.org>
Date:   Mon, 9 May 2022 12:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] tty: n_gsm: fix mux activation issues in gsm_config()
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220504081733.3494-1-daniel.starke@siemens.com>
 <20220504081733.3494-2-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220504081733.3494-2-daniel.starke@siemens.com>
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
> The current implementation activates the mux if it was restarted and opens
> the control channel if the mux was previously closed and we are now acting
> as initiator instead of responder, which is the default setting.
> This has two issues.
> 1) No mux is activated if we keep all default values and only switch to
> initiator. The control channel is not allocated but will be opened next
> which results in a NULL pointer dereference.
> 2) Switching the configuration after it was once configured while keeping
> the initiator value the same will not reopen the control channel if it was
> closed due to parameter incompatibilities. The mux remains dead.
> 
> Fix 1) by always activating the mux if it is dead after configuration.
> Fix 2) by always opening the control channel after mux activation.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 9b0b435cf26e..bcb714031d69 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2352,6 +2352,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
>   
>   static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>   {
> +	int ret = 0;

Why is the initialization needed? You can as well declare the variable 
only inside the if below.

>   	int need_close = 0;
>   	int need_restart = 0;
>   
> @@ -2419,10 +2420,13 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>   	 * FIXME: We need to separate activation/deactivation from adding
>   	 * and removing from the mux array
>   	 */
> -	if (need_restart)
> -		gsm_activate_mux(gsm);
> -	if (gsm->initiator && need_close)
> -		gsm_dlci_begin_open(gsm->dlci[0]);
> +	if (gsm->dead) {
> +		ret = gsm_activate_mux(gsm);
> +		if (ret)
> +			return ret;
> +		if (gsm->initiator)
> +			gsm_dlci_begin_open(gsm->dlci[0]);
> +	}
>   	return 0;
>   }
>   


-- 
js
suse labs
