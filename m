Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2804AD4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354346AbiBHJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiBHJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:24:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02555C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:24:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so1135311wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U4eTC6qoUMprkOAPi/nq4R8RnDpnU3YMicKdHmccZLQ=;
        b=OjSkWWAHIdktAsoxsPi8byPQ2FeJ3bEHJsUZ77uP4OKAnFUO5xzu8gJgEUWd9BJvBz
         aO9juV01Jl+Jg51nPtatv0IZ7mhfSBtVI2MgFLAD7hRQhDhCKaCghTlC7XJOB4AytX2/
         UAC8qQsvDpuYIsar6dqeLQttRFVBOCGRSP/kOjCVp0iPeQVX5eWrBKnmGyMClgEKMPaQ
         uRN+U37PNeVifs+mA5ddKOWgc4VOK+8xIYZhqyAJQgcBY5ZQN+1I5Ajxr+QzVIjxBQax
         q7lAMPJoX4Cm4+OenG6xR9SaqiNfcTMbrnGzlg7YTuXhm7VnbLDUwDnsqIjtdsDoePeS
         agyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U4eTC6qoUMprkOAPi/nq4R8RnDpnU3YMicKdHmccZLQ=;
        b=Uo1C3WdUJyOEOjbJSlqEcsnQz4syi0S62TBK8vJq4tHU7Kn+gyyudSONyyLYjY7hRQ
         DgnfGPQh2UlWksDXpxUpauhhzoCL2FbWkA4GGiA3pP/laDxb3750FjE1s4JksOzEluLA
         6DiKbVUQ1MHSueSQZb4HltKQJ76porFsci1scEGNxpEkqMvWONXIgt6EIu/QLH3wXApG
         DAfZ6n/g34EHLNvQKE+DFspLYYjJoTmeRmaOnqP+rvrVwOSV6hXnA5OMb9zyRXM+ujyH
         y4DLUXEXjuq233YKEE+b/9OXyKlLmIRI2sN8KbA7cRdTbemBM5KbbfJgEjucA/B3wBkE
         aj5Q==
X-Gm-Message-State: AOAM533Ofi1UAAHz5HE/sYxKRaM0KZE/kpMfcmxS3O9Q7G4neXTpJp/I
        l0mHglS0yLOUhLpegrI/9aKwHQ==
X-Google-Smtp-Source: ABdhPJyETs0h54mjP52R9i4urCVEkYxAlnNZHIWK+XSjvKFVpOSKSwgint1uilZINo2Imx/EJawJvw==
X-Received: by 2002:a05:600c:4e90:: with SMTP id f16mr274231wmq.175.1644312260622;
        Tue, 08 Feb 2022 01:24:20 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j46sm27994wrj.58.2022.02.08.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:24:19 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:24:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] backlight: qcom-wled: Add PM6150L compatible
Message-ID: <YgI2wXYHjrcsF40f@google.com>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
 <20211229170358.2457006-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211229170358.2457006-3-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021, Luca Weiss wrote:

> PM6150L contains WLED of version 5. Add support ofr it to the driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/video/backlight/qcom-wled.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
