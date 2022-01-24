Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02E44977A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiAXDND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbiAXDNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:13:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDBC06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:13:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu18so46367817lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qVRM/Y9KnTf5W/OW47uEzjGsZq7YvdI6MDc82La160=;
        b=UlGkxmIGFurpQPQLsy3DHRon2/mDjj7Q9J/DY0DCAhxEg6rtDo79bddPp/YOKubJtC
         /tFIY5HlZAMacqbKHnZQVmNYaH2V6/nYrNDLWnSBq+1jYjZwCpHW8kaLPnpSj9Yzrq8D
         /zTzYAI+oMwUm37NjaYH0/lr9jk8yjSRqwN7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qVRM/Y9KnTf5W/OW47uEzjGsZq7YvdI6MDc82La160=;
        b=y197EhR36jRkLwYP6/iMeDzGgF74NBweQ2mDbxLFuQI3IgckOTtR+GEt+fuGNvFugC
         OrEk1rnrHfESQpr3vkPW/dbmg3/UwBVg73XJLWy0W9PROfVDDOqUk67TeZWInhRlhkWn
         nl9k1gkT72INInsxAnXkTFymWrNlGrnRXrnNfMyUVp53wq/1rQjBDUBYyjDVTl9DwPjz
         1ex/rAijaDcJ6DK6gqZqu1wqdjmZLdUUIqnTqf6gHiu8dAN0fznGWnFU16dN3vLOJlaR
         FkLCT2nZMk4t8pQnxsAMoTvhzTyBNpxgWtn/ZL6ick3slAGHwNPraiB5RlwKGW47uSnX
         uTbQ==
X-Gm-Message-State: AOAM531HF9RVZ9sLQuvseuj5mDb2X5GEjCYR07WPG9QvBYrUq8SUgOdE
        /899PXyt1lV04HUk6Q5UfEwGw2mgMCv1QCwoKo8cow==
X-Google-Smtp-Source: ABdhPJzG18l672TgZ/EmECfzrQYf6wq8lGBjSmTvpyYvaqtsPUqWNgNQKmjGEnHknumxN8qo9BV/N9rD/h475wz3Fgo=
X-Received: by 2002:a05:6512:1320:: with SMTP id x32mr11937257lfu.597.1642993980077;
 Sun, 23 Jan 2022 19:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20220123033306.29799-1-qizhong.cheng@mediatek.com>
In-Reply-To: <20220123033306.29799-1-qizhong.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Jan 2022 11:12:49 +0800
Message-ID: <CAGXv+5EcAXFTnjkbeU4f3J2s4Ue5zxrN4QgS=t54BnLX8Gkw2w@mail.gmail.com>
Subject: Re: [PATCH] PCI: mediatek: Change MSI interrupt processing sequence
To:     qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 23, 2022 at 11:34 AM qizhong cheng
<qizhong.cheng@mediatek.com> wrote:
>
> As an edge-triggered interrupts, its interrupt status should be cleared
> before dispatch to the handler of device.

I'm curious, is this just a code correction or are there real world
cases where something fails?

Also, please add a Fixes tag and maybe Cc stable so this gets backported
automatically.

ChenYu

> Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 2f3f974977a3..705ea33758b1 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -624,12 +624,12 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
>                 if (status & MSI_STATUS){
>                         unsigned long imsi_status;
>
> +                       /* Clear MSI interrupt status */
> +                       writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>                         while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>                                 for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM)
>                                         generic_handle_domain_irq(port->inner_domain, bit);
>                         }
> -                       /* Clear MSI interrupt status */
> -                       writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>                 }
>         }
>
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
