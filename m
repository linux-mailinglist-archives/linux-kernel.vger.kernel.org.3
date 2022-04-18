Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8724D504CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiDRHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiDRHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:05:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E42727;
        Mon, 18 Apr 2022 00:02:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ks6so25402531ejb.1;
        Mon, 18 Apr 2022 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1gFxdoicgPAwmlV8o1tsLddS7qSbrf3VwqTa9k37xvE=;
        b=W4lI4+bHoC/yfI5uEvATGxwYQ3wMZQscD9cXYkYyUkxubmhOJauGLdXqMQ4FO/Di1P
         f3HDG95xwgJOMEF9WXnzNp+NXi+tVz25dALxT/LX/DDzi0QVQdZVSh8YQvwIj14oDONa
         s8zBPZlPaqFPZghx3UkayPf0FEyKeSHqHZ8BiLUwHJ1OtQ/7EA1rI2qZthhIwXMe2Cb4
         tP/G9qsp2XnULoW9YufKyplA7Vxu3ZFvG9eyBtRkTRJmyAwSrRPSXxsrX8LYMLdH/kJa
         Ho1OoDKRwLlB+bgUamtWzB84FTB1VMhXizn9/MyV3PviVMbH8W9L1PzpaD0I3dn/bVVu
         3M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1gFxdoicgPAwmlV8o1tsLddS7qSbrf3VwqTa9k37xvE=;
        b=wPjHAbGxTQk/Rp7SG7gBXzyaq/JEtKbJXnwnOR2sI3zmUvGKhGMxHhsChgTxsRunTD
         R9OZtO/LcMQTIyQbsO+/2RiSJRe+CAa/doIdBHRCeeXT57sF68wXGjwzXUpgnWllaBQY
         u+6Tush+BeRRL6y5spS3oxYNZB48y48LQ4A3teigSFgm+omUqFVobRdW0QTODd9pnwyo
         qNbpfs96m5q2QFOukxl73yygZU2McZy4l+tQ+ye7m4VQgf4mQusnE+2SGT7vd01Yko3y
         MZCqUzYtEuyyxTK5ddMOMtRNOSjBzkw078bY4JZ4sFBE42qyM8si59PY47DsWPUE3sdr
         G4LQ==
X-Gm-Message-State: AOAM533IPOWdk/C3dFVkOWez6bSm2BJC+fcdHUbt/+LHR9xC6vcJ4XYt
        kT7H/azsBB15G+KviBD+OBwTmUfpRiIhzMxh
X-Google-Smtp-Source: ABdhPJxp/5FaUasy/UnwFg5HQ/pK7TUTLO6u8erRBshd3B2WMjwHIfQf53rSiwpo3xjbugHXaCkW4g==
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id l7-20020a170906794700b006da892f2503mr7881427ejo.710.1650265367005;
        Mon, 18 Apr 2022 00:02:47 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00423d9e50fb6sm2470811eds.55.2022.04.18.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 00:02:46 -0700 (PDT)
Message-ID: <2cc9141e27d6c5317a8129af60decd30ac8470ce.camel@gmail.com>
Subject: Re: [PATCH] input: Make use of the helper function
 devm_platform_ioremap_resource()
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     cgel.zte@gmail.com, dmitry.torokhov@gmail.com
Cc:     lv.ruyi@zte.com.cn, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Date:   Mon, 18 Apr 2022 09:02:44 +0200
In-Reply-To: <20220418015036.2556731-1-lv.ruyi@zte.com.cn>
References: <20220418015036.2556731-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lv!

On Mon, 2022-04-18 at 01:50 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  drivers/input/keyboard/ep93xx_keypad.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index 272a4f1c6e81..7a3b0664ab4f 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -231,7 +231,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>         struct ep93xx_keypad *keypad;
>         const struct matrix_keymap_data *keymap_data;
>         struct input_dev *input_dev;
> -       struct resource *res;
>         int err;
>  
>         keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
> @@ -250,11 +249,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>         if (keypad->irq < 0)
>                 return keypad->irq;
>  
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENXIO;
> -
> -       keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
> +       keypad->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(keypad->mmio_base))
>                 return PTR_ERR(keypad->mmio_base);
>  

-- 
Alexander Sverdlin.

