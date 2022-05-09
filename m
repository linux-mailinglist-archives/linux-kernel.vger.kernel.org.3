Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C851FA65
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiEIKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiEIKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:50:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CF2D2E0B;
        Mon,  9 May 2022 03:46:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so8011117wme.3;
        Mon, 09 May 2022 03:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T3V/lJ4KUDk6qXJayPf/9nDf9cdeXl1HqcM89tsaVpI=;
        b=c3u+pHWHX+KRBICJluZBGRYy4OlWzlKvluuGrCdgoXGH0a69jGDaP0k5BX/dgB7oYw
         rfmI/FphL878Amre2FtUZy7e0fOUddHib2whV4Cx8oS2gwvzDLnAmID7U01ziYkBBV8y
         jBS9h9uqboJuFR3YJ4hVnruqamNMgQ3HUe3HyqcefpqL+uyWDpcEsFYDJkB1+bSFU2cY
         yRggGixlIfKFY1K5dMk3Dm2nkwcj2zfbFqgnUtA2h6FR5Zrt7Hs1NYmxYjz/Iftc6ufy
         47w+DIwUXTmb33sPMopKtAdWVqkobUSXvPO943aWqirbgPk0CljZto413gVvu8zfl7mi
         k81w==
X-Gm-Message-State: AOAM5302biJV4KkdAKV+pF8hSnToMCN4xXxqnT67krE7SyKI/iH4tGF1
        Lkg4yUzv7o7ylgFi7XWZ/lpTFo8556Efug==
X-Google-Smtp-Source: ABdhPJyhgE0jqM93Q9glBx5zr2oitPx34fTQ646NYNBCLlHFa9uKBazTrFpDIlIgdcOjOZ0WNnIALg==
X-Received: by 2002:a05:600c:4f49:b0:394:8125:8b6 with SMTP id m9-20020a05600c4f4900b00394812508b6mr10898849wmq.80.1652092879195;
        Mon, 09 May 2022 03:41:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b003942a244ec5sm12731163wms.10.2022.05.09.03.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:41:18 -0700 (PDT)
Message-ID: <b17dde9a-6519-15be-07c6-218b1a1ef416@kernel.org>
Date:   Mon, 9 May 2022 12:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] tty: n_gsm: fix buffer over-read in gsm_dlci_data()
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220504081733.3494-1-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220504081733.3494-1-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 05. 22, 10:17, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> 'len' is decreased after each octet that has its EA bit set to 0, which
> means that the value is encoded with additional octets. However, the final
> octet does not decreases 'len' which results in 'len' being one byte too
> long. A buffer over-read may occur in tty_insert_flip_string() as it tries
> to read one byte more than the passed content size of 'data'.
> Decrease 'len' also for the final octet which has the EA bit set to 1 to
> write the correct number of bytes from the internal receive buffer to the
> virtual tty.
> 
> Fixes: 2e124b4a390c ("TTY: switch tty_flip_buffer_push")

That commit barely introduced the problem.

> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index a38b922bcbc1..9b0b435cf26e 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1658,6 +1658,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
>   			if (len == 0)
>   				return;
>   		}
> +		len--;
>   		slen++;
>   		tty = tty_port_tty_get(port);
>   		if (tty) {


-- 
js
suse labs
