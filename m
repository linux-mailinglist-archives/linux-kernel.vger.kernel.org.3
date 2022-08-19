Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAB059A426
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354652AbiHSRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354713AbiHSRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3819B49F;
        Fri, 19 Aug 2022 09:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CE84617C8;
        Fri, 19 Aug 2022 16:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C046C433C1;
        Fri, 19 Aug 2022 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660928300;
        bh=B7wtpYbVqvYrqMVwSCIUP06XU/CcJjX43wllSxU3raA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VtLkFKrlMnUXiYhuec+gqjSTXauPmLHeOEBwx4q2IksrWF37uxCNoMeddSUoB/GGu
         OvtwHiTjwrtn9KaBkWm9SUCxJwLhe76meS1lB7MQA1+DyeD9u2xvbBHl2Pl18eUzUa
         hA4sLAbJrjp3FC/sTdm9FoTYjUnNN/55tQwRan2+kbj5CxPIIe+Xb5AKlPG3BQKvUw
         44/4tHYpf0b47Q3lcNd7lZSHExJm7BDJt6C/fYEsgi/xVrX4BpJrdcCMw1oFoxzhWz
         KMULMsK32Qj+UUwKnxXd77R362pH+Rsqhh/3pbKpf1Q6qvDAyCYnQlDrAQPJVyvyZh
         cFVzqonZz5Ztg==
Date:   Fri, 19 Aug 2022 18:08:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: frequency: admv1014: return -EINVAL directly
Message-ID: <20220819180856.5a1d4e5a@jic23-huawei>
In-Reply-To: <20220819104117.4600-1-antoniu.miclaus@analog.com>
References: <20220819104117.4600-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 13:41:17 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Remove extra step where the error code is assigned to the `ret`
> variable.
> 
> Return instead error code directly.
> 
> Fixes: f4eb9ac ("iio: frequency: admv1014: add support for ADMV1014")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Change is fine, but I've dropped the fixes tag. The code before this
wasn't broken, just longer than it needed to be. We don't want the noise
of this getting backported because someone sees the fixes tag and thinks
there is a reason it needs to be.

Applied to the togreg branch of iio.git
Thanks,

Jonathan


 
> ---
>  drivers/iio/frequency/admv1014.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> index 865addd10db4..bb5e1feef42b 100644
> --- a/drivers/iio/frequency/admv1014.c
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -669,8 +669,7 @@ static int admv1014_init(struct admv1014_state *st)
>  	chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
>  	if (chip_id != ADMV1014_CHIP_ID) {
>  		dev_err(&spi->dev, "Invalid Chip ID.\n");
> -		ret = -EINVAL;
> -		return ret;
> +		return -EINVAL;
>  	}
>  
>  	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,

