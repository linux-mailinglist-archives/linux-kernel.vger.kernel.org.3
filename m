Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF71596E65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiHQMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiHQMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B38607A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f8so2324716wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=T4H8g2TlTdIU/Bg666ljfBRAWBNZM0kKOI8uoeGDhqA=;
        b=Vekllf6tqfbB+9Q/yUgB3FBfiJ9DOjYkyFR44o3kjziHjzATgnHjz7QGPif7PzdAe7
         7SaN+bClZ26ixBs+3IB/cq6REoWpMAYpNU9xXyWJbvumABVDeeqR3+MO1qJP507ov/p/
         hfQI13O8D0T/HxhIl6otICNLzyRnlMoANxe1lsF3dLYW/FsYGhvyHaCpRf7YXHOyw1hv
         ernb4vn6gURXO1Xw24ofDPAzFUJgn4Hz3ePnlYBAYesioB+J3lqDD2hdkwFbC7cz1EuO
         3zeaaxRJcsa/ZeAifJZC4TBUu/k2mrvE1moCti4e/BtXbXTFj1tGijtKr1eq4KCh78wf
         kMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=T4H8g2TlTdIU/Bg666ljfBRAWBNZM0kKOI8uoeGDhqA=;
        b=G0P/QlX9Dl1IjfvAAOuedvZZW6xANpTFgZP5KP1B36RgvdIcNH2niHMRbQ6BbObEhV
         UIIBNBDN86VsdVHMqmcC9/KFeMfwjFrfJc2mY+42n59mLaPoH2fNCPVZ1IUYkRpXrVry
         XoF8Xio1jLrW2WopInfybONUjB3GKEzdBcwxaVk2IcO6z62P5Qx/1cLITB//87g+0C5K
         i1H4y/sJnkdT/JjGqM8bNSB+KR0pkZ1trTCY5ijPzOhnKzy3W6x2vzMySZTbOa60wgPT
         rajsfud9lYRUcgqr+uOjFURQFb/3wV9PT6J+LTSU067/B4PjataEe9hoVGYEEn/8J3EO
         2tJw==
X-Gm-Message-State: ACgBeo1fIpKbfnYiQpjnAldBAi4GZunsjTtKMiNA/Cze01nGwRNSzrL7
        nFbrkQ1QiSl8N1uhxr7LEAm2AT7u99yoBA==
X-Google-Smtp-Source: AA6agR7GridoUpmEwYVJCJmbANZTGROMs72bh4KtoO2DwpX51fv5hvC3PJyiuVqUWW/5LNvJBCdlkA==
X-Received: by 2002:adf:db06:0:b0:220:7a57:6665 with SMTP id s6-20020adfdb06000000b002207a576665mr14515643wri.55.1660739093084;
        Wed, 17 Aug 2022 05:24:53 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id b3-20020a05600010c300b002217339ce90sm12947959wrx.8.2022.08.17.05.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:24:52 -0700 (PDT)
Message-ID: <601d9f11-254b-ece9-df61-e6a352f520d0@linaro.org>
Date:   Wed, 17 Aug 2022 13:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmem: brcm_nvram: Use kzalloc for allocating only one
 element
Content-Language: en-US
To:     Kenneth Lee <klee33@uw.edu>
Cc:     linux-kernel@vger.kernel.org
References: <20220810031037.2620221-1-klee33@uw.edu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220810031037.2620221-1-klee33@uw.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/2022 04:10, Kenneth Lee wrote:
> Use kzalloc(...) rather than kcalloc(1, ...) because the number of
> elements we are specifying in this case is 1, so kzalloc would
> accomplish the same thing and we can simplify.
> 
> Signed-off-by: Kenneth Lee <klee33@uw.edu>
> ---

Applied thanks,

--srini
>   drivers/nvmem/brcm_nvram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 450b927691c3..4441daa20965 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -96,7 +96,7 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
>   
>   	len = le32_to_cpu(header.len);
>   
> -	data = kcalloc(1, len, GFP_KERNEL);
> +	data = kzalloc(len, GFP_KERNEL);
>   	memcpy_fromio(data, priv->base, len);
>   	data[len - 1] = '\0';
>   
