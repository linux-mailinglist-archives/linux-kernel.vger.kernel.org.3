Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E335262AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380565AbiEMNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiEMNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:12:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B03387B3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:12:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so11363126wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LGxOhx8g+uzMEucXSgcWuDgXr4IlXAOmT59wc9xxNUQ=;
        b=wRQl3HzxSMdYo3oAFiLxfCpRXx68CvABA7PTFHJ4KoYFsSKoKYI2o0kck84GVkrBPy
         Ydmi/opjnQr49lORQ2aUaZSPE+/GVtznPLLirTIhAGKxyF9K+8SkFklnqG8THPvEnIl9
         4OnyFli6+XLHcvlwPFcd/Lruz0Fk2j8qyZ0QhBnKLJzDsnJjuHoUuslW66qfhOHUDICf
         FYaXMNNqGc7u+UnZbaWj8jLEL35mH0fsJEnNRtrBKIZ1clKfzNQhhoetCB5ScLqSg8/J
         idGnNG0BGzsGtIvpg4JMSLaF5jqun0MxhJPpGU0TfZaAvlaDKAHhqGaxavFd2yb+/dB2
         vveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LGxOhx8g+uzMEucXSgcWuDgXr4IlXAOmT59wc9xxNUQ=;
        b=7EZfEbn5B7Uz9y1cXrnuoJfIokv18LxWhikQ9xjkjqdHfYj4z8eh5njrw8XQIiSfOk
         TC4VSeCsMCpysaTRdkNgJi/uDp43agEGQNKiUXOY8CJ/OTqqVYSWpe1IJn0uYxcfil90
         aHY7ew5jn0ThNop3uE8IoWPvNLGWGvsRNj4mm/ZEGANUjBBFXUqb+NvDpqJ9zwzSGaMj
         8skpCvL4Vp66De/sQQvOAYLsP9ugT1ggPBtCDcw8LZTBNPQE8ZxTpFBLFQ8TDL1gYFPL
         XN6nOKT6lQyjK7jaghz9KP4Rql5sjGYP75t1djbuoNSQHhdA1OgLTwP1RBwZo9k068v4
         iZew==
X-Gm-Message-State: AOAM531MR5JlMzpFQOrdbqU9qMYj5UhrIIFVYTXQe3wN9jQ11L8ZelF6
        vcCuinihCt35TjF0XaH0Nsvvsz3HAuFGQEeO
X-Google-Smtp-Source: ABdhPJzqtxMi8tXdBozGwPO/lz7/uf3fxfcq7tdNkmA+KiH+k9aO4jgE0qPxI3t/ZmZJHJs6tODIAw==
X-Received: by 2002:adf:cc83:0:b0:20a:ca0c:ca1 with SMTP id p3-20020adfcc83000000b0020aca0c0ca1mr3817869wrj.553.1652447524944;
        Fri, 13 May 2022 06:12:04 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:7639:a43b:f4c1:258d? ([2001:861:44c0:66c0:7639:a43b:f4c1:258d])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c460a00b003947e11c3ecsm2204392wmo.17.2022.05.13.06.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 06:12:04 -0700 (PDT)
Message-ID: <d0730221-537c-ba0e-378b-388a37a2a736@baylibre.com>
Date:   Fri, 13 May 2022 15:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/4] mtd: rawnand: meson: refine resource getting in
 probe
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220513123404.48513-1-liang.yang@amlogic.com>
 <20220513123404.48513-4-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220513123404.48513-4-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 14:34, Liang Yang wrote:
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index cc93667a1e7f..6e50387475bb 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -1378,7 +1378,6 @@ static int meson_nfc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct meson_nfc *nfc;
> -	struct resource *res;
>   	int ret, irq;
>   
>   	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> @@ -1395,8 +1394,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
>   
>   	nfc->dev = dev;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nfc->reg_base = devm_ioremap_resource(dev, res);
> +	nfc->reg_base = devm_platform_ioremap_resource_byname(pdev, "nfc");
>   	if (IS_ERR(nfc->reg_base))
>   		return PTR_ERR(nfc->reg_base);
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
