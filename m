Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157614F046A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbiDBPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiDBPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:31:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3212342E;
        Sat,  2 Apr 2022 08:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBF0BB80990;
        Sat,  2 Apr 2022 15:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C983EC340EC;
        Sat,  2 Apr 2022 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648913382;
        bh=Ef9VlYwPAyUnvztGaMgffvzv4Ib7J175ViIcW3rXYpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c1zDfDzzrSDB2gkDsugjNMvLx2Vl3oS4zbI8A9Dnrh0mbCNvL/fsnK9WFQwjargvV
         S9LJJw7Ho4ezy2Q8E8bwfAcmOqvE5uUySEGaePlW2FReEfZdUM0ZKa/dBz80KYchuF
         wiBhGlUZ0S78IYoc4SZRQOBazdWnau25x4CHk7Pf09ZSWwdjTC8G4PfJ2tpFG/4nr5
         fE+0iOVwyDe2S4+loWEouYUqfh0SwR3YotDcEAPY7BHWjc5AmfMFQzN353XgCQXqHz
         1ltA5xvzCSkv7LUzTl7zbujWud7xiEMcYtiwqnAtU/sRjaZKABSc7isemeU6WhQqWK
         aX4oqKM9JS9wA==
Date:   Sat, 2 Apr 2022 16:37:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
 for list_for_each_entry_continue_reverse()
Message-ID: <20220402163645.17e911fd@jic23-huawei>
In-Reply-To: <20220331230632.957634-1-jakobkoschel@gmail.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri,  1 Apr 2022 01:06:30 +0200
Jakob Koschel <jakobkoschel@gmail.com> wrote:

> In preparation to limit the scope of the list iterator variable to the
> list traversal loop, use a dedicated pointer to iterate through the
> list [1].
> 
> Since that variable should not be used past the loop iteration, a
> separate variable is used to 'remember the current location within the
> loop'.
> 
> To either continue iterating from that position or start a new
> iteration (if the previous iteration was complete) list_prepare_entry()
> is used.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Hi Jakob,

Series applied to the togreg branch of iio.git and pushed out as testing to let
0-day take a poke at it. Note I'll be rebasing that branch on rc1 once available
before pushing it out for linux-next to pick up.

Note I'm happy to add additional tags if anyone else takes a look at it.

Thanks

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 208b5193c621..151a77c2affd 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1059,7 +1059,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	struct iio_device_config *config)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	struct iio_buffer *buffer;
> +	struct iio_buffer *buffer, *tmp = NULL;
>  	int ret;
> 
>  	indio_dev->active_scan_mask = config->scan_mask;
> @@ -1097,8 +1097,10 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> 
>  	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
>  		ret = iio_buffer_enable(buffer, indio_dev);
> -		if (ret)
> +		if (ret) {
> +			tmp = buffer;
>  			goto err_disable_buffers;
> +		}
>  	}
> 
>  	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> @@ -1125,6 +1127,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  					     indio_dev->pollfunc);
>  	}
>  err_disable_buffers:
> +	buffer = list_prepare_entry(tmp, &iio_dev_opaque->buffer_list, buffer_list);
>  	list_for_each_entry_continue_reverse(buffer, &iio_dev_opaque->buffer_list,
>  					     buffer_list)
>  		iio_buffer_disable(buffer, indio_dev);
> 
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
> --
> 2.25.1
> 

