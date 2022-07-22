Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6400657E373
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiGVPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiGVPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:10:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3165492869;
        Fri, 22 Jul 2022 08:10:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n10-20020a17090a670a00b001f22ebae50aso4464577pjj.3;
        Fri, 22 Jul 2022 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yt1GMCYQ6tTtoHBPDiRDkD4NMBul0Gh4DVBTb9sB3w4=;
        b=kLb62tcDFcoByFlLWJhWFFqayDeWr55LnbT/2DRJJVZlwlZCYN8kJ4PNZ9Dx5x7iIq
         8y9cKxmdjoF4Hf+FflKD5sb9maAU//UIIBNymiEfUvcuvSM/h6Gbr7p+NeeBJSPqKuOq
         JvQ2NkQ/dNfTIJtOcxjzfkpZ726xEJzkc2Gk2gNLBzEqnKwAY2m7wUsYJDVau7/hn39X
         WDgidi5ejP81LzyTVzOF2CuLprKZ1xthnWE0AX5Mm4CeZ3cz9xhZAN57F5Oeqm0af3X1
         rrRp6TjTgcx5INN1PWJmTl/4XjCYO8xKYHyfkX3eVXqbJes8i3nrHezi9MKRLCNDhvF2
         cdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yt1GMCYQ6tTtoHBPDiRDkD4NMBul0Gh4DVBTb9sB3w4=;
        b=jRzfiL8QA/E9qgUPay5wu4AOJPyXyWNQzFoURh9y/XefgQJgoKN274MyiPVXIRWCLr
         NdWBuv0ocZ+mTPOUgi89cJM5bFRB5CZqAPN65HHfM/xiHyGRqzeyHkv6NIH1l+Y0oHsu
         8NtSBdM6xoqWDivTj9yGTiEZs8ifFdJDtbXebC1iwC7W9IwLkfzWzQ84LHi+GYfelHGg
         //GAlqFanABXlEA03CxOka7oy9jXenlOM4FzfrwsAcAgvxtHllt6kjS0ry5lArKZeIJr
         PGQ3un7KsNsOIO9EL8Q4738OXJ51KAn5TfdbJVn3GstI1s6V4DaK/XqMSL4XU+nfRWaI
         RquA==
X-Gm-Message-State: AJIora8SPlLTppoNB2sNweh4hmrGPz3LiJgKQGdG9Ho53/uW2pzvRIG8
        VWeBTNgCxRu8rbJOg9RmGEQ=
X-Google-Smtp-Source: AGRyM1tfO6OhsX3GHtwRr27Ut81h24OifrVsvLqBxuunIvaGGMerKpqc41Zmb+Jerr5e596taqFTTw==
X-Received: by 2002:a17:90b:1bc7:b0:1ef:d6f3:b3d0 with SMTP id oa7-20020a17090b1bc700b001efd6f3b3d0mr17933641pjb.4.1658502657743;
        Fri, 22 Jul 2022 08:10:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020aa79dd2000000b00525442ac579sm4007678pfq.212.2022.07.22.08.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 08:10:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b54381ba-f4e4-69d1-1151-8f1eeb1da088@roeck-us.net>
Date:   Fri, 22 Jul 2022 08:10:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] watchdog: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220716041856.34449-1-wangborong@cdjrlc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220716041856.34449-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 21:18, Jason Wang wrote:
> The double `and' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/booke_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 5e4dc1a0f2c6..75da5cd02615 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -74,7 +74,7 @@ static unsigned long long period_to_sec(unsigned int period)
>   /*
>    * This procedure will find the highest period which will give a timeout
>    * greater than the one required. e.g. for a bus speed of 66666666 and
> - * and a parameter of 2 secs, then this procedure will return a value of 38.
> + * a parameter of 2 secs, then this procedure will return a value of 38.
>    */
>   static unsigned int sec_to_period(unsigned int secs)
>   {

