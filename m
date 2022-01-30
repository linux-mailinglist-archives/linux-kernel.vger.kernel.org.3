Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19DB4A365C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 13:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354804AbiA3Mtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347052AbiA3Mt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 07:49:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3AEC061714;
        Sun, 30 Jan 2022 04:49:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A4A9611A1;
        Sun, 30 Jan 2022 12:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E639CC340E4;
        Sun, 30 Jan 2022 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643546967;
        bh=SvHf990N9OZ/M53+ectTQRnyiCwRR/WpgplqgrfkeB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NsZY3c9fANhTPm0mjJ9UXS3XPMOr7N2xk0ByXa6g1q+5Zw7APZtjao+WdhABzjT5J
         jKHH/m+xfacLDrOIwRV9h09R64R5/MMKie4MUdFeVbgj6hB90CsqfCkeOaFu1PcMQo
         SSWfG5QLs+fFWgprj5TNcGqa5gawQqxvbLJO2/xrx6iALKhCqF+tT+psDSxL/6zMbF
         csX3avDq09m+Lz5PcsBv+tOyqSpkLnuuKnuN3m8oBp5Yn5H0C3B2FBr+nyhnfbjyA+
         x+k5y1bkJf6sccMW2lf0wlDlTk9LZRS/wpWGczcBruw+9SgO0CnTgdTknrFm34VD2l
         u2Ua0Z5/8Y9/g==
Date:   Sun, 30 Jan 2022 12:55:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     eajames@linux.ibm.com, andy.shevchenko@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dps310: Add ACPI HID table
Message-ID: <20220130125551.7fc9bcd7@jic23-huawei>
In-Reply-To: <20220128023144.2050615-1-kai.heng.feng@canonical.com>
References: <20220128023144.2050615-1-kai.heng.feng@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 10:31:44 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> x86 boards may use ACPI HID "IFX3100" for the dps310 device.
> 
> Vendor told us feel free to add the ID and contact
> "Saumitra.Chafekar@infineon.com" for further questions.
> 
> So add an ACPI match table for that accordingly.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to the togreg branch of iio.git and pushed out as testing
on the off chance 0-day finds something we missed.

Thanks,

Jonathan

> ---
> v3:
>  - Drop redundant line and comma.
>  - Wording change.
> 
> v2:
>  - Drop ACPI_PTR().
>  - Add info from vendor.
> 
>  drivers/iio/pressure/dps310.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 0730380ceb692..36fb7ae0d0a9d 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -812,9 +812,16 @@ static const struct i2c_device_id dps310_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
>  
> +static const struct acpi_device_id dps310_acpi_match[] = {
> +	{ "IFX3100" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
> +
>  static struct i2c_driver dps310_driver = {
>  	.driver = {
>  		.name = DPS310_DEV_NAME,
> +		.acpi_match_table = dps310_acpi_match,
>  	},
>  	.probe = dps310_probe,
>  	.id_table = dps310_id,

