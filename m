Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814BB569AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiGGGsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiGGGsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:48:40 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307118B24;
        Wed,  6 Jul 2022 23:48:38 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id dn9so25449694ejc.7;
        Wed, 06 Jul 2022 23:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=90jJy+ca1WJWTmf30QTwkp6Rg+7I6b/A/6FAp+w4mRQ=;
        b=pEmsXxO+cyClKeyTCEEcHYDpMai69VhIvw3zM1LlD/Az3dbOI/DmC7uSojytNlHPUH
         3oSTbtwvADvIjq+2JcarA2gxCQ8/mKFQdN/pgRHnl8+2nTFluDGb4zIWF2cCw/Onrym4
         HbhFB4PZHhh+8aENye+uGHSA7yzX1FTMP4CJg6HzsCmioG78aQcWns0WnGnzRnw79ctv
         sGsfzhu12kManlrE+ktuL7J0qPPd/LMCp8hXnoykaPq0DCfaQ6TsAb14IMWVr6dFawi2
         sYGu3pItXGITd4WaSsJqndv896nZpx5Z3fJ8NSulAypmBq+dTS+FpYHjm88u7uTR9NCs
         ZRJQ==
X-Gm-Message-State: AJIora/T6en+/fy+GRwbcim6C12mjT2RUUZS6wefP08tP8fwZJNQ5yMy
        85adtvfX0ecEMCwVwZxxid0=
X-Google-Smtp-Source: AGRyM1uTViCcG7u/rZveiGTrA3aqCtDAbjrXBZb5bEcOtW0SE1Ld4uSXhqAn/3xhV+vQU49DQrkKpA==
X-Received: by 2002:a17:906:8442:b0:72a:8b2b:c5c5 with SMTP id e2-20020a170906844200b0072a8b2bc5c5mr30490909ejy.691.1657176517140;
        Wed, 06 Jul 2022 23:48:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709070b0700b00711d8696de9sm18368673ejl.70.2022.07.06.23.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:48:36 -0700 (PDT)
Message-ID: <1c605fa7-dddf-fb9d-0656-286bb6830d36@kernel.org>
Date:   Thu, 7 Jul 2022 08:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] tty: n_gsm: fix missing corner cases in gsmld_poll()
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220706054452.3663-1-daniel.starke@siemens.com>
 <20220706054452.3663-4-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220706054452.3663-4-daniel.starke@siemens.com>
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

On 06. 07. 22, 7:44, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> gsmld_poll() currently fails to handle some corner cases correctly:
> - tty ldisc association lost
> - remote party closed the associated tty
> 
> Add the missing checks and map those to EPOLLHUP.
> Reorder the checks to group them by their reaction.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Based on tty-testing.
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 51447ccccbab..47566bd2ed6e 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3051,14 +3051,20 @@ static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
>   	__poll_t mask = 0;
>   	struct gsm_mux *gsm = tty->disc_data;
>   
> +	if (!gsm)
> +		return EPOLLHUP;

Hmm, how can this happen? It's a tty bug if it calls ld ops after 
NULLing disc_data.

thanks,
-- 
js
suse labs
