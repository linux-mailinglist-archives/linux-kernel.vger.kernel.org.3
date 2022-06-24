Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2585455A013
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiFXRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:36:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ECC5DF25
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:36:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so6427010pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3tejim6nzB75lm4NOJYENLppeUpH5ct1kCbXERXFHSQ=;
        b=i4v9ObAH9p9emQBJy5npqaKQc4gDNMt8SM/Df3WI7fBbJk1TsUGTGhGvaMSJA7hptg
         snfRS46NbjgqbzVCI8qHYKCGUHe8qgRiM25sLSfDn/44eC1RTK4jK0JZ+nV575KojMXR
         1kkFJ3NOPVtwZhY3PA58/oUN7YCpBvCje5CYCRHmpI/3/7xV4yiBgyUcKXs2ADboiJV8
         +UEc4wk7HuauX4FsVb6IsaRpPxUNoslti+1qOAsW68vnYSfc4xhVnvjTfGTjX5KliYGM
         2gJRoMDU48sLFk7qSDF3yzyDEs90TbJjlnTvEVnBru9y1GaKcBXZ6RQjPwNTzoWY6DbH
         i6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3tejim6nzB75lm4NOJYENLppeUpH5ct1kCbXERXFHSQ=;
        b=I66Au8Y2AM+UWSUx7coBbIiH/hvWRj/teVG7Einf0HmoH9l2sRubmxWnjRlxtnJR4Z
         6a281t9wHe5DDMcxAPBsbKJ4IVc5CsmGqGh+FOpOJ6vM90/iM3xfLbDHJPm3td1R+DGy
         0LIo1ZsFi/gwXwB96pyoNVerkTmmut6++xIs0gxz6RIpb/e4I1Q9MeHk3oYOLVscoyje
         AeK8HleRi5eaABwXbHDG22WTw8ufajRfMl7UmASUYfwSAgr03DK8iG0NnDO7a5CTfmSx
         420U+0Tog4ToMm+3oI5iU6nuo4+lXjurQTkacO5tKyu3n6eJ7w75VCF79sTTR31pxAJG
         VACQ==
X-Gm-Message-State: AJIora/LmsP6xd6PXWpVFperSzFnjWEYcPIW1OI6Crrb6eFF75Ri15kJ
        RA8fvrw2OjLRdXXOl2xPla20tqcxT5jBGA==
X-Google-Smtp-Source: AGRyM1tYp/RSiDESfqIGLsXMa6eRXkw8298tIe+RDAKrzDSjKy278q9qLFJWk/B394Ptlw7Sa+Lm2Q==
X-Received: by 2002:a17:902:f64c:b0:156:4349:7e9b with SMTP id m12-20020a170902f64c00b0015643497e9bmr153949plg.139.1656092186820;
        Fri, 24 Jun 2022 10:36:26 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i68-20020a636d47000000b003fd1deccd4dsm1844360pgc.59.2022.06.24.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:36:25 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:36:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Message-ID: <20220624173621.GC1736477@p14s>
References: <20220624024120.11576-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624024120.11576-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
> rpmsg_register_device_override need to call put_device to free vch when
> driver_set_override fails.
> 
> Fix this by adding a put_device() to the error path.
> 
> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")

This is funny... Neither Bjorn nor I have reviewed this patch...

> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> v2: change the commit log.
> 
>  drivers/rpmsg/rpmsg_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 290c1f02da10..5a47cad89fdc 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -618,6 +618,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>  					  strlen(driver_override));
>  		if (ret) {
>  			dev_err(dev, "device_set_override failed: %d\n", ret);
> +			put_device(dev);

Applied.

Thanks,
Mathieu

>  			return ret;
>  		}
>  	}
> -- 
> 2.25.1
> 
