Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0494AD4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354109AbiBHJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354083AbiBHJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:23:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09638C03FEC6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:23:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so29453831wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nv9eGMngUI4irs2c+oCw9hCjsOWg2bDP2XUBGqADoak=;
        b=pjGIicdCBYz734ZtdMDLF0Vk0sQ4CQdXf13cqIefkoiIZvpwGSwsRPI7XLM+fzR/JU
         66QDwlp33BgK6zTu5GMchSO6Ya9LIEeg4vIq/hsPX9qoPO/DBT617X9KBShEQ9HjKS3U
         gVwWvGKzfRSOZn7GFMBRHHBpbfJhj1VVzWYRmEtM2bYZZmCn/l/ewK9rphxpSqANRpvG
         E1nBnNFufGsa7tYM50+ZOtRY6zuv0Y53TRZq2ffG0QggCSdsLFY2h57mKKXYqGlDp4VO
         pdzzVHt/rJ+K6LFu45fvQxTcKaMVXBNOCUfbuZEfXzpsVIs/gOslOA0VAS15MRIPWYTV
         OKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nv9eGMngUI4irs2c+oCw9hCjsOWg2bDP2XUBGqADoak=;
        b=MqnPfF0GyzJHLPNFUTOTCXZP+6DX9LMJNH1pTjkGbbF+kVN5GXChZbOZMkrd4Xz1K6
         I8cODWemCaDiUoB2uZJ57ZaTd3dAnFYHEAQwrbySoRPS6R5ovXu56dXn4nGNVuo0pdYU
         RvamYrDVDMsmi99iriCBz3/+R4h4HwEdAzuOpk14+wfvYRO5Y3gJ7IS/be6rJA42gxeQ
         jCzNQzYUovWDRQbxJTHUHjnFiuUOhxJh3iJ1xK+dwwYtkk/rnaegKs4EnVW3uMAZjAis
         KoX2Sllc3Mi0j+4iKuaccd562a3xfNMHfmnOvhMwtohOdVIBvgU5498kBRLpYCAty25/
         5wuQ==
X-Gm-Message-State: AOAM530LFD5Ena8lm9IgIMLdIaks329XHaNmthgdBnFdqhAPmGM2gUD3
        SV4j2/tsC+gJQVUfhRsHStnYEg==
X-Google-Smtp-Source: ABdhPJxjRg1M0ImAnVJO2McmBHHY7WjBVt9i/brwoGpY52oPDZ+DU4XInyUB2s7IiA+cTZulDHS/rg==
X-Received: by 2002:adf:b610:: with SMTP id f16mr2693143wre.266.1644312218574;
        Tue, 08 Feb 2022 01:23:38 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y1sm1771596wmi.36.2022.02.08.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:23:37 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:23:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: backlight: qcom-wled: Add PM6150L
 compatible
Message-ID: <YgI2ltTYI/1mAxR+@google.com>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
 <20211229170358.2457006-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211229170358.2457006-2-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021, Luca Weiss wrote:

> Document the compatible for the wled block found in PM6150L.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
