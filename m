Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A835A5C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiH3G7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiH3G7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:59:40 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52952C00DA;
        Mon, 29 Aug 2022 23:59:39 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id fy31so19781075ejc.6;
        Mon, 29 Aug 2022 23:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=udLDyvqYEWiFFMc7PF4o3+l6dw+FJ84syS3HsmSGTcA=;
        b=nybnJGTvo1weV/qzWwUP+2cXrQ3ED9Pyh5MQbj+W47K8nM0QkwohrSGjtUZ+enM9Dd
         9H/dpixKrroTtehrQoZBETDDFHs4Lc16eS4ItdSSEgnMOEp0zkiuO/KFIynJQ5q7AtmX
         WhwzJWS8uCNmND9xfR0x9cBEwLrV6lLM1UUITeH7CJYAN9G47QWEjWoHyFWjd6Ril9cJ
         cpZu5YJayw8DVVe4g++Bqihs6zwGPm6opVytoqD5Hb3FP1J6WvLmj8WeZsDZ1eAHzQ+G
         XRsvh/gqMh+imm+GUJuZC0Qy1V4cHNjpT9t+TCLjfo+rzfsBaWpzh1Mb20MnoUcrvwZv
         KiYQ==
X-Gm-Message-State: ACgBeo3Qk8xuvnHZGreVeZ3nBWoPFxikEv1ww6ESppxi9QtkRGIbtoTf
        nFtxQtobfkPdmDH+RUP6S9U7jbk7N9ltVA==
X-Google-Smtp-Source: AA6agR6Flm8qe4jXyOfHveehL6f0JSYaqRNWgZurTFrHZIkwS7S7R7X/1vOMlUKm8gI2O12IYevEbg==
X-Received: by 2002:a17:907:728d:b0:731:8396:ea86 with SMTP id dt13-20020a170907728d00b007318396ea86mr16058182ejc.361.1661842777858;
        Mon, 29 Aug 2022 23:59:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7cb57000000b0043a61f6c389sm5638914edt.4.2022.08.29.23.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:59:37 -0700 (PDT)
Message-ID: <fe014b7b-a1d2-9be9-625b-2f630934c56c@kernel.org>
Date:   Tue, 30 Aug 2022 08:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/6] tty: n_gsm: introduce gsm_control_command()
 function
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220823062259.4754-1-daniel.starke@siemens.com>
 <20220823062259.4754-4-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823062259.4754-4-daniel.starke@siemens.com>
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

On 23. 08. 22, 8:22, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Move the content of gsm_control_transmit() to a new function
> gsm_control_command() with a more generic signature and analog to
> gsm_control_reply(). Use this within gsm_control_transmit().
> 
> This is needed to simplify upcoming functional additions.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 30 +++++++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> No changes since v1.
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 9535e84f3063..5a20561c0a5d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1316,6 +1316,28 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
>    */
>   
>   
> +/**
> + *	gsm_control_command	-	send a command frame to a control
> + *	@gsm: gsm channel
> + *	@cmd: the command to use
> + *	@data: data to follow encoded info
> + *	@dlen: length of data
> + *
> + *	Encode up and queue a UI/UIH frame containing our command.

These tabs after asterisks are not understood by kernel-doc. You should 
add no new ones.

> + */
> +static int gsm_control_command(struct gsm_mux *gsm, int cmd, u8 *data, int dlen)

Can gsm and data be const? I assume gsm cannot due to call to 
gsm_data_queue(). And what about cmd & dlen being uint? cmd seems to be 
u8 at least...

> +{
> +	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->ftype);
> +
> +	if (msg == NULL)
> +		return -ENOMEM;

\n here

> +	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
> +	msg->data[1] = (dlen << 1) | EA;
> +	memcpy(msg->data + 2, data, dlen);
> +	gsm_data_queue(gsm->dlci[0], msg);

\n here

> +	return 0;
> +}
> +
>   /**
>    *	gsm_control_reply	-	send a response frame to a control
>    *	@gsm: gsm channel
> @@ -1623,13 +1645,7 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
>   
>   static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
>   {
> -	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 2, gsm->ftype);
> -	if (msg == NULL)
> -		return;
> -	msg->data[0] = (ctrl->cmd << 1) | CR | EA;	/* command */
> -	msg->data[1] = (ctrl->len << 1) | EA;
> -	memcpy(msg->data + 2, ctrl->data, ctrl->len);
> -	gsm_data_queue(gsm->dlci[0], msg);
> +	gsm_control_command(gsm, ctrl->cmd, ctrl->data, ctrl->len);
>   }

thanks,
-- 
js
suse labs

