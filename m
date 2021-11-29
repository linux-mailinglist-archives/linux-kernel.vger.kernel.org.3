Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529E46160F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377615AbhK2NUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377668AbhK2NSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:18:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460AC07E5E0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:59:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so16592463wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UmkfB3QpQ+/FNVInKkZsvXH+lfTkwZM91ssTv4OXvbU=;
        b=h80VVRoRp09hhlbxLC1FiyxUUyWp+RHUOMntHak2P01/WlCOtyBE7mCSLd31Gp5x7R
         PlDiOCN7I+LzpLRojQ+p83fPaV+OXe4Y4VUCGA2JU6IMjZMA3a3FhI3Hd4JRI88LoAJn
         2bB2jWlp9PK8aTbsleMh0t9Mz3NPnPrgbUTiUIfumkm2j0UcNh6o5LmlUi23qPX8asWU
         0zlfnl2h9YLK9kC6x0VHdAMTSmdzNPyZCnS7hg02Wv3A5aLilJsAsNfgO3TDmOqipSJ3
         lpmGBcjYVNUXyozvJQDemfR0YoCNW8nKJYTUq8SY/Aw2lYfVZxHWl83AUhfNeidMaGNZ
         AtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UmkfB3QpQ+/FNVInKkZsvXH+lfTkwZM91ssTv4OXvbU=;
        b=4Eq3de/0HD0QWjyhKYOOOEPlzftNXcITNK5HS+cqgwqWKfM7QiiV8BwoC7Vgk09l1m
         EPDs9mL74C47AsN5KNZARB160xsyEuUfI/o/TXVSdNCYvhQ4MeLZ9BQ3RI9KgTuhjHwh
         PfVS1ScOPd7bit/+YnFNECRxRPnyLahvGW5dO15bFFDtRmSm35R/35yfVxF1g+USP8xk
         GpfMHkfI0quH+vlN6a0NHCDszQCh3mlTRzGiBdpr1zrGalwKmtRXl0WXGQQQIsK7wT3D
         bqpM9VVz7hplmS5LPwOheH7Bdx72oxotNzGXgkg/s0KF2s8Luc3Voa6hOgGtU/AROgay
         H8YA==
X-Gm-Message-State: AOAM532GXi0QZ2z6CJmHrnyVaHAVmmyn9Ux63kDk8tad2ADk2YZidfRh
        C0JKlu54Ls6Pnvy68v/7iQb5jw==
X-Google-Smtp-Source: ABdhPJzDF/PuUhJhqzNCAQ8FUADARrtQzkA8krw1+hBgCafCJU8ot/f1JUnQzPtJ7AIfURLo90zf1w==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr36411131wmq.53.1638187177204;
        Mon, 29 Nov 2021 03:59:37 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id t16sm6780575wrn.49.2021.11.29.03.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 03:59:36 -0800 (PST)
Date:   Mon, 29 Nov 2021 11:59:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Message-ID: <YaTApiRJPQSLItYI@google.com>
References: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021, Andy Shevchenko wrote:

> The runtime PM callback may be called as soon as the runtime PM facility
> is enabled and activated. It means that ->suspend() may be called before
> we finish probing the device in the ACPI case. Hence, NULL pointer
> dereference:
> 
>   intel-lpss INT34BA:00: IRQ index 0 not found
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   ...
>   Workqueue: pm pm_runtime_work
>   RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]
> 
> To fix this, first try to register the device and only after that enable
> runtime PM facility.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2: added tag (Aditya), returned 0 explicitly at the end of ->probe()
>  drivers/mfd/intel-lpss-acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
