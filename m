Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61922471FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhLMEDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhLMEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:03:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C3CC06173F;
        Sun, 12 Dec 2021 20:03:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso16142355otj.11;
        Sun, 12 Dec 2021 20:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ug13LLEtOlyfDsGusRE39UXEknZ3h0eopE24mhESkBw=;
        b=O+qZgOmCbOUhJzYLrtlEsn5ErqpoVgtQ/LNhCJ33sft0B9maQUg7027+hPK9U7Ikm3
         k45GVUbidP9o+lOcR002kxvQb9YFqHvZJrVvnEmHP79qH8AKyc4Szw2dk1oaGky+CUTY
         eIIqlEu7DgxDKVSg1lqqTv0Rh3F+AHMllxX0GWHhOtHuz56cx8b+/fFxCZ/CXp6uVIyz
         Ls3ePmMsMvcEedc7bGsCqKJC5+0jGmYnTr/Qpy/T0A64vkKkD51KHeLK09hQc0Tj3C2B
         ifS0SYHM5IMSuLlliC85+8dFqspyJ6WoGjA6pjfEsAFdSR7QyPvOXK1gLjW7wqpWMUxo
         dU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ug13LLEtOlyfDsGusRE39UXEknZ3h0eopE24mhESkBw=;
        b=pVTIO1+gdMDRif+s82ykW9Gm/jrAdMTwIrX9S4BK93rtfcRCV7wAssMImEygaiKgcx
         bmdDm6WIQXftaFPl7mxpO+tdmJ9JgZhtGemK1M3CJX50xoSMYQaITFUEJV0sxw67eWSf
         SpqG8AGOGv7u68YNnPgiDvek+5khBNBIXi3fR/FxQCop8gNizueuTe1IA/McnQ6eq0bb
         uvj0Qkey355NfBHwYMnxrbELA9E3HgRAllZqivfX7TsFYorpR3SobZFrvKTEpiQUzG/V
         lPtzZd4cWW03tO8q8TNuZj9DBiI8h0hbuQZMgTu2DQCay/XJYCk8/QjKZQbjqW9a2wfK
         E8yg==
X-Gm-Message-State: AOAM533V7kQ3yvv6IcTkeBGK7haLWJXo8VXL2G35Y0Zf+B2dNWhEWgmw
        AGGS4h5bTCYAHRFCpeSJX7jrSZJsURg=
X-Google-Smtp-Source: ABdhPJxTh+nMmn7T4QvU38aV8sxW/Kgfg2KQnKtDCRXpjH+AoMbpp6WcyZmzp/plOqNLpjOnkEzqMA==
X-Received: by 2002:a9d:404b:: with SMTP id o11mr21920449oti.332.1639368215664;
        Sun, 12 Dec 2021 20:03:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h14sm2039655ots.22.2021.12.12.20.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 20:03:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: fix array may be out of bound
To:     zhangyue <zhangyue1@kylinos.cn>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211213033419.70458-1-zhangyue1@kylinos.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8cef5d56-0d26-d35c-13c4-f6a6671888a2@roeck-us.net>
Date:   Sun, 12 Dec 2021 20:03:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213033419.70458-1-zhangyue1@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/21 7:34 PM, zhangyue wrote:
> In this function, the param 'idx' may be
> equal to 'DW_WDT_NUM_TOPS'.
> At this time, the array 'dw_wdt->timeouts'
> may be out of bound
> 
> Signed-off-by: zhangyue <zhangyue1@kylinos.cn>
> ---
>   drivers/watchdog/dw_wdt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index cd578843277e..15fb1895c085 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -155,6 +155,9 @@ static unsigned int dw_wdt_get_min_timeout(struct dw_wdt *dw_wdt)
>   			break;
>   	}
>   
> +	if (idx == DW_WDT_NUM_TOPS)
> +		return 1;
> +

Please look at the code (and the comments) more closely.
This can not happen.

Guenter
