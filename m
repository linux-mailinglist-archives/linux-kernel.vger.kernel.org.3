Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2452303D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiEKKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiEKKFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:05:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B205D62A3A;
        Wed, 11 May 2022 03:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FBEEB82161;
        Wed, 11 May 2022 10:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B4C340EB;
        Wed, 11 May 2022 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652263521;
        bh=eN6tRaNsKdXJ5b2UYaX+XtTfVsjOULKf85SSpTbupxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aavEMBHUNy33lh4iB/6lVCkiD+LzZNAaGsRNCNw5nHRojoLcQ5jTGzCVX9nuA1/n9
         M8IqNM+wkoIGFUISczX0KY8nhQLXnah43fX64CnGO0IUDeDJ/FY+UAESUFpSZleJEW
         IIDryw91pZlUFsdRaGaW9IUEHwyafwqMSkVQcZAk=
Date:   Wed, 11 May 2022 12:05:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net
Subject: Re: [PATCH -next] drivers: w1: use kfree_sensitive()
Message-ID: <YnuKXrcAojBAiCsN@kroah.com>
References: <20220511064954.3401381-1-yangyingliang@huawei.com>
 <YntbdfHLjeHzAb9/@kroah.com>
 <2cf24169-ea56-9c72-fa95-a1e6625c8545@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf24169-ea56-9c72-fa95-a1e6625c8545@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:25:52PM +0800, Yang Yingliang wrote:
> Hi,
> 
> On 2022/5/11 14:45, Greg KH wrote:
> > On Wed, May 11, 2022 at 02:49:54PM +0800, Yang Yingliang wrote:
> > > Use kfree_sensitive() instead of open-coding it.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   drivers/w1/w1.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> > > index f2ae2e563dc5..a0a6c3c739d9 100644
> > > --- a/drivers/w1/w1.c
> > > +++ b/drivers/w1/w1.c
> > > @@ -73,8 +73,7 @@ static void w1_master_release(struct device *dev)
> > >   	struct w1_master *md = dev_to_w1_master(dev);
> > >   	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
> > > -	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
> > > -	kfree(md);
> > > +	kfree_sensitive(md);
> > Does this actually change anything?  Why is the memset being called here
> > at all?
> It's no functional change and I got this by
> scripts/coccinelle/api/kfree_sensitive.cocci.

That's an odd rule, and as you can see here, not always correct or
needed.

> I'm not sure why using memset() here.

Then let's not make this change without figuring that out first please.

thanks,

greg k-h
