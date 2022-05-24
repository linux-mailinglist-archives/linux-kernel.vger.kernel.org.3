Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6330C532F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiEXQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:41:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF12B244;
        Tue, 24 May 2022 09:41:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c22so16797865pgu.2;
        Tue, 24 May 2022 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=54bmEZ++K7ig8vN/OveMaZwftyKMfoK/livEpi3yPkU=;
        b=cwk8BjSpPjQmJ+hzqdyfkFnu+Yoc0pdrRH2mkoiCe1x35JxAeXs2ufMLuFlSy9x3lP
         f1DeEQZbMzXjE9S0JwpP1IXXY9wZYLUXW9GFgmEMpZTZOX/2o8M9aiYmziGxPuu0yUYM
         5MKwPa0WmjS/jH9BwHsU2aE7bkFxwe4JFmvA8vldvPOIM4ohiHi61YcrjxLK3SgIWJQE
         VX6Hz0KCIm9HRLd/5UNEgnfnmoR2ASzD+leQIgq4msVqHBEl/ntwprfF7XzciIUL4zSk
         wu48Bh52w3iHzFtCdBlbZ6jO/KknWSP3WSMGMygaJ/PtwR3lHAbHeTy880Paq4p2V2w/
         VjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=54bmEZ++K7ig8vN/OveMaZwftyKMfoK/livEpi3yPkU=;
        b=I+KLkQJFjo4JtxNvHUfROPjty6OSSpawihdExcSJX8bbO3NnmVHYOFGelpEwTBGnMX
         xie2MrClGC1c4uyhQ0mK1/xewRylUoj3GLQhPmzUHkBh25Lk/y226QBJD5I+d6R6qqjw
         miVj7V9ESqyFy0M2OjVpAI1gN0WUV7hOVWMfmigSqZzU7IemwwjhRFmnByqyysJbPQqt
         KgJO6ozLtgE9+VxwuB7PQpMUz6uISpfL8eZKgQVuIRX7BB1weUSvArZ6EUzi1wM1o1Qk
         coulg5DMM5g5r3Q6avM2K4wLiurzdqurrlZSXj5ZneKWcgArADUYaBfPbi1O0nYRqlC0
         tX9w==
X-Gm-Message-State: AOAM531gNlNuBWg4Y/Fm9aDbrEuBa28NP92k57C8mbxXeC5sghNwnx5J
        6BcI9pimeLLsy1/4F21G+gA=
X-Google-Smtp-Source: ABdhPJz3E8OGCE3qkq1XtpScdaqVhjfE5Y78Pb3IokOStU9OD3cc4Qk4Z63s599XzkD6yIPw/k9Z2w==
X-Received: by 2002:a05:6a00:1a08:b0:510:a1db:1a91 with SMTP id g8-20020a056a001a0800b00510a1db1a91mr29026230pfv.69.1653410501245;
        Tue, 24 May 2022 09:41:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 1-20020a170902c10100b0015e8d4eb228sm7495221pli.114.2022.05.24.09.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 09:41:40 -0700 (PDT)
Message-ID: <6c5f414b-870d-4cef-a6b9-7d9c19381064@gmail.com>
Date:   Tue, 24 May 2022 09:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] gpio: vr41xx: Use spurious_interrupt() and export it
 to modules
Content-Language: en-US
To:     Genjian Zhang <zhanggenjian123@gmail.com>,
        tsbogend@alpha.franken.de, maz@kernel.org, keescook@chromium.org,
        mark.rutland@arm.com, nathan@kernel.org, siyanteng01@gmail.com,
        yyuasa@linux.com, ralf@linux-mips.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        huhai@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20220524032847.3244853-1-zhanggenjian@kylinos.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220524032847.3244853-1-zhanggenjian@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 20:28, Genjian Zhang wrote:
> From: huhai <huhai@kylinos.cn>
> 
> modpost complains once these drivers become modules.
>    ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!
> 
> Fix it by use spurious_interrupt() and export spurious_interrupt() when
> that symbol is =m.
> 
> Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
> Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>   arch/mips/kernel/irq.c     | 3 +++
>   drivers/gpio/gpio-vr41xx.c | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index 5e11582fe308..69f9a46bf9e5 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -49,6 +49,9 @@ asmlinkage void spurious_interrupt(void)
>   {
>   	atomic_inc(&irq_err_count);
>   }
> +#ifdef CONFIG_GPIO_VR41XX_MODULE
> +EXPORT_SYMBOL_GPL(spurious_interrupt);
> +#endif

You should not be exporting for just a specific configuration, export it 
unconditionally. The generic IRQ layer however prefers to use 
handle_bad_irq() which is already exported, can you consider using that?
-- 
Florian
