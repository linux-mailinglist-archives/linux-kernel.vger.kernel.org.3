Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37B4520F78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiEJINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiEJIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:12:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BD5259F9F;
        Tue, 10 May 2022 01:09:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h29so27918173lfj.2;
        Tue, 10 May 2022 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xzPh7IxEmgmLgWQHcCt5lYBmlrpjIGQRCNfXWTLYTjc=;
        b=GR0botMAzsTd7L/xuvFVTOPgIqfmzEf6jXW524GW9QqiEOS5OhPmQNmzMtcB0uG+if
         mjUKoZE65AzToT9Se/vJ3Qv0kuhW1LFxNnqX0RzLUIJ8k+1k/7GGQ9yZPyi0KBQuHbQw
         9qCaGZ6POsWL+iN5nqqLXEfxXPwPKoBnmUiIVvIydRgjw4CvpKHsbPeg6vKL34PXBx/R
         vgHuWq+gt8bEfsUmAuk9VR31laGC0EBmya3EBP+Si0Z3tEERVcd7wIUhPbqA1N5fl0ks
         aTBgAoJqiIYTpWtMPSVmvwfjsLMrJWV470hNYRWk/TOpdJl6ihmT+59JwDNA7zhLzF6D
         3gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xzPh7IxEmgmLgWQHcCt5lYBmlrpjIGQRCNfXWTLYTjc=;
        b=KDPCPJkf/0JUOx7wls07nb3JOFzFl6el0B+wh/1q4p6ONE7VB6FwZpQK2ONZwpNA81
         FM4G3C4H1SfKu9uQZwGKnc4/lM5RH48EkUGRSqqSPKbuV6XAdBHzZk4X7kGSAUfbhhfF
         +iIoiSm39+BkIFbAowfvfkHv1ryXVtBaiq940tLdPHemi7PUOUsC0/SGynEdQcpeR5oj
         l3ty0ctTGnnqBZFwFxomMYvaFyXWu0hHZEJICsfGzy3Eura/g2Llkq25f0AJVIaHRFXU
         tjeD7UsS7pzzLv9zDRXzGRtrJnK2IbKjqnZsRu1+XOJK6KNPqG4wcHJPa3IR/MkvevBZ
         ufQw==
X-Gm-Message-State: AOAM532P8SHPn/moTAFLV8V5OGDjIL6y4rf2vVA2PDg+sEVTiz8ODdYO
        BQHfmKu+e2tupnOCcZnUNlwTMwV6K6w=
X-Google-Smtp-Source: ABdhPJwU17orx7/uxe4N2MQbzcJbvbuRFuzcOJ5DXRYpR+s5zTKc5l7Gk49xQQCfTN0c2cNyJT7GOA==
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id m17-20020a0565120a9100b00473bb9efc80mr16072648lfu.471.1652170138922;
        Tue, 10 May 2022 01:08:58 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.87.32])
        by smtp.gmail.com with ESMTPSA id k15-20020a196f0f000000b00473edee678fsm1795741lfc.287.2022.05.10.01.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:08:58 -0700 (PDT)
Subject: Re: [PATCH] irqchip/loongson-liointc: 4 cores correspond to different
 interrupt status registers
To:     Haoran Jiang <jianghaoran@kylinos.cn>, chenhuacai@kernel.org
Cc:     jiaxun.yang@flygoat.com, tglx@linutronix.de, maz@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <b6a10a52-6d0e-5351-cdb5-373286cf7d3f@gmail.com>
Date:   Tue, 10 May 2022 11:08:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/10/22 8:53 AM, Haoran Jiang wrote:

> According to the loongson cpu manual,different cpu cores

   Please add space after comma.

> correspond to different interrupt status registers
> 
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index 649c58391618..f4e015b50af0 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -195,7 +195,7 @@ static int __init liointc_of_init(struct device_node *node,
>  		}
>  
>  		for (i = 0; i < LIOINTC_NUM_CORES; i++)
> -			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
> +			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS + i*8;

   Please add spaces around *.

[...]

MBR, Sergey
