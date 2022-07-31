Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB83585ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiGaMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGaMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:23:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519095A0;
        Sun, 31 Jul 2022 05:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC771B80D1D;
        Sun, 31 Jul 2022 12:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318CC433D6;
        Sun, 31 Jul 2022 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659270225;
        bh=/xtBcibcR1O/mDtgYXRCM38rkzxKP0vEboH12OrYl/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lcB2cZZx3vzEDtHd+pVcUVXfSGhO2Nb5JUOMkW9Xe2A9IoviKOIvFXelW1ob2o2rI
         KKylV+qAbwZoRUxFaA5cza6t5mMBWHnhfkTLww/LEqg3OkQmtG1aTrxTTBsGwFDfPv
         aBM4OnW2D8ZROPGa9xEi0V8N54P6Q39aZSFtoAMfqbu/nEMCaYbxtde86SMYN5kBBf
         DSkkb5mQG/K2LlhqRd7PR2ygbEsBNTiwyAXexfdl7ghO4qS1NuAEivgLyfQCcm5AKl
         DS1R20B3LauaEnTPVyC0AFbCETBPjS1a8F3CcFZ6/NPuNgWAgZ1NSPwhTjkQPHJ/Js
         nBZT1kZ6zAA+A==
Date:   Sun, 31 Jul 2022 13:33:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: pressure: dlhl60d: Don't take garbage into
 consideration when reading data
Message-ID: <20220731133357.5705df25@jic23-huawei>
In-Reply-To: <20220726142048.4494-1-andriy.shevchenko@linux.intel.com>
References: <20220726142048.4494-1-andriy.shevchenko@linux.intel.com>
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

On Tue, 26 Jul 2022 17:20:48 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Both pressure and temperature are 24-bit long. Use proper accessors
> instead of overlapping readings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks correct to me, but it made me scratch my head just enough that I'd
like Tomislav to take a look if possible.  So give me a poke if this
hasn't progressed in a few weeks time.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/dlhl60d.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
> index 5f6bb3603a8b..f0b0d198c6d4 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -129,9 +129,8 @@ static int dlh_read_direct(struct dlh_state *st,
>  	if (ret)
>  		return ret;
>  
> -	*pressure = get_unaligned_be32(&st->rx_buf[1]) >> 8;
> -	*temperature = get_unaligned_be32(&st->rx_buf[3]) &
> -		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
> +	*pressure = get_unaligned_be24(&st->rx_buf[1]);
> +	*temperature = get_unaligned_be24(&st->rx_buf[4]);
>  
>  	return 0;
>  }

