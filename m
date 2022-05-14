Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0E52725C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiENPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiENPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3BF62E6;
        Sat, 14 May 2022 08:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5F860F90;
        Sat, 14 May 2022 15:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C84C34115;
        Sat, 14 May 2022 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652540581;
        bh=jrynMDebaFTvWo4V2CiUg7ZFUbJHNgkLbj8yXQzhq1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nzaMar0L++m05lyExWvFgD/W/tIxhcTWy41ETyJEBbv7uWrOONMCWuA9a5RqaOjMi
         9ux04gKJ6v3SRU05gbdiv5nHJ5qkKfXFlcxSua9cLMicSRueOG6Zp4olEXhV6it8xV
         SPBZAaghxdG+1v1ieRxlgCj5Mwlphb4UjC+ASFm6bQtz1m1+upRq3zTV5qMrxL+Rg6
         zI/ZTbfu0s5tgJ7ekl/1dHqctIyHsenn07VB+qseO8WJqMJMOrp2zYehMunGHN+SQQ
         d6QDQrmx1biMtJ/lIYlMnsmmtdPYY96n18NbrXYs/GD0vJB8TsB1LPf6qspos1YUXs
         SinN7pqOTm4Aw==
Date:   Sat, 14 May 2022 16:11:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] iio: freq: admv1014: Fix warning about dubious x &
 !y and improve readability
Message-ID: <20220514161136.772fd848@jic23-huawei>
In-Reply-To: <20220511090006.90502-1-antoniu.miclaus@analog.com>
References: <20220511090006.90502-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Wed, 11 May 2022 12:00:06 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The warning comes from __BF_FIELD_CHECK()
> specifically
> 
> BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> 		 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
> 		 _pfx "value too large for the field"); \
> 
> The code was using !(enum value) which is not particularly easy to follow
> so replace that with explicit matching and use of ? 0 : 1; or ? 1 : 0;
> to improve readability.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Thanks. 

Applied tot he fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> changes in v2:
>  - fix the logic for the input mode set bits
>  drivers/iio/frequency/admv1014.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> index a7994f8e6b9b..1aac5665b5de 100644
> --- a/drivers/iio/frequency/admv1014.c
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -700,8 +700,10 @@ static int admv1014_init(struct admv1014_state *st)
>  			 ADMV1014_DET_EN_MSK;
>  
>  	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |
> -		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
> -		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
> +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
> +				(st->input_mode == ADMV1014_IF_MODE) ? 0 : 1) |
> +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
> +				(st->input_mode == ADMV1014_IF_MODE) ? 1 : 0) |
>  		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
>  
>  	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);

