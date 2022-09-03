Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549D95ABE65
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiICKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiICKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:04:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D651CFC1;
        Sat,  3 Sep 2022 03:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3E01B817BB;
        Sat,  3 Sep 2022 10:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B40C433C1;
        Sat,  3 Sep 2022 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662199482;
        bh=Pj0zqIKfHzh65CyGkqtE2borz9TbGysUmBOC7MLXY58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOhhg4xesyo8EpZYWuUAYqHWLTizkU+6Zw+HGyYnQMWRG3bErMbWdbXAwTdQmF04o
         QKfpjYhvPNJkdZyhT+J21xhwAh26HBi87mNxZP1ml6EwJQvR3Fk9QjpKDg2cuVQvsD
         4O2zjRgXfRt7qnfwH5TNKqe9V2i7UQxfrxcLuw24=
Date:   Sat, 3 Sep 2022 12:04:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     Sean Young <sean@mess.org>, hdanton@sina.com,
        linux-kernel@vger.kernel.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called
 if write is in progress
Message-ID: <YxMmtzKzkoglBOwu@kroah.com>
References: <20220814142543.24910-1-gautammenghani201@gmail.com>
 <YxJHmYDMtmzaHWQG@biggie>
 <YxMHJNNq2e3kLxdQ@gofer.mess.org>
 <YxMgj9CoUyY+r2qa@biggie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxMgj9CoUyY+r2qa@biggie>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 03:08:23PM +0530, Gautam Menghani wrote:
> On Sat, Sep 03, 2022 at 08:49:56AM +0100, Sean Young wrote:
> > On Fri, Sep 02, 2022 at 11:42:41PM +0530, Gautam Menghani wrote:
> > > On Sun, Aug 14, 2022 at 07:55:42PM +0530, Gautam Menghani wrote:
> > > > The warning "URB submitted while active" is reported if the function
> > > > send_packet() in imon.c is called if a write is already is in progress.
> > > > Add a check to return -EBUSY in case a write is already is in progress.
> > > > Also, mark tx.busy as false after transmission is completed.
> > > > 
> > > > Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> > > > Cc: hdanton@sina.com
> > > > Suggested-by: hdanton@sina.com
> > > > Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> > > > Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> > > > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> > > > ---
> > > >  drivers/media/rc/imon.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> > > > index 735b925da998..a5b997c2c7e2 100644
> > > > --- a/drivers/media/rc/imon.c
> > > > +++ b/drivers/media/rc/imon.c
> > > > @@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
> > > >  	int retval = 0;
> > > >  	struct usb_ctrlrequest *control_req = NULL;
> > > >  
> > > > +	if (ictx->tx.busy)
> > > > +		return -EBUSY;
> > > >  	/* Check if we need to use control or interrupt urb */
> > > >  	if (!ictx->tx_control) {
> > > >  		pipe = usb_sndintpipe(ictx->usbdev_intf0,
> > > > @@ -654,6 +656,7 @@ static int send_packet(struct imon_context *ictx)
> > > >  			pr_err_ratelimited("task interrupted\n");
> > > >  		}
> > > >  		mutex_lock(&ictx->lock);
> > > > +		ictx->tx.busy = false;
> > > >  
> > > >  		retval = ictx->tx.status;
> > > >  		if (retval)
> > > > -- 
> > > > 2.34.1
> > > > 
> > > Hi,
> > > 
> > > Please review the above fix and let me know if any changes are needed.
> > 
> > Greg has pointed out issues with this patch: there is no locking.
> > 
> > Thanks,
> > 
> > Sean
> 
> Hi,
> 
> I am a bit confused about the locking part. All the calls to send_packet() are
> made with ictx->lock held. So will the following be sufficient?
> 
> lockdep_assert_held(&ictx->lock);
> if (ictx->tx.busy)
> 	return -EBUSY;
> 
> Or do we need to add a mutex/spin lock inside ictx->tx structure? 

If a lock is held, how can this function be called at the same time
through different ways?  That should not happen.

> Or should we instead wait for the the tx to be completed as follows:
> wait_for_completion(&ictx->tx.finished);

It depends on what you are trying to protect from here.  What is the
real issue that is allowing multiple submissions of the same urb to
happen?  Fix that issue instead of trying to paper over it in this lower
level function please.

thanks,

greg k-h
