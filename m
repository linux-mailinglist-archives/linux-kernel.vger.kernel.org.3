Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5572A490819
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiAQMBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:01:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41204
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239453AbiAQMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:01:44 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E88E73F1C9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642420902;
        bh=bAUdRzIm9/2z1tZx93HbZGiaxfI165En29R890ewPoU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UzlMSriAYt/VsMIgB5iS7dgfqnUpuc4K003Eqk3icTMVlFhZeypeYslrPoYz8heKk
         s8hkL2lnLwti4r4cZzhWi/yCOBqRWFiAFEbfSxEasnJypcoGPpK6GOcR4o9gYBxGxJ
         Aj9fvfqTzub8eTmjbAbtEDjBvGqzi4q3joABviMGxfBDAV2R4DylJDpC2d0N0J+j+1
         SiyFoyEucLelrM3G60Z+9EZin8iTo2V09qyzGYUomOkaZPXPIKww8dxH0AlmKmHbYF
         lr5eNIePqx9TemfGthh/DI0dFaLTSOGN/Nl+h2p0yYM1IUJp2+hmZNsw/odh9nUllO
         Ud0CBpdeP3lVw==
Received: by mail-ed1-f69.google.com with SMTP id s9-20020aa7d789000000b004021d03e2dfso3761101edq.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bAUdRzIm9/2z1tZx93HbZGiaxfI165En29R890ewPoU=;
        b=4yRCQd9X3LKnr3ckteHdRWEoyc48jaAG3v4XVHg6ZevMT34JurUjLec1ZoGe9HSWgm
         nJhIUq4S8rlfrRbg0PuQLhdV+Kk2+yM3WC22lruyBZGW7AbdWJUjjq58gQyDWIQpmqN0
         GXHgK1ag3K+1YNARH0bf+hHHfH7abRDa9DcCFYd++IES/pEZFcA+k8nt5L9SzNoGxNsl
         II2PHo5qFLXVwBFN6L6eanZHIAqcO5GZ8FM8WxHzS+j3JfqVGLuGFJM/0Na7hhXh661R
         Slx2RqiDMwIO24vOToEn5n6p6r7UE7qdZebzYT498c77kyrDruJCUZHp2gMd8htPVCGS
         swjA==
X-Gm-Message-State: AOAM530ypAodiqMzmuT3umeX9Q6PRs/D+u+ctvG/yjaQH1hrVflvdrMw
        /x2X1YtDllZGkIRDmypaHdQ34yms6LC2xaP/ys2D7yl9dfFAiq2F/F1PipRUsaWIRQWL6sf8J/X
        xcHJjs3Wd1XZQe10VHSNJNcFkLwmLXsN/Z9c2Iw0wzg==
X-Received: by 2002:a17:906:e249:: with SMTP id gq9mr14818924ejb.258.1642420902484;
        Mon, 17 Jan 2022 04:01:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdZgJNSpG3yPSHuygPWHopeMLD3qUZtx1G/vR+ammoYPGm5EgWxjMpAsCvVrMFa/M0hof7+A==
X-Received: by 2002:a17:906:e249:: with SMTP id gq9mr14818904ejb.258.1642420902250;
        Mon, 17 Jan 2022 04:01:42 -0800 (PST)
Received: from [192.168.0.37] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r15sm1766230ejz.39.2022.01.17.04.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 04:01:41 -0800 (PST)
Message-ID: <7370f18b-e273-69f2-1cc9-a42495e04874@canonical.com>
Date:   Mon, 17 Jan 2022 13:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 5/7] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-6-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113111057.29918-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 12:10, Yong Wu wrote:
> Function clk_bulk_prepare_enable() returns 0 for success or a negative
> number for error. Fix this code style issue.

The message does not really make sense. If negative is returned, then
the check (ret < 0) was correct.

I guess you wanted to say that common code style is to check for any
non-zero return value, just like it's implementation in clk.h does.

I'll adjust the commit msg when applying.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
