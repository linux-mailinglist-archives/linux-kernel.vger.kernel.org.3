Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B68529F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbiEQKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbiEQKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468E4BFE1;
        Tue, 17 May 2022 03:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E462615E8;
        Tue, 17 May 2022 10:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46240C34117;
        Tue, 17 May 2022 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652782725;
        bh=v2apwGjWbFjt3W1NYCU1hTCmO/tsOL6niZc398NrbFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFjsCyG6q/I/b5u7wJ4bTjJVBE8nbiSwnbqKZ4rAqBtAuk40QuOLsD+neuNpefXTO
         kNQdD4ZcWSircc26ULALAo3KLkiN1U+oPX+4VUssma0Z845mgrPaj3VKaaEr+BfA7B
         sijcOfMIDg6khvpRjhbTJlpFAJJ7nGOPmv1FadsQ=
Date:   Tue, 17 May 2022 12:18:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net
Subject: Re: [PATCH -next] drivers: w1: use kfree_sensitive()
Message-ID: <YoN2fn5zRyNEnaUT@kroah.com>
References: <20220511064954.3401381-1-yangyingliang@huawei.com>
 <YntbdfHLjeHzAb9/@kroah.com>
 <2cf24169-ea56-9c72-fa95-a1e6625c8545@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf24169-ea56-9c72-fa95-a1e6625c8545@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> I'm not sure why using memset() here.

I think the memset() can just be dropped.  Can you make that change and
test it to verify it still works properly with that change?

thanks,

greg k-h
