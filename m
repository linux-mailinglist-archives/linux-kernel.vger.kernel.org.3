Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747452935F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349637AbiEPWI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349598AbiEPWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:08:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509D377E5;
        Mon, 16 May 2022 15:08:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gg20so5688003pjb.1;
        Mon, 16 May 2022 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IWic1dFXb6vf1tLGQit4oc1BbStdhuePyIT8u9/UMjY=;
        b=F9Ct9DBO7I3G+Atdvqfyy+70DbAffJ0vjzjdEmTu81+6jmH2MgQcv55zGKDvtXabZt
         qzTrLkSDpnkctjyLt81ZQ7FGJkPViPpB0bLyP9uMBNDdXa6RNjmQyZFTy+fo1V3weg3C
         aPDSqzks+8PDW9JzrYefCkygKkGQh29eUtC8LsMTFhvvFL5VnJMh13Va28M33crs4gyr
         Bnfz/1vV+ubyRo2DM9IEF3dIZ93NPMd4HjayFsJVpj5fcwhM6XqlTzug9XOvaXEa+uTO
         YAyiL0eqUDHnotUzr5zvHuX0WGqPraLBOCErKhLTwRzyIvPLSPRmTYHolp38+c0zLKPU
         KZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IWic1dFXb6vf1tLGQit4oc1BbStdhuePyIT8u9/UMjY=;
        b=pbilRl767NBZvf36GBlehwA/uKlHkN/akP8H2LWoAlCzDgL32mpqrFU2E79ncUsR0G
         3Q+Rb9Um3CaZ705wtweaO8VO4J/voJsghPcqwVGBV4pkiXNUPMiqRYyPOsYz+fSBMzu6
         JJ1Ho49PhttDQNVuIJQSdgx/AM0osHBNeRrzqPU9JZUTUdReGajQyYzLjvrk2ehEeZJm
         2wpSbOUJkcxdqMuVULKNnwEMBwD7bYvmzHI6fmDaDjDn5ghFKR9oMxI6lmwQ93WiA077
         ZURrzwC9WJ3chnjKszlK+u2M7BC4laZd2r5MdqFkDIBCeeR/+AQ4+CHHc15e0ifiOInM
         qOIA==
X-Gm-Message-State: AOAM531jEnp/xoED02qRgJ4RSozcYnydrSGHzquGxQbXUsMuiPWcKa2q
        nzSt1kz/8SGJPUKHMR13QLzWZIr+PRU=
X-Google-Smtp-Source: ABdhPJz3JT9oJcMLVlcv6cfLW1qMUjTO6DcAdGSgIxPsN4AkUJw11+2G0hrzGTtulDiqLsX3ibq5gg==
X-Received: by 2002:a17:902:a988:b0:158:9877:6c2c with SMTP id bh8-20020a170902a98800b0015898776c2cmr19721071plb.80.1652738896268;
        Mon, 16 May 2022 15:08:16 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2bd1:73e2:8118:8ba9])
        by smtp.gmail.com with ESMTPSA id e35-20020a635023000000b003db141a5f26sm7150034pgb.1.2022.05.16.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:08:15 -0700 (PDT)
Date:   Mon, 16 May 2022 15:08:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: sparcspkr: Fix refcount leak in bbc_beep_probe
Message-ID: <YoLLTBALPU1O8VI5@google.com>
References: <20220516081018.42728-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516081018.42728-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
On Mon, May 16, 2022 at 12:10:16PM +0400, Miaoqian Lin wrote:
> of_find_node_by_path() calls of_find_node_opts_by_path(),
> which returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 9c1a5077fdca ("input: Rewrite sparcspkr device probing.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Thank you for the patch.

>  drivers/input/misc/sparcspkr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
> index fe43e5557ed7..6a86900aa1fb 100644
> --- a/drivers/input/misc/sparcspkr.c
> +++ b/drivers/input/misc/sparcspkr.c
> @@ -206,11 +206,11 @@ static int bbc_beep_probe(struct platform_device *op)
>  	info = &state->u.bbc;
>  	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
>  	if (!info->clock_freq)
> -		goto out_free;
> +		goto out_put;
>  
>  	info->regs = of_ioremap(&op->resource[0], 0, 6, "bbc beep");
>  	if (!info->regs)
> -		goto out_free;
> +		goto out_put;
>  
>  	platform_set_drvdata(op, state);
>  
> @@ -218,11 +218,14 @@ static int bbc_beep_probe(struct platform_device *op)
>  	if (err)
>  		goto out_clear_drvdata;
>  
> +	of_node_put(dp);
> +

We do not really need to keep node pointer for that long, how about the
version of your patch below?

Thanks.

-- 
Dmitry


Input: sparcspkr - fix refcount leak in bbc_beep_probe

From: Miaoqian Lin <linmq006@gmail.com>

of_find_node_by_path() calls of_find_node_opts_by_path(),
which returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 9c1a5077fdca ("input: Rewrite sparcspkr device probing.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220516081018.42728-1-linmq006@gmail.com
Patchwork-Id: 12850379
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/sparcspkr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index fe43e5557ed7..cdcb7737c46a 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -205,6 +205,7 @@ static int bbc_beep_probe(struct platform_device *op)
 
 	info = &state->u.bbc;
 	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
+	of_node_put(dp);
 	if (!info->clock_freq)
 		goto out_free;
 
