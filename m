Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742E4481396
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhL2Ngu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhL2Ngt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:36:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0DC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:36:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso7136751wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0FfIMZbJg7XcmpHy8tJJu5EbaxZu+URt8xFWV1rf4hc=;
        b=iTwUhZkhPvpl7GJAun+kXS6iATLGqMpLGB1tQrfnadiYT9Edwpbn+20J0s2NHG2ZSi
         /xKSZiLCTiVQYPW1Fo/cIQkKmdi4uyReRvLQn6+nipiRSqMwtw32V5o9KgCn/Zo8QjmY
         exdkC+/41yUvJ05pFnVRuZDHVRXowzBQxa2NQ4KpXDW8sQ514P0UJWlfaIqhdrKZ5ICN
         Sugiakg9PhCI3yv3UxFZeSRFWK/1PmrD6PmIFRl8o8YmtzRKkZ9cMD7s8bs9mG1n943W
         gEW7ldlvEE37YBYP9bnEdZPKCYVCgbDO25AVZuhlt8ou402zr3DVtMsbejPLqgcb6Q/8
         zuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0FfIMZbJg7XcmpHy8tJJu5EbaxZu+URt8xFWV1rf4hc=;
        b=7QLBZqN4v6Yslr2z8/+eyrLcaFrEnxtJwssW8578wdGpzcjI3019YUcQz8XM9lS2Uh
         3qcyi0yk1GPArhs7Mst3qo6cCUP+OSclPa5l4JbcMaKYK3ykQJvM0LFLQpSYji0P06Rx
         9kts8TvG6X0CsOlyve/Cc+qnrqOLJjGsW6vpVhK44NjNSCRdRaQKp/7zRC/oOQZU34YH
         6eDApCJS0lkVC7kWsQmEfNvz8L8w7Nuq9991bh1SMySXPjh+DTaq1Zs1AMiS/80uuD78
         ELWCFKYeBdTrjkP7t+5qmBPbBvCh3tUzgF7K8CbDNSofkjaatfQelHVxgUBnK7yEL5Ws
         X3Mg==
X-Gm-Message-State: AOAM532/b8rCsOIbnNx2cnGQXbY9z17/rQPkNT1ENdFxYBDzoJeb4YL+
        ji1I8JaYlg0O7DXNn4NQ9TmHpg==
X-Google-Smtp-Source: ABdhPJxWgL92JFmSjS0Xa44DifxO4r+i+JRKWsaWvyah0ozzeJPyvF/+quqQutQFuigo8d4XgkP/5A==
X-Received: by 2002:a05:600c:34c8:: with SMTP id d8mr21901981wmq.94.1640785007658;
        Wed, 29 Dec 2021 05:36:47 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id b16sm23601946wmq.41.2021.12.29.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 05:36:47 -0800 (PST)
Date:   Wed, 29 Dec 2021 13:36:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: tps65910: Set PWR_OFF bit during driver probe
Message-ID: <YcxkbWWD5p4PrZKE@google.com>
References: <20211124190104.23554-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124190104.23554-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Dmitry Osipenko wrote:

> The PWR_OFF bit needs to be set in order to power off properly, without
> hanging PMIC. This bit needs to be set early in order to allow thermal
> protection of NVIDIA Terga SoCs to power off hardware properly, otherwise
> a battery re-plug may be needed on some devices to recover after the hang.
> 
> Cc: <stable@vger.kernel.org>
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Please keep these chronological.

> ---
>  drivers/mfd/tps65910.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
