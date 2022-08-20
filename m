Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0629059ADCE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbiHTMH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbiHTMHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:07:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F39D126;
        Sat, 20 Aug 2022 05:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82859B80B8B;
        Sat, 20 Aug 2022 12:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FFFC433C1;
        Sat, 20 Aug 2022 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660997238;
        bh=ET+Eoevr87hUV2gzJcF2VdzryEshL8SZbQM1YaN7lUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mu0IER8MeSaURN+xVaCZP5DTyTFbAjgJUHn8FU4EvDvbCnTbGh5mZjZpS6EaOUTWj
         /+7+KV1mOaWpPRvtZBJsv11uEO6Hi7ZCq/3qWAv4yxEyM+ZQYzAIMjSYI0sXxiNBBF
         hhB/nE0KZtNqwLp3RomqB/knThT3xUknX693mhevrna0oXgwxRYqvqNJ9vCVLeSFvp
         GIqPsY09eiJhCZy6bT7sD9UaCQuHy55Mli5LTxiWeMvXAyaUPECma0oICqpYyHeg7n
         ajPBOwuUWT4twuhtyLj23v1j4pTi1ScHzrHXOu+wx0//fIqraS8Zkb7ZqQsjZxJASf
         GxRtIytoZylMA==
Date:   Sat, 20 Aug 2022 13:17:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: Avoid multiple line dereference for mask
Message-ID: <20220820131754.729d59a9@jic23-huawei>
In-Reply-To: <20220819182012.219523-1-joetalbott@gmail.com>
References: <20220819182012.219523-1-joetalbott@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 19 Aug 2022 14:20:12 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> Prefer lines > 80 characters over splitting dereferences across multiple
> lines. Reported by checkpatch.pl.
> 
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
Applied to the togreg branch of iio.git which will get pushed out initially
as testing for all the normal reasons...

Jonathan

> ---
> changes in v2:
> * Don't use a temporary variable.
> 
>  drivers/iio/industrialio-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 67d3d01d2dac..d38623c046cc 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1303,8 +1303,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  
>  	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
>  						  IIO_SEPARATE,
> -						  &chan->
> -						  info_mask_separate_available);
> +						  &chan->info_mask_separate_available);
>  	if (ret < 0)
>  		return ret;
>  	attrcount += ret;
> @@ -1318,8 +1317,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  
>  	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
>  						  IIO_SHARED_BY_TYPE,
> -						  &chan->
> -						  info_mask_shared_by_type_available);
> +						  &chan->info_mask_shared_by_type_available);
>  	if (ret < 0)
>  		return ret;
>  	attrcount += ret;

