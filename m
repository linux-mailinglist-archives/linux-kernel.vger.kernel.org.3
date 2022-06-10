Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017A546CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiFJSoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbiFJSod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0276C22E692
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654886672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+bgqEFlNGsSZP0ydOxQikqPn/Ach7Xe4eAsJh69aB0=;
        b=giZGWGfCXmv+rvvVP2eQCVl9CXkhD0kzn3VM90P1QM7F7eLl3ab+Pwp/cgmLEK5xkIFvur
        fxanNy70G1RgQZ3TTUsTBgdgk2z+Lcy4zat1cVNt6lHA31XBx2ojxHEk8R9KREKu7gyHc5
        Ofa6Wffuo23JHAZliYZf7R3fcrsB8F0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-66IntYEtMx2X8Hr_K_KNqg-1; Fri, 10 Jun 2022 14:44:30 -0400
X-MC-Unique: 66IntYEtMx2X8Hr_K_KNqg-1
Received: by mail-ej1-f69.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso12833422ejb.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l+bgqEFlNGsSZP0ydOxQikqPn/Ach7Xe4eAsJh69aB0=;
        b=Us4i3i7/AyqTX8p6EsjIxoqWxF9BB22OYUiIm7zfoWcvkwlm+Uu0VFPhQ7opXECrsx
         gBOfP80SoHYTznnJDl8Y0a0O7LVgYCcAHc1Or5EOLWE5WBHaYsDekjoqVHQKd/9ntHzf
         MmlETrJgMH3R2ccMR7qvAOrMThhcgl+OuXO53kwnKW99cvQpLDuD6uNiOrI8NeDJmE2L
         xuBZfDpDiZEt8/iR8lw5awTDTSOwkJab9dpft7J0C3dO11eqbIfUy0+tO75hVpKmmGk1
         B9VkE8x2PxLPQP/tC0Rb8q2NazlLKkiT0CXEPHLBnFRTrPAEzDfDyjJOL+6mDHyOdU4o
         ysuQ==
X-Gm-Message-State: AOAM531ciPST+Be30rqDaacZA3uG/1MnGVeDv52G8h4zCQbUVjMkFqZr
        rOoBbQOTljmVOROjtqHdbmioqgrg0Wyx8cPjGgeHBcTRw6JW3z+SDGVslPwTnINam5oS0PL3bGF
        2slrvIE+W44cLfbNFEZbyJ+aY
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr40953383ejc.762.1654886669653;
        Fri, 10 Jun 2022 11:44:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ7MrLQnjoc0JgGNtXzN423/UM2kCHjIvtW+kLiqpNKUIPKv7D/umJ9WuGmeePmYkdRi2+dQ==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr40953372ejc.762.1654886669456;
        Fri, 10 Jun 2022 11:44:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090615d500b006feb479fcb4sm12497662ejd.44.2022.06.10.11.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:44:28 -0700 (PDT)
Message-ID: <66b25f33-7988-b615-9816-d4bde5c6bd0c@redhat.com>
Date:   Fri, 10 Jun 2022 20:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/mellanox: Spelling s/platfom/platform/
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9c8edde31e271311b7832d7677fe84aba917da8d.1653376503.git.geert@linux-m68k.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9c8edde31e271311b7832d7677fe84aba917da8d.1653376503.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/24/22 09:15, Geert Uytterhoeven wrote:
> Fix a misspelling of the word "platform".
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/mellanox/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
> index 72df4b8f4dd8b5a0..09c7829e95c4b037 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -85,7 +85,7 @@ config NVSW_SN2201
>  	depends on I2C
>  	depends on REGMAP_I2C
>  	help
> -	  This driver provides support for the Nvidia SN2201 platfom.
> +	  This driver provides support for the Nvidia SN2201 platform.
>  	  The SN2201 is a highly integrated for one rack unit system with
>  	  L3 management switches. It has 48 x 1Gbps RJ45 + 4 x 100G QSFP28
>  	  ports in a compact 1RU form factor. The system also including a

