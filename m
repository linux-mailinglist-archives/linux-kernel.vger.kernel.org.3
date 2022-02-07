Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF84AB7DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiBGJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354794AbiBGJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:31:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BDAC043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:31:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i15so1157433wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e71qr5cQmHNfaTvqFdZSatwMnOkMecpoZmeynQAfXfU=;
        b=IipD0Md8PLGqTRc8YbhUGW9RZUZYMQMHks4wT414D4MJkTvXaIaxCLgX7q7EqqZkkE
         RniraUcxZGQqnV/BLhI8fR3OhKUqDYUBLkiKkwsuJN/ZNCuhQa9etjVpPPbBQ9jyOrwx
         MGb+BBECiHqPAOCpL/b5+NFypnEjgPgL0Rb5qKUiTSwuyDcdtYMjQxjnCr4gVMsnv1db
         4Li8Ccoityy3n7nCqgyhw562KdbA+9+AlCO3h6k33jebIUk0d7GU1cLOM5H73yN+w4Xf
         YMhAHQA5StGpYsrAUVc3HUB89o5DXP0IdN5Syh15D5UZS0wH6QYVpbsbWtyqGxNwNZ4L
         OgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e71qr5cQmHNfaTvqFdZSatwMnOkMecpoZmeynQAfXfU=;
        b=pzNhygrU8Ln2zPQs5wapkKdHpA46vEwMftokhLEDj5ZyjFdi5WY4HHfjNGUNmGAhEH
         S5+0lsCVJzMYgC+SCv7wUmHB3SSBjix2edog5LlrXSugQZ2sVItiteYTSJ7zH3+bUNz4
         K+ZEHG8gmiXv12Gj8kTB4eMAk6cZ7OvyC2xOJzvOKS5jDwfnpewoxKGeKAZr22ltSdMW
         hnkx3GGwu7J96Vdrmvdk8rE+8SXTojYZhTgSYbnkQG9caajGnd8PzwEFQjS78vvJI/rT
         zRVg+K2/CusnlUVqZYRJjJuSWAKrEzfi2mllcyDEccszXdaO8uN4QSq0PQs5MmGhESV5
         1thA==
X-Gm-Message-State: AOAM530kJOH3FNwv5ysR8wR8UiC8wa7RvxVq1TGIxEkQbgy6DIJYIlPh
        zYOCnk/00zVimcBTNqgipHq/FQ==
X-Google-Smtp-Source: ABdhPJxyfEhDPaQTrpIwF3s8f+P5EuB6O3syjtuhYC4gv/uXtG6GnEb8OsVA43hN5ymF4KDaQpvKuQ==
X-Received: by 2002:a05:6000:385:: with SMTP id u5mr3350003wrf.105.1644226262555;
        Mon, 07 Feb 2022 01:31:02 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n15sm10497806wrf.37.2022.02.07.01.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:31:01 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:31:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid open coded arithmetic in memory
 allocation
Message-ID: <YgDm1FWtlneMLCTS@google.com>
References: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
 <20220207080128.xmvommcddjfgz7ey@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207080128.xmvommcddjfgz7ey@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Uwe Kleine-König wrote:

> On Sat, Feb 05, 2022 at 08:40:48AM +0100, Christophe JAILLET wrote:
> > kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> > a multiplication is needed to compute the size of the requested memory.
> > 
> > So turn a kzalloc()+explicit size computation into an equivalent kcalloc().
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> LGTM
> 
> Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks
> Uwe

I am totally confused!

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
