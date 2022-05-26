Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF4535206
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbiEZQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:27:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79548506F8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:27:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m1so1866934plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4vutIBHqxzPtRizpru9FIl4V8pZQd9bQbIhzf9Wl6YM=;
        b=fYIUii+ilJ6xYpJ/aW7FWU4cHzVZhJ8tF7CN/IwV+ecrBavxUSQQmuxvcSMjL8U44x
         6iTAlBS0cN5hnPjmUPOQ00jVxY3DvWF7Q1tgpZfPecxbsGAPvss7VFtwcUxvsY/CCFP8
         MNGkHYNq9RQNdtiYWoWygRrZQKj+DuPAs+mA8b2Vr5QYSYJ+ItH65JCWkewhQ54JWhIl
         SpNdnhSy7WqZbPBldKQaDf6gYtVJXIylFYmWgVw7BrlpDsVfNNDBWlew3a2+ZoTM4rSH
         Gm9Rn7/5LA7G8yquhdsNw2RzlGViPAQWVT/5hWQIHshikVeBCWobCqmIqJvpvDjkdh3d
         jLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4vutIBHqxzPtRizpru9FIl4V8pZQd9bQbIhzf9Wl6YM=;
        b=vbCyST8C+cHancbRaHnmUj9S3Bn6jD5WnWKpA6KpEC9p9m0ie//+Vf/nvZqmGSrjTd
         fJbw06IHKui0cCrV9Xej97ZbL3/qdi0rzfVsL6rjPjGs7L2YU5ZDKkToeSLOvr0Ttgy+
         3xnbzmfUnmfJVAOUGw4f1kXD+HV+cCxUPjoVciojxL5hgKYChggYYiWAoJc3anqF3+fE
         RjpNfKtws1Zy3vCOp+OhXn+0GokUEiJMg+/jTj4uaUTd/nmfj6cL43B4JAqfUjTUUoDW
         ES118LhI9Oy8bknXqjyFRlppNHQP6exJt2sPgMZuVWXLQVZ7Qhk6FbHWarrGC6ufSxHa
         TvPw==
X-Gm-Message-State: AOAM531ixFyRiQZTvQOoXyC1oSh08VaEQ4jG/aL6L3Hf/4Bp4s6+BoQ/
        ezv2++ccTzHCgraOwVGz5bgxcA==
X-Google-Smtp-Source: ABdhPJxDqS/Z3pSXV5Ra/3fFBt04uf3IzrKccw9F+aLXlXccc6U1sN8lO/y6czwPUNvcJgeJcgf6AQ==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id p19-20020a170902a41300b00156015b524amr38615941plq.106.1653582464964;
        Thu, 26 May 2022 09:27:44 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x1-20020a633101000000b003f60a8d7dadsm1733424pgx.15.2022.05.26.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 09:27:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mtd: rawnand: meson: refine resource getting in
 probe
In-Reply-To: <20220513123404.48513-4-liang.yang@amlogic.com>
References: <20220513123404.48513-1-liang.yang@amlogic.com>
 <20220513123404.48513-4-liang.yang@amlogic.com>
Date:   Thu, 26 May 2022 09:27:43 -0700
Message-ID: <7hzgj48dj4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liang Yang <liang.yang@amlogic.com> writes:

> Signed-off-by: Liang Yang <liang.yang@amlogic.com>

Patch should have a changelog.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index cc93667a1e7f..6e50387475bb 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -1378,7 +1378,6 @@ static int meson_nfc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct meson_nfc *nfc;
> -	struct resource *res;
>  	int ret, irq;
>  
>  	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> @@ -1395,8 +1394,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
>  
>  	nfc->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nfc->reg_base = devm_ioremap_resource(dev, res);
> +	nfc->reg_base = devm_platform_ioremap_resource_byname(pdev, "nfc");
>  	if (IS_ERR(nfc->reg_base))
>  		return PTR_ERR(nfc->reg_base);
>  
> -- 
> 2.34.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
