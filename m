Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0A46848D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384812AbhLDLwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:52:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56454
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhLDLwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:52:10 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 623053F317
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638618524;
        bh=1lFAfFri95NobHHfuhDqwKUl/WgnOhHBeDas/mq7lKQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jeMDyAlAQdwBl4jRdI0lhWG0PVK7ngCbRZ2w+4W/ovx5hTgnAYlGwRAZIsD9EdOW6
         dCt+XPn1RiDFjdjdXOnb7tyd830TdMDL144yLJZZb40reI9cfowLT4Tn4jQNmgVjxu
         kKObBSKV/hDboOp7P4tj0wtqjcWi+z7/OBQG9G4fIwEzHOg16wd/wkVGvPqFvSNadn
         F+2XsP8mi7EcSSVc8li6cDIQkQjkD03et8SOFXIfmbRGS/4TvFSdOZQZzI6OUbkl/U
         OypULsYfcH6LpgwNaN7Fnw37dHPTLX2/sg3h3s4LiJJPnfL8b0kSjkXPky2IMBPdm0
         SXY5fGqID3vBw==
Received: by mail-lf1-f71.google.com with SMTP id 24-20020ac25f58000000b0041799ebf529so1859477lfz.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1lFAfFri95NobHHfuhDqwKUl/WgnOhHBeDas/mq7lKQ=;
        b=dGJGEtVt4omv0481eI4/YwI2br0KwlkyZzjJLaDh7vWR8bU5NUS254soPeAfdVNcko
         H3ghWX19MxFz6cFYjW+0F2j+cmmeKTAGGM4AweA8VS13EsEHOwlsavPRznOVZINlQMfG
         tdxrGrw91xt51XbBIrjAw0Jo5EPr2rPyndoTmT3fril1rW9YFno3CbV4uSKl88UTwSNx
         h7WzowQ6Hf25XbBiq0qzO6/dIiTmvqowdwRFocTo4ehuvYK/k98XdJXp1dtfTY+lzMFL
         8xA6oKLS6UM5/73sTuZITUFerCjVlP4ICInPHgT89N9jGKjtMqSr8O+kRPjWsovCdHeY
         ECEA==
X-Gm-Message-State: AOAM530fsuCsuhLsMyPshGUTQQ0ZcFhihH31dnYnwjqoi7YCni9cOYKH
        sejUe/7vqvNISrqSSxhxOwfq4JeUhGCQa9iOmlZ3eRqLnPSKF6RPtCqN89pQdBTrmkW1RXuHsCN
        yYhugz59c6GkkiUN2jet8uJjjwx9yNnkCqJGm3ipMfQ==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr22500763lfg.63.1638618523698;
        Sat, 04 Dec 2021 03:48:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8VY1xCGJelFHJMdlqnOnN6muluQiZeh4zdF+O15Whdka1EH+b6V5t0L4S8RYhNAMtWAAoJw==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr22500750lfg.63.1638618523478;
        Sat, 04 Dec 2021 03:48:43 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p26sm798181ljj.70.2021.12.04.03.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 03:48:42 -0800 (PST)
Message-ID: <9631fe7c-b878-79b0-1680-80b0be089429@canonical.com>
Date:   Sat, 4 Dec 2021 12:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-4-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211203064027.14993-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 07:40, Yong Wu wrote:
> sleep control means that when the larb go to sleep, we should wait a bit

s/go/goes/

> until all the current commands are finished. thus, when the larb runtime

Please start every sentence with a capital letter.

> suspend, we need enable this function to wait until all the existed

s/suspend/suspends/
s/we need enable/we need to enable/

> command are finished. when the larb resume, just disable this function.

s/command/commands/
s/resume/resumes/

> This function only improve the safe of bus. Add a new flag for this

s/improve/improves/
s/the safe/the safety/

> function. Prepare for mt8186.

In total it is hard to parse, really.

> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..4b59b28e4d73 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -8,6 +8,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -32,6 +33,10 @@
>  #define SMI_DUMMY			0x444
>  
>  /* SMI LARB */
> +#define SMI_LARB_SLP_CON                0x00c
> +#define SLP_PROT_EN                     BIT(0)
> +#define SLP_PROT_RDY                    BIT(16)
> +
>  #define SMI_LARB_CMD_THRT_CON		0x24
>  #define SMI_LARB_THRT_RD_NU_LMT_MSK	GENMASK(7, 4)
>  #define SMI_LARB_THRT_RD_NU_LMT		(5 << 4)
> @@ -81,6 +86,7 @@
>  
>  #define MTK_SMI_FLAG_THRT_UPDATE	BIT(0)
>  #define MTK_SMI_FLAG_SW_FLAG		BIT(1)
> +#define MTK_SMI_FLAG_SLEEP_CTL		BIT(2)
>  #define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
>  
>  struct mtk_smi_reg_pair {
> @@ -371,6 +377,24 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{}
>  };
>  
> +static int mtk_smi_larb_sleep_ctrl(struct device *dev, bool to_sleep)
> +{

Make two functions instead. There is no single code reuse (shared)
between sleep and resume. In the same time bool arguments are confusing
when looking at caller and one never knows whether true means to resume
or to sleep. Having two functions is obvious. Obvious code is easier to
read and maintain.

> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u32 tmp;
> +
> +	if (to_sleep) {
> +		writel_relaxed(SLP_PROT_EN, larb->base + SMI_LARB_SLP_CON);
> +		ret = readl_poll_timeout_atomic(larb->base + SMI_LARB_SLP_CON,
> +						tmp, !!(tmp & SLP_PROT_RDY), 10, 1000);
> +		if (ret)
> +			dev_warn(dev, "sleep ctrl is not ready(0x%x).\n", tmp);
> +	} else {
> +		writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
> +	}
> +	return ret;
> +}
> +
>  static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
>  {
>  	struct platform_device *smi_com_pdev;
> @@ -477,24 +501,31 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  {
>  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>  	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> -	int ret;
> +	int ret = 0;

This line does not have a sense.

>  
>  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)

Why changing this?



Best regards,
Krzysztof
