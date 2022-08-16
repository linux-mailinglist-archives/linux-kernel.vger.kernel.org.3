Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298D659545C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiHPIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiHPIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:01:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC435B794
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:20:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso16369835pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=38ZipuGlgcGilrPMDkFhdoUjJ/3FDArhDOlQ2DOW4s8=;
        b=IsjBhnJPeIJdkqo1ehpYoRLT0VitBdKe08mRfC4rYgwgC0w7/SF6+1O9PNsWnkpHdw
         XJbRo7KkdyO8PK/i6MdQoR3jI+mF6BDW4JUQ62jdrfXut9lEyZl7SLU/+TWeHIRa67ZL
         54JGyugLq029uLg7lBucHI+Rx0mTJbsoMm6GxqlZsk6vqDv6t7b+Rw2N+D7A7DJGKRLN
         gxax9e6i93WF2ugfQqLB3Qm37LWbJk6hyxampKI7aal7IowuviC6g6S6pvihdaKWj5ro
         rWWptlrsnxzQGkoT5fE9W6UiLbUbLYFeK+OuxuRDKvTtDcBgKEqwrzgwL8YNeAbCWCay
         sxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=38ZipuGlgcGilrPMDkFhdoUjJ/3FDArhDOlQ2DOW4s8=;
        b=4w2/pFjcjB/Cjs9QYfuQAyTaXelXPlOAsMH8PvcnTcI9ecwnsoBetdqGFp5JAXY31q
         3L8ZhJhGTjpd9fOsKkAMIk0pj3nCfGpXXAlOJBq+tkqc+fvsKVBW/Ef5dy3YtTfLMl5d
         EeVgabYEJv2qhw6YJZ5/doMqQ1QpU3pkUX95LAoRRsUkhSLyVGc6aOu4qx/nUnKkiPIK
         s3H8dgk2PFCwMHvr3AXTKjyioznaIbbw7EVJ4LChHkw/hhNKxnL5f5adr2eM68zJDPvk
         SmkbAjbJbdFPo6MJgzNFj9F0dMAGC+SfWDZSLj6rukun4qY8PBqdn1KOUq7QQNhrDKw3
         KdOQ==
X-Gm-Message-State: ACgBeo3Gwxw7wx4VXVOo2kzKvs+abgov+61tv7BESgHqTmXPYtOs1sVE
        Fv4oJpP7P8vdljV4X0vY8Mz56w==
X-Google-Smtp-Source: AA6agR7P9gzYxYLmzi7vzJqMMOI9qtuU7Ub85bOxZF3FskIRNGoRk0cwlIB+BPctooCIMJadzMLtNw==
X-Received: by 2002:a17:90a:c24a:b0:1f3:3abd:6306 with SMTP id d10-20020a17090ac24a00b001f33abd6306mr22030875pjx.128.1660627230927;
        Mon, 15 Aug 2022 22:20:30 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709029a8b00b00168dadc7354sm7933941plp.78.2022.08.15.22.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:20:30 -0700 (PDT)
Date:   Tue, 16 Aug 2022 10:50:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix an un-initialized variable usage
Message-ID: <20220816052026.ijcj63zhlaus27pi@vireshk-i7>
References: <a21fb09a4f2fcdb08eeb43cf4fb525621b16d086.1660567465.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21fb09a4f2fcdb08eeb43cf4fb525621b16d086.1660567465.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-08-22, 14:44, Christophe JAILLET wrote:
> smatch complains that 'ret' may be returned un-initialized.
> 
> Explicitly return 0 if we reach the end of the function (should
> 'opp_table->clk_count' be 0).
> 
> Fixes: 8174a3a613af ("OPP: Provide a simple implementation to configure multiple clocks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 77d1ba3a4154..e87567dbe99f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -873,7 +873,7 @@ int dev_pm_opp_config_clks_simple(struct device *dev,
>  		}
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_config_clks_simple);

Applied. Thanks.

-- 
viresh
