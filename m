Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBE4D89E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiCNQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbiCNQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:38:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D337AA9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:37:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g8so9686538qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dpBAoVsBs5pmN0ITaSoUHzzdcUkZXl3b73bSC3GUG9U=;
        b=TA0eK4AXTtiOBAwdWRCR6Nv6wWYLsoxxDFGDGXc4JJ1XMmlDmv2YlrJy0HmkG68Ejn
         I5HoTb/W9Rv6icvi3mH10PiPHPBH7zOUVRP89Z3L3vVSc4BJt822XLFyediPKA/7LCQW
         C8kE6glKqF1Y4yMxRHzXgsA+v+FKf13UQfGkgGCNFfIA8JiYswThwEjqOJ+F0tdl4WZg
         SM8u8kxhbBFI+PHfuoHPA8CwyySHEGMM//DvgaD38+DVdE5ocmXYDMzMnq4uSGFcj1OM
         y5eEXj6z35wZL2YL0fI4oUdSQyX6bfDc2TtSxjpdnaialOlsdhCUnhaawp9nVZ5oKTBc
         KxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpBAoVsBs5pmN0ITaSoUHzzdcUkZXl3b73bSC3GUG9U=;
        b=FRIWgVsuITUB2j1i597UKV/EYfvDGnPx4e2y45cuu7tMa6YKT8bGZP5BzBc8OhFyw6
         Exn0JL+uZpyslti1M27XGVJtkk+ycWV4jS8qVcKvNXFQeQ1LSHfP2J/4w1MhXrDWENhZ
         lR33a2O81rmbITn73GrhDfG6Q8h18xqBDN1aNJE8d4t+vykraeKlzVRqipaivKBGXgCl
         ykzxp2Z0sfyqeXJ9X9ERliJUBliY5iKMVn3Gcvqa0thBiW74Ha76yye8N+EvaWo8Edxw
         X8uQkk8PxOBf5/9pVslN82tzHSPrGWDrnIq7nj9zJYbYQkazqxAG4z28EtkdvZ/lcrq8
         xW7A==
X-Gm-Message-State: AOAM533kVUNdIYD46gJSVbM3MH2QBi/Vc9GG0np1UnZQuRszGnGg3JcZ
        iBN1UocvudB07XrjK+VKQ0uvbA==
X-Google-Smtp-Source: ABdhPJxMjebTF+bOmlEycAd5SxCn5ZJwAsh0pbHUVpZ5dmiWF4Lhr8C02y08OzygCSHYBFNzIpctfA==
X-Received: by 2002:a37:9a13:0:b0:67b:11f3:231f with SMTP id c19-20020a379a13000000b0067b11f3231fmr14854160qke.641.1647275827168;
        Mon, 14 Mar 2022 09:37:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm11410178qtg.0.2022.03.14.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:37:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nTngv-000Q4z-HM; Mon, 14 Mar 2022 13:37:05 -0300
Date:   Mon, 14 Mar 2022 13:37:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, weiyongjun1@huawei.com, peterhuewe@gmx.de,
        jarkko@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Message-ID: <20220314163705.GA64706@ziepe.ca>
References: <20220307104827.40843-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307104827.40843-1-guozihua@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:48:27PM +0800, GUO Zihua wrote:
> Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
> call put_device on error, while tpm->devs is left untouched. Call
> put_device on tpm->devs as well if devm_add_action_or_reset returns an
> error.
> 
> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index b009e7479b70..0a92334e8c40 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
>  	return 0;
>  }
>  
> +static void tpm_chip_free(struct tpm_chip *chip)
> +{
> +	put_device(&chip->devs);
> +	put_device(&chip->dev);
> +}
> +
>  /**
>   * tpm_chip_alloc() - allocate a new struct tpm_chip instance
>   * @pdev: device to which the chip is associated
> @@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	return chip;
>  
>  out:
> -	put_device(&chip->devs);
> -	put_device(&chip->dev);
> +	tpm_chip_free(chip);
>  	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_alloc);
> @@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  		return chip;
>  
>  	rc = devm_add_action_or_reset(pdev,
> -				      (void (*)(void *)) put_device,
> -				      &chip->dev);
> +				      (void (*)(void *)) tpm_chip_free,
> +				      chip);
>  	if (rc)

This looks like the same issue as was adressed by the recent discussion..

Jason
