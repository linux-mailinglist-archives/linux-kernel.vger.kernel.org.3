Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAA522C87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbiEKGpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiEKGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:45:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF71FD845;
        Tue, 10 May 2022 23:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BDF1CE22C4;
        Wed, 11 May 2022 06:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2242C385DB;
        Wed, 11 May 2022 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652251512;
        bh=Fx2QMCjEWeZ49x9y9ggLcnUsS1BY3UQodV4PGmGBX8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OC8eDHtpnhpd1T5hhiDvGvZjuDaefTo3FWKpw8wMrsbbjeLLK8SUI4b2GTl89obOc
         QOTRQNGbaXzWhU2PyWm7l70mAwcEb5yQbVFOR5OgGmJtkx3WJHkCV3Rmt5ReSiz1LW
         3ETwi0xVb8HNKR9L/QyeqZSfoQLHBv2oWeYBOUt8=
Date:   Wed, 11 May 2022 08:45:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net
Subject: Re: [PATCH -next] drivers: w1: use kfree_sensitive()
Message-ID: <YntbdfHLjeHzAb9/@kroah.com>
References: <20220511064954.3401381-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511064954.3401381-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:49:54PM +0800, Yang Yingliang wrote:
> Use kfree_sensitive() instead of open-coding it.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/w1/w1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index f2ae2e563dc5..a0a6c3c739d9 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -73,8 +73,7 @@ static void w1_master_release(struct device *dev)
>  	struct w1_master *md = dev_to_w1_master(dev);
>  
>  	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
> -	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
> -	kfree(md);
> +	kfree_sensitive(md);

Does this actually change anything?  Why is the memset being called here
at all?

thanks,

greg k-h
