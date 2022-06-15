Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0552354D34C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiFOVGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiFOVGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:06:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845453EAB2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:06:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so3354380pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C2Ku7qa75z9YE3IquAr7Ebmxd4PtdYpE3qZcCL6xmjA=;
        b=HKtFgwjom4IlGGQAROF161kO4Dk9H2HUUtljoNhdvpuDG8XIYEc2V7d+jp7cfVEHAz
         Hv41NyViCBaWu29mQWo7SCCLQG92XRSRpPVJCUCHyiMIPbreyJZSUvwuEsZi3Ym2JsWD
         19aLn6ibBNJF8Eqa83r9/UdDFXQZvVxG1/jQ4Kr0J4pI+WLuKofODQyygrLtorT2L6fl
         BrJWA9NHcQFnzf1O9AKF7DLKb7KeCqMD1l1965dk4LDl7PxLqipAYsn/c+24+GzEI1ym
         Em4MSTIaICrzfs5eOzfSNrkBR85MPJ1KBNWGSHwfmTfG3HzXScWF1ljeIb5En5dUR0ST
         PHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C2Ku7qa75z9YE3IquAr7Ebmxd4PtdYpE3qZcCL6xmjA=;
        b=wCNKjDh9ioMc5nmDUg60iYjI1sy+sW0fQfnlNrX/YaqcjX9YBGG4CAekBOi85S5+jj
         ghjBM93/dWAe5TZSgfaWRHDnjWlEqY7xm3cYr3mZPQb1sIahyz/tEHQ1w5DMqL9umv9B
         l8YTFh+T0d/k+csVwIXM2e+Zel8sDNIL/fA8tP/+UYCH2VRsQJXUJpdIZBdJ//8DegZH
         jh989CsSsyiTQsh67Ins4Rmwvzcg67pS2NfVYgwu0Ohtn8sfJlsnJkquH9l+oAAT7l9T
         KNZ0xBhMFR/zVhpGwL6PEWENhrkp8xI7ITg/7D8KPYW26/w/LX7gg/dj0k69xS+eCYCu
         XZaQ==
X-Gm-Message-State: AJIora9fdJRb0lQ5WliULfpSjU1ivTt0G//gh96ilA7r3210vqGFywk1
        I2KeW3BYn/t4/tTAJGoJE6gGBA==
X-Google-Smtp-Source: AGRyM1ssOT7GcKBiDbBgq2e2JekHOqLDUHkzkuNO9JP/l7z7fPaTYvfrVVlEnPv8czx5EWrcMTIQYw==
X-Received: by 2002:a17:902:e412:b0:169:3fd:3080 with SMTP id m18-20020a170902e41200b0016903fd3080mr256919ple.16.1655327207045;
        Wed, 15 Jun 2022 14:06:47 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a588a00b001e2f892b352sm2254071pji.45.2022.06.15.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:06:46 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:06:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] mfd: t7l66xb: Drop platform disable callback
Message-ID: <YqpJ49i4yEFdGznZ@google.com>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
 <20220530192430.2108217-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530192430.2108217-3-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Uwe Kleine-König wrote:

> None of the in-tree instantiations of struct t7l66xb_platform_data
> provides a disable callback. So better don't dereference this function
> pointer unconditionally. As there is no user, drop it completely instead
> of calling it conditional.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Fixes: 1f192015ca5b ("mfd: driver for the T7L66XB TMIO SoC")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Technically this fixes the first commit introducing a struct
> t7l66xb_platform_data without a disable callback, but ...
> ---
>  drivers/mfd/t7l66xb.c       | 6 +-----
>  include/linux/mfd/t7l66xb.h | 1 -
>  2 files changed, 1 insertion(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
