Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07D56D791
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiGKIQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGKIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:16:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629C1D0C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:16:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so2245063wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+8li6A77GmVGB7gNs8uz0mqxxn45BbTVA9yroTVyVxY=;
        b=f2SP/g6Gi8y3RwdSkz43v7ICOK3uFD3iE1d1jnc5BlgokgWoQpUIG67gUxyDae7T3Y
         TpLudkIPUJ3VCfbz4pxYgLCKyM1qc1PirBybA3IsD6BUNnXMcWMfOWYdOxQPlF7Sa30t
         +u+bPFidROU0It1ws9nZuiyEmdyOWwTAcIJFDCF/2aBZnedXIOsLyObLXi+PxKeFARR2
         7ZUsLe/p/t1deTC0G6RiFcgCQY8ndFB5OGqbd4HP5r2KRlgHNtSAZPEGZ/r7QWTMhm0x
         kDH7iHiHBmpJMlnz4mFhZlD7vjlX+2IMSnj/DZqZ2egXgE1UllHZ1oofBP/Gz57XlOxM
         cVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+8li6A77GmVGB7gNs8uz0mqxxn45BbTVA9yroTVyVxY=;
        b=R1r71jl4vaSjMclxCnMQP77ec0rvih8Je4P4jArh0xEMGkdYdMKwHsK5ifcGWUE6vx
         HP0yg2G/u1FBtWIJajWWcyXLiogKfRLFKrWhLsX3R+5b3Zu+XsqfKHGdrbULCPbRMVlS
         TYVepW5o1+IQcNO1CXFENALRGFcWFSrvguOyG2YmSjl0qoplLrs1Q/h918lk/YJ9JBcp
         /cszmCFr7ohCt7/lEzRuZ5G/t8nWnCuF+BJoCyUZ8SfRNbspLXgt62Wc5c/vndvkMN9w
         ewbiUczXWZ2mPUcb4uOa7mRo98NnDxfMU7BKxSzRwNCKpnxugOFGQMq0e8LDE7YwUSTc
         /Wpg==
X-Gm-Message-State: AJIora8noh2MUBS5IY/g8MbW9wIBzp5WcpOSqxRveJ1HIiKqHk7GH1dK
        MKaF2F+xBoq6sHu50GdftXyzTw==
X-Google-Smtp-Source: AGRyM1tQ8418x5JR1m19BGmddRRNhs5EYe+se+0wyk2QOii76nInv/vYz/T37MuYhOUXCy5nTZtZfg==
X-Received: by 2002:a7b:c4d3:0:b0:3a2:aef9:2415 with SMTP id g19-20020a7bc4d3000000b003a2aef92415mr14505237wmk.72.1657527363083;
        Mon, 11 Jul 2022 01:16:03 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003a2cf1ba9e2sm6152166wmb.6.2022.07.11.01.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:16:02 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:16:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 02/11] mfd: intel_soc_pmic_bxtwc: Create sysfs
 attributes using core driver's facility
Message-ID: <YsvcQONqoZIuOUu2@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> Driver core takes care of sysfs attributes. Use this facility instead of
> doing it explicitly in ->probe() and ->remove().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
