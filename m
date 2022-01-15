Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7248F8E0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiAOSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiAOSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA89CC061574;
        Sat, 15 Jan 2022 10:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E28AAB80B21;
        Sat, 15 Jan 2022 18:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F58C36AF3;
        Sat, 15 Jan 2022 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642272614;
        bh=UIo7EekZ67jB1nDi/znzWuTLgVtn/O12F/o980the4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ct+BKj90U+6lDtpCeH2773zAcqoNUxPXVKUb/mAhdM8hbYHWmO/I95SSIECQpUdY8
         Xrglik12PS4vTCJSh+Hd+1TAd01a+00zw90ccYOA0bFlX/C+/aVxh+3szl4yaUdJuR
         f3vuPbaC+MxtTPtkiK/c/ChnlKL9hv7xO3NrHyrfhdNU9ogKMAe5TQwFRC4Ktv/b4D
         ZALNixB2qegUuQQE9p3b2EsRQMdZZFqb02TsNAsf3PPsNVxXMM9gmFR+aO47AfPaKO
         uVpssXXixtLFvqGNmr62v/qlCeIBAzzQL7/bH5mquo4TwnY6B/sQZ1+Xd3sGOy88Pv
         OmdlLGGB2jxWw==
Date:   Sat, 15 Jan 2022 18:56:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix mask used for setting AIN_BUFP &
 AIN_BUFM bits
Message-ID: <20220115185615.403ee183@jic23-huawei>
In-Reply-To: <20220112200036.694490-1-cosmin.tanislav@analog.com>
References: <20220112200036.694490-1-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 22:00:36 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> According to page 90 of the datasheet [1], AIN_BUFP is bit 6 and
> AIN_BUFM is bit 5 of the CONFIG_0 -> CONFIG_7 registers.
> 
> Fix the mask used for setting these bits.
> 
> [1]: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7124-8.pdf
> 
> Fixes: 0eaecea6e487 ("iio: adc: ad7124: Add buffered input support")
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Curious that didn't cause problems anyone noticed before. Ah well.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Note that branch will probably be rebased after rc1 as I have some
other things that need rc1 which will be in same pull request.

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index e45c600fccc0..18c154afbd7a 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -76,7 +76,7 @@
>  #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
>  #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
>  #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
> -#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
> +#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(6, 5)
>  #define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
>  
>  /* AD7124_FILTER_X */

