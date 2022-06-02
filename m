Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADAB53B3CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiFBGpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiFBGpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E29A988;
        Wed,  1 Jun 2022 23:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6207F61780;
        Thu,  2 Jun 2022 06:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DAC385A5;
        Thu,  2 Jun 2022 06:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654152332;
        bh=2zv03libTPFBXLeHn+11rPpU3Zh5JwBccfACN55f9jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVbAFtL+vUBULTxSlQRQdvG8oNQErHcxDMOc+co1dGehg6d7O1EXH2e1QDYl57s04
         wfsUhEMPJsBKv0MDk4oUKkJBVRNKLj7hWKnXFK51Mg6I8hPNkRi21fuSlUDcB7GL7D
         Kux6E4Q59CvhIazpXoW820XYZ2b3p2N3rq5IEFIHvwvmUJdpfTLqxIOQmgoEirbm9g
         qnbIpyGlhh/41uuy0fK8uN4TxodQSUeRNy8Ooo2A6v7lo8ffEIP3eY8eo3Bn4vuihB
         8XMG4my/syN+ug52SCYsCcE7uAZp73uBpmBeGXg35oezdC8Oej6ho4tBrPKONCBSfY
         XBYrNbnniAD7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nweaG-0003AY-JA; Thu, 02 Jun 2022 08:45:28 +0200
Date:   Thu, 2 Jun 2022 08:45:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        gushengxian <gushengxian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: flexcop-usb: fix sanity check of bNumEndpoints
Message-ID: <YphciEToNtxIUrzU@hovoldconsulting.com>
References: <20220602055027.849014-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602055027.849014-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 01:50:24PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Commit d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type
> ") adds a sanity check for endpoint[1], but fails to modify the sanity
> check of bNumEndpoints.
> 
> Fix this by modifying the sanity check of bNumEndpoints to 2.

Are you sure that d725d20e81c2 ("media: flexcop-usb: sanity checking of
endpoint type) was correct?

> Fixes: d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
> index 7835bb0f32fc..eb54bfdda01f 100644
> --- a/drivers/media/usb/b2c2/flexcop-usb.c
> +++ b/drivers/media/usb/b2c2/flexcop-usb.c
> @@ -509,7 +509,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
>  		return ret;
>  	}
>  
> -	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
> +	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 2)
>  		return -ENODEV;
>  	if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[1].desc))
>  		return -ENODEV;

It looks like it should have verified the type of endpoint[0] here
instead.

Oliver?

Johan
