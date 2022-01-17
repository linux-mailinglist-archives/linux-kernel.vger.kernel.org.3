Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E70490747
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiAQLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:46:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40658
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239176AbiAQLqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:46:22 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 20DF73F211
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642419981;
        bh=2navcQ0WRElNhWSfCvnqCtUkEsAg/QuZ7IOd8SfSz50=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KicMYF6qukoV9p2Jg6A+ViNQZKd5qd/+YGCTlmPaTDaH/0EJn6dwg20l4WZgscmSX
         yszIl531gwtsYREKa/gGVzLxTT6VX9DzI9vmDe8ZKBJHQRSSj07xczb4WrAI5anWqt
         AVNN4T5eMV5c0D9IFruqIbu9DskX0EO6jl5jR1UvnUz6VibtrpJEdtLkVrTo+CjmZD
         fuOjjHnxpiDH4qO6tZwW/eBtk4AiUB5l+VTnqgnAyeOKWAhSg6FtGjaMFDgI2wcQZt
         nmDMlhgbkYa9R0mnMxDqyzHy4vs1tXsE5eJB0XhZ8pGKOxMcjyNV3E7W2mqYr7Z3OJ
         vRyEye4k2qwXQ==
Received: by mail-ed1-f72.google.com with SMTP id cf15-20020a0564020b8f00b0040284b671c6so2857686edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2navcQ0WRElNhWSfCvnqCtUkEsAg/QuZ7IOd8SfSz50=;
        b=G+ZckyclB56YVZ9WyfaK2XZg4oFiUdDHfEPpLej8ftrgFvHSW+LgYriC28BIcwdqqz
         uVgveeu/cKERNK0MFittIQfZOhuQp2E2BqY+oxyYylqmtfCeGgz/gbnIHv/28JcPc4u9
         SrLkVxgSc2AKkeBtEsuZB59os19eHNWP3iYf9m3rXiWaZzTjKg1RZ4L5eHAZOXek/CKw
         +OLUXLBRGqZkhuQQ3pblTBrTFoIvZD2Ac1VwkXZFLkSuHZxj0eO2E+dpO+trhAEFi1B6
         lG1P4Edsgnvoypz6o3NV9Y1C/dgJmBEsMkuWQO8HPArKgMHgwbuR/JXXTRKO8gkahTjb
         MHJQ==
X-Gm-Message-State: AOAM532xFkQo96ru2GKM/E7vLpaGKN13kat0G6UF9nOkh8SYYZ+mIT2o
        Ylr5GL9uP3XhAeNIv6XwLF88MTcpcEKOQBPp0d1nro/hp4DecDaxOcdDvVmsKQRwMsTKTBmKG6o
        iUsgWMYrvO6X3KEJWBwgRUAIwWpm9DPHVCNt64yWyqA==
X-Received: by 2002:a17:906:954f:: with SMTP id g15mr10577307ejy.755.1642419980496;
        Mon, 17 Jan 2022 03:46:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGTZAqOavFLCxp4H/YcZ7P4w7DVAjIx/j59efiAeyFrXxLU+CMV9xrYwEVLTkxErw6RieKXw==
X-Received: by 2002:a17:906:954f:: with SMTP id g15mr10577296ejy.755.1642419980301;
        Mon, 17 Jan 2022 03:46:20 -0800 (PST)
Received: from [192.168.0.37] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w11sm4327081eds.88.2022.01.17.03.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 03:46:19 -0800 (PST)
Message-ID: <5ea17ac8-c351-069a-efe5-832b1778b7dc@canonical.com>
Date:   Mon, 17 Jan 2022 12:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] sound/soc/samsung: remove unneeded ret variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220117110357.863990-1-chi.minghao@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220117110357.863990-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 12:03, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from io_remap_pfn_range() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Where is the report? What is being reported here? The tag reported-by is
used to credit bug reporters, mostly public as we work in a public way.
Since there is no bug and there is no public report of anything, the tag
is not applicable.

Please do not add unrelated tags to the patches.

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  sound/soc/samsung/idma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 


Best regards,
Krzysztof
