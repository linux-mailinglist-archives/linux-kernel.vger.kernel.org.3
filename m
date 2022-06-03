Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8A53CD9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344162AbiFCQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbiFCQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:57:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4D21A071;
        Fri,  3 Jun 2022 09:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64F98B8238F;
        Fri,  3 Jun 2022 16:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA25C385A9;
        Fri,  3 Jun 2022 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654275438;
        bh=JVE9HbaugiiB51hEgk5LaOAfHPFZnwaQGCoqDbrEHfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cU5BKYLhgvfC7UST/dXizUd+1JDAT/niCvUbi9UZ5JYETNHyehaa3BJvn2TPRI7wQ
         mDsHbY1T2H4UyU5JOmnTjP20VLzbZlYYWAZ0nHyTDTZ9VhsrGCU/dogqW5QfzPlwaC
         SLXZhpRI9t0mK30L44Am8OXPEF6U3HBesLKeqA3CvOPXKGk/saujMiY5aUZVefdIAR
         Uadu17PfOZVaIFBrI+T9mSrePP4JQEXgHp1NPseHJTyQhvZg9H+V2vu7iHJQBoi+7r
         Wtg2SHHzuYdQCcM0wEGoYDnR8pBJcXkRUOFRAtkZW9YUSLkhkhfdK9jLy1lwhGLTVi
         Y0rESlg2T9XhA==
Date:   Fri, 3 Jun 2022 18:06:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx_common: Allow IIO core to
 take care of firmware node
Message-ID: <20220603180618.4b643391@jic23-huawei>
In-Reply-To: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com>
References: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com>
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

On Mon, 30 May 2022 20:43:26 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core correctly will take care of firmware node if it's not set in
> the driver. Drop ACPI and OF specifics from the driver and allow IIO
> core to handle this.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks fine to me.  As such I'll apply it now, but Gwendal, you've
been active with this driver recently so if you have time to sanity check
that would be great.  Once I've caught up with new stuff I plan to check
where we are with your various series on this driver.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx_common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index 8ad814d96b7e..6bb68c1835da 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -5,7 +5,6 @@
>   * Common part of most Semtech SAR sensor.
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/byteorder/generic.h>
>  #include <linux/delay.h>
> @@ -520,8 +519,6 @@ int sx_common_probe(struct i2c_client *client,
>  	if (ret)
>  		return dev_err_probe(dev, ret, "error reading WHOAMI\n");
>  
> -	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> -	indio_dev->dev.of_node = client->dev.of_node;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	indio_dev->channels =  data->chip_info->iio_channels;

