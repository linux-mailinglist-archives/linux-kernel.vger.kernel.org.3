Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94555E09F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbiF1MSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbiF1MSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309792C11B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0415611AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF39C341CA;
        Tue, 28 Jun 2022 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656418712;
        bh=pvcgfgj1+JW5rJv2QYzCzgQ4UJqn+XYqQ+OluEMeYTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqTTn0tENW61kEiqToF2VjZKt++5wXyN/muIGZz5nk3fyOa6tXEYYW5UZ9X3Oi/uK
         EaEWRBuRvTjs8rHaMi9SZlN30qJUiucZ9Nm0p9gu+a52WkCpKu4PEpIHjl4wsW9cq9
         lmzP8NXL4r7i6ZOOhmX3pJQG4P8evyRqW6hl7ZKs=
Date:   Tue, 28 Jun 2022 14:18:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     duoming@zju.edu.cn
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7] devcoredump: change gfp_t parameter of kzalloc to
 GFP_KERNEL
Message-ID: <YrrxlT0KVCGY8zaq@kroah.com>
References: <20220628034458.17384-1-duoming@zju.edu.cn>
 <YrqbAgM6aR8OKpZj@kroah.com>
 <5a9830c1.18fd7.181a9fded00.Coremail.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9830c1.18fd7.181a9fded00.Coremail.duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:06:39PM +0800, duoming@zju.edu.cn wrote:
> hello,
> 
> On Tue, 28 Jun 2022 08:09:06 +0200 greg KH wrote:
> 
> > On Tue, Jun 28, 2022 at 11:44:58AM +0800, Duoming Zhou wrote:
> > > The dev_coredumpv() and dev_coredumpm() could not be used in atomic
> > > context, because they call kvasprintf_const() and kstrdup() with
> > > GFP_KERNEL parameter. The process is shown below:
> > > 
> > > dev_coredumpv(.., gfp_t gfp)
> > >   dev_coredumpm(.., gfp_t gfp)
> > >     kzalloc(.., gfp);
> > >     dev_set_name
> > >       kobject_set_name_vargs
> > >         kvasprintf_const(GFP_KERNEL, ...); //may sleep
> > >           kstrdup(s, GFP_KERNEL); //may sleep
> > > 
> > > This patch changes the gfp_t parameter of kzalloc() in dev_coredumpm() to
> > > GFP_KERNEL in order to show they could not be used in atomic context.
> > > 
> > > What's more, this patch does not remove the gfp_t parameter in
> > > dev_coredumpv() and dev_coredumpm() in order that it will not influence
> > > other new users that are added in other trees.
> > > 
> > > Fixes: 833c95456a70 ("device coredump: add new device coredump class")
> > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > ---
> > > Changes in v7:
> > >   - change gfp_t parameter of kzalloc in dev_coredumpm() to GFP_KERNEL.
> > > 
> > >  drivers/base/devcoredump.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > > index f4d794d6bb8..cf60aacf8a8 100644
> > > --- a/drivers/base/devcoredump.c
> > > +++ b/drivers/base/devcoredump.c
> > > @@ -268,7 +268,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> > >  	if (!try_module_get(owner))
> > >  		goto free;
> > >  
> > > -	devcd = kzalloc(sizeof(*devcd), gfp);
> > > +	devcd = kzalloc(sizeof(*devcd), GFP_KERNEL);
> > 
> > No, you can't just ignore the flag entirely, that doesn't help anyone
> > out who tries to set it and is totally confused as to why the field is
> > ignored.
> > 
> > You need to evolve the function over time to not need the parameter at
> > all, this just papers over the entire issue, which makes the api lie to
> > the caller, not something you ever want to do.
> 
> Thank you for your time and reply.
> 
> But if there are new devices come into kernel, it may use devcoredump api.
> What is the proper time to remove the gfp_t parameter of dev_coredumpv()
> and dev_coredumpm()?

Normally you prepare some patches that does the conversion as a patch
series and I queue them up in my tree, and get them merged in -rc1, then
any stragglers are then fixed up in -rc2 along with the final rename of
the old way and then all is good.  See lots of examples of changing apis
over time on the mailing lists for how to do this.

thanks,

greg k-h
