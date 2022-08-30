Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EB5A5C39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiH3Gza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH3GzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:55:25 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EBDF23;
        Mon, 29 Aug 2022 23:55:21 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id cu2so20243248ejb.0;
        Mon, 29 Aug 2022 23:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UPXJ1JqGigKFmyD9U/hiuxsOSi9xW0X3BsnOgNCxc0w=;
        b=UTlnTHLuKDdgEQydVpgsFP5L7frav0d1NKNZR7Kpn9j0Ygj6ntrr6+ciWdMHxQdVNA
         Q9MpxUDVck+wpnGe1fBUj/o1JOK36roJ5m/Eo9XGrGbg9c/vNgzupKexRS1kiAcnO1Oq
         Jk6xZAsJ1RgWu8A/X19SLrObHI9RHYT1nVVmttAM1QdewevOTTYSXtIriRZDswKi8B9l
         5s+XcfDP6AAGAOeR/V+d2hS3q140/I5Y1iNIoIOGFffnCZHMrjHXxE1hDmOcnAAKkIRz
         bNXhT7PjFveGJr+nwZfnECzDUIPA2lxDep5GQ3C5WnRGwCr4y2iueC5qi/Zot7DeOsMU
         U4AQ==
X-Gm-Message-State: ACgBeo20sGPWjQQFiu7U0JoY6wUJhUpxE+LCrLy23L5M8jBxrXcmXJgD
        1MSAWd3lNlmOlNLX7egK2dI=
X-Google-Smtp-Source: AA6agR5tLpVcq4TB+Wma0x0M4j3UnQqurgLeChLbe8oncg++th8Y0G6ch7qXXpgLNgRrw2X52XMatg==
X-Received: by 2002:a17:907:9625:b0:730:ad62:9c86 with SMTP id gb37-20020a170907962500b00730ad629c86mr15882997ejc.281.1661842519955;
        Mon, 29 Aug 2022 23:55:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h8-20020a50ed88000000b004463b99bc09sm6756792edr.88.2022.08.29.23.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:55:19 -0700 (PDT)
Message-ID: <387a0d37-6a75-d721-87dd-86219f61ef86@kernel.org>
Date:   Tue, 30 Aug 2022 08:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/6] tty: n_gsm: replace use of gsm_read_ea() with
 gsm_read_ea_val()
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
 <20220823062259.4754-3-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823062259.4754-3-daniel.starke@siemens.com>
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
> Replace the use of gsm_read_ea() with gsm_read_ea_val() where applicable to
> improve code readability and avoid errors like in the past.

What errors?

> Reported-by: kernel test robot <lkp@intel.com>

Perhaps you have a link?

> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 99 +++++++++++++++++++++++----------------------
>   1 file changed, 51 insertions(+), 48 deletions(-)
> 
> Changes since v1:
> Fixed use of wrong variable in debug output within gsm_dlci_data().
> 
> Link: https://lore.kernel.org/all/202208222147.WfFRmf1r-lkp@intel.com/

Ah, you do. This should have been above...

> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index ed399d57b197..9535e84f3063 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1418,18 +1418,13 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
>   	unsigned int modem = 0;
>   	struct gsm_dlci *dlci;
>   	int len = clen;
> -	int slen;
> +	int cl = clen;
>   	const u8 *dp = data;
>   	struct tty_struct *tty;
>   
> -	while (gsm_read_ea(&addr, *dp++) == 0) {
> -		len--;
> -		if (len == 0)
> -			return;
> -	}
> -	/* Must be at least one byte following the EA */
> -	len--;
> -	if (len <= 0)
> +	len = gsm_read_ea_val(&addr, data, cl);
> +

There should be likely no extra \n here between assignment and check of 
the value (len).

