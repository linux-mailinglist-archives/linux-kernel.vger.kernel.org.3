Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498D54A4B94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380085AbiAaQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380125AbiAaQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:14:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C7C06173E;
        Mon, 31 Jan 2022 08:14:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c3so12769691pls.5;
        Mon, 31 Jan 2022 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/pdltBI+iiGeQ5gA5f30zIEh19HygeH9zPLuWiWvMYQ=;
        b=hMCRiA3Ypccpm1omtUm1SKb0pg6mhtSck6YQpU3BXGcopcjYu4+UcFrhhHCzbG9Ej9
         b9RO8SXkEaltRLYWHr+NG5KBfeTLHb7sj0sU/j//BOa53i4PifpAuIXqf9GJ7395biD5
         rcgJ5dnFsLLXFd+hjx33NM79aGFTWjGjA5ZQoVGQSyCVgDhvXIpu+DPMvX1f8xq+faaV
         KwCuHp0h1hggK/FeVoXQE6CiS6hSie/rTda5HN8H5zbUOEgFwo8h39Ynd4mZe5qDRjy2
         oCv+6pEMyPH00nAyemaNrOyVAZ9YK6B8fhZhavHaflGlepWFIiU39YHHgkiUBSWKxhCK
         Z1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/pdltBI+iiGeQ5gA5f30zIEh19HygeH9zPLuWiWvMYQ=;
        b=VSh8y8i6HmwvGpLOkou34npmp5XvY68PUGIiSYR2WnvV6OQIkWIAlBQOjB8eRxGYOI
         6EnQ8/uS7uVjeZIZxij42qI63lDZW93hhubSGCta0p3jC74K34+Cq43lydUP5H4Px0TW
         472e+X/2hA3EM4q1snVZgVWXA5++HYwmoU0DOGFY8/eMn11GSUCyDSu9v8+32LUIYLq0
         vZECUnua2wyIzOcmJD8UDSLda/d1AL/6eGI+E5BUPbY53nGdBxuNcfqw6Bwnx7hbnLTE
         hHE3qRkPt4oY2MCiVMjt4Kd3VIRTDK6rH1DWxJSBAJ2cZniscF207MS5aNvizyzXiCFe
         RsDQ==
X-Gm-Message-State: AOAM530TwVNrXcyDSy2I3nkpXF3trGLhcPJt5vwbZ08lnRilvqRm39k9
        ROcencBuwBYnZ7geH04srIE=
X-Google-Smtp-Source: ABdhPJxH23jNKrR3GSuqq3WTLpUnzOJ3BOcW6Gf9gby0rv87tmtdNi4iF48J2d83ZzhTJyt7SAHuCg==
X-Received: by 2002:a17:90b:1e41:: with SMTP id pi1mr24736555pjb.62.1643645653725;
        Mon, 31 Jan 2022 08:14:13 -0800 (PST)
Received: from google.com ([2620:15c:202:201:6213:1c4:865f:204c])
        by smtp.gmail.com with ESMTPSA id lt17sm11335673pjb.41.2022.01.31.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:14:12 -0800 (PST)
Date:   Mon, 31 Jan 2022 08:14:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sachin Kamat <sachin.kamat@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: samsung-keypad - Simplify resource management
Message-ID: <YfgK0RPYbXSJ8fJ9@google.com>
References: <8877b9db412fbeb3b43ba4a3ff6c4b39a5440c70.1643530436.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8877b9db412fbeb3b43ba4a3ff6c4b39a5440c70.1643530436.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sun, Jan 30, 2022 at 09:14:08AM +0100, Christophe JAILLET wrote:
> Since the commit in the Fixes tag below, 'keypad->input_dev' is a managed
> resource that doesn't need to be explicitly unregistered or freed (see
> devm_input_allocate_device() documentation)
> 
> So, remove some unless line of code to slightly simplify it.
> 
> Fixes: a57da3479545 ("Input: samsung-keypad - switch to using managed resources")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/input/keyboard/samsung-keypad.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index df0258dcf89e..b6c3c6399b2e 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -451,8 +451,6 @@ static int samsung_keypad_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> -	input_unregister_device(keypad->input_dev);
> -

This is wrong; the order of operations is important and you do not want
to call clk_enable/disable on an unprepared clock.

If you want to do this you need to also replace clk_prepare/unprepare
with devm_ variant.

>  	clk_unprepare(keypad->clk);
>  
>  	return 0;
> -- 
> 2.32.0
> 

Thanks.

-- 
Dmitry
