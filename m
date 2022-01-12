Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7048C229
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352475AbiALKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:20:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56574
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239249AbiALKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:20:14 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A25D34074F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641982813;
        bh=ZFiQ3BSkZV8JLMzs5+GiJp8IJAdyEgrG9WjGPcBJ1to=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=POHAO9WikL3dKLKuvnpHW7Y/hRV7+YQASlT4ZX+OiqmhpF8DA21NRXe1IxBrXVrUv
         pVCut8RjKjN7EWPcoxXuJyePNmOv6prGx+xNPTROHX2rtMsf0HDk4PekzvIhzp5Kvd
         ZZSQF9Uq6muts2f8fhpk/7Zp+Zu41PESByl99bLkD3Mo0HbONkqKyclfg2YpEMBl5+
         Ziz/2ZnlWqsIcT4GiCUrNBKe9ijb1gh9k/Kmd99OOjTup1tyd+SsaMV9RuxyiXscUl
         YtzbXHgeIvHHphhqijKdDH73pr3DYR5iejey794cWIXFK8CXsJpqyzpf9onYPw8UJ7
         8tee9+n+Q+f6A==
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso1852480ede.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZFiQ3BSkZV8JLMzs5+GiJp8IJAdyEgrG9WjGPcBJ1to=;
        b=Rvrr+j0CXgAH50WmJT3ZnA5rqD4Gw9djwCBRwB61REzLNp1jaGjsytkvpVZKUnCXih
         AiKy0Jm4GTLMxwb+ZoxlPWjCVJzGcnhF26xjhNwG7wRrA5tf1/WGkgH45d/vVEJA8ItV
         H790kdD9DC2ijEFVhiHIQr+0n78mKMA3EZqtxvG8YfNvqPYT7ZTL1jPJZjYy6vNAss9x
         8CrxJTcZe8+sq33LTtA/J7bNNG7fp9m65lnvocKAJKRPE3rnFo0bvqlr2wt57BFl64Kq
         v2nNzlugx0eVPCX2oeks7pV5O79V9bflJDwLg/A7NHfe386oH+Gb/YhheIafXBImFvR6
         riEQ==
X-Gm-Message-State: AOAM532W9yrPhi/h0qXAQS4d2XoXN531B5ZwFpQADkA8EgCTYs8HVyy2
        QlXZWJm/ZCGX0o9mWB1jrnDCv77Z1Ei2t11X63FMMKEYluy5JkkfTt6JhpM5rr5f+IYHNL1uK0b
        x/4177fTubcrdUO+zInj9Xu+DgA1ihsjbuwWZfI5t/A==
X-Received: by 2002:a05:6402:5251:: with SMTP id t17mr8194544edd.397.1641982813190;
        Wed, 12 Jan 2022 02:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdLsOYtXRyV8ugt5h8vZw6vPbgwVNs4QQiqNdhIAdlMzEhEhXKY3AjG7bkdFEafgdxVmb/Yw==
X-Received: by 2002:a05:6402:5251:: with SMTP id t17mr8194520edd.397.1641982813026;
        Wed, 12 Jan 2022 02:20:13 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id kw14sm4349252ejc.68.2022.01.12.02.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 02:20:12 -0800 (PST)
Message-ID: <a3c48c27-515d-f741-e447-98e0ddfe3b01@canonical.com>
Date:   Wed, 12 Jan 2022 11:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 4/6] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
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
        anthony.huang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-5-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111063904.7583-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 07:39, Yong Wu wrote:
> The successful return value for clk_bulk_prepare_enable is 0, rather than
> "< 0". Fix this.

I do not understand. The commit description does not match the code.
What is the error here?

> 
> Fixes: 0e14917c57f9 ("memory: mtk-smi: Use clk_bulk clock ops")

There is no bug to fix...

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..e7b1a22b12ea 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -480,7 +480,7 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  	int ret;
>  
>  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/* Configure the basic setting for this larb */
> 


Best regards,
Krzysztof
