Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D854CF1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiCGGhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiCGGhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:37:23 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AD659A56;
        Sun,  6 Mar 2022 22:36:29 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a8so29594200ejc.8;
        Sun, 06 Mar 2022 22:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Q9gynFpJyzCLfhH7rD1M3nIchFd0uYBoT2DS2g4prE=;
        b=dvaH8mLVgeQbAyAKh8R7wuD8VXwO28plTiG1Y/ejJ63USE3PxKdW6n/kXtuCPSsgMM
         w/fXw34KsmKfDjPJwIvTAFUkt41qS0tSelFwEqImEJuDt4ojNc7wvYMRpeLqk0odAs9I
         HouW4iMnCj+Woqh4Zno6QN+UHo33/qU/At25oywhpkEZDD5Gh6vPP9NhnD7xzvFKyK7e
         oTFXoSRJXhzDqFD9dSqeAWC5rKTTeIHxFXVnPmCznB1hKToUnJgMVqNKBnB1POE3otX3
         Kabef8Gazyy1Dd6wjraMTeUo41c960rfbC7Evil90dnowCegK3gph6XCT44rPaOkOZpT
         MA9g==
X-Gm-Message-State: AOAM532e8qT62Cg2r6dBcirPqS1Dlh+lQ/vB0Bpkj+y+So0QKoZDSg+H
        BazdloARxnw0e/vGQ6+uD+c=
X-Google-Smtp-Source: ABdhPJycmMq9LDywM4G25QPlA9PQF5v5YnSLQSQBcdwVxV9cGcgmj8sEOJ3Pf6/1+SLhZ76BmIhmNg==
X-Received: by 2002:a17:906:d555:b0:6da:ac8c:f66b with SMTP id cr21-20020a170906d55500b006daac8cf66bmr7765786ejc.107.1646634988517;
        Sun, 06 Mar 2022 22:36:28 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906c30f00b006da81e2bd21sm4558268ejz.172.2022.03.06.22.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:36:28 -0800 (PST)
Message-ID: <25128bad-08a6-83a9-b554-ab32869538e3@kernel.org>
Date:   Mon, 7 Mar 2022 07:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/7] tty: serial: samsung: constify UART name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-4-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304080348.218581-4-krzysztof.kozlowski@canonical.com>
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

On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
> The UART name from driver data holds only string literals.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/samsung_tty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 0b4f40044e87..279c413f2300 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -63,7 +63,7 @@ enum s3c24xx_port_type {
>   };
>   
>   struct s3c24xx_uart_info {
> -	char			*name;
> +	const char		*name;
>   	enum s3c24xx_port_type	type;
>   	unsigned int		port_type;
>   	unsigned int		fifosize;


-- 
js
suse labs
