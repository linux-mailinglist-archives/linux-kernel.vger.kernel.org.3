Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18A52A9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351682AbiEQR7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiEQR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C54A3F1;
        Tue, 17 May 2022 10:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1069D614B3;
        Tue, 17 May 2022 17:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EADC385B8;
        Tue, 17 May 2022 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652810375;
        bh=XZdrlI4v+ZvAe+NF3BwYsni+wVoFODseYbMtOFnMRpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fflH5VkNmt9j0yusExsnCvthLSaOh3KJunUZcGpUK9Mbi5eSW81PdH4f0aSFF2A5I
         aH/5G0XHNdCl13iSQeNmhotvggmBxVRkeIIHdtEmVguS+D3E+dzYboZrIH0HZ419gz
         AOKvIdLJ+MVWP3zR9aOcxURNQPVKrL7lBzBbRhAM=
Date:   Tue, 17 May 2022 15:48:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net
Subject: Re: [PATCH -next] drivers: w1: use kfree_sensitive()
Message-ID: <YoOnrsEAFOclLbG2@kroah.com>
References: <20220511064954.3401381-1-yangyingliang@huawei.com>
 <YntbdfHLjeHzAb9/@kroah.com>
 <2cf24169-ea56-9c72-fa95-a1e6625c8545@huawei.com>
 <YoN2fn5zRyNEnaUT@kroah.com>
 <16959408-3e91-774d-484f-508caff1f8f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16959408-3e91-774d-484f-508caff1f8f7@huawei.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:03:43PM +0800, Yang Yingliang wrote:
> 
> On 2022/5/17 18:18, Greg KH wrote:
> > On Wed, May 11, 2022 at 03:25:52PM +0800, Yang Yingliang wrote:
> > > Hi,
> > > 
> > > On 2022/5/11 14:45, Greg KH wrote:
> > > > On Wed, May 11, 2022 at 02:49:54PM +0800, Yang Yingliang wrote:
> > > > > Use kfree_sensitive() instead of open-coding it.
> > > > > 
> > > > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > > > ---
> > > > >    drivers/w1/w1.c | 3 +--
> > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> > > > > index f2ae2e563dc5..a0a6c3c739d9 100644
> > > > > --- a/drivers/w1/w1.c
> > > > > +++ b/drivers/w1/w1.c
> > > > > @@ -73,8 +73,7 @@ static void w1_master_release(struct device *dev)
> > > > >    	struct w1_master *md = dev_to_w1_master(dev);
> > > > >    	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
> > > > > -	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
> > > > > -	kfree(md);
> > > > > +	kfree_sensitive(md);
> > > > Does this actually change anything?  Why is the memset being called here
> > > > at all?
> > > It's no functional change and I got this by
> > > scripts/coccinelle/api/kfree_sensitive.cocci.
> > > I'm not sure why using memset() here.
> > I think the memset() can just be dropped.  Can you make that change and
> > test it to verify it still works properly with that change?
> I can make change and send a patch for this, but I don't have device to test
> it.

For something like this, it would be great to test.

thanks,

greg k-h
