Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865F4BCE90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiBTNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:11:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiBTNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90004ECDB;
        Sun, 20 Feb 2022 05:11:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208EA61170;
        Sun, 20 Feb 2022 13:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01FCC340E8;
        Sun, 20 Feb 2022 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645362678;
        bh=AcZOgu0tuVyGYdY45Zu3DvF/1IChW8HjkuF8aWEB+7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GbzrqlkHlTXdq1wgMpkUMZQBNYkxxUdO6/mJpXzYNCOYmKzb7JpdWya9UlWN7NbJ4
         Egnxx2krA4qM4Pq7nDQItkUUKNi/80wiIdyADYcwGuz539WzziWDmQtZHDcj72W0gQ
         lvY97FZM6NbvyXNpxg+DYv9Yr1Udq9gQrWaymWvJStyVGc0D8wb5+vIWBwTdd7Nqfw
         9Yc5Quwq7Yt2MIO3Tx0IknNFZWhZrPGaxbAllUx2zeDuC31D9Fd0dCKvEFEacbum7l
         W32sYLXfYqqCintI/xHc7J6YlWtrXYbRR4qxP9nLON0xgl2WPbJjAT5LJ02q3mBKKS
         ZHv9O3NeXD38g==
Date:   Sun, 20 Feb 2022 13:18:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nandor Han <nandor.han@vaisala.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iio: core: provide a default value `label` property
Message-ID: <20220220131809.1bc184e0@jic23-huawei>
In-Reply-To: <20220216135604.3435769-1-nandor.han@vaisala.com>
References: <20220216135604.3435769-1-nandor.han@vaisala.com>
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

On Wed, 16 Feb 2022 15:56:04 +0200
Nandor Han <nandor.han@vaisala.com> wrote:

> The label property is used to correctly identify the same IIO device
> over reboots. The implementation requires that a value will be provided
> through device-tree. This sometime could requires many changes to
> device-trees when multiple devices want to use the label property.
> In order to prevent this, we could use the device-tree node
> name as default value. The device-tree node name is unique and
> also reflects the device which makes it a good choice as default value.
> This change is backward compatible since doesn't affect the users that
> do configure a label using the device-tree or the ones that are not
> using the labels at all.
> 
> Use the device-tree node name as a default value for `label` property,
> in case there isn't one configured through device-tree.

Interesting idea.  However a few concerns come to mind.
1) If we start having a default for this, then it will get used as ABI
   and if a label is applied later to the DT then we will end up breaking
   userspace scripts.
2) If we do this it should be firmware agnostics (we need to fix
   the existing code to be such as well).
3) Is the node name always unique (think multiple accelerometers on
   different i2c masters)?
3) I'm fairly sure this information is readily available anyway.
   either via the of_node link for the iio\:deviceX 
   So why not have your usespace use that instead of label?
   I'm not a fan of duplicating information that is readily available
   anyway - be it as name and reg in the of_node directory.

Thanks,

Jonathan

> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
> 
> Notes:
>     Testing
>     -------
>     Using mx6sxsabresd dev board with device-tree:
>     ```
>     &adc1 {
>         vref-supply = <&reg_vref_3v3>;
>         label = "adc1";
>         status = "okay";
>     };
>     
>     &adc2 {
>         vref-supply = <&reg_vref_3v3>;
>         status = "okay";
>     };
>     ```
>     1. Verify that label property is visible and readable:PASS
>     > iio:device0 # ls -la label  
>     -r--r--r--    1 root     root          4096 Jan  1 00:00 label
>     > iio:device0 # cat label  
>     adc1
>     ```
>     2. Verify that default label property is used for adc2 device: PASS
>     ```
>     > iio:device1 # cat label  
>     adc@2284000
>     ```
> 
>  drivers/iio/industrialio-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..bd26df90ce41 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1895,6 +1895,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	const char *label;
> +	const char *node_name;
>  	int ret;
>  
>  	if (!indio_dev->info)
> @@ -1906,8 +1907,13 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>  
>  	label = of_get_property(indio_dev->dev.of_node, "label", NULL);
> -	if (label)
> +	if (label) {
>  		indio_dev->label = label;
> +	} else {
> +		node_name = of_node_full_name(indio_dev->dev.of_node);
> +		if (node_name)
> +			indio_dev->label = node_name;
> +	}
>  
>  	ret = iio_check_unique_scan_index(indio_dev);
>  	if (ret < 0)

