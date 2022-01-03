Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B204483477
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiACP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiACP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:59:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEDFC061761;
        Mon,  3 Jan 2022 07:59:42 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r5so30415545pgi.6;
        Mon, 03 Jan 2022 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ul8L7yJ1J0zXK3Ue0HqUoFN3kW9JC/qcbMluleB9bYk=;
        b=BhhL/rcLHewHWuEpiTyXFcVFqUPcGFip+UI5EMwbtJwRNyRy+VgzNwt5779X0heBpt
         0NFRaNryLWq6Ys86Z5rgZ7MvPwuq7KJEpxqt+hUnKvugsCiDFQjK9B471jz6Zq/UpVoS
         NcNyyAfISHXLg1Mgi6mffySBV0DElYMDYqTDuWP2+zUQgOXcUr5CX2881LKbl6nA/dgG
         fGE2fP3brPeCI8tTgpNvQoZSSnUXynEBTK6WGiootPmewqOSNro3Uzlbl/MMelFDUoTW
         KOMbpM3ZNPgYtPoAepLTl8thFUncGVKUD96O1cbvnH3jxuncXnaBt7ENGRlKB5g/leug
         EZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ul8L7yJ1J0zXK3Ue0HqUoFN3kW9JC/qcbMluleB9bYk=;
        b=PfshiK/QP5aSjpN2AT4LvPtiMjq5Zfk800B6GRlnjc33vI48cSRa3gYcn3nKUuXPGV
         uC2QAITgBM5zMoLMaYg/qafta57PE5wfUCV1sJNmMd9k2u/V1s2BzAcgu77Pkr8SeRjv
         MIz9trbiCEVsT7z7SXswwWY7fyd2TQ72f/0UV8PCVcST5o7yt+gnSj2YQSC2rC1IrSfY
         BuYXZdhl4QnvsJPd2UbFoD/tGw/ufwhCI5pUQRNX7H1h7vCFmBHatlfrP/5lah5EUH9G
         oSOzHsaVxxbpTA9jXg1QK44vrm4sqwwGfXhhL5ZpUeRvYtZbMAj8cJsRMgI84Wg9tdT5
         Fzwg==
X-Gm-Message-State: AOAM5300YxVFwiTpSRBU9AH42fVu7iv5fh3wR+oSrzk5C4f4bO+ZW3K1
        ctFvCPbcCOLGmY1TFI3n2s0=
X-Google-Smtp-Source: ABdhPJxp/Ic16mK7JMI9+HKup25AtmvCmIFdDy+ouZVAL4txSOBEa0euIyHjl7ZLRsMvDizTHzPROg==
X-Received: by 2002:a05:6a00:8d3:b0:4bc:3fe0:98d2 with SMTP id s19-20020a056a0008d300b004bc3fe098d2mr22110560pfu.3.1641225582453;
        Mon, 03 Jan 2022 07:59:42 -0800 (PST)
Received: from [192.168.3.7] (softbank219203027033.bbtec.net. [219.203.27.33])
        by smtp.gmail.com with ESMTPSA id f4sm36518361pfj.25.2022.01.03.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:59:42 -0800 (PST)
Message-ID: <a86506727555e6cd38681b94fcecf6b7fabf5bc8.camel@gmail.com>
Subject: Re: [PATCH] media: pt3: Use dma_set_mask_and_coherent() and
 simplify code
From:   Akihiro TSUKADA <tskd08@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mchehab@kernel.org, andy.shevchenko@gmail.com,
        kirill.shilimanov@huawei.com, novikov@ispras.ru
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Tue, 04 Jan 2022 00:59:38 +0900
In-Reply-To: <34f3a2b58d5f9078709b7d592536af0be49ea1d9.1641072450.git.christophe.jaillet@wanadoo.fr>
References: <34f3a2b58d5f9078709b7d592536af0be49ea1d9.1641072450.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/media/pci/pt3/pt3.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/pci/pt3/pt3.c
> b/drivers/media/pci/pt3/pt3.c
> index 0d51bdf01f43..11f26cac0abc 100644
> --- a/drivers/media/pci/pt3/pt3.c
> +++ b/drivers/media/pci/pt3/pt3.c
> @@ -707,18 +707,10 @@ static int pt3_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>         if (ret < 0)
>                 return ret;
>  
> -       ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> -       if (ret == 0)
> -               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> -       else {
> -               ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> -               if (ret == 0)
> -                       dma_set_coherent_mask(&pdev->dev,
> DMA_BIT_MASK(32));
> -               else {
> -                       dev_err(&pdev->dev, "Failed to set DMA
> mask\n");
> -                       return ret;
> -               }
> -               dev_info(&pdev->dev, "Use 32bit DMA\n");
> +       ret = dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(64));
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to set DMA mask\n");
> +               return ret;
>         }
>  
>         pt3 = devm_kzalloc(&pdev->dev, sizeof(*pt3), GFP_KERNEL);

tested on x86_64.

Acked-by: Akihiro Tsukada <tskd08@gmail.com>