> +	if (len < 1)
>   		return;
>   
>   	addr >>= 1;
> @@ -1438,15 +1433,21 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
>   		return;
>   	dlci = gsm->dlci[addr];
>   
> -	slen = len;
> -	while (gsm_read_ea(&modem, *dp++) == 0) {
> -		len--;
> -		if (len == 0)
> -			return;
> -	}
> -	len--;
> +	/* Must be at least one byte following the EA */
> +	if ((cl - len) < 1)
> +		return;
> +
> +	dp += len;
> +	cl -= len;
> +
> +	/* get the modem status */
> +	len = gsm_read_ea_val(&modem, dp, cl);
> +
> +	if (len < 1)

The same here.

> +		return;
> +
>   	tty = tty_port_tty_get(&dlci->port);
> -	gsm_process_modem(tty, dlci, modem, slen - len);
> +	gsm_process_modem(tty, dlci, modem, cl);
>   	if (tty) {
>   		tty_wakeup(tty);
>   		tty_kref_put(tty);
> @@ -1921,11 +1922,10 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
>   	struct tty_port *port = &dlci->port;
>   	struct tty_struct *tty;
>   	unsigned int modem = 0;
> -	int len = clen;
> -	int slen = 0;
> +	int len;
>   
>   	if (debug & 16)
> -		pr_debug("%d bytes for tty\n", len);
> +		pr_debug("%d bytes for tty\n", clen);
>   	switch (dlci->adaption)  {
>   	/* Unsupported types */
>   	case 4:		/* Packetised interruptible data */
> @@ -1933,24 +1933,22 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
>   	case 3:		/* Packetised uininterruptible voice/data */
>   		break;
>   	case 2:		/* Asynchronous serial with line state in each frame */
> -		while (gsm_read_ea(&modem, *data++) == 0) {
> -			len--;
> -			slen++;
> -			if (len == 0)
> -				return;
> -		}
> -		len--;
> -		slen++;
> +		len = gsm_read_ea_val(&modem, data, clen);
> +		if (len < 1)
> +			return;
>   		tty = tty_port_tty_get(port);
>   		if (tty) {
> -			gsm_process_modem(tty, dlci, modem, slen);
> +			gsm_process_modem(tty, dlci, modem, len);
>   			tty_wakeup(tty);
>   			tty_kref_put(tty);
>   		}
> +		/* Skip processed modem data */
> +		data += len;
> +		clen -= len;
>   		fallthrough;
>   	case 1:		/* Line state will go via DLCI 0 controls only */
>   	default:
> -		tty_insert_flip_string(port, data, len);
> +		tty_insert_flip_string(port, data, clen);
>   		tty_flip_buffer_push(port);
>   	}
>   }
> @@ -1971,24 +1969,29 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
>   {
>   	/* See what command is involved */
>   	unsigned int command = 0;
> -	while (len-- > 0) {
> -		if (gsm_read_ea(&command, *data++) == 1) {
> -			int clen = *data++;
> -			len--;
> -			/* FIXME: this is properly an EA */
> -			clen >>= 1;
> -			/* Malformed command ? */
> -			if (clen > len)
> -				return;
> -			if (command & 1)
> -				gsm_control_message(dlci->gsm, command,
> -								data, clen);
> -			else
> -				gsm_control_response(dlci->gsm, command,
> -								data, clen);
> -			return;
> -		}
> -	}
> +	const u8 *dp = data;

Why is the local "dp" needed?

> +	int clen = 0;
> +	int dlen;

Having lengths signed is mostly confusing. Shouldn't/couldn't they be 
uint instead?

> +	/* read the command */
> +	dlen = gsm_read_ea_val(&command, dp, len);
> +	len -= dlen;
> +	dp += dlen;
> +
> +	/* read any control data */
> +	dlen = gsm_read_ea_val(&clen, dp, len);
> +	len -= dlen;
> +	dp += dlen;
> +
> +	/* Malformed command? */
> +	if (clen > len)
> +		return;
> +
> +	if (command & 1)
> +		gsm_control_message(dlci->gsm, command, dp, clen);
> +	else
> +		gsm_control_response(dlci->gsm, command, dp, clen);
> +	return;

An extra return.

>   }

thanks,
-- 
js
suse labs

