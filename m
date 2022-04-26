Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E1510022
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbiDZOP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiDZOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:15:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79377167DF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:12:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s21so10969449wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VMMP/IItIJ0xPf2C2eqTM4RGuhn+ypHsUW9yu32eB+U=;
        b=u7XQgH0hx57MWvlgfRtwSyhhKeLWu1wBy3CJODwee+tgQZLGuFNw4fy/kJSSuxHRZZ
         H51w1tS98PUPoTKGjP6r7lz7ML9QleWIaikL76i5jCSb7Jazm/8Zipzz6KoV1Vv1XY7k
         2IjQyZ4d6P6IMemNBY6FGrsFabFflwX1zlydUY+RFItRa3M4mz9bxgN5Bnw2JBsJunDe
         G1LLGUSrQ60YDdMb9TIqmzicg8lkS/WC9LyLF0mclFKo2xKgBts1NkJpBKzfdwiQ2Fou
         LDsA/e9bd14O4TCoPwCbMt3TkJ83rME9rwQUl7vCCkg2hdTFrn5II8fDeQkb9S15dubR
         LYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VMMP/IItIJ0xPf2C2eqTM4RGuhn+ypHsUW9yu32eB+U=;
        b=TZ+oDGaGw4cdGJ1zcftSy0rE6wkFpq5S4EJzo0cbVpXCZ18KD43YezjuQ4lHfcItSC
         6sFacKbe2qmYRxY5SUqmyZHfZsjtxdPG2O3xJ8xNFj8mEfqHb2wegurcZBbOORx7Awm+
         qQ4+9L/BugCGNGO7dMLoXueFOoq34Zar+Wq66C7oCahLxudEinkuqfxWPx2+MLBJsA7S
         bExS4iOZhr9s1O1J+C0ZCiXj0YKwQW+fJhg2+Crk7dcodf8sZNMrf82TH429t968sxc3
         NVXxQTtx86+qzFXml64h+ZtaIkzu63R35gffVH+GTC3oUfITOSkcQmTGkRPDng28vjs3
         CQpg==
X-Gm-Message-State: AOAM533yxKcu1RZFNwrWojh/Np9+8NYUnliWanzE8OJFU2Ods7p6tt/u
        zobtNknejvBVuMh+EsNZ4zH8Cw==
X-Google-Smtp-Source: ABdhPJxiDF96MxwRnQxAdwoiiIx5VzZfn6Ol6BvhkVVTh9otVZllPKi+fMrj8AlyvEnidy7sBEZPNA==
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id l6-20020a5d4806000000b0020ada03711bmr8808413wrq.395.1650982336111;
        Tue, 26 Apr 2022 07:12:16 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b2-20020adfc742000000b0020ac89e4241sm12722504wrh.31.2022.04.26.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:12:15 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:12:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cgel.zte@gmail.com
Cc:     gremlin@gremlin.it, gregkh@linuxfoundation.org, mad_soft@inbox.ru,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mfd: fix error check return value of platform_get_irq()
Message-ID: <Ymf9vfkhXVbqF5pi@google.com>
References: <20220412085305.2533030-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412085305.2533030-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022, cgel.zte@gmail.com wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> platform_get_irq() return negative value on failure, so null check of
> irq is incorrect. Fix it by comparing whether it is less than zero.
> 
> Fixes: dcc21cc09e3c ("mfd: Add driver for Atmel Microcontroller on iPaq h3xxx")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/mfd/ipaq-micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I fixed the subject line for you and applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
