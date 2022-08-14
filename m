Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33B591F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiHNKOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHNKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:13:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55570201B9;
        Sun, 14 Aug 2022 03:13:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so6330437edb.9;
        Sun, 14 Aug 2022 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=s2xCRCS5m4i4+EfBqMdOEQInaq/ShuXp1FW8bVckG40=;
        b=WAX9jpeTuNWjlK8hqNNxEsbMZ7M3aD+MgDj/BVKuUiGwTEAG17A1knJU8BBwA4hJLI
         /HAobNHHkFzxsZDlBjIj+o+3o/+6iXtKmwc4xnaXjaDOY912JF8twRccony2QhKgvpfW
         TcyGggtlXvNwPPIoSkb9Lt9CIi6oNAHS3KlNenppEF7SnhcoEnZBDDQhFLgLWXfvP3At
         Yl4REhB2gt4ghQ67RDOKrPaGLyt+LOAcuXAsF+P+cbJo7vI3lVKl9iu7p857sQEhgSZn
         PfRVlFm+SkktqecyYSYVmEej1B8TBwHPv0SHJjpB3R9xoBcQMFRfxWnOlbgMhqYakwnF
         dnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=s2xCRCS5m4i4+EfBqMdOEQInaq/ShuXp1FW8bVckG40=;
        b=16NthCSxW38YvtEGA0uNUXkwGw7KtGPUco96D3YsHI27lEM8b+WdrEyyYTiS2ZnttH
         Cak7uRChjEtu8oAalGGwICqh7SWGg0kkWaAraYuc7pMMzTGfImR3/NHHgfP+Bq6EBnjp
         iT/2LuYcpyPr+JtQj8CXbtLw+NfbJiC7z0eZ4sW08IRelUd61a1QxFXiRxCD0xr3fe1Z
         4+RgA8SkMh4ZBoPMkbeTvQOnYL+RvjIQ/a5uw4BTLmJb0L/lpMdO9RG+yDdb6x4AXaLA
         U+KNNTFEk1HpFprcqeiKBpa7fe+UbB2Y7n3I5nM367tLUYAQoI0B0lnXN6QvMDKn6EUK
         NEXQ==
X-Gm-Message-State: ACgBeo0MYfCN2IF9EOcnRL4LifFLCwX6VlBT2HtW+POp15iA9n2a0iy3
        c55yIGLg35H+lTyKGeSBdzzl3G6p854M6w==
X-Google-Smtp-Source: AA6agR42k51Lq8Yp/MP5cdbyrsfugOi+nLPScpkpXy8R/epCeq6yMXoPKsS9t/LJLtkE6kyFkTmLCQ==
X-Received: by 2002:a05:6402:331f:b0:43d:931c:6945 with SMTP id e31-20020a056402331f00b0043d931c6945mr10280751eda.199.1660472033733;
        Sun, 14 Aug 2022 03:13:53 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id c18-20020a056402121200b0043cc2c9f5adsm4496602edw.40.2022.08.14.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:13:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, cgel.zte@gmail.com
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] crypto: sun8i-ce:using the pm_runtime_resume_and_get  to simplify the code
Date:   Sun, 14 Aug 2022 12:13:52 +0200
Message-ID: <8140378.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20220802074820.1648786-1-ye.xingchen@zte.com.cn>
References: <20220802074820.1648786-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 02. avgust 2022 ob 09:48:20 CEST je cgel.zte@gmail.com napisal(a):
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
> and pm_runtime_put_noidle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
> b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c index
> 19cd2e52f89d..ef9cfc61af32 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
> @@ -54,9 +54,8 @@ static int sun8i_ce_trng_read(struct hwrng *rng, void
> *data, size_t max, bool wa goto err_dst;
>  	}
> 
> -	err = pm_runtime_get_sync(ce->dev);
> +	err = pm_runtime_resume_and_get(ce->dev);
>  	if (err < 0) {
> -		pm_runtime_put_noidle(ce->dev);
>  		goto err_pm;
>  	}

You should also remove braces, since there is only one line left.

With that fixed:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



