Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B6514578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356646AbiD2JhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiD2JhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:37:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08121C6151
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:33:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so5679616wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EW/toHLb6y+1M7wLI94NJ4Z/BFmxHWRzQqK5HO/iHI8=;
        b=uMv4LJwlp1CHsz9bkWvP66hloIn6RRCqdUsl//CCAHqumM8BFgKtW2CMSAwnXWFqcZ
         qr8AXKUU4zoOn2wuk0Y9EN3VCqoB0hMbr+ww7RWhj72WzFiyJxRuNa4qJLLGzXof7Kt6
         uVF7kL97EORzwrBUL+WKvQgMsS2R6jNQgbGSWrMp+SrakmiKGfP599C280s1tC0RZNMU
         l5Xkp/RwlHwJS5sJ0H46KNB9m7nAZgi5g8uC4kPUav4qGnT2pz1nZZz9wIPUuo8Nzsvg
         Dtptg/EGxm4+A+TqyshcEV13c05PLxBpwHkjLcs60DOkEV52erhZKJl4O28wR/ybZuy5
         7+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EW/toHLb6y+1M7wLI94NJ4Z/BFmxHWRzQqK5HO/iHI8=;
        b=iB4KnSIB4/2wvurStV2ZdAzpGC2x3OKinZTKWBmI6EKIje8qfPokO6/Q1CasJeFvUt
         yrT3z409hTD7JonYgSVxW58uG9ktdGyJnqDmsN0RrCxVdZ1fW09bvIlA1Nn4D7pmnvAi
         kjOIUfVPKxiXPAsbGrrywEshsYSJFsvbXiOStrc53ttPaqMhK/gu4o5MGf0P4WSMDmZw
         xGst7V+YqWCz+bvJUkQxThqqZoLJ27xOccBYZhypWYCxKwYpoN6X93DiRCEXHJ3cTrc6
         Gm2nkZZl7Zk3w6e7P0hEU5NTU+Jew3BBUmn7rK32IPOi0jD84dolLPj6bJ4L7a1bnTVY
         628Q==
X-Gm-Message-State: AOAM533zc7CvesigxFu+T8RJr9uDI0tv6H3zJmnyu9JFSsC5L5EpTWTu
        bwjAdBJbbYO224rh34Gq7krAzQ==
X-Google-Smtp-Source: ABdhPJzy/BNNBTkrtGebfsbySOLNkOjsDUHjdDXcPHUjik0w14dHHGfJttoILyklCQF5MYBbdUzawQ==
X-Received: by 2002:a1c:4d0d:0:b0:394:4de:539 with SMTP id o13-20020a1c4d0d000000b0039404de0539mr2319445wmh.124.1651224826589;
        Fri, 29 Apr 2022 02:33:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id n2-20020a1ca402000000b003942429cd1esm261251wme.10.2022.04.29.02.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:33:46 -0700 (PDT)
Message-ID: <996eb652-8a18-184b-c163-85e67d67b530@linaro.org>
Date:   Fri, 29 Apr 2022 10:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nvmem: check for allocation failure
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20220301081127.GC17375@kili>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220301081127.GC17375@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2022 08:11, Dan Carpenter wrote:
> Check for if the kcalloc() fails.
> 
> Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---


Applied after changing subject line to "nvmem: brcm_nvram: check for 
allocation failure"


--srini
>   drivers/nvmem/brcm_nvram.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 439f00b9eef6..c80af8a31eba 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -95,6 +95,8 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
>   	len = le32_to_cpu(header.len);
>   
>   	data = kcalloc(1, len, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>   	memcpy_fromio(data, priv->base, len);
>   	data[len - 1] = '\0';
>   
