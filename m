Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3DC484339
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiADOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiADOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:20:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3BAC061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:20:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q16so76515205wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WeeQCilTFNE7Nh007wpxMFboWE5lVX/qeHUt4Da2x6c=;
        b=KJiosB/89hqKX7GXGJC0SgqE7yLt3BnJ+gWDCoQ3Eh7n9pW11tyn5I2ygUov09Z4f+
         HvyzWkpUTZk89/jv9FhjAUHp0240JCKYZFML/yqGzz6seu2ob65gpk4jgkpE58p3PZ0X
         nU5NcJ7+8cBv9X94p+fp6GJcNwqzkuMbzi0l30NMfvWEIB3lRIImEP5SgZD9rSfBacbU
         64+XimNRphqL/JQ20UagMgU+h5dzPH+Ci+EicYq942IgGs2nkxiqWhvfxX18q58SoUw1
         lweURD7cElEXdJt+auTId7ok7ZlHT7jwiRNnrm08gJWgcsJsYDTjxUngOVm/ulV1KZIX
         OWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WeeQCilTFNE7Nh007wpxMFboWE5lVX/qeHUt4Da2x6c=;
        b=gTETAdVkM1h/e4y1G/DFbz0ar1lxOPRcpkk+9pH3V9RIPOEItQTq46ZgvpHdBXPOrm
         XlAeBabLyON3gV2ERZDrsKZxdb3BGciW40/hVtx+hKLXH70u7y9N8z6twu+JM596KYtx
         4Xdn2GAOUNlHBfjOBlmitF9w58ZwIBm5egYt1qwp1tBDJ1UL+B1n+t9Pt2OBmZ3ctQDD
         SPZXJORVzHxa4BNy5kBRU7bLZzkshuvxHhjOhoVtXuvAUJ7Bg0Q51ny0HBeTpdyaqOLV
         VO08xLyYP4VjDBnS+XJ4tAZMOZh0o8ARk5yP6kEZWVIAdHrcn7ox6EMzsNn4vvPYS5HO
         d8SQ==
X-Gm-Message-State: AOAM532LY4JtrsGbyxN7oWQ3W3AN0bm0XHLNW4NsYPdTuRImzRIyH9hy
        hAqNyUPKGa5Xh0Vj6+OfNWUAoQ==
X-Google-Smtp-Source: ABdhPJwMrTzASSAtuAeHD13Uah3zwGwzHwTERozrKIQfJGj44BxpQ00MYPr62K/vCy7LTPB3/EduVA==
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr42360529wrt.322.1641306046777;
        Tue, 04 Jan 2022 06:20:46 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j39sm35717478wms.0.2022.01.04.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:20:46 -0800 (PST)
Date:   Tue, 4 Jan 2022 14:20:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] backlight: qcom-wled: Add PM6150L compatible
Message-ID: <20220104142044.iit5wnsrgzngu76w@maple.lan>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
 <20211229170358.2457006-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229170358.2457006-3-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 06:03:56PM +0100, Luca Weiss wrote:
> PM6150L contains WLED of version 5. Add support ofr it to the driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
