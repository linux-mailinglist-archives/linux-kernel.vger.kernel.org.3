Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433335A5C19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiH3GtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH3GtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:49:13 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB35F9BC;
        Mon, 29 Aug 2022 23:49:12 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id a36so9094024edf.5;
        Mon, 29 Aug 2022 23:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PuuakMlbSUWdRa3bhVkS+N7uIpC9ls42yK9ElE4J+og=;
        b=nsGjsbXJMUyRukifeVX7Fx92h7yZGRF5U89db1VGGijgx7B7udq4wxpqOS66osEJrM
         tq4HCToPVRBApC6spOAGRZsySN6zH3TdYW5cCPIg6loT4XZjNlwmFz7glUKv8Vyyqc9V
         nUph0IVaH0N7gDE9NYFxDocJZuIni4XEA4XlOykedc0LeA03tOZTDlKgHiqO714kLWOo
         hO7HyMzjf74wNu4KE3jVPT9ZI1hO9U62xXMfcWyDnUBBNxZqEHyY8U1EPKsaiPkgHTwj
         TUhbjoLS3i4x3gwjTQ43KRfD96jRIoW0szQFa9ZeDDZeA4p9zyQTYsmlUzicRRIA1GsH
         +ZvA==
X-Gm-Message-State: ACgBeo0OOGC2q+rFfu6J9Nshl7yhc8GaulwXcrI+IAYyI4BIKMqrM6Fd
        yeM53ESbJsFJrPSrxhtT3ienJTfTxsZ3ew==
X-Google-Smtp-Source: AA6agR6YtGWaXN4JX9mGLsOYayZmeKKLwouftX09f9KWnsT7Z6oJA/Ih9LRjD8DG2khZxpgIHh6BhQ==
X-Received: by 2002:a05:6402:241d:b0:443:39c5:808b with SMTP id t29-20020a056402241d00b0044339c5808bmr19377344eda.39.1661842150816;
        Mon, 29 Aug 2022 23:49:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906198600b0073dc6def190sm5307502ejd.158.2022.08.29.23.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:49:10 -0700 (PDT)
Message-ID: <3801995e-1eb5-1184-a9ba-2cec1d19bc58@kernel.org>
Date:   Tue, 30 Aug 2022 08:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/6] tty: n_gsm: add enumeration for gsm encodings
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220823062259.4754-1-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
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

On 23. 08. 22, 8:22, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Add an enumeration for the gsm mux encoding types to improve code
> readability and to avoid invalid values. Only two values are defined by the
> standard:
> - basic option mode
> - advanced option mode (uses ISO HDLC standard transparency mechanism)
> 
> Also remove redundant configuration in gsmld_open(). The same value is
> already set in gsm_alloc_mux() which is also called in gsmld_open().
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 
> No changes since v1.
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index caa5c14ed57f..5bf09d129357 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
...
> @@ -2651,7 +2656,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
>   {
>   	memset(c, 0, sizeof(*c));
>   	c->adaption = gsm->adaption;
> -	c->encapsulation = gsm->encoding;
> +	c->encapsulation = (int)gsm->encoding;

IIRC, the C standard says enum behave like int. So why is the cast needed?

>   	c->initiator = gsm->initiator;
>   	c->t1 = gsm->t1;
>   	c->t2 = gsm->t2;
...
> @@ -2942,8 +2947,6 @@ static int gsmld_open(struct tty_struct *tty)
>   	tty->receive_room = 65536;
>   
>   	/* Attach the initial passive connection */
> -	gsm->encoding = 1;
> -

This doesn't relate to "add enumeration for gsm encodings". Why do you 
remove this line?

>   	gsmld_attach_gsm(tty, gsm);

thanks,
-- 
js
suse labs

