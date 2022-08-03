Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37876588C20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiHCMaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiHCMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:30:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DFE13D5B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1BB0B82253
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150BAC433D7;
        Wed,  3 Aug 2022 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659529823;
        bh=AdWGEbEZ/lHN4pPwof4wLKR8WEKA97IaNOAPBYS/GlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yiXwglll6oq4AkdBbgjwkGXVe6yWG5W5gdQ/DhFOp33KiMaXWPUeo0ouT0wzD7TIi
         KL9pvpGVcfxacojNgwaa5trRNMb9yb5L3YI6To1HW0M+1sH2VpqXK3OnLVfzNhGtBs
         zTyMHRvewVQvf6DV5ibivHNUsHsISx75JRcfapJs=
Date:   Wed, 3 Aug 2022 14:30:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Elder <elder@linaro.org>
Cc:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [greybus-dev] Re: [PATCH linux-next] staging: greybus:using the
Message-ID: <YupqXVa+RYm4Ul+m@kroah.com>
References: <20220803062258.1650792-1-ye.xingchen@zte.com.cn>
 <YuoWCSQCnNU3DrUL@kroah.com>
 <81d363ba-82ef-d556-2d77-083e3b2d9d02@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d363ba-82ef-d556-2d77-083e3b2d9d02@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:00:21AM -0500, Alex Elder wrote:
> On 8/3/22 1:30 AM, Greg KH wrote:
> > On Wed, Aug 03, 2022 at 06:22:58AM +0000, cgel.zte@gmail.com wrote:
> > > From: ye xingchen <ye.xingchen@zte.com.cn>
> > > 
> > > Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
> > > and pm_runtime_put_noidle.
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by:  <ye.xingchen@zte.com.cn>
> > > ---
> > >   drivers/greybus/core.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> > > index e546c6431877..b9063e86534b 100644
> > > --- a/drivers/greybus/core.c
> > > +++ b/drivers/greybus/core.c
> > > @@ -174,9 +174,8 @@ static int greybus_probe(struct device *dev)
> > >   	if (!id)
> > >   		return -ENODEV;
> > > -	retval = pm_runtime_get_sync(&bundle->intf->dev);
> > > +	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
> > >   	if (retval < 0) {
> > > -		pm_runtime_put_noidle(&bundle->intf->dev);
> > >   		return retval;
> > >   	}
> > > -- 
> > > 2.25.1
> > 
> > Now this is just being silly.  Consider all future emails also dropped.
> 
> 
> No Greg, please don't do this, or please undo this.
> 
> This happened because the original poster was not a subscriber to the
> greybus-dev mailing list.  Such messages get held until someone (me)
> releases them after picking them out from the mostly spam that is
> caught and held.  I have been trying to do that daily lately but
> it's still not enough to avoid this happening.
> 
> You were on the original addressee list.  So you got the message
> immediately.  But the mailing list filter held it and sent it
> again when I released it yesterday.  This is why you saw it the
> second time.
> 
> Ye Xingchen had nothing to do with your receiving the message twice.

Ah, ok.  But they did send a number of patches like this while after I
had sent my first request to not do patches in this format anymore,
which is what caused my response here.

thanks,

greg k-h
