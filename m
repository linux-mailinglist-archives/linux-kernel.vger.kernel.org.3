Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE947D0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbhLVLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244535AbhLVLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:17:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85326C061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:17:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso1264808wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wVK031yMnXY3SmMKEknhUmLtfDhQrZN1O0BSgsFgdUk=;
        b=rK1UzhFPqw84pe94lIW2HWw+rmVKq6EaIbpFAnw6ZCqPxBiWCu/PtB1bxwkuq2dWZ4
         fHPU794foZOkkrVd9yjiLRfuUyXa3YGMY+cR1g6nGy96kBD6J7Fb52EGrD2jZkhhpPx8
         f2KAvrIFTclWCw9THT8pehbI7TM1KdumjtbVu8CIWvj9QrDjWygV++ukZutqFVxjrIkc
         4Qwf7fYRTUrXEz52D3gzhUpkSGUlsAG56JVqpnbC7aXAPLkGsoqsjIEowb+MgcSGlWm6
         PM1HHvGNRY7G45ffMhKHSSGT/kJtESH7+PtS0znc9jObNqyTgcQUIn0ISPPh9fZSZ0O1
         EpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wVK031yMnXY3SmMKEknhUmLtfDhQrZN1O0BSgsFgdUk=;
        b=EBmWiIFWi+8qyMVbM5pCDQOunq2brF9ntwrO6wT8N29xBpQK96gXz9TGixN1LNQjkH
         z2m67Drim7NEMUV2pkuwhqL3CgvWsWmghUv1TPfk/fZoajBemrPmzdxQkZ2DUPJNZJDR
         46xM7G9Bx4ptZzYyncsLj57RnSRadPqwo+ibjPe4BmEEPd7+k29gpX/gC1DFxe20H+ar
         h/KN4H3lRTtIpodk+Mi7IvKSs1TUIVkjcPwE6YMXKVY6kpVGzw0G56ADh/IEO11KdcUk
         nR42R8xdYEBcMKUACpPcqTJ5zwYeg5LU/RsgOI7AN9blwBPLEXR3Uv+9VcU6FrFRQAd2
         Z5yQ==
X-Gm-Message-State: AOAM531mf9dSn4DytWAcFts2R975nWjRWzVRkzLut3uUcT+Uvxzo4bbk
        kJ+CG73jQSHD8810Ztod7QX8rg==
X-Google-Smtp-Source: ABdhPJzjekleXXqF7vsLzXFMY/qG6/Yx+/aY4TkyoCVvBNYne4YUJFzJkT1Fvc7V/leGnHklMSABjQ==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr588998wmb.137.1640171847097;
        Wed, 22 Dec 2021 03:17:27 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id c9sm1420121wml.12.2021.12.22.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:17:26 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:17:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 5/9] backlight: qcom-wled: Override default length
 with qcom,enabled-strings
Message-ID: <YcMJROV8Kn6foQUU@google.com>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211115203459.1634079-6-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115203459.1634079-6-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021, Marijn Suijten wrote:

> The length of qcom,enabled-strings as property array is enough to
> determine the number of strings to be enabled, without needing to set
> qcom,num-strings to override the default number of strings when less
> than the default (which is also the maximum) is provided in DT.
> 
> This also introduces an extra warning when qcom,num-strings is set,
> denoting that it is not necessary to set both anymore.  It is usually
> more concise to set just qcom,num-length when a zero-based, contiguous
> range of strings is needed (the majority of the cases), or to only set
> qcom,enabled-strings when a specific set of indices is desired.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
