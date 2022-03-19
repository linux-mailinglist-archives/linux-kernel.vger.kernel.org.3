Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9944DE90A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbiCSPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbiCSPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:32:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBA25278F;
        Sat, 19 Mar 2022 08:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31412B801BD;
        Sat, 19 Mar 2022 15:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED363C340EC;
        Sat, 19 Mar 2022 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647703876;
        bh=HsKRicTJPFvzoDCAO0YqkVB0YHJYjH6+NNPct+/DRyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S3Xc8i8MkvENmKsIi+24Ph154zItXKI7v5vpRqYA3t2K317NJVXnCBhVp5VcHngdi
         xKhH0ddcBN4xpFcsJUaGC/BIA4NpTcS6JLXy4fuvIeW2EEfvJU1UCNrjwHi9WnbMwc
         DPLi9Gre3IwGzgKrLij22Z38IJP+wcFvteqhM/03JT/XaoE2Q4v4dbFgxKJKuLrNo1
         9bom5KO3SyzzMkRQlSeABX8avRETTAiA+SpzlI4vwWRb01rMXzqrwIBwAOdWPSwpvz
         mqNgbQdIPUFEFDExZc3QNWZXVPaGmMoaehw4mikxgJMSYAAdvvsEV/YCPA6hDLWCxc
         q6irFrWwiLB+w==
Date:   Sat, 19 Mar 2022 15:38:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] iio: adc: ad7124: Remove shift from scan_type
Message-ID: <20220319153841.2483194a@jic23-huawei>
In-Reply-To: <20220318162722.51215-2-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
        <20220318162722.51215-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:27:15 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> The 24 bits data is stored in 32 bits in BE. There
> is no need to shift it. This confuses user-space apps.
> 
> Fixes: b3af341bbd966 ("iio: adc: Add ad7124 support")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Hi Alexandru,

Just to confirm my understanding (which gets a bit messy when endian
conversions are involved - and it occurs to me that our docs
are not great on how to handle endian conversions with shifts).

With a little endian cpu:
After userspace performs the 32bit big endian to little endian conversion
the value the shift would have previously dropped the bottom 8 bits
of the channel reading?

Looking at what ad_sigma_delta is doing it's documented as
leaving the upper 8 bits as 0 so this would make sense.

Have I understood the issue correctly?

I'll need to hold this one for now as I'll need to rebase the
fixes-togreg branch of iio.git after rc1 is available.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ad7124.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 998a342d51a6..7249db2c4422 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -188,7 +188,6 @@ static const struct iio_chan_spec ad7124_channel_template = {
>  		.sign = 'u',
>  		.realbits = 24,
>  		.storagebits = 32,
> -		.shift = 8,
>  		.endianness = IIO_BE,
>  	},
>  };

