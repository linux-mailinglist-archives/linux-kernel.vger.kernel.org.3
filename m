Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41F48ED9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiANQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiANQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:02:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:02:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x4so16369311wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xZzF8jRq/y/h9eqJLnj+PjpGmcmPav5EfqP3FY3NYi8=;
        b=V0aYU9lM2tThUDewNR5coBOdW+kY8Mvww7QlK8ifg2d/pqtYeCEz5U18blbnxmXsRy
         b6z8n+PdphvpY4Tp4G6aZdBMmPDk/T/RpWFhkivQbwBkJWBldglHGky8IK9cwu51HzmM
         w+gzXxJo47L/wEUJgiKP80YTs73vI2MwAgaJJ3G2Tzhuqkbk1LRvGyU5oe0r3XBUpwd/
         aMgkUxQDGnprMTKsym76aHy5xGHCeefPwBcN2QBwspbHnjnLrXCrOwUDndgDadLg1bRB
         b3pNBcnqBxsEY3hWK9Ifxgk1i3tuJwnYZuF8n60p4fOF4c18zsf7ovExSTxgz9qGF5Ms
         DWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xZzF8jRq/y/h9eqJLnj+PjpGmcmPav5EfqP3FY3NYi8=;
        b=Cq+PW8JzBQHMBu9chZnglwx7Cqv2mSge5kmbctZpqdfjshbVnjQsr1JXKUEUJhCnRE
         j3XWVBKJ3qWni2+RTQT4z2zmwcfqFkriP3flm8DjuSM3hrXUuZdgP6LAHoiywSw/Mvma
         uKGOM/nYW9ahPelr6iBetImJssAmwoydLQt5rsJ3+jRs5sHywjOZMnSgnGtZEkRX4FwH
         PbaAoL5jUwkmbLHaGmqPc/JgoAsMoUwWYpe640d4cvPYZLnT5fjJHrioLYdllUdoUHvn
         MANeenmWogaIbFrSchLCLGiAZ95Fq7Pka8TFePhgofvWBtk3zPn6qB0xbAnPwnfEhcas
         dVUQ==
X-Gm-Message-State: AOAM530vUd/NYcktKGP3WzREQ5rB7stNtLTMbjVis9iP9hTtHtGtfEnW
        pSwysWp5UCAPlOq+N8YsIuY=
X-Google-Smtp-Source: ABdhPJz3vgPy4mEKsWeLWZJldjyCHIe5FYzFAjuNKRgD2AKZZB7ntFwrYzveqy5NL+dYmtVd2No7Xw==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr9023006wrn.329.1642176172085;
        Fri, 14 Jan 2022 08:02:52 -0800 (PST)
Received: from [192.168.0.14] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id x8sm5487523wru.102.2022.01.14.08.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 08:02:51 -0800 (PST)
Message-ID: <56d0a5d3-65e7-db59-7704-e9868952bb45@gmail.com>
Date:   Fri, 14 Jan 2022 17:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] drm/mediatek: Fix mtk_cec_mask()
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Jie Qiu <jie.qiu@mediatek.com>
Cc:     Zhiqiang Lin <zhiqiang.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220103054706.8072-1-miles.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220103054706.8072-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2022 06:47, Miles Chen wrote:
> In current implementation, mtk_cec_mask() writes val into target register
> and ignores the mask. After talking to our hdmi experts, mtk_cec_mask()
> should read a register, clean only mask bits, and update (val | mask) bits
> to the register.
> 
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> 

Normally there is no new line here.

> Cc: Zhiqiang Lin <zhiqiang.lin@mediatek.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> 

Neither here.

> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 

But that are nit-picks. I leave it to the maintainer to decide if he want to fix 
that when applying the patch:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks a lot,
Matthias

> ---
> 
> Change since v1:
> add Fixes tag
> 
> Change since v2:
> add explanation of mtk_cec_mask()
> 
> Change since v3:
> change misleading subject and modify the commit message since this is a bug fix patch
> 
> ---
>   drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
> index e9cef5c0c8f7..cdfa648910b2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -85,7 +85,7 @@ static void mtk_cec_mask(struct mtk_cec *cec, unsigned int offset,
>   	u32 tmp = readl(cec->regs + offset) & ~mask;
>   
>   	tmp |= val & mask;
> -	writel(val, cec->regs + offset);
> +	writel(tmp, cec->regs + offset);
>   }
>   
>   void mtk_cec_set_hpd_event(struct device *dev,
> 
