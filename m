Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D94BCE35
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiBTLj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:39:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbiBTLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:39:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890631DDE;
        Sun, 20 Feb 2022 03:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18120B80CDD;
        Sun, 20 Feb 2022 11:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A1FC340E8;
        Sun, 20 Feb 2022 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645357144;
        bh=+CU4F09gW1jBdGn9D9BvL+RyHIoPA31D2oqtNT2Ket4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d/++ud/mknmxEatFHQl7zc4/SOTpe35Zw8tYVB0WkYJTKiQiKQuFMtzBCJOWBk2gY
         EXiOi0KexVIe+GDG1xMxaO9Qx88Zr624mfAMansh4SgfPRKl3m7J6OMvm9GscSL1Ad
         kCqwkKSp0ozLJlZCBZ+ut7m3zoqeA3A8rGIXkBnFalSFOYOaAG8/YtDYQcAk+GNL4a
         5UuL8gv7wP7e1JdhbChujxKDDsXTpQPdHTHDUueLDhb7m48GQBZqxnb57dLPbQH+aZ
         cXfUlpJOrrKYkjxg/9H2+keBOq/44MHz0xENSJZ24E425uflChoL8E7IZq00ZlGcJ8
         ehTzwWbciwDqQ==
Date:   Sun, 20 Feb 2022 11:45:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: Use
 devm_delayed_work_autocancel() to simplify code
Message-ID: <20220220114552.53fedd33@jic23-huawei>
In-Reply-To: <2626e6a057e40cd2271ef0e5f81d12e607bad5b4.1644776929.git.christophe.jaillet@wanadoo.fr>
References: <2626e6a057e40cd2271ef0e5f81d12e607bad5b4.1644776929.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Sun, 13 Feb 2022 19:29:05 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use devm_delayed_work_autocancel() instead of hand writing it. This is
> less verbose and saves a few lines of code.
> 
> devm_delayed_work_autocancel() uses devm_add_action() instead of
> devm_add_action_or_reset(). This is fine, because if the underlying memory
> allocation fails, no work has been scheduled yet. So there is nothing to
> undo.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Looks good to me, but I'd ideally like some input from someone familiar with
the driver.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-ams.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 8343c5f74121..6ffddf4038b8 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -12,6 +12,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -1348,11 +1349,6 @@ static void ams_clk_disable_unprepare(void *data)
>  	clk_disable_unprepare(data);
>  }
>  
> -static void ams_cancel_delayed_work(void *data)
> -{
> -	cancel_delayed_work(data);
> -}
> -
>  static int ams_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -1389,9 +1385,8 @@ static int ams_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
> -	ret = devm_add_action_or_reset(&pdev->dev, ams_cancel_delayed_work,
> -				       &ams->ams_unmask_work);
> +	ret = devm_delayed_work_autocancel(&pdev->dev, &ams->ams_unmask_work,
> +					   ams_unmask_worker);
>  	if (ret < 0)
>  		return ret;
>  

