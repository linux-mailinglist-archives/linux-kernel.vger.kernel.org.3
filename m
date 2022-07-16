Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15D57702E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiGPQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:48:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE1C11479;
        Sat, 16 Jul 2022 09:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24E1DB8091D;
        Sat, 16 Jul 2022 16:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D9C34114;
        Sat, 16 Jul 2022 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657990133;
        bh=2b4lZh13eztCglSb1wAaqWNmDsWuOdW82qKI4EFLnK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWAUk94PM4eZkvREgCCl26kaWOHuOuBZp2qeW/R8X069N4+KizjlIeZxjF/7vrd75
         1fyhtb4ICkYFnQXVk+YCTM2Nnn1BYTepRi61RN6mbvONK9zDgXOGX54cavzoK0OMUd
         kAmb27mob2lU/SrHKxPBhJtUfEU+XGryY88Tqj/u5OcEeoyqO36c0F45Jeg1hOKpq7
         6VHJ7sWwFN5bvDUnwvbIp9jnm9VS9u4E0DtyppCBfce1IOXL8Eu2ZZljK9W2EfZ5nP
         lETdarkXcK498Co5bHNplcVJmQHzSrx5r8bIwP2792FC1kB8Fmj5HIgityqqmACedP
         EjIojbyNxhl3A==
Date:   Sat, 16 Jul 2022 17:58:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: rm3100: do not explicity set
 INDIO_BUFFER_TRIGGERED mode
Message-ID: <20220716175847.27e91729@jic23-huawei>
In-Reply-To: <20220702085005.31666-1-marcus.folkesson@gmail.com>
References: <20220702085005.31666-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Jul 2022 10:50:05 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The core sets INDIO_BUFFER_TRIGGERED as part of
> devm_iio_triggered_buffer_setup().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
You seem to be on a fairly old tree.

Anyhow, the issue is still there, so I dealt with the fuzz.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it. Not I'll be rebasing on rc1 once available.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/rm3100-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 26195733ea3e..060914c63969 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -552,7 +552,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	indio_dev->info = &rm3100_info;
>  	indio_dev->channels = rm3100_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> -	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  
>  	if (!irq)

