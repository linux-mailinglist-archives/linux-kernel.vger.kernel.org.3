Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898AA5302B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiEVLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiEVLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:39:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C283BBEA;
        Sun, 22 May 2022 04:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C414B80B08;
        Sun, 22 May 2022 11:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A55C385AA;
        Sun, 22 May 2022 11:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653219560;
        bh=R3cMWESMPtbduNLMaekRkB5cyJb+GEmehK1+zJSrB58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRd6cnkRR7RnvyvMbZcf9kDtRG4wQIFgPK7fUE8YMQUW3nh7OKk/o5jwdlRonmbkd
         f16WOfqGqxgpic5zeIAeDtVEnED8jIBwcccLrmCI91zrJlCZuh/BgMLFTXDpxQ4ueH
         IkUbwDnUWsy3SPKpIMswF0nEv2iLJUfH68SlfFTy5pwdcMO0twrmDgLUuVoRerOuaL
         1T1H0H6weqBAGw4Vd0YQaVsmxMxsdD1WPUNKHRhgi5zQfVKkHzORlhY7OWpjkLhzF9
         pS4WZGdyTutITsw3euRcqmKpkmEZBJffE7MMx3xWoD5cC8gRjEgDZYmBDIfca0nz8i
         r9XeecNQrdxiw==
Date:   Sun, 22 May 2022 12:48:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: aspeed: Fix refcount leak in
 aspeed_adc_set_trim_data
Message-ID: <20220522124804.7ec5940a@jic23-huawei>
In-Reply-To: <20220516075206.34580-1-linmq006@gmail.com>
References: <20220516075206.34580-1-linmq006@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 11:52:02 +0400
Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_node_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: d0a4c17b4073 ("iio: adc: aspeed: Get and set trimming data.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

In the 'hopefully obviously correct' category so applied to the fixes
togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 0793d2474cdc..9341e0e0eb55 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -186,6 +186,7 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
>  		return -EOPNOTSUPP;
>  	}
>  	scu = syscon_node_to_regmap(syscon);
> +	of_node_put(syscon);
>  	if (IS_ERR(scu)) {
>  		dev_warn(data->dev, "Failed to get syscon regmap\n");
>  		return -EOPNOTSUPP;

