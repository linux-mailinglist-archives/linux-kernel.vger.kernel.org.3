Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A785998E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348182AbiHSJm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbiHSJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0ED1D0C9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A042615D5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502A6C433D6;
        Fri, 19 Aug 2022 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660902142;
        bh=pEN+et5gf6W626fbns6sKMRGFSpCUpImxJQGhoBbmn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCorilECWp86FSIJOu7M4oaEdM3MAsWX/zHqayk7i5SYDEBuY+2MjZl3DvWef19Vd
         X8ciVRr/Kl/QZaKLkL9VIyrxwb8NlS+7whX2hTIczPU2XFfNm3bRYe0Ac1Qjo1+1a0
         fD8g65kmdKHUr26PqfHgQN6h3oYbl/bH6VGHTipo=
Date:   Fri, 19 Aug 2022 11:42:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH -next] driver core: switch to use dev_err_probe()
Message-ID: <Yv9a9+iREzQWYecQ@kroah.com>
References: <20220819094656.1945653-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819094656.1945653-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:46:56PM +0800, Yang Yingliang wrote:
> Use dev_err_probe() to simplify code and print error code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/base/core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 753e7cca0f40..e51a09f9d0ec 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2507,11 +2507,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
>  	int rc;
>  
>  	rc = kobject_synth_uevent(&dev->kobj, buf, count);
> -
> -	if (rc) {
> -		dev_err(dev, "uevent: failed to send synthetic uevent\n");
> -		return rc;
> -	}
> +	if (rc)
> +		return dev_err_probe(dev, rc,
> +				     "uevent: failed to send synthetic uevent\n");

I do not understand this at all, this is not on the probe path at all,
so why is this function needed?

Have you tested this?  What was the resulting output before and after
this change?

thanks,

greg k-h
