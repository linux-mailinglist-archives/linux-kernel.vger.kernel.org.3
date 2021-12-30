Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57B481B79
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbhL3Ktx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:49:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54864
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238672AbhL3Ktw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:49:52 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D1D34005B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640861391;
        bh=T7SSQLzvNaGqombUsG5MeeLlkx6Boh3UgJFRdWX3IeM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VpBoGXbQwTbWH4m3S2vpPTBF27K55FxSnU5HoZbq/+UgAVDiJqe3tX8iP/w0ZXmSo
         kyOKtwdgLfz/+HBQA2y0IEgDZD6e+xHpEBQsPCYVvX+rQbz0opiWA2oA+CszBSORSa
         Pp/lVx7SJmmSKrwDY1TMypTK8pRmKD216szyTDZC2tytiKBSNgCkfkgBnIGyEjJt83
         /JS1KC+/mjA0JjhS6l68/XiiFOy0A2l0TXmlmIZEGLulx6696o0B5hJIi2dUVr9NXl
         x1xk8zowMNOwew3ddH34Pk5+Xzq6eSbb2emrJA+4ZlYhCIcyyaniZFTzcggZeJa8y+
         oXhQJFGXzLrgQ==
Received: by mail-lf1-f72.google.com with SMTP id z23-20020a0565120c1700b004258a35caf2so4799969lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T7SSQLzvNaGqombUsG5MeeLlkx6Boh3UgJFRdWX3IeM=;
        b=VDOMbLaCk+YtmH90YivbS4tYuMY59HY3Z9ax0bjE/1fsxnaNXhDHEvXppyi82q877l
         GLts1G/HjejOalNBfNoch8FTRoliWftVp+vU7lyc5eUUo/5EiHNbZzw+hZ7+tIBhaphM
         XKBO1UzJvE8umNAdVR/vHxhqeD8MD/cqZ1/DUYD1WFMcmzZfc5eSChvKadThBA+Vw36r
         UUyQBZ9jvVLYFInJnLuKHFhoxsAs4iB9q+NPLzcVx2Hfd6E/lcv2bB+o/DKOOoGEUgyi
         Pi/HYFCiEUEqCycGbqRE3LYCNzMWF47NJeU7R7c8MW5cR97YXgh3YxmrQF+jO74vwoby
         QuSw==
X-Gm-Message-State: AOAM530ZoQpJGUOT0GjYRVjCEI9iiU3CBdlZTc3cMfjbOyCUr+1WmDz6
        juop/yGKYtyOr2+nEQ/jHslomzVNbjC1GDUxtG/nRuaAD0fMd+s3I9mopp94/18biDfGwaRg998
        z7RSkbmwlKuJN/RGUJwRyj8VTIaV60mPhbidtq5IUuA==
X-Received: by 2002:a2e:b7c9:: with SMTP id p9mr25714025ljo.255.1640861390622;
        Thu, 30 Dec 2021 02:49:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8K8ZccB1+kw4+ZEpMxyuJwdEIzuctUDEAqF9O1N2eYr6XzKGsRZzlk12PPDs4nEswLC99ew==
X-Received: by 2002:a2e:b7c9:: with SMTP id p9mr25714011ljo.255.1640861390414;
        Thu, 30 Dec 2021 02:49:50 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y1sm2407792lja.132.2021.12.30.02.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 02:49:49 -0800 (PST)
Message-ID: <c1050d0d-55ae-a626-58c5-b0fab6f8f0c3@canonical.com>
Date:   Thu, 30 Dec 2021 11:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] memory: mtk-smi: add missing put_device() call in
 mtk_smi_device_link_common
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211230084115.5375-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211230084115.5375-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2021 09:41, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling paths.
> 
> Fixes: 4740475 ("memory: mtk-smi: Add device link for smi-sub-common")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/memory/mtk-smi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e201e5976f34..2131f2c9e7ed 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -386,8 +386,10 @@ static int mtk_smi_device_link_common(struct device *dev, struct device **com_de
>  	of_node_put(smi_com_node);
>  	if (smi_com_pdev) {
>  		/* smi common is the supplier, Make sure it is ready before */
> -		if (!platform_get_drvdata(smi_com_pdev))
> +		if (!platform_get_drvdata(smi_com_pdev)) {
> +			put_device(&smi_com_pdev->dev);
>  			return -EPROBE_DEFER;
> +		}

What about other return paths (-ENODEV, 0)?


Best regards,
Krzysztof
