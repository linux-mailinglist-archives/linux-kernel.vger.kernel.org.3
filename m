Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28F5104A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353414AbiDZQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353604AbiDZQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:55:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE05427C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:52:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c1so13650916qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqUR0c7kIfOD/vD/YKkVpkdvcyQWCmE0JRAtCDl4Ovs=;
        b=C8hwhh7uEC6m2zOD/nAcUGPqgF3WeHql9lkeJRc6BmxkPieL3Kyc8v4RNJ/vt+iUpN
         +IgZPwvK7gwiayFEj2jURS6zF080FYWzVTPXDRsSl5OIIhMuckxYGoG2j6euIscZYCye
         KXkxUy1MgIh++h0q0cQAtPkg4BT/7yNYt4S98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqUR0c7kIfOD/vD/YKkVpkdvcyQWCmE0JRAtCDl4Ovs=;
        b=o+FZ26r/ghH7SVyUNELeAmn5T83conI8wBIG/9WSI7EvXvuyylL6sX7q/9sO50Jb/q
         /ubSd3Oi/0QGWDnL7updxWpMXgp8jLqsU6M7xwkQBBp6qhO+vHRrExTmcsSuG/MfkrPa
         rY8agIIPZMuW8AvxH3zzADH3AJVqiHcz70yNCp85UqY5pE/zz9sWgqqaD22bl7ealGF3
         2hDPz5YxQ/5x5Rl4o9PbhMBZi5fT9k8p82o3PIkJwvqBmdS9Avva1lEJs+NoD8e8YGSQ
         jvCaRpvzwvrxVLGzZSF13x2MNGVVnBxTF6+kh0wwzwoX/HpWB14CtcaQ9d5qVFZa3pMT
         K0eA==
X-Gm-Message-State: AOAM532oAMITWwhETt6bKpdk0fFpkBHiXHIhrGbIaEeFvfxez7f0x0m7
        nZFKz1UG/SWR/rIKy9q88vrUIWa7+lsJMiBzuK9Nxw==
X-Google-Smtp-Source: ABdhPJx1o2mJSh4zS7CrbcgNcsvrnRgihUn9uVOHoVGxS3Rk8p6EoavtaO4OBtVkqYcrSA6ToxZ+4CDS2ZXUCHDL0N4=
X-Received: by 2002:a37:b4d:0:b0:69f:7742:9778 with SMTP id
 74-20020a370b4d000000b0069f77429778mr2486350qkl.109.1650991936058; Tue, 26
 Apr 2022 09:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org> <20220419142859.380566-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419142859.380566-6-krzysztof.kozlowski@linaro.org>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Tue, 26 Apr 2022 09:52:05 -0700
Message-ID: <CAGt4E5tyGQStKT3S=tUg8CLchzS3S3g8Byh2Kap9oids=jF-UQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] memory: brcmstb_dpfe: simplify platform_get_resource_byname()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 07:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use devm_platform_ioremap_resource_byname() instead of
> platform_get_resource_byname() and devm_ioremap_resource().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for the change.

Acked-by: Markus Mayer <mmayer@broadcom.com>

Regards,
-Markus

> ---
>  drivers/memory/brcmstb_dpfe.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 14412002775d..76c82e9c8fce 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -857,7 +857,6 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct brcmstb_dpfe_priv *priv;
> -       struct resource *res;
>         int ret;
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -869,22 +868,19 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>         mutex_init(&priv->lock);
>         platform_set_drvdata(pdev, priv);
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-cpu");
> -       priv->regs = devm_ioremap_resource(dev, res);
> +       priv->regs = devm_platform_ioremap_resource_byname(pdev, "dpfe-cpu");
>         if (IS_ERR(priv->regs)) {
>                 dev_err(dev, "couldn't map DCPU registers\n");
>                 return -ENODEV;
>         }
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-dmem");
> -       priv->dmem = devm_ioremap_resource(dev, res);
> +       priv->dmem = devm_platform_ioremap_resource_byname(pdev, "dpfe-dmem");
>         if (IS_ERR(priv->dmem)) {
>                 dev_err(dev, "Couldn't map DCPU data memory\n");
>                 return -ENOENT;
>         }
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-imem");
> -       priv->imem = devm_ioremap_resource(dev, res);
> +       priv->imem = devm_platform_ioremap_resource_byname(pdev, "dpfe-imem");
>         if (IS_ERR(priv->imem)) {
>                 dev_err(dev, "Couldn't map DCPU instruction memory\n");
>                 return -ENOENT;
> --
> 2.32.0
>
