Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0331149B4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386863AbiAYNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:25:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44212
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575844AbiAYNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:19:55 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 32FE73F1D1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643116780;
        bh=7H+kwmtltVSBKx5eHk33vYDBjpgrbeevYoDgB27H+CI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lokDWwC6CE9N/xXzBGFrWAkmoqIQt5tP7uAgs8+EQzRKp0ED6fVN7Yef4QIMOp97s
         jg2KVzr9h3dwoISj8WO9mPnp96YT9boiNcoBnXQO950r8/CZpAlUus8yi8n+LGtF3i
         oAwUTJtNhwVj6iBUj+i1rbjs6IRf911/cqtZE5b8ucyfbVsGZXmCBUnMXAWeRCimE2
         a7sci0pgBRa3gkm4s3ruBSCz60GiTcN+4thtK38rH/XyqgDwSTG7U73L72FA1w96Vu
         F43EV44S/rx6aDf5H44SsC1tvZHxFefhyDagpqG1mjO8BZHwwYzKicBzTViBvqQFcL
         oZNxRZzxV7F5w==
Received: by mail-wm1-f71.google.com with SMTP id c16-20020a1c9a10000000b0034dd409329eso1458982wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7H+kwmtltVSBKx5eHk33vYDBjpgrbeevYoDgB27H+CI=;
        b=lKnvdA9F24GUeFarP/hZRj6VFxSTvzwsP9ti20i67ld43SHN/TxES6uzgTqf80T3oD
         XveJyWjbmm0wje3DOhjDMoTk9j5gux0Y1vlRrXtzjN2UgQfcZ9dOmmke5Yb2d2ZzWrnN
         qEHJEiVvSfaSzLpIuVgajECJkhmjdPYEstq2vdUnCdT30ZCJXQnlYBz4Jr2OtAfIU3Qh
         7ztz8pfccsMt/0qUBqxz6GzwncHA6BXXQaD4D4h8kNNjgs2VLnUmYXGE2ZDR1/xIDura
         IhL8wV3GaMqjhgcgy6XxyDcvz7HuQzRn6sOD+8oAt8XmcYqJoJR1Lww2b6lIz+dfCQFw
         xpEg==
X-Gm-Message-State: AOAM530geVJHEpTBLfDkrV6tAaSwRG9DtdLlXEyJsY91vhKAzG7IEstp
        Splf7jUcDc5Jtig6jLAo3COyeAYMWgig/VBHf3lrzjqvgWNU2RKktyNa/vXFv1yGaScIqZ/KQrK
        EeE1S5acwmixyXhpHfR3jM/AkWpMj6kF7QR5Ex2fJzw==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr2930720wmh.1.1643116779821;
        Tue, 25 Jan 2022 05:19:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa5CbjVgAdTzjpJrtsTBt6f96wmnehH2oqiBhJobNl5d/0gRlB/5PGKzta91V9mOV7mtz02w==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr2930685wmh.1.1643116779550;
        Tue, 25 Jan 2022 05:19:39 -0800 (PST)
Received: from [192.168.0.57] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l20sm552432wms.24.2022.01.25.05.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:19:38 -0800 (PST)
Message-ID: <9ce18ea8-caed-7d46-8f79-725561429f57@canonical.com>
Date:   Tue, 25 Jan 2022 14:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mt8186: Add binding for MM
 iommu
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220125093244.18230-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 10:32, Yong Wu wrote:
> Add mt8186 iommu binding. "-mm" means the iommu is for Multimedia.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
>  .../dt-bindings/memory/mt8186-memory-port.h   | 217 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
